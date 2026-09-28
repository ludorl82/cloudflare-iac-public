// Tests for retrieve() — which chunks of the corpus reach the model.
//
//   node --test live/workers/gpu-01-chat/retrieve.test.mjs
//
// What has to be true, and why each one is here:
//
//   * a post's "Résumé technique" is handed over even when three of its
//     ordinary chunks outscore it. That is the bug: on 2026-09-26 "Pourquoi tes
//     connexions SSH gelaient-elles après une minute ?" got the symptom, the
//     macOS red herring and a footnote, lost the summary by 0.012, and gpu-01
//     explained the firewall backwards — 0 right answers out of 4, 4 of 4 once
//     the summary was there.
//   * an ordinary first paragraph is NOT promoted. Only the block written to be
//     read out of context earns the exception.
//   * at most two posts bring a summary, the two best-ranked. Uncapped, an
//     off-topic question scattered over five posts pulled in five summaries
//     and grew the prompt past what LOCAL_NUM_CTX can hold with a full history.
//
// The index is synthetic and two-dimensional: a chunk at angle θ from the
// query scores cos θ, so each test states its scores directly.
import { test } from "node:test";
import assert from "node:assert/strict";
import { retrieve } from "./index.js";

function chunk(slug, i, score, text) {
  const v = new Int8Array([Math.round(127 * score), Math.round(127 * Math.sqrt(1 - score * score))]);
  return { c: { slug, i, lang: "fr", title: slug, url: `/blog/${slug}/`, date: "2026-09-25", text }, v };
}
function index(list) {
  return { chunks: list.map((x) => x.c), vectors: list.map((x) => x.v) };
}
const Q = [[1, 0]];
const SUMMARY = "> **Résumé technique** _(pour les agents)_\n> - **La cause** : ...";
const got = (hits) => hits.map((h) => `${h.slug}#${h.i}`).sort();

test("the summary of the dominant post is kept even when it ranks fourth", () => {
  const idx = index([
    chunk("ssh", 0, 0.695, SUMMARY),
    chunk("ssh", 1, 0.707, "Je viens d'ajouter un MacBook Air…"),
    chunk("ssh", 5, 0.706, "La confidentialité « Réseau local »…"),
    chunk("ssh", 15, 0.719, "--- _réalisé en session avec Claude Code_"),
  ]);
  assert.ok(got(retrieve(idx, Q, false)).includes("ssh#0"));
});

test("an ordinary first paragraph is not promoted", () => {
  const idx = index([
    chunk("plain", 0, 0.60, "Un premier paragraphe comme les autres."),
    chunk("plain", 4, 0.72, "a"),
    chunk("plain", 8, 0.71, "b"),
    chunk("plain", 12, 0.70, "c"),
  ]);
  assert.ok(!got(retrieve(idx, Q, false)).includes("plain#0"));
});

test("at most two posts bring a summary, the two best-ranked", () => {
  const posts = ["a", "b", "c", "d", "e"];
  const idx = index(posts.flatMap((p, n) => [
    chunk(p, 0, 0.50, SUMMARY),
    chunk(p, 6, 0.90 - n * 0.01, "corps"),
  ]));
  const summaries = got(retrieve(idx, Q, false)).filter((h) => h.endsWith("#0"));
  assert.deepEqual(summaries, ["a#0", "b#0"]);
});
