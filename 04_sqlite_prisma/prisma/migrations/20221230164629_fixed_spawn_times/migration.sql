/*
  Warnings:

  - You are about to alter the column `avg_spawns` on the `Pokemon` table. The data in that column could be lost. The data in that column will be cast from `Int` to `Float`.

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
    "spawn_chance" REAL NOT NULL,
    "avg_spawns" REAL NOT NULL,
    "spawn_time" TEXT NOT NULL
);
INSERT INTO "new_Pokemon" ("avg_spawns", "candy", "candy_count", "eggMetres", "heightCm", "id", "name", "num", "spawn_chance", "spawn_time", "version", "weightGrams") SELECT "avg_spawns", "candy", "candy_count", "eggMetres", "heightCm", "id", "name", "num", "spawn_chance", "spawn_time", "version", "weightGrams" FROM "Pokemon";
DROP TABLE "Pokemon";
ALTER TABLE "new_Pokemon" RENAME TO "Pokemon";
CREATE UNIQUE INDEX "Pokemon_id_key" ON "Pokemon"("id");
CREATE UNIQUE INDEX "Pokemon_name_key" ON "Pokemon"("name");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
