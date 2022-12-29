-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Tweet" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "text" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    "liked" BOOLEAN NOT NULL DEFAULT false,
    CONSTRAINT "Tweet_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Tweet" ("createdAt", "id", "text", "userId") SELECT "createdAt", "id", "text", "userId" FROM "Tweet";
DROP TABLE "Tweet";
ALTER TABLE "new_Tweet" RENAME TO "Tweet";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
