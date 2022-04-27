-- CreateTable
CREATE TABLE "Pokemon" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "order" INTEGER NOT NULL,
    "weight" INTEGER NOT NULL,
    "height" INTEGER NOT NULL,
    "baseExperience" INTEGER NOT NULL,
    "baseHappiness" INTEGER NOT NULL,
    "isDefault" BOOLEAN NOT NULL,
    "captureRate" INTEGER NOT NULL,
    "evolutionChain" INTEGER,
    "evolvesFrom" INTEGER,
    "evolvesTo" INTEGER,
    "flavorText" TEXT NOT NULL,
    "genus" TEXT NOT NULL,

    CONSTRAINT "Pokemon_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Type" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "doubleDamageFrom" INTEGER[],
    "doubleDamageTo" INTEGER[],
    "halfDamageFrom" INTEGER[],
    "halfDamageTo" INTEGER[],
    "noDamageFrom" INTEGER[],
    "noDamageTo" INTEGER[],
    "moveDamageClassId" INTEGER NOT NULL,

    CONSTRAINT "Type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DamageClass" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "DamageClass_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Move" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "typeId" INTEGER NOT NULL,
    "power" INTEGER NOT NULL,
    "accuracy" INTEGER NOT NULL,
    "pp" INTEGER NOT NULL,
    "priority" INTEGER NOT NULL,
    "effect" TEXT NOT NULL,
    "shortEffect" TEXT NOT NULL,
    "damageClassId" INTEGER NOT NULL,
    "effectChance" INTEGER NOT NULL,
    "flavorText" TEXT NOT NULL,

    CONSTRAINT "Move_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Stat" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "effort" INTEGER NOT NULL,
    "baseStat" INTEGER NOT NULL,

    CONSTRAINT "Stat_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_PokemonToType" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_PokemonToStat" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_MoveToPokemon" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_PokemonToType_AB_unique" ON "_PokemonToType"("A", "B");

-- CreateIndex
CREATE INDEX "_PokemonToType_B_index" ON "_PokemonToType"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_PokemonToStat_AB_unique" ON "_PokemonToStat"("A", "B");

-- CreateIndex
CREATE INDEX "_PokemonToStat_B_index" ON "_PokemonToStat"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_MoveToPokemon_AB_unique" ON "_MoveToPokemon"("A", "B");

-- CreateIndex
CREATE INDEX "_MoveToPokemon_B_index" ON "_MoveToPokemon"("B");

-- AddForeignKey
ALTER TABLE "Type" ADD CONSTRAINT "Type_moveDamageClassId_fkey" FOREIGN KEY ("moveDamageClassId") REFERENCES "DamageClass"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Move" ADD CONSTRAINT "Move_typeId_fkey" FOREIGN KEY ("typeId") REFERENCES "Type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Move" ADD CONSTRAINT "Move_damageClassId_fkey" FOREIGN KEY ("damageClassId") REFERENCES "DamageClass"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PokemonToType" ADD FOREIGN KEY ("A") REFERENCES "Pokemon"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PokemonToType" ADD FOREIGN KEY ("B") REFERENCES "Type"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PokemonToStat" ADD FOREIGN KEY ("A") REFERENCES "Pokemon"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PokemonToStat" ADD FOREIGN KEY ("B") REFERENCES "Stat"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_MoveToPokemon" ADD FOREIGN KEY ("A") REFERENCES "Move"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_MoveToPokemon" ADD FOREIGN KEY ("B") REFERENCES "Pokemon"("id") ON DELETE CASCADE ON UPDATE CASCADE;
