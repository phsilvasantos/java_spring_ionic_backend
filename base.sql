-- MariaDB dump 10.17  Distrib 10.4.8-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: curso_spring
-- ------------------------------------------------------
-- Server version	10.4.8-MariaDB
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO,POSTGRESQL' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table "categoria"
--

DROP TABLE IF EXISTS "categoria";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "categoria" (
  "id" int(11) NOT NULL,
  "nome" varchar(255) DEFAULT NULL,
  PRIMARY KEY ("id")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table "categorias_do_produto"
--

DROP TABLE IF EXISTS "categorias_do_produto";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "categorias_do_produto" (
  "produto_id" int(11) NOT NULL,
  "categoria_id" int(11) NOT NULL,
  KEY "FKqn00yt655qipllt55jv5dtlsi" ("categoria_id"),
  KEY "FKailuncfgdeplgr2higulqxudn" ("produto_id"),
  CONSTRAINT "FKailuncfgdeplgr2higulqxudn" FOREIGN KEY ("produto_id") REFERENCES "produto" ("id"),
  CONSTRAINT "FKqn00yt655qipllt55jv5dtlsi" FOREIGN KEY ("categoria_id") REFERENCES "categoria" ("id")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table "cidade"
--

DROP TABLE IF EXISTS "cidade";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "cidade" (
  "id" int(11) NOT NULL,
  "nome" varchar(255) DEFAULT NULL,
  "estado_id" int(11) DEFAULT NULL,
  PRIMARY KEY ("id"),
  KEY "FKkworrwk40xj58kevvh3evi500" ("estado_id"),
  CONSTRAINT "FKkworrwk40xj58kevvh3evi500" FOREIGN KEY ("estado_id") REFERENCES "estado" ("id")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table "cliente"
--

DROP TABLE IF EXISTS "cliente";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "cliente" (
  "id" int(11) NOT NULL,
  "cpf_ou_cnpj" varchar(255) DEFAULT NULL,
  "email" varchar(255) DEFAULT NULL,
  "nome" varchar(255) DEFAULT NULL,
  "pessoa" int(11) DEFAULT NULL,
  PRIMARY KEY ("id"),
  UNIQUE KEY "UK_cmxo70m08n43599l3h0h07cc6" ("email")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table "endereco"
--

DROP TABLE IF EXISTS "endereco";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "endereco" (
  "id" int(11) NOT NULL,
  "bairro" varchar(255) DEFAULT NULL,
  "cep" varchar(255) DEFAULT NULL,
  "complemento" varchar(255) DEFAULT NULL,
  "logradouro" varchar(255) DEFAULT NULL,
  "numero" varchar(255) DEFAULT NULL,
  "cidade_id" int(11) DEFAULT NULL,
  "cliente_id" int(11) DEFAULT NULL,
  PRIMARY KEY ("id"),
  KEY "FK8b1kcb3wucapb8dejshyn5fsx" ("cidade_id"),
  KEY "FK8s7ivtl4foyhrfam9xqom73n9" ("cliente_id"),
  CONSTRAINT "FK8b1kcb3wucapb8dejshyn5fsx" FOREIGN KEY ("cidade_id") REFERENCES "cidade" ("id"),
  CONSTRAINT "FK8s7ivtl4foyhrfam9xqom73n9" FOREIGN KEY ("cliente_id") REFERENCES "cliente" ("id")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table "estado"
--

DROP TABLE IF EXISTS "estado";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "estado" (
  "id" int(11) NOT NULL,
  "nome" varchar(255) DEFAULT NULL,
  PRIMARY KEY ("id")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table "item_pedido"
--

DROP TABLE IF EXISTS "item_pedido";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "item_pedido" (
  "desconto" double DEFAULT NULL,
  "preco" double DEFAULT NULL,
  "quantidade" int(11) DEFAULT NULL,
  "pedido_id" int(11) NOT NULL,
  "produto_id" int(11) NOT NULL,
  PRIMARY KEY ("pedido_id","produto_id"),
  KEY "FKtk55mn6d6bvl5h0no5uagi3sf" ("produto_id"),
  CONSTRAINT "FK60ym08cfoysa17wrn1swyiuda" FOREIGN KEY ("pedido_id") REFERENCES "pedido" ("id"),
  CONSTRAINT "FKtk55mn6d6bvl5h0no5uagi3sf" FOREIGN KEY ("produto_id") REFERENCES "produto" ("id")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table "pagamento"
--

DROP TABLE IF EXISTS "pagamento";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "pagamento" (
  "pedido_id" int(11) NOT NULL,
  "estado" int(11) DEFAULT NULL,
  PRIMARY KEY ("pedido_id"),
  CONSTRAINT "FKthad9tkw4188hb3qo1lm5ueb0" FOREIGN KEY ("pedido_id") REFERENCES "pedido" ("id")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table "pagamento_com_boleto"
--

DROP TABLE IF EXISTS "pagamento_com_boleto";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "pagamento_com_boleto" (
  "data_pagamento" datetime DEFAULT NULL,
  "data_vencimento" datetime DEFAULT NULL,
  "pedido_id" int(11) NOT NULL,
  PRIMARY KEY ("pedido_id"),
  CONSTRAINT "FKcr74vrxf8nfph0knq2bho8doo" FOREIGN KEY ("pedido_id") REFERENCES "pagamento" ("pedido_id")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table "pagamento_com_cartao"
--

DROP TABLE IF EXISTS "pagamento_com_cartao";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "pagamento_com_cartao" (
  "numero_de_parcelas" int(11) DEFAULT NULL,
  "pedido_id" int(11) NOT NULL,
  PRIMARY KEY ("pedido_id"),
  CONSTRAINT "FKta3cdnuuxclwfh52t4qi432ow" FOREIGN KEY ("pedido_id") REFERENCES "pagamento" ("pedido_id")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table "pedido"
--

DROP TABLE IF EXISTS "pedido";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "pedido" (
  "id" int(11) NOT NULL,
  "criado_em" datetime DEFAULT NULL,
  "cliente_id" int(11) DEFAULT NULL,
  "endereco_de_entrega_id" int(11) DEFAULT NULL,
  PRIMARY KEY ("id"),
  KEY "FK30s8j2ktpay6of18lbyqn3632" ("cliente_id"),
  KEY "FK1fihyy2fnocpuwc74674qmfkv" ("endereco_de_entrega_id"),
  CONSTRAINT "FK1fihyy2fnocpuwc74674qmfkv" FOREIGN KEY ("endereco_de_entrega_id") REFERENCES "endereco" ("id"),
  CONSTRAINT "FK30s8j2ktpay6of18lbyqn3632" FOREIGN KEY ("cliente_id") REFERENCES "cliente" ("id")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table "produto"
--

DROP TABLE IF EXISTS "produto";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "produto" (
  "id" int(11) NOT NULL,
  "nome" varchar(255) DEFAULT NULL,
  "preco" double DEFAULT NULL,
  PRIMARY KEY ("id")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table "telefones"
--

DROP TABLE IF EXISTS "telefones";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "telefones" (
  "cliente_id" int(11) NOT NULL,
  "telefones" varchar(255) DEFAULT NULL,
  KEY "FK8ujf1478gyy3vk8tur1cni603" ("cliente_id"),
  CONSTRAINT "FK8ujf1478gyy3vk8tur1cni603" FOREIGN KEY ("cliente_id") REFERENCES "cliente" ("id")
);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-25  9:50:22
