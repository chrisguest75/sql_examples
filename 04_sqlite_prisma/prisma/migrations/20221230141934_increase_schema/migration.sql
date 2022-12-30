/*
  Warnings:

  - Added the required column `avg_spawns` to the `Pokemon` table without a default value. This is not possible if the table is not empty.
  - Added the required column `candy` to the `Pokemon` table without a default value. This is not possible if the table is not empty.
  - Added the required column `candy_count` to the `Pokemon` table without a default value. This is not possible if the table is not empty.
  - Added the required column `eggMetres` to the `Pokemon` table without a default value. This is not possible if the table is not empty.
  - Added the required column `heightCm` to the `Pokemon` table without a default value. This is not possible if the table is not empty.
  - Added the required column `num` to the `Pokemon` table without a default value. This is not possible if the table is not empty.
  - Added the required column `spawn_chance` to the `Pokemon` table without a default value. This is not possible if the table is not empty.
  - Added the required column `spawn_time` to the `Pokemon` table without a default value. This is not possible if the table is not empty.
  - Added the required column `version` to the `Pokemon` table without a default value. This is not possible if the table is not empty.
  - Added the required column `weightGrams` to the `Pokemon` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Pokemon" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "version" INTEGER NOT NULL,
    "num" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "heightCm" INTEGER NOT NULL,
    "weightGrams" INTEGER NOT NULL,
    "candy" TEXT NOT NULL,
    "candy_count" INTEGER NOT NULL,
    "eggMetres" INTEGER NOT NULL,
    "spawn_chance" INTEGER NOT NULL,
    "avg_spawns" INTEGER NOT NULL,
    "spawn_time" TEXT NOT NULL
);
INSERT INTO "new_Pokemon" ("id", "name") SELECT "id", "name" FROM "Pokemon";
DROP TABLE "Pokemon";
ALTER TABLE "new_Pokemon" RENAME TO "Pokemon";
CREATE UNIQUE INDEX "Pokemon_id_key" ON "Pokemon"("id");
CREATE UNIQUE INDEX "Pokemon_name_key" ON "Pokemon"("name");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
