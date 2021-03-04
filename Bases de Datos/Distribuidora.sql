--
-- PostgreSQL database dump
--

-- Dumped from database version 12.6 (Ubuntu 12.6-1.pgdg20.04+1)
-- Dumped by pg_dump version 12.6 (Ubuntu 12.6-1.pgdg20.04+1)

-- Started on 2021-03-04 11:40:16 -03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2 (class 3079 OID 58615)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- TOC entry 3108 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- TOC entry 263 (class 1255 OID 58761)
-- Name: actualizardescuentocliente(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.actualizardescuentocliente() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE cantidad integer;
BEGIN
	SELECT count (pedido."idPedido") into cantidad FROM pedido, cliente where new."idCliente" = cliente."idCliente" and pedido.estado=true and pedido."idCliente" = cliente."idCliente" and pedido.condicion = 'Entregado'; 
	if cantidad >= 15 and cantidad < 25 then
		UPDATE ClientePreferencial SET descuento= 5 WHERE clientepreferencial."idCliente" = new."idCliente";
		RETURN NEW;
	elseif cantidad >= 25 and cantidad < 35 then
		UPDATE ClientePreferencial SET descuento= 10 WHERE clientepreferencial."idCliente" = new."idCliente";
		RETURN NEW;
	elseif cantidad >= 35 and cantidad < 45 then
		UPDATE ClientePreferencial SET descuento= 15 WHERE clientepreferencial."idCliente" = new."idCliente";
		RETURN NEW;
	elseif cantidad >= 45 then
		UPDATE ClientePreferencial SET descuento= 20 WHERE clientepreferencial."idCliente" = new."idCliente";
		RETURN NEW;
	else
		UPDATE ClientePreferencial SET descuento= 0 WHERE clientepreferencial."idCliente" = new."idCliente";
		RETURN NEW;
	end if;
    cantidad= 0;
END
$$;


ALTER FUNCTION public.actualizardescuentocliente() OWNER TO postgres;

--
-- TOC entry 264 (class 1255 OID 58653)
-- Name: sumarstockenpedidonulado(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sumarstockenpedidonulado() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
if new."condicion" = 'En Espera' then
update producto  set stock = stock - detallepedido.cantidad from  
 detallepedido where detallepedido.idpedido = new."idPedido"  and producto."idProducto" = detallepedido.idproducto;
elseif new."condicion" = 'Cancelado' then
update producto  set stock = stock + detallepedido.cantidad from  
 detallepedido where detallepedido.idpedido = new."idPedido"  and producto."idProducto" = detallepedido.idproducto;
end if;
return new;

end
$$;


ALTER FUNCTION public.sumarstockenpedidonulado() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 203 (class 1259 OID 58654)
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    "idCliente" integer NOT NULL,
    nombre character varying(60),
    apellido character varying(60),
    domicilio character varying(255),
    cuil character varying(11),
    telefono character varying(20),
    "fechaIngreso" date
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 58657)
-- Name: cliente_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cliente_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cliente_id_seq OWNER TO postgres;

--
-- TOC entry 3109 (class 0 OID 0)
-- Dependencies: 204
-- Name: cliente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cliente_id_seq OWNED BY public.cliente."idCliente";


--
-- TOC entry 205 (class 1259 OID 58659)
-- Name: clientepreferencial; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clientepreferencial (
    "idClientePreferencial" integer NOT NULL,
    descuento numeric(5,2),
    "idCliente" integer
);


ALTER TABLE public.clientepreferencial OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 58662)
-- Name: clientepreferencial_idClientePreferencial_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."clientepreferencial_idClientePreferencial_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."clientepreferencial_idClientePreferencial_seq" OWNER TO postgres;

--
-- TOC entry 3110 (class 0 OID 0)
-- Dependencies: 206
-- Name: clientepreferencial_idClientePreferencial_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."clientepreferencial_idClientePreferencial_seq" OWNED BY public.clientepreferencial."idClientePreferencial";


--
-- TOC entry 207 (class 1259 OID 58664)
-- Name: detallepedido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detallepedido (
    "idDetallePedido" integer NOT NULL,
    cantidad integer,
    idpedido integer,
    idproducto integer
);


ALTER TABLE public.detallepedido OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 58667)
-- Name: detallepedido_idDetallePedido_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."detallepedido_idDetallePedido_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."detallepedido_idDetallePedido_seq" OWNER TO postgres;

--
-- TOC entry 3111 (class 0 OID 0)
-- Dependencies: 208
-- Name: detallepedido_idDetallePedido_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."detallepedido_idDetallePedido_seq" OWNED BY public.detallepedido."idDetallePedido";


--
-- TOC entry 209 (class 1259 OID 58669)
-- Name: pedido_idpedido_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pedido_idpedido_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.pedido_idpedido_seq OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 58671)
-- Name: pedido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pedido (
    "idPedido" integer DEFAULT nextval('public.pedido_idpedido_seq'::regclass) NOT NULL,
    fecha date,
    hora character varying,
    descuento double precision,
    totalpagar double precision,
    "idCliente" integer,
    estado boolean,
    condicion character varying
);


ALTER TABLE public.pedido OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 58678)
-- Name: producto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.producto (
    "idProducto" integer NOT NULL,
    codproducto integer,
    categoria character varying(60),
    marca character varying(100),
    medida numeric(8,2),
    unidad character varying(20),
    stock integer,
    preciounitario numeric(8,2),
    detalle character varying(255)
);


ALTER TABLE public.producto OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 58681)
-- Name: producto_idProducto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."producto_idProducto_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."producto_idProducto_seq" OWNER TO postgres;

--
-- TOC entry 3112 (class 0 OID 0)
-- Dependencies: 212
-- Name: producto_idProducto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."producto_idProducto_seq" OWNED BY public.producto."idProducto";


--
-- TOC entry 213 (class 1259 OID 58683)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    "idUsuario" integer NOT NULL,
    mail character varying(120),
    nick character varying(60),
    contrasena character varying(255),
    rol character varying(60),
    "idCliente" integer
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 58686)
-- Name: usuario_idUsuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."usuario_idUsuario_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."usuario_idUsuario_seq" OWNER TO postgres;

--
-- TOC entry 3113 (class 0 OID 0)
-- Dependencies: 214
-- Name: usuario_idUsuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."usuario_idUsuario_seq" OWNED BY public.usuario."idUsuario";


--
-- TOC entry 2942 (class 2604 OID 58688)
-- Name: cliente idCliente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente ALTER COLUMN "idCliente" SET DEFAULT nextval('public.cliente_id_seq'::regclass);


--
-- TOC entry 2943 (class 2604 OID 58689)
-- Name: clientepreferencial idClientePreferencial; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientepreferencial ALTER COLUMN "idClientePreferencial" SET DEFAULT nextval('public."clientepreferencial_idClientePreferencial_seq"'::regclass);


--
-- TOC entry 2944 (class 2604 OID 58690)
-- Name: detallepedido idDetallePedido; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detallepedido ALTER COLUMN "idDetallePedido" SET DEFAULT nextval('public."detallepedido_idDetallePedido_seq"'::regclass);


--
-- TOC entry 2946 (class 2604 OID 58691)
-- Name: producto idProducto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto ALTER COLUMN "idProducto" SET DEFAULT nextval('public."producto_idProducto_seq"'::regclass);


--
-- TOC entry 2947 (class 2604 OID 58692)
-- Name: usuario idUsuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario ALTER COLUMN "idUsuario" SET DEFAULT nextval('public."usuario_idUsuario_seq"'::regclass);


--
-- TOC entry 3091 (class 0 OID 58654)
-- Dependencies: 203
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cliente ("idCliente", nombre, apellido, domicilio, cuil, telefono, "fechaIngreso") VALUES (1, 'Cristian', 'Sanchez', 'Chacra 138, Manzana 7, Casa 122', '20343958073', '376154825015', '2021-01-20');
INSERT INTO public.cliente ("idCliente", nombre, apellido, domicilio, cuil, telefono, "fechaIngreso") VALUES (2, 'Juan', 'Soteldo', 'Chacra 90, Casa 56', '20362581252', '376154256987', '2021-01-20');
INSERT INTO public.cliente ("idCliente", nombre, apellido, domicilio, cuil, telefono, "fechaIngreso") VALUES (3, 'Maria', 'Rodriguez', 'Chacra 137, Manzana 2, Casa 55', '20271583652', '376154354812', '2021-01-25');
INSERT INTO public.cliente ("idCliente", nombre, apellido, domicilio, cuil, telefono, "fechaIngreso") VALUES (4, 'Carlos', 'Gomez', 'Chacra 80, Casa 35', '20231681461', '376154351460', '2021-01-25');
INSERT INTO public.cliente ("idCliente", nombre, apellido, domicilio, cuil, telefono, "fechaIngreso") VALUES (5, 'Julian', 'Peralta', 'Calle Belgrano 3350, Departamento 5', '20251649523', '376154621843', '2021-01-25');
INSERT INTO public.cliente ("idCliente", nombre, apellido, domicilio, cuil, telefono, "fechaIngreso") VALUES (6, 'Antonieta', 'Alarcón', 'Calle San Martín 2810, Casa 76', '20283561482', '376154961572', '2021-01-25');
INSERT INTO public.cliente ("idCliente", nombre, apellido, domicilio, cuil, telefono, "fechaIngreso") VALUES (7, 'Fernando', 'Lopez', 'Villa Sarita, Calle Berón Astrada 772, Casa 1280', '20311562851', '376154141543', '2021-01-25');
INSERT INTO public.cliente ("idCliente", nombre, apellido, domicilio, cuil, telefono, "fechaIngreso") VALUES (8, 'Emilia', 'Garmendia', 'Chacra 123, Manzana 5, Casa 13', '20275841731', '376154751369', '2021-01-25');
INSERT INTO public.cliente ("idCliente", nombre, apellido, domicilio, cuil, telefono, "fechaIngreso") VALUES (9, 'Antonio', 'Klieber', 'Calle General Paz 1270, Casa 14', '20331568471', '376154168713', '2021-01-25');
INSERT INTO public.cliente ("idCliente", nombre, apellido, domicilio, cuil, telefono, "fechaIngreso") VALUES (10, 'Rubén', 'Hernandez', 'Chacra 139, Edificio 7, Departamento 3', '20291658461', '376154871296', '2021-01-25');
INSERT INTO public.cliente ("idCliente", nombre, apellido, domicilio, cuil, telefono, "fechaIngreso") VALUES (11, 'Ana María', 'Gutierrez', 'Avenida Corriente 550, Edificio Pablo I, Departamento 15', '20284512781', '376154751486', '2021-01-25');
INSERT INTO public.cliente ("idCliente", nombre, apellido, domicilio, cuil, telefono, "fechaIngreso") VALUES (12, 'Daniela', 'Junquera', 'Calle Urquiza 2435, Casa 1321', '20361783591', '376154791458', '2021-01-25');


--
-- TOC entry 3093 (class 0 OID 58659)
-- Dependencies: 205
-- Data for Name: clientepreferencial; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.clientepreferencial ("idClientePreferencial", descuento, "idCliente") VALUES (1, 0.00, 1);
INSERT INTO public.clientepreferencial ("idClientePreferencial", descuento, "idCliente") VALUES (5, 0.00, 5);
INSERT INTO public.clientepreferencial ("idClientePreferencial", descuento, "idCliente") VALUES (6, 0.00, 6);
INSERT INTO public.clientepreferencial ("idClientePreferencial", descuento, "idCliente") VALUES (7, 0.00, 7);
INSERT INTO public.clientepreferencial ("idClientePreferencial", descuento, "idCliente") VALUES (8, 0.00, 8);
INSERT INTO public.clientepreferencial ("idClientePreferencial", descuento, "idCliente") VALUES (9, 0.00, 9);
INSERT INTO public.clientepreferencial ("idClientePreferencial", descuento, "idCliente") VALUES (10, 0.00, 10);
INSERT INTO public.clientepreferencial ("idClientePreferencial", descuento, "idCliente") VALUES (3, 0.00, 3);
INSERT INTO public.clientepreferencial ("idClientePreferencial", descuento, "idCliente") VALUES (4, 0.00, 4);
INSERT INTO public.clientepreferencial ("idClientePreferencial", descuento, "idCliente") VALUES (11, 0.00, 11);
INSERT INTO public.clientepreferencial ("idClientePreferencial", descuento, "idCliente") VALUES (2, 10.00, 2);
INSERT INTO public.clientepreferencial ("idClientePreferencial", descuento, "idCliente") VALUES (12, 0.00, 12);


--
-- TOC entry 3095 (class 0 OID 58664)
-- Dependencies: 207
-- Data for Name: detallepedido; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (1, 2, 1, 5);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (2, 2, 1, 57);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (3, 1, 1, 289);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (4, 2, 1, 90);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (5, 1, 1, 272);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (6, 1, 2, 84);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (7, 2, 2, 7);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (8, 1, 2, 370);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (9, 3, 2, 612);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (10, 1, 2, 1339);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (11, 1, 3, 86);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (12, 2, 3, 32);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (13, 2, 3, 31);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (14, 1, 3, 175);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (15, 1, 3, 498);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (143, 2, 26, 9);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (18, 3, 3, 591);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (144, 1, 26, 92);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (145, 1, 27, 220);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (146, 1, 27, 327);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (17, 1, 4, 121);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (147, 1, 27, 213);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (19, 1, 4, 726);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (20, 2, 4, 762);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (21, 1, 4, 1214);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (22, 1, 4, 1110);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (23, 1, 4, 969);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (24, 2, 5, 56);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (25, 1, 5, 385);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (26, 1, 5, 1049);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (27, 1, 5, 161);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (28, 1, 5, 245);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (29, 2, 5, 29);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (30, 1, 5, 827);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (31, 1, 5, 1137);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (32, 1, 6, 815);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (33, 1, 6, 101);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (34, 1, 6, 192);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (35, 1, 6, 1207);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (36, 1, 6, 1332);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (37, 2, 6, 17);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (38, 1, 6, 1363);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (39, 1, 7, 91);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (40, 1, 7, 340);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (41, 2, 7, 13);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (42, 1, 7, 548);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (43, 1, 7, 202);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (44, 4, 7, 598);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (45, 5, 7, 666);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (46, 1, 7, 671);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (47, 4, 8, 385);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (48, 2, 8, 486);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (49, 10, 8, 567);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (148, 1, 28, 359);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (51, 1, 8, 69);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (52, 2, 9, 440);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (53, 1, 9, 677);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (54, 2, 9, 1406);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (55, 1, 9, 922);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (56, 3, 9, 60);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (57, 1, 9, 1135);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (58, 5, 9, 36);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (59, 2, 10, 61);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (60, 1, 10, 719);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (61, 1, 10, 1239);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (62, 1, 10, 1279);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (63, 1, 10, 1480);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (64, 1, 10, 7);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (65, 3, 10, 9);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (66, 2, 10, 8);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (67, 3, 11, 414);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (68, 2, 11, 127);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (69, 1, 11, 324);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (70, 1, 11, 959);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (71, 2, 11, 1113);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (72, 2, 12, 3);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (73, 1, 12, 248);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (74, 2, 12, 232);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (75, 1, 12, 1278);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (76, 1, 12, 486);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (149, 3, 28, 11);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (78, 2, 13, 615);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (79, 2, 13, 1010);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (80, 3, 13, 449);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (81, 3, 13, 61);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (150, 2, 28, 1448);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (151, 2, 29, 34);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (152, 1, 29, 6);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (153, 1, 29, 119);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (154, 3, 30, 16);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (155, 1, 30, 135);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (156, 1, 30, 88);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (157, 1, 30, 138);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (158, 1, 31, 222);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (159, 1, 31, 485);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (160, 3, 31, 10);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (161, 1, 32, 96);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (162, 4, 32, 21);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (163, 2, 32, 17);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (164, 2, 33, 18);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (165, 1, 33, 1157);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (166, 1, 33, 60);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (82, 3, 14, 9);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (83, 1, 14, 130);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (84, 1, 14, 171);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (85, 1, 14, 545);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (86, 1, 15, 84);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (87, 1, 15, 205);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (88, 1, 15, 548);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (89, 2, 16, 8);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (90, 1, 16, 192);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (91, 1, 16, 393);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (92, 1, 16, 742);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (93, 1, 16, 914);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (167, 1, 33, 78);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (95, 1, 17, 120);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (96, 1, 17, 56);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (97, 1, 17, 1360);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (98, 1, 17, 1186);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (99, 1, 17, 1067);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (100, 2, 18, 51);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (101, 3, 18, 8);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (102, 1, 18, 626);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (103, 2, 18, 794);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (104, 3, 18, 778);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (105, 1, 18, 884);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (106, 3, 19, 9);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (107, 2, 19, 69);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (108, 1, 19, 171);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (168, 3, 33, 602);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (110, 1, 19, 367);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (111, 1, 19, 573);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (112, 1, 19, 1219);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (113, 2, 19, 1023);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (114, 1, 20, 393);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (115, 1, 20, 185);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (116, 1, 20, 907);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (117, 1, 20, 1487);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (118, 1, 21, 979);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (119, 1, 21, 1053);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (169, 1, 33, 281);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (121, 4, 21, 10);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (122, 3, 21, 8);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (123, 2, 21, 1020);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (124, 1, 21, 1315);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (125, 2, 22, 7);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (126, 1, 22, 163);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (127, 1, 22, 1201);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (128, 2, 22, 1075);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (129, 1, 22, 328);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (170, 1, 34, 77);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (171, 1, 34, 61);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (172, 4, 35, 12);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (173, 1, 35, 285);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (130, 3, 23, 15);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (131, 2, 23, 84);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (132, 1, 23, 175);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (133, 2, 23, 490);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (134, 2, 23, 139);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (135, 2, 24, 8);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (136, 2, 24, 86);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (137, 1, 24, 160);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (138, 1, 24, 75);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (139, 1, 25, 53);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (141, 1, 25, 92);
INSERT INTO public.detallepedido ("idDetallePedido", cantidad, idpedido, idproducto) VALUES (142, 1, 25, 265);


--
-- TOC entry 3098 (class 0 OID 58671)
-- Dependencies: 210
-- Data for Name: pedido; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (1, '2020-08-16', '20:10', 0, 597.81, 2, true, 'Entregado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (2, '2020-08-19', '15:52', 0, 1215.23, 2, true, 'Entregado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (3, '2020-09-30', '18:22', 0, 529.46, 2, true, 'Entregado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (4, '2020-09-10', '10:22', 0, 1553.08, 2, true, 'Entregado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (5, '2020-09-17', '21:12', 0, 774.26, 2, true, 'Entregado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (6, '2020-09-23', '11:49', 0, 999.16, 2, true, 'Entregado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (7, '2020-09-28', '16:12', 0, 1880.59, 2, true, 'Entregado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (8, '2020-10-07', '17:25', 0, 1414.9, 2, true, 'Entregado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (9, '2020-10-13', '9:44', 0, 1177.23, 2, true, 'Entregado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (10, '2020-10-20', '14:49', 0, 1163.55, 2, true, 'Entregado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (11, '2020-10-29', '12:52', 0, 1459.47, 2, true, 'Entregado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (12, '2020-11-12', '10:24', 0, 726.87, 2, true, 'Entregado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (13, '2020-11-18', '20:56', 0, 563.15, 2, true, 'Entregado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (14, '2020-11-25', '14:39', 0, 566.04, 2, true, 'Entregado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (15, '2020-12-06', '17:20', 0, 999.05, 2, true, 'Entregado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (16, '2020-12-15', '19:05', 5, 298.58, 2, true, 'Entregado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (17, '2020-12-18', '11:29', 5, 1097.14, 2, true, 'Entregado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (18, '2020-12-23', '15:14', 5, 831.84, 2, true, 'Entregado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (19, '2020-12-28', '16:36', 5, 633.32, 2, true, 'Entregado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (20, '2020-01-04', '7:13', 5, 448.46, 2, true, 'Entregado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (21, '2021-01-12', '17:06', 5, 705.4, 2, true, 'Entregado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (22, '2021-01-18', '19:20', 5, 705.72, 2, true, 'Entregado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (23, '2021-01-19', '11:21', 0, 0, 11, false, 'En Espera');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (24, '2021-01-20', '15:14', 0, 677.53, 12, true, 'Entregado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (25, '2021-01-23', '15:18', 5, 194.01, 2, true, 'Entregado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (26, '2021-01-25', '12:47', 5, 147.18, 2, true, 'Entregado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (27, '2021-01-27', '18:28', 5, 400.32, 2, true, 'Entregado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (28, '2021-01-18', '10:18', 5, 530.59, 2, true, 'Cancelado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (29, '2021-01-31', '13:24', 10, 296.98, 2, true, 'Entregado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (30, '2021-02-05', '19:34', 0, 501.6, 12, true, 'Entregado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (31, '2021-02-10', '13:50', 0, 151.86, 12, true, 'Entregado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (32, '2021-02-14', '16:05', 0, 547.91, 12, true, 'Entregado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (33, '2021-02-20', '09:25', 0, 743.28, 12, true, 'Entregado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (34, '2021-02-25', '11:52', 0, 199.14, 12, true, 'Cancelado');
INSERT INTO public.pedido ("idPedido", fecha, hora, descuento, totalpagar, "idCliente", estado, condicion) VALUES (35, '2021-02-25', '12:8', 0, 481.71, 12, true, 'Cancelado');


--
-- TOC entry 3099 (class 0 OID 58678)
-- Dependencies: 211
-- Data for Name: producto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1, 1000, 'Pastas', 'Lucchetti', 500.00, 'Gramos', 2500, 61.91, 'Fideo Moños');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (2, 1001, 'Pastas', 'Lucchetti', 500.00, 'Gramos', 3000, 61.91, 'Fideo Cabello de ángel');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (54, 2009, 'Arroz', 'Molto', 500.00, 'Gramos', 1499, 49.16, 'Arroz Integral');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (14, 1014, 'Pastas', 'Don Vicente', 500.00, 'Gramos', 1968, 98.45, 'Fideo Fetuccini');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (19, 1019, 'Pastas', 'Marolio', 500.00, 'Gramos', 2780, 71.12, 'Fideo Nido Al Huevo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (20, 1020, 'Pastas', 'Knorr', 200.00, 'Gramos', 1960, 92.83, 'Lasagna Espinaca');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (22, 1022, 'Pastas', 'Lucchetti', 500.00, 'Gramos', 3000, 44.70, 'Fideo Bucattini');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (23, 1023, 'Pastas', 'Lucchetti', 500.00, 'Gramos', 2700, 44.70, 'Fideo Codito');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (24, 1024, 'Pastas', 'Molto', 500.00, 'Gramos', 2600, 42.45, 'Fideo Bavette');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (25, 1025, 'Pastas', 'Santa Isabel', 500.00, 'Gramos', 2500, 30.13, 'Fideo Bavette');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (26, 1026, 'Pastas', 'Santa Isabel', 500.00, 'Gramos', 2650, 30.13, 'Fideo Codito');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (27, 1027, 'Pastas', 'Lucchetti', 500.00, 'Gramos', 2300, 69.35, 'Fideo 3 Vegetales Tirabuzón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (28, 1028, 'Pastas', 'Molto', 500.00, 'Gramos', 2250, 73.81, 'Fideo Dobladitos Espinaca');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (30, 1030, 'Pastas', 'Cica', 500.00, 'Gramos', 2099, 33.49, 'Fideo Mostachol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (33, 1033, 'Pastas', 'Cica', 500.00, 'Gramos', 2100, 33.49, 'Fideo Rigatti');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (37, 1037, 'Pastas', 'Knorr', 500.00, 'Gramos', 1900, 44.70, 'Fideo Foratti');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (38, 1038, 'Pastas', 'Knorr', 500.00, 'Gramos', 1700, 44.70, 'Fideo Caracoles');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (39, 1039, 'Pastas', 'Santa Isabel', 500.00, 'Gramos', 2000, 30.13, 'Fideo Mostachol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (40, 1040, 'Pastas', 'Santa Isabel', 500.00, 'Gramos', 2000, 30.13, 'Fideo Celentano');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (42, 1042, 'Pastas', 'Molto', 500.00, 'Gramos', 1800, 42.45, 'Fideo Pampero');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (43, 1201, 'Pastas', 'Molto', 500.00, 'Gramos', 1300, 54.20, 'Canelones');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (44, 1301, 'Pastas', 'Lucchetti', 500.00, 'Gramos', 700, 174.04, 'Capellini Lucchettinis Multicolor');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (45, 1302, 'Pastas', 'Lucchetti', 500.00, 'Gramos', 700, 176.04, 'Capellini Lucchettinis Carnes');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (46, 2001, 'Arroz', 'Marolio', 500.00, 'Gramos', 1600, 53.20, 'Arroz Doble');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (47, 2002, 'Arroz', 'Marolio', 1.00, 'Kilogramos', 1600, 104.05, 'Arroz Doble');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (48, 2003, 'Arroz', 'Marolio', 500.00, 'Gramos', 1700, 55.88, 'Arroz Parboil');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (49, 2004, 'Arroz', 'Marolio', 1.00, 'Kilogramos', 1500, 78.29, 'Arroz Largo Fino');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (50, 2005, 'Arroz', 'Marolio', 500.00, 'Gramos', 1200, 44.69, 'Arroz Largo Fino');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (52, 2007, 'Arroz', 'Molto', 500.00, 'Kilogramos', 2300, 57.68, 'Arroz Doble Carolina');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (55, 2010, 'Arroz', 'Molto', 1.00, 'Kilogramos', 1600, 88.38, 'Arroz Largo Fino');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (58, 2013, 'Arroz', 'Molto', 500.00, 'Gramos', 1600, 60.35, 'Arroz Parboil');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (59, 2014, 'Arroz', 'Fabiola', 1.00, 'Kilogramos', 1500, 135.39, 'Arroz Fortuna 00000');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (62, 2017, 'Arroz', 'Lucchetti', 1.00, 'Kilogramos', 1300, 142.14, 'Arroz Doble Carolina');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (63, 2018, 'Arroz', 'Lucchetti', 1.00, 'Kilogramos', 2100, 76.71, 'Arroz Largo Fino');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (65, 2020, 'Arroz', 'Lucchetti', 500.00, 'Gramos', 1800, 42.45, 'Arroz Largo Fino');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (68, 2023, 'Arroz', 'Gallo', 1.00, 'Kilogramos', 1400, 114.13, 'Arroz Gallo Oro Estuche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (70, 2025, 'Arroz', 'Gallo', 500.00, 'Gramos', 1300, 52.08, 'Arroz Largo Fino');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (72, 2027, 'Arroz', 'Gallo', 1.00, 'Kilogramos', 1200, 196.55, 'Arroz Doble Carolina Estuche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (73, 2028, 'Arroz', 'Gallo', 1.00, 'Kilogramos', 1300, 94.63, 'Arroz Largo Fino');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (74, 2029, 'Arroz', 'Gallo', 1.00, 'Kilogramos', 1200, 113.01, 'Arroz Oro Bolsa');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (76, 3002, 'Aceites', 'Cañuelas', 500.00, 'Centímetro Cúbico', 1500, 353.80, 'Aceite Oliva Extra Virgen Suave Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (156, 3221, 'Vinagres', 'Dos Anclas', 1.00, 'Litro', 1000, 87.25, 'Vinagre Manzana');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (304, 3528, 'Aderezos', 'Fanacoa', 118.00, 'Gramos', 1200, 16.25, 'Mayonesa Sachet');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (66, 2021, 'Arroz', 'Knorr', 194.00, 'Gramos', 1300, 147.58, 'Arroz Primavera');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (4, 1004, 'Pastas', 'Terrabusi', 500.00, 'Gramos', 3490, 51.36, 'Fideo Tallarin');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (35, 1035, 'Pastas', 'Knorr', 500.00, 'Gramos', 1595, 59.62, 'Fideo Mostachol Mix de Sabores');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (41, 1041, 'Pastas', 'Molto', 500.00, 'Gramos', 1796, 42.45, 'Fideo Pamperitos');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (82, 3008, 'Aceites', 'Cañuelas', 500.00, 'Centímetro Cúbico', 1600, 298.01, 'Aceite Oliva Extra Virgen Suave Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (83, 3009, 'Aceites', 'Cañuelas', 500.00, 'Centímetro Cúbico', 1300, 353.80, 'Aceite Oliva Extra Virgen Intenso Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (85, 3011, 'Aceites', 'Cañuelas', 187.00, 'Centímetro Cúbico', 1300, 105.57, 'Aceite Aerosol Girasol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (87, 3013, 'Aceites', 'Cañuelas', 900.00, 'Centímetro Cúbico', 1500, 102.03, 'Aceite Girasol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (32, 1032, 'Pastas', 'Cica', 500.00, 'Gramos', 2153, 33.49, 'Fideo Tallarines');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (31, 1031, 'Pastas', 'Cica', 500.00, 'Gramos', 2194, 33.49, 'Fideo Spaghetti');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (71, 2026, 'Arroz', 'Gallo', 500.00, 'Gramos', 1293, 62.16, 'Arroz Oro');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (11, 1011, 'Pastas', 'Matarazzo', 500.00, 'Gramos', 3238, 64.84, 'Fideo Mostachol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (77, 3003, 'Aceites', 'Cañuelas', 1.00, 'Litro', 1998, 148.85, 'Aceite Maiz');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (34, 1034, 'Pastas', 'Knorr', 500.00, 'Gramos', 1683, 58.14, 'Fideo Tirabuzón Mix de Sabores');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (6, 1006, 'Pastas', 'Lucchetti', 500.00, 'Gramos', 2283, 73.81, 'Fideo Nido Fetuccini');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (16, 1016, 'Pastas', 'Molto', 500.00, 'Gramos', 2393, 74.92, 'Fideo Moños Espinaca');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (15, 1015, 'Pastas', 'Molto', 500.00, 'Gramos', 2168, 74.92, 'Fideo Moños');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (75, 3001, 'Aceites', 'Cañuelas', 500.00, 'Centímetro Cúbico', 2393, 268.68, 'Aceite Oliva Extra Virgen Petaca');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (53, 2008, 'Arroz', 'Molto', 1.00, 'Kilogramos', 1191, 88.38, 'Arroz Integral');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (12, 1012, 'Pastas', 'Don Vicente', 500.00, 'Gramos', 1670, 98.44, 'Fideo Tallarin');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (21, 1021, 'Pastas', 'Santa Isabel', 500.00, 'Gramos', 2476, 30.13, 'Fideo Dedalón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (18, 1018, 'Pastas', 'Santa Isabel', 500.00, 'Gramos', 3635, 30.13, 'Fideo Foratti');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (78, 3004, 'Aceites', 'Cañuelas', 1.00, 'Litro', 2195, 218.28, 'Aceite Girasol Oliva Extra Virgen');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (89, 3015, 'Aceites', 'Cañuelas', 3.00, 'Litro', 1500, 312.48, 'Aceite Girasol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (95, 3021, 'Aceites', 'Natura', 500.00, 'Centímetro Cúbico', 1200, 337.97, 'Aceite Oliva Extra Virgen Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (97, 3023, 'Aceites', 'Natura', 900.00, 'Centímetro Cúbico', 1300, 215.32, 'Aceite Blend');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (98, 3024, 'Aceites', 'Natura', 120.00, 'Centímetro Cúbico', 1200, 168.90, 'Aceite Aerosol Oliva Virgen');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (100, 3026, 'Aceites', 'Natura', 500.00, 'Centímetro Cúbico', 1000, 386.10, 'Aceite Oliva Extra Virgen Botella');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (102, 3028, 'Aceites', 'Natura', 5.00, 'Litro', 1000, 779.24, 'Aceite Girasol Bidón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (103, 3029, 'Aceites', 'Molto', 900.00, 'Centímetro Cúbico', 1200, 139.89, 'Aceite Girasol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (104, 3030, 'Aceites', 'Molto', 1.50, 'Litro', 1500, 235.09, 'Aceite Girasol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (105, 3031, 'Aceites', 'Molto', 3.00, 'Litro', 1000, 307.07, 'Aceite Girasol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (106, 3032, 'Aceites', 'Molto', 5.00, 'Litro', 800, 457.51, 'Aceite Girasol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (107, 3033, 'Aceites', 'Molto', 120.00, 'Centímetro Cúbico', 1500, 123.09, 'Aceite Aerosol Girasol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (108, 3034, 'Aceites', 'Molto', 120.00, 'Centímetro Cúbico', 1500, 123.09, 'Aceite Aerosol Manteca');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (109, 3035, 'Aceites', 'Molto', 500.00, 'Centímetro Cúbico', 1300, 106.29, 'Aceite Maiz');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (110, 3036, 'Aceites', 'Molto', 500.00, 'Centímetro Cúbico', 1300, 87.25, 'Aceite Blend');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (111, 3037, 'Aceites', 'Molto', 500.00, 'Centímetro Cúbico', 1300, 80.63, 'Aceite Girasol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (80, 3006, 'Aceites', 'Cañuelas', 500.00, 'Centímetro Cúbico', 1700, 268.68, 'Aceite Oliva Extra Virgen Suave Petaca');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (81, 3007, 'Aceites', 'Cañuelas', 500.00, 'Centímetro Cúbico', 1500, 268.68, 'Aceite Oliva Extra Virgen Intenso Petaca');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (112, 3038, 'Aceites', 'Molto', 250.00, 'Centímetro Cúbico', 1200, 156.68, 'Aceite Oliva Extra Virgen Clásico');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (113, 3039, 'Aceites', 'Molto', 500.00, 'Centímetro Cúbico', 1200, 269.69, 'Aceite Oliva Extra Virgen Clásico');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (114, 3040, 'Aceites', 'Molto', 120.00, 'Centímetro Cúbico', 1000, 156.68, 'Aceite Aerosol Oliva');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (116, 3042, 'Aceites', 'Marolio', 4.50, 'Litro', 800, 394.13, 'Aceite Mezcla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (115, 3041, 'Aceites', 'Marolio', 1.50, 'Litro', 1200, 176.85, 'Aceite Mezcla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (122, 3047, 'Aceites', 'Marolio', 4.50, 'Litro', 800, 446.32, 'Aceite Girasol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (123, 3048, 'Aceites', 'Marolio', 500.00, 'Centímetro Cúbico', 1000, 268.68, 'Aceite Oliva Botella');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (124, 3049, 'Aceites', 'Marolio', 250.00, 'Centímetro Cúbico', 1000, 145.44, 'Aceite Oliva Botella');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (125, 3050, 'Aceites', 'Cocinero', 900.00, 'Mililitro', 1200, 123.09, 'Aceite Blend');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (126, 3051, 'Aceites', 'Cocinero', 1.50, 'Litro', 1200, 201.49, 'Aceite Girasol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (128, 3053, 'Aceites', 'Cocinero', 500.00, 'Centímetro Cúbico', 1000, 287.28, 'Aceite Oliva Petaca');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (129, 3054, 'Aceites', 'Cocinero', 900.00, 'Centímetro Cúbico', 1200, 111.89, 'Aceite Mezcla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (132, 3057, 'Aceites', 'Pureza', 900.00, 'Centímetro Cúbico', 1000, 145.49, 'Aceite Girasol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (133, 3058, 'Aceites', 'Pureza', 1.50, 'Litro', 1000, 240.68, 'Aceite Girasol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (134, 3059, 'Aceites', 'Ideal', 900.00, 'Centímetro Cúbico', 1500, 81.99, 'Aceite Girasol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (136, 3201, 'Vinagres', 'Marolio', 1.00, 'Litro', 1700, 50.29, 'Vinagre Blanco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (137, 3202, 'Vinagres', 'Marolio', 500.00, 'Centímetro Cúbico', 1800, 60.35, 'Vinagre Manzana');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (141, 3206, 'Vinagres', 'Marolio', 500.00, 'Mililitro', 800, 117.48, 'Vinagre Balsámico');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (142, 3207, 'Vinagres', 'Marolio', 250.00, 'Mililitro', 800, 72.70, 'Vinagre Balsámico');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (143, 3208, 'Vinagres', 'Molto', 500.00, 'Centímetro Cúbico', 1200, 42.45, 'Vinagre Alcohol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (145, 3210, 'Vinagres', 'Molto', 500.00, 'Centímetro Cúbico', 1200, 67.08, 'Vinagre Manzana');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (146, 3211, 'Vinagres', 'Molto', 1.00, 'Litro', 800, 100.70, 'Vinagre Manzana');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (149, 3214, 'Vinagres', 'Molto', 250.00, 'Mililitro', 800, 83.89, 'Aceto Reducción');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (150, 3215, 'Vinagres', 'Molto', 500.00, 'Mililitro', 800, 132.05, 'Aceto Reducción');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (151, 3216, 'Vinagres', 'Dos Anclas', 500.00, 'Centímetro Cúbico', 1200, 37.97, 'Vinagre Alcohol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (152, 3217, 'Vinagres', 'Dos Anclas', 500.00, 'Centímetro Cúbico', 1200, 51.40, 'Vinagre Vino');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (153, 3218, 'Vinagres', 'Dos Anclas', 500.00, 'Centímetro Cúbico', 1200, 59.25, 'Vinagre Manzana');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (154, 3219, 'Vinagres', 'Dos Anclas', 1.00, 'Litro', 100, 53.65, 'Vinagre Alcohol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (155, 3220, 'Vinagres', 'Dos Anclas', 1.00, 'Litro', 100, 85.01, 'Vinagre Vino');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (148, 3213, 'Vinagres', 'Molto', 1.00, 'Litro', 1000, 89.48, 'Vinagre Vino');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (140, 3205, 'Vinagres', 'Marolio', 500.00, 'Centímetro Cúbico', 1500, 49.16, 'Vinagre Vino');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (93, 3019, 'Aceites', 'Natura', 3.00, 'Litro', 1199, 503.89, 'Aceite Girasol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (118, 3043, 'Aceites', 'Marolio', 900.00, 'Centímetro Cúbico', 1098, 106.29, 'Aceite Mezcla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (131, 3056, 'Aceites', 'Cocinero', 500.00, 'Centímetro Cúbico', 999, 315.73, 'Aceite Oliva Extra Virgen Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (94, 3020, 'Aceites', 'Natura', 120.00, 'Centímetro Cúbico', 1990, 132.70, 'Aceite Aerosol Rocio Vegetal');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (157, 3223, 'Vinagres', 'Dos Anclas', 250.00, 'Centímetro Cúbico', 1000, 93.97, 'Aceto Balsámico Petaca');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (162, 3228, 'Vinagres', 'Menoyo', 500.00, 'Centímetro Cúbico', 1200, 67.75, 'Vinagre Manzana');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (170, 3306, 'Aderezos', 'Marolio', 295.00, 'Gramos', 1199, 59.64, 'Aji Suave Pomo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (158, 3224, 'Vinagres', 'Menoyo', 1.00, 'Litro', 999, 69.33, 'Vinagre Blanco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (173, 3309, 'Aderezos', 'Marolio', 1.00, 'Kilogramos', 800, 110.78, 'Salsa Soja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (121, 3046, 'Aceites', 'Marolio', 3.00, 'Litro', 792, 306.31, 'Aceite Girasol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (117, 3043, 'Aceites', 'Marolio', 3.00, 'Litro', 799, 246.28, 'Aceite Mezcla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (96, 3022, 'Aceites', 'Natura', 500.00, 'Centímetro Cúbico', 1194, 337.97, 'Aceite Oliva Extra Virgen Intenso Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (139, 3204, 'Vinagres', 'Marolio', 1.00, 'Litro', 1312, 78.29, 'Vinagre Vino');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (119, 3044, 'Aceites', 'Marolio', 900.00, 'Centímetro Cúbico', 1193, 139.89, 'Aceite Girasol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (135, 3200, 'Vinagres', 'Marolio', 500.00, 'Centímetro Cúbico', 1791, 36.84, 'Vinagre Blanco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (88, 3014, 'Aceites', 'Cañuelas', 1.50, 'Litro', 1491, 150.52, 'Aceite Girasol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (92, 3018, 'Aceites', 'Natura', 500.00, 'Centímetro Cúbico', 2486, 87.95, 'Aceite Girasol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (138, 3203, 'Vinagres', 'Marolio', 1.00, 'Litro', 1491, 89.48, 'Vinagre Manzana');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (174, 3310, 'Aderezos', 'Marolio', 1.00, 'Kilogramos', 800, 104.05, 'Chimichurri Clásico');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (187, 3323, 'Aderezos', 'Dos Anclas', 500.00, 'Centímetro Cúbico', 800, 179.09, 'Salsa Soja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (159, 3225, 'Vinagres', 'Menoyo', 1.00, 'Litro', 999, 89.85, 'Vinagre Vino');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (203, 3339, 'Aderezos', 'Natura', 125.00, 'Centímetro Cúbico', 1000, 31.04, 'Salsa Golf Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (201, 3337, 'Aderezos', 'Natura', 250.00, 'Centímetro Cúbico', 1000, 61.43, 'Ketchup Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (200, 3336, 'Aderezos', 'Natura', 250.00, 'Centímetro Cúbico', 1000, 59.85, 'Salsa Golf Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (199, 3335, 'Aderezos', 'Hellmann''s', 1.00, 'Kilogramos', 800, 223.43, 'Salsa Barbacoa Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (198, 3334, 'Aderezos', 'Hellmann''s', 250.00, 'Gramos', 800, 81.18, 'Salsa Barbacoa Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (197, 3333, 'Aderezos', 'Hellmann''s', 500.00, 'Gramos', 800, 187.39, 'Ketchup Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (196, 3332, 'Aderezos', 'Hellmann''s', 250.00, 'Gramos', 800, 79.82, 'Salsa Golf Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (195, 3331, 'Aderezos', 'Hellmann''s', 250.00, 'Gramos', 800, 95.08, 'Ketchup Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (193, 3329, 'Aderezos', 'Hellmann''s', 60.00, 'Gramos', 1200, 32.37, 'Ketchup Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (183, 3319, 'Aderezos', 'Savora', 250.00, 'Gramos', 800, 67.63, 'Mostaza Suave Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (180, 3316, 'Aderezos', 'Savora', 1.00, 'Kilogramos', 800, 200.36, 'Mostaza Original Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (182, 3318, 'Aderezos', 'Savora', 500.00, 'Gramos', 800, 145.48, 'Mostaza Original Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (204, 3340, 'Aderezos', 'Fanacoa', 250.00, 'Gramos', 800, 56.79, 'Salsa Golf Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (206, 3342, 'Aderezos', 'Fanacoa', 250.00, 'Gramos', 800, 51.36, 'Ketchup Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (208, 3344, 'Aderezos', 'Ri-k', 250.00, 'Gramos', 800, 58.14, 'Ketchup Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (209, 3345, 'Aderezos', 'Ri-k', 250.00, 'Gramos', 800, 55.43, 'Salsa Golf Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (207, 3343, 'Aderezos', 'Ri-k', 250.00, 'Gramos', 800, 43.23, 'Mostaza Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (211, 3347, 'Aderezos', 'Vanoli', 180.00, 'Gramos', 600, 73.81, 'Salsa Inglesa');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (212, 3348, 'Aderezos', 'Vanoli', 950.00, 'Centímetro Cúbico', 600, 208.60, 'Salsa Inglesa');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (214, 3400, 'Condimentos y Especias', 'Alicante', 25.00, 'Gramos', 600, 30.13, 'Aji Molido Triturado');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (215, 3401, 'Condimentos y Especias', 'Alicante', 25.00, 'Gramos', 600, 45.81, 'Chimichurri');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (217, 3403, 'Condimentos y Especias', 'Alicante', 25.00, 'Gramos', 600, 37.97, 'Pimentón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (218, 3404, 'Condimentos y Especias', 'Alicante', 50.00, 'Gramos', 600, 52.53, 'Ajo Deshidratado');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (219, 3405, 'Condimentos y Especias', 'Alicante', 50.00, 'Gramos', 600, 77.16, 'Cebolla Deshidratada');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (221, 3407, 'Condimentos y Especias', 'Alicante', 50.00, 'Gramos', 600, 98.45, 'Orégano');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (216, 3402, 'Condimentos y Especias', 'Alicante', 25.00, 'Gramos', 600, 53.65, 'Orégano');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (224, 3410, 'Condimentos y Especias', 'Alicante', 25.00, 'Gramos', 600, 50.29, 'Pimienta Blanca en Grano');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (225, 3411, 'Condimentos y Especias', 'Alicante', 25.00, 'Gramos', 600, 53.64, 'Pimienta Negra en Grano');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (226, 3412, 'Condimentos y Especias', 'Alicante', 15.00, 'Gramos', 600, 25.64, 'Tomillo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (227, 3413, 'Condimentos y Especias', 'Alicante', 25.00, 'Gramos', 600, 73.81, 'Canela Molida');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (228, 3414, 'Condimentos y Especias', 'Alicante', 25.00, 'Gramos', 600, 50.29, 'Comino Molido');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (229, 3415, 'Condimentos y Especias', 'Alicante', 25.00, 'Gramos', 600, 40.21, 'Condimento para Pizza');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (230, 3416, 'Condimentos y Especias', 'Alicante', 25.00, 'Gramos', 600, 37.97, 'Condimento para Arroz');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (231, 3417, 'Condimentos y Especias', 'Alicante', 25.00, 'Gramos', 600, 117.48, 'Nuez Moscada');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (164, 3300, 'Aderezos', 'Marolio', 280.00, 'Gramos', 1200, 57.02, 'Salsa Inglesa Pomo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (165, 3301, 'Aderezos', 'Marolio', 285.00, 'Gramos', 1200, 54.60, 'Chimichurri Clásico Pomo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (166, 3302, 'Aderezos', 'Marolio', 285.00, 'Gramos', 1200, 54.60, 'Chimichurri Picante Pomo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (167, 3303, 'Aderezos', 'Marolio', 285.00, 'Gramos', 1200, 54.60, 'Chimichurri Ahumado Pomo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (168, 3304, 'Aderezos', 'Marolio', 280.00, 'Gramos', 1200, 54.60, 'Salsa Soja Pomo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (169, 3305, 'Aderezos', 'Marolio', 295.00, 'Gramos', 1200, 59.64, 'Aji Picante Pomo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (172, 3308, 'Aderezos', 'Marolio', 280.00, 'Gramos', 1200, 57.02, 'Salsa Provenzal Pomo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (176, 3312, 'Aderezos', 'Savora', 200.00, 'Gramos', 1000, 83.89, 'Mostaza Original Pomo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (179, 3315, 'Aderezos', 'Savora', 250.00, 'Gramos', 999, 73.81, 'Mostaza Original Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (178, 3314, 'Aderezos', 'Savora', 200.00, 'Gramos', 800, 82.53, 'Mostaza Suave Pomo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (184, 3320, 'Aderezos', 'Dos Anclas', 350.00, 'Centímetro Cúbico', 800, 145.49, 'Salsa Caesar Pomo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (186, 3322, 'Aderezos', 'Dos Anclas', 375.00, 'Centímetro Cúbico', 800, 129.81, 'Salsa Aji Picante Pomo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (188, 3324, 'Aderezos', 'Dos Anclas', 420.00, 'Gramos', 800, 81.30, 'Kepchup Pomo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (190, 3326, 'Aderezos', 'Dos Anclas', 360.00, 'Centímetro Cúbico', 800, 162.29, 'Salsa Spicy Pomo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (194, 3330, 'Aderezos', 'Hellmann''s', 240.00, 'Gramos', 800, 188.24, 'Salsa Aji Picante Pomo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (305, 3529, 'Aderezos', 'Fanacoa', 950.00, 'Gramos', 800, 135.39, 'Mayonesa Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (177, 3313, 'Aderezos', 'Savora', 370.00, 'Gramos', 799, 126.71, 'Mostaza Original Pomo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (210, 3346, 'Aderezos', 'Vanoli', 500.00, 'Gramos', 599, 64.84, 'Salsa Soja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (234, 3420, 'Condimentos y Especias', 'Alicante', 50.00, 'Gramos', 600, 89.48, 'Chimichurri');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (235, 3421, 'Condimentos y Especias', 'Alicante', 40.00, 'Gramos', 600, 47.42, 'Salsa Blanca');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (236, 3422, 'Condimentos y Especias', 'Alicante', 25.00, 'Gramos', 600, 44.70, 'Condimento para Tucos y  Guisos');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (237, 3423, 'Condimentos y Especias', 'Alicante', 25.00, 'Gramos', 600, 44.70, 'Condimento para Milanesas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (238, 3424, 'Condimentos y Especias', 'Alicante', 25.00, 'Gramos', 600, 62.61, 'Pimienta Blanca Molida');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (239, 3425, 'Condimentos y Especias', 'Alicante', 25.00, 'Gramos', 600, 88.35, 'Nuez Moscada Entera');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (240, 3426, 'Condimentos y Especias', 'Alicante', 25.00, 'Gramos', 600, 44.70, 'Condimento para Carnes');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (241, 3427, 'Condimentos y Especias', 'Alicante', 25.00, 'Gramos', 600, 44.70, 'Condimento para Empanadas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (242, 3428, 'Condimentos y Especias', 'Alicante', 25.00, 'Gramos', 600, 44.70, 'Condimento para Vegetales Cocidos');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (202, 3338, 'Aderezos', 'Natura', 250.00, 'Centímetro Cúbico', 997, 45.64, 'Mostaza Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (160, 3226, 'Vinagres', 'Menoyo', 1.00, 'Litro', 992, 100.91, 'Vinagre Manzana');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (220, 3406, 'Condimentos y Especias', 'Alicante', 50.00, 'Gramos', 593, 29.67, 'Bicarbonato de Sodio');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (213, 3349, 'Aderezos', 'Knorr', 1.00, 'Litro', 293, 348.15, 'Salsa Soja Shoyu');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (222, 3408, 'Condimentos y Especias', 'Alicante', 25.00, 'Gramos', 592, 37.97, 'Pimienta Negra Molida');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (243, 3429, 'Condimentos y Especias', 'Alicante', 10.00, 'Gramos', 600, 59.25, 'Laurel en Hojas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (244, 3430, 'Condimentos y Especias', 'Alicante', 16.00, 'Gramos', 200, 806.30, 'Azafrán');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (246, 3432, 'Condimentos y Especias', 'Dos Anclas', 25.00, 'Gramos', 600, 23.40, 'Chimichurri');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (247, 3433, 'Condimentos y Especias', 'Dos Anclas', 50.00, 'Gramos', 600, 108.52, 'Pimienta Negra en Grano');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (249, 3435, 'Condimentos y Especias', 'Dos Anclas', 25.00, 'Gramos', 600, 33.49, 'Romero');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (250, 3436, 'Condimentos y Especias', 'Dos Anclas', 25.00, 'Gramos', 600, 41.33, 'Tomillo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (251, 3437, 'Condimentos y Especias', 'Dos Anclas', 50.00, 'Gramos', 600, 67.08, 'Comino Molido');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (252, 3438, 'Condimentos y Especias', 'Dos Anclas', 25.00, 'Gramos', 600, 33.49, 'Ajo Deshidratado');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (253, 3439, 'Condimentos y Especias', 'Dos Anclas', 25.00, 'Gramos', 600, 15.57, 'Bicarbonato de Sodio');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (254, 3440, 'Condimentos y Especias', 'Dos Anclas', 30.00, 'Gramos', 600, 48.04, 'Canela Molida');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (255, 3441, 'Condimentos y Especias', 'Dos Anclas', 25.00, 'Gramos', 600, 81.65, 'Nuez Moscada Molida');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (256, 3442, 'Condimentos y Especias', 'Dos Anclas', 25.00, 'Gramos', 600, 36.84, 'Perejil Deshidratado');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (257, 3443, 'Condimentos y Especias', 'Dos Anclas', 25.00, 'Gramos', 600, 31.25, 'Orégano');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (258, 3444, 'Condimentos y Especias', 'Dos Anclas', 25.00, 'Gramos', 600, 33.49, 'Provenzal');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (259, 3445, 'Condimentos y Especias', 'Dos Anclas', 25.00, 'Gramos', 600, 29.00, 'Condimento para Pizza');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (260, 3446, 'Condimentos y Especias', 'Dos Anclas', 50.00, 'Gramos', 600, 48.04, 'Pimentón Extra');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (261, 3447, 'Condimentos y Especias', 'Dos Anclas', 50.00, 'Gramos', 600, 37.97, 'Ají Molido');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (262, 3448, 'Condimentos y Especias', 'Dos Anclas', 25.00, 'Gramos', 600, 41.33, 'Pimienta Blanca Molida');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (263, 3449, 'Condimentos y Especias', 'Dos Anclas', 40.00, 'Gramos', 600, 24.53, 'Salsa Blanca');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (264, 3450, 'Condimentos y Especias', 'Marolio', 25.00, 'Gramos', 600, 27.89, 'Ají Molido');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (266, 3452, 'Condimentos y Especias', 'Marolio', 50.00, 'Gramos', 600, 26.77, 'Bicarbonato de Sodio');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (267, 3453, 'Condimentos y Especias', 'Marolio', 25.00, 'Gramos', 600, 31.25, 'Condimento para Pizza');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (268, 3454, 'Condimentos y Especias', 'Marolio', 25.00, 'Gramos', 600, 31.25, 'Nuez Moscada Molida');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (269, 3455, 'Condimentos y Especias', 'Marolio', 25.00, 'Gramos', 600, 29.00, 'Orégano en Hoja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (270, 3456, 'Condimentos y Especias', 'Marolio', 25.00, 'Gramos', 600, 30.92, 'Pimentón Dulce');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (271, 3457, 'Condimentos y Especias', 'Marolio', 25.00, 'Gramos', 600, 58.13, 'Pimienta Blanca Molida');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (273, 3459, 'Condimentos y Especias', 'Knorr', 35.00, 'Gramos', 350, 85.24, 'Salsa 4 Quesos');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (274, 3460, 'Condimentos y Especias', 'Knorr', 22.00, 'Gramos', 350, 85.24, 'Salsa Blanca');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (275, 3461, 'Condimentos y Especias', 'Knorr', 11.00, 'Gramos', 350, 85.24, 'Salsa Pesto');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (276, 3500, 'Aderezos', 'Hellmann''s', 475.00, 'Gramos', 1000, 123.09, 'Mayonesa Light Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (277, 3501, 'Aderezos', 'Hellmann''s', 237.00, 'Gramos', 1000, 67.08, 'Mayonesa Light Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (278, 3502, 'Aderezos', 'Hellmann''s', 118.00, 'Gramos', 1200, 36.84, 'Mayonesa Light Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (279, 3503, 'Aderezos', 'Hellmann''s', 250.00, 'Gramos', 1000, 81.18, 'Mayonesa Libre Colesterol Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (181, 3317, 'Aderezos', 'Savora', 220.00, 'Gramos', 800, 161.14, 'Mostaza con Miel Pomo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (191, 3327, 'Aderezos', 'Dos Anclas', 360.00, 'Centímetro Cúbico', 800, 162.29, 'Salsa Alioli Pomo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (299, 3523, 'Aderezos', 'Natura', 250.00, 'Gramos', 1199, 58.14, 'Mayonesa Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (282, 3506, 'Aderezos', 'Hellmann''s', 238.00, 'Gramos', 1000, 83.89, 'Mayonesa con Aceite de Oliva Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (283, 3507, 'Aderezos', 'Hellmann''s', 950.00, 'Gramos', 1000, 271.08, 'Mayonesa Light Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (284, 3508, 'Aderezos', 'Hellmann''s', 242.00, 'Gramos', 1000, 50.01, 'Mayonesa Suave Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (288, 3512, 'Aderezos', 'Hellmann''s', 332.00, 'Gramos', 1200, 119.94, 'Mayonesa Clásica Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (290, 3514, 'Aderezos', 'Hellmann''s', 237.00, 'Gramos', 1200, 54.76, 'Mayonesa Clásica Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (291, 3515, 'Aderezos', 'Hellmann''s', 118.00, 'Gramos', 1200, 24.53, 'Mayonesa Clásica Sachet');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (292, 3516, 'Aderezos', 'Molto', 120.00, 'Gramos', 1500, 17.81, 'Mayonesa Sachet');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (293, 3517, 'Aderezos', 'Molto', 241.00, 'Gramos', 1200, 39.08, 'Mayonesa Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (294, 3518, 'Aderezos', 'Molto', 482.00, 'Gramos', 1200, 72.70, 'Mayonesa Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (295, 3519, 'Aderezos', 'Molto', 965.00, 'Gramos', 800, 139.89, 'Mayonesa Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (296, 3520, 'Aderezos', 'Molto', 241.00, 'Gramos', 1000, 39.08, 'Mayonesa Light Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (297, 3521, 'Aderezos', 'Molto', 482.00, 'Gramos', 1000, 72.70, 'Mayonesa Light Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (298, 3522, 'Aderezos', 'Natura', 1.00, 'Kilogramos', 1200, 203.15, 'Mayonesa Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (300, 3524, 'Aderezos', 'Natura', 500.00, 'Gramos', 1200, 105.57, 'Mayonesa Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (301, 3525, 'Aderezos', 'Natura', 125.00, 'Gramos', 1200, 28.33, 'Mayonesa Sachet');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (302, 3526, 'Aderezos', 'Natura', 2.90, 'Kilogramos', 800, 410.42, 'Mayonesa Sachet');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (303, 3527, 'Aderezos', 'Fanacoa', 237.00, 'Gramos', 1200, 37.81, 'Mayonesa Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (306, 3530, 'Aderezos', 'Fanacoa', 475.00, 'Gramos', 1200, 55.44, 'Mayonesa Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (307, 3531, 'Aderezos', 'Ri-k', 121.00, 'Gramos', 1200, 21.55, 'Mayonesa Sachet');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (308, 3532, 'Aderezos', 'Ri-k', 970.00, 'Gramos', 800, 182.82, 'Mayonesa Sin Colesterol Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (309, 3533, 'Aderezos', 'Ri-k', 242.00, 'Gramos', 1200, 47.30, 'Mayonesa Sin Colesterol Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (310, 3534, 'Aderezos', 'Ri-k', 485.00, 'Gramos', 1200, 77.11, 'Mayonesa Sin Colesterol Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (311, 3535, 'Aderezos', 'Mayoliva', 500.00, 'Gramos', 1000, 125.90, 'Mayonesa con Aceite de Oliva Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (312, 3536, 'Aderezos', 'Mayoliva', 250.00, 'Gramos', 1000, 46.84, 'Mayonesa con Aceite de Oliva Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (313, 3537, 'Aderezos', 'Mayoliva', 125.00, 'Gramos', 1200, 33.75, 'Mayonesa con Aceite de Oliva Sachet');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (314, 3538, 'Aderezos', 'Dánica', 100.00, 'Gramos', 1800, 5.80, 'Mayonesa Fiesta Sachet');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (365, 3703, 'Salsas', 'Molto', 340.00, 'Gramos', 1200, 44.70, 'Salsa Pizza en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (315, 3600, 'Condimentos', 'Celusal', 1.00, 'Kilogramos', 1200, 55.89, 'Sal Entrefina para la Parrilla en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (316, 3601, 'Condimentos', 'Celusal', 1.00, 'Kilogramos', 1200, 115.24, 'Sal Gruesa en Salero');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (317, 3602, 'Condimentos', 'Celusal', 1.00, 'Kilogramos', 1200, 126.44, 'Sal Entrefina para la Parrilla en Salero');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (245, 3431, 'Condimentos y Especias', 'Dos Anclas', 25.00, 'Gramos', 597, 27.89, 'Pimentón Extra');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (281, 3505, 'Aderezos', 'Hellmann''s', 332.00, 'Gramos', 1194, 123.19, 'Mayonesa Clásica Pomo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (286, 3510, 'Aderezos', 'Hellmann''s', 232.00, 'Gramos', 1199, 97.44, 'Mayonesa Receta tipo Casera Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (265, 3451, 'Condimentos y Especias', 'Marolio', 25.00, 'Gramos', 593, 27.89, 'Chimichurri');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (285, 3509, 'Aderezos', 'Hellmann''s', 242.00, 'Gramos', 1000, 87.95, 'Mayonesa con Aceite de Palta Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (318, 3603, 'Condimentos', 'Celusal', 500.00, 'Gramos', 1200, 121.96, 'Sal Light en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (319, 3604, 'Condimentos', 'Celusal', 500.00, 'Gramos', 1200, 49.16, 'Sal Plus con Hierro en Paquete');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (320, 3605, 'Condimentos', 'Celusal', 500.00, 'Gramos', 1200, 50.30, 'Sal Plus con Hierro en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (321, 3606, 'Condimentos', 'Celusal', 500.00, 'Gramos', 1200, 145.48, 'Sal Plus con Hierro en Salero');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (322, 3607, 'Condimentos', 'Celusal', 230.00, 'Gramos', 1200, 115.54, 'Sal con Hierbas en Salero');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (323, 3608, 'Condimentos', 'Celusal', 230.00, 'Gramos', 1200, 115.54, 'Sal con Hierbas y Especias en Salero');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (326, 3611, 'Condimentos', 'Celusal', 500.00, 'Gramos', 1200, 25.64, 'Sal Entrefina para Parrilla en Paquete');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (331, 3616, 'Condimentos', 'Celusal', 500.00, 'Gramos', 1200, 87.25, 'Sal Fina en Salero');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (329, 3614, 'Condimentos', 'Celusal', 235.00, 'Gramos', 1200, 119.73, 'Sal Light en Salero');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (330, 3615, 'Condimentos', 'Celusal', 100.00, 'Gramos', 1200, 43.57, 'Sal Fina en Salero');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (332, 3617, 'Condimentos', 'Celusal', 500.00, 'Gramos', 1200, 33.49, 'Sal Fina en Paquete');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (333, 3618, 'Condimentos', 'Celusal', 1.00, 'Kilogramos', 1200, 42.45, 'Sal Gruesa en Paquete');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (334, 3619, 'Condimentos', 'Celusal', 470.00, 'Gramos', 1200, 156.68, 'Sal Fina Light en Salero');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (335, 3620, 'Condimentos', 'Celusal', 500.00, 'Gramos', 1200, 37.96, 'Sal Fina en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (336, 3621, 'Condimentos', 'Celusal', 1.00, 'Kilogramos', 1200, 48.04, 'Sal Gruesa en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (337, 3622, 'Condimentos', 'Dos Anclas', 200.00, 'Gramos', 1200, 114.13, 'Sal con Hierbas en Salero');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (338, 3623, 'Condimentos', 'Dos Anclas', 500.00, 'Gramos', 1200, 27.89, 'Sal Gruesa en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (339, 3624, 'Condimentos', 'Dos Anclas', 500.00, 'Gramos', 1200, 78.29, 'Sal Gruesa en Salero');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (341, 3626, 'Condimentos', 'Dos Anclas', 1.00, 'Kilogramos', 1200, 51.40, 'Sal Parrillera  en Paquete ');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (342, 3627, 'Condimentos', 'Dos Anclas', 500.00, 'Gramos', 1200, 97.33, 'Sal Fina en Salero');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (343, 3628, 'Condimentos', 'Dos Anclas', 500.00, 'Gramos', 1200, 34.57, 'Sal Fina en Paquete');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (344, 3629, 'Condimentos', 'Dos Anclas', 250.00, 'Gramos', 1200, 76.05, 'Sal Fina en Paquete');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (345, 3630, 'Condimentos', 'Dos Anclas', 500.00, 'Gramos', 1200, 97.33, 'Sal Fina Tradicional en Salero');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (346, 3631, 'Condimentos', 'Dos Anclas', 500.00, 'Gramos', 1200, 82.76, 'Sal Parrillera en Salero');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (347, 3632, 'Condimentos', 'Dos Anclas', 200.00, 'Gramos', 1200, 114.13, 'Sal con Especias en Salero');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (348, 3633, 'Condimentos', 'Dos Anclas', 500.00, 'Gramos', 1200, 27.89, 'Sal Parrillera en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (349, 3634, 'Condimentos', 'Dos Anclas', 250.00, 'Gramos', 1200, 149.06, 'Sal Light en Salero');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (350, 3635, 'Condimentos', 'Dos Anclas', 25.00, 'Kilogramos', 250, 481.48, 'Sal Entrefina en Bolsa');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (351, 3636, 'Condimentos', 'Dos Anclas', 1.00, 'Kilogramos', 1200, 50.29, 'Sal Gruesa en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (352, 3637, 'Condimentos', 'Dos Anclas', 1.00, 'Kilogramos', 1200, 57.01, 'Sal Parrillera en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (354, 3639, 'Condimentos', 'Dos Anclas', 500.00, 'Gramos', 1200, 110.78, 'Sal Light en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (355, 3640, 'Condimentos', 'Dos Anclas', 25.00, 'Kilogramos', 250, 683.09, 'Sal Fina en Bolsa');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (356, 3641, 'Condimentos', 'Marolio', 500.00, 'Gramos', 1200, 25.64, 'Sal Fina en Paquete');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (357, 3642, 'Condimentos', 'Marolio', 1.00, 'Kilogramos', 1200, 37.97, 'Sal Entrefina en Paquete');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (358, 3643, 'Condimentos', 'Marolio', 1.00, 'Kilogramos', 1200, 37.97, 'Sal Gruesa en Paquete');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (360, 3645, 'Condimentos', 'Marolio', 1.00, 'Kilogramos', 1200, 40.21, 'Sal Gruesa en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (361, 3646, 'Condimentos', 'Marolio', 1.00, 'Kilogramos', 1200, 44.69, 'Sal Entrefina en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (362, 3700, 'Salsas', 'Molto', 340.00, 'Gramos', 1200, 44.70, 'Salsa Pomarola en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (363, 3701, 'Salsas', 'Molto', 340.00, 'Gramos', 1200, 44.70, 'Salsa Portuguesa en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (364, 3702, 'Salsas', 'Molto', 340.00, 'Gramos', 1200, 44.70, 'Salsa Filetto en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (366, 3704, 'Salsas', 'Arcor', 340.00, 'Gramos', 1200, 58.14, 'Salsa Lista Filetto en Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (368, 3706, 'Salsas', 'Arcor', 340.00, 'Gramos', 1200, 58.14, 'Salsa Lista Pomarola en Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (369, 3707, 'Salsas', 'Arcor', 340.00, 'Gramos', 1200, 58.14, 'Salsa Lista Portuguesa en Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (373, 3711, 'Salsas', 'Cica', 340.00, 'Gramos', 1200, 35.10, 'Salsa Lista Portuguesa en Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (371, 3709, 'Salsas', 'Cica', 340.00, 'Gramos', 1200, 35.10, 'Salsa Lista Pizza en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (372, 3710, 'Salsas', 'Cica', 340.00, 'Gramos', 1200, 35.10, 'Salsa Lista Pomarola en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (374, 3712, 'Salsas', 'Cica', 340.00, '340', 1200, 35.10, 'Salsa Lista Tuco en Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (375, 3713, 'Salsas', 'Noel', 340.00, 'Gramos', 1200, 47.30, 'Salsa Pizza en Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (376, 3714, 'Salsas', 'Noel', 340.00, 'Gramos', 1200, 47.30, 'Salsa Pomarola en Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (377, 3715, 'Salsas', 'Noel', 340.00, 'Gramos', 1200, 47.30, 'Salsa Filetto en Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (378, 3716, 'Salsas', 'Noel', 350.00, 'Gramos', 1200, 47.30, 'Salsa Portuguesa en Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (379, 3717, 'Salsas', 'Knorr', 340.00, 'Gramos', 1200, 56.79, 'Salsa Lista Napolitana en Sobre');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (380, 3718, 'Salsas', 'Knorr', 340.00, 'Gramos', 1200, 67.63, 'Salsa Lista Pomarola en Sobre');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (325, 3610, 'Condimentos', 'Celusal', 500.00, 'Gramos', 1199, 23.40, 'Sal Gruesa en Paquete');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (381, 3719, 'Salsas', 'Knorr', 340.00, 'Gramos', 1200, 71.57, 'Salsa Lista Portuguesa en Sobre');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (382, 3720, 'Salsas', 'Knorr', 200.00, 'Gramos', 1200, 36.46, 'Salsa Lista Filetto en Sobre');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (383, 3721, 'Salsas', 'Knorr', 340.00, 'Gramos', 1200, 67.63, 'Salsa Lista Pizza en Sobre');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (384, 3722, 'Salsas', 'Knorr', 340.00, 'Gramos', 1200, 71.57, 'Salsa Lista Bolognesa en Sobre');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (386, 3724, 'Salsas', 'Knorr', 340.00, 'Gramos', 1200, 56.79, 'Salsa Lista Filetto en Sobre');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (387, 3725, 'Salsas', 'Knorr', 340.00, 'Gramos', 1200, 56.79, 'Salsa Lista Balance Pomarola en Sobre');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (388, 3726, 'Salsas', 'Knorr', 200.00, 'Gramos', 1200, 36.46, 'Salsa Lista Pomarola en Sobre');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (389, 3727, 'Salsas', 'Knorr', 340.00, 'Gramos', 1200, 14.36, 'Salsa Lista Pomarola con Cebolla de Verdeo en Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (390, 3800, 'Caldos', 'Molto', 12.00, 'Unidades', 800, 59.25, 'Caldo de Gallina');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (391, 3801, 'Caldos', 'Molto', 12.00, 'Unidades', 800, 59.25, 'Caldo de Verdura');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (392, 3802, 'Caldos', 'Molto', 12.00, 'Unidades', 800, 59.25, 'Caldo de Carne');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (394, 3804, 'Caldos', 'Molto', 6.00, 'Unidades', 800, 33.49, 'Caldo de Verdura');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (395, 3805, 'Caldos', 'Molto', 6.00, 'Unidades', 800, 33.49, 'Caldo de Carne');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (396, 3806, 'Caldos', 'Maggi', 2.00, 'Unidades', 800, 14.00, 'Caldo de Gallina');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (340, 3625, 'Condimentos', 'Dos Anclas', 1.00, 'Kilogramos', 1197, 46.61, 'Sal Gruesa en Paquete');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (359, 3644, 'Condimentos', 'Marolio', 500.00, 'Gramos', 1194, 29.00, 'Sal Fina en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (327, 3612, 'Condimentos', 'Celusal', 1.00, 'Kilogramos', 1193, 43.57, 'Sal Entrefina para Parrilla en Paquete');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (397, 3807, 'Caldos', 'Maggi', 6.00, 'Unidades', 800, 34.61, 'Caldo de Gallina');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (398, 3808, 'Caldos', 'Maggi', 2.00, 'Unidades', 800, 14.00, 'Caldo de Verduras');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (399, 3809, 'Caldos', 'Maggi', 6.00, 'Unidades', 800, 34.61, 'Caldo de Verduras');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (401, 3811, 'Caldos', 'Maggi', 12.00, 'Unidades', 800, 55.89, 'Caldo de Verduras');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (402, 3812, 'Caldos', 'Knorr', 12.00, 'Unidades', 800, 100.67, 'Caldo de Carne');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (403, 3813, 'Caldos', 'Knorr', 12.00, 'Unidades', 800, 100.67, 'Caldo Balance de Gallina');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (404, 3814, 'Caldos', 'Knorr', 6.00, 'Unidades', 800, 46.94, 'Caldo de Verduras Deshidratado');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (405, 3815, 'Caldos', 'Knorr', 2.00, 'Unidades', 800, 18.92, 'Caldo de Verduras');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (406, 3816, 'Caldos', 'Knorr', 12.00, 'Unidades', 800, 100.67, 'Caldo de Verduras');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (408, 3818, 'Caldos', 'Knorr', 5.00, 'Sobres', 800, 44.59, 'Caldo de Verduras Sin Calorías');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (409, 3819, 'Caldos', 'Knorr', 5.00, 'Sobres', 800, 44.59, 'Caldo de Verduras Reducido en Sodio Dietética');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (410, 3820, 'Caldos', 'Knorr', 7.50, 'Gramos', 800, 44.59, 'Caldo para Saborizar sabor Verdura');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (413, 3823, 'Caldos', 'Knorr', 7.50, 'Gramos', 800, 11.11, 'Caldo sabor en Sobre Gallina');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (415, 3825, 'Caldos', 'Knorr', 2.00, 'Unidades', 800, 18.92, 'Caldo de Gallina');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (416, 3826, 'Caldos', 'Knorr', 6.00, 'Unidades', 800, 46.94, 'Caldo de Gallina');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (417, 3900, 'Sopas', 'Alicante', 68.00, 'Gramos', 1200, 41.33, 'Sopa Crema de Arvejas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (418, 3901, 'Sopas', 'Alicante', 72.00, 'Gramos', 1200, 57.02, 'Sopa de Fideos y Verduras de la Huerta');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (419, 3902, 'Sopas', 'Alicante', 40.00, 'Gramos', 1200, 27.09, 'Sopa Lista de Zapallo Light');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (420, 3903, 'Sopas', 'Alicante', 40.00, 'Gramos', 1200, 43.35, 'Sopa Lista de Vegetales Light');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (421, 3904, 'Sopas', 'Alicante', 72.00, 'Gramos', 1200, 64.84, 'Sopa Tipo Criolla con Vegetales');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (422, 3905, 'Sopas', 'Alicante', 63.00, 'Gramos', 1200, 54.76, 'Sopa de Pollo con Arroz y Vegetales');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (423, 3906, 'Sopas', 'Molto', 50.00, 'Gramos', 1200, 83.89, 'Sopa de Zapallo Pronto Light');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (424, 3907, 'Sopas', 'Molto', 50.00, 'Gramos', 1200, 83.89, 'Sopa de Choclo Pronto Light');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (425, 3908, 'Sopas', 'Molto', 50.00, 'Gramos', 1200, 83.89, 'Sopa de Arvejas Pronto Light');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (426, 3909, 'Sopas', 'Molto', 50.00, 'Gramos', 1200, 83.89, 'Sopa de Esparrago Pronto Light');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (427, 3910, 'Sopas', 'Molto', 50.00, 'Gramos', 1200, 83.89, 'Sopa de Vegetales Pronto Light');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (428, 3911, 'Sopas', 'Molto', 50.00, 'Gramos', 1200, 83.89, 'Sopa de Esparrago Pronto Clásico');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (429, 3912, 'Sopas', 'Molto', 50.00, 'Gramos', 1200, 83.89, 'Sopa de Vegetales Pronto Clásico');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (430, 3913, 'Sopas', 'Molto', 50.00, 'Gramos', 1200, 83.89, 'Sopa de Choclo Pronto Clásico');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (431, 3914, 'Sopas', 'Molto', 50.00, 'Gramos', 1200, 83.89, 'Sopa de Arvejas Pronto Clásico');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (432, 3915, 'Sopas', 'Molto', 50.00, 'Gramos', 1200, 83.89, 'Sopa de Zapallo Pronto Clásico');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (433, 3916, 'Sopas', 'Knorr', 47.00, 'Gramos', 1200, 72.70, 'Sopa de Vegetales con Fideos de Letras');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (443, 3926, 'Sopas', 'Knorr', 650.00, 'Gramos', 200, 478.25, 'Sopa Crema de Verduras');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (434, 3917, 'Sopas', 'Knorr', 47.00, 'Gramos', 800, 89.31, 'Sopa de Zapallo Quick Light');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (435, 3918, 'Sopas', 'Knorr', 47.00, 'Gramos', 800, 108.28, 'Sopa de Pollo con Mix de Vegetales Quick Light');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (436, 3919, 'Sopas', 'Knorr', 61.00, 'Gramos', 800, 72.70, 'Sopa Crema Verduras');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (437, 3920, 'Sopas', 'Knorr', 105.00, 'Gramos', 800, 72.70, 'Sopa Familiar Pollo con Fideos Municiones');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (438, 3921, 'Sopas', 'Knorr', 107.50, 'Gramos', 800, 72.70, 'Sopa Familiar Vegetales con Fideos Caracolitos Tricolor');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (439, 3922, 'Sopas', 'Knorr', 60.00, 'Gramos', 800, 89.31, 'Sopa de Verduras Quick');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (441, 3924, 'Sopas', 'Knorr', 5.00, 'Porciones', 800, 72.70, 'Sopa Familiar Caserísimo Verduras con Pasta');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (442, 3925, 'Sopas', 'Knorr', 735.00, 'Gramos', 200, 478.25, 'Sopa Crema de Zapallo con Vegetales Seleccionados');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (444, 3927, 'Sopas', 'Knorr', 630.00, 'Gramos', 200, 478.25, 'Sopa Crema de Arvejas con Jamón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (445, 3928, 'Sopas', 'Knorr', 70.00, 'Gramos', 800, 108.28, 'Sopa Pollo con Mix de Vegetales Quick Light');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (446, 3929, 'Sopas', 'Knorr', 69.00, 'Gramos', 800, 72.70, 'Sopa Crema de Choclo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (447, 3930, 'Sopas', 'Knorr', 64.50, 'Gramos', 800, 72.70, 'Sopa Crema Pollo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (448, 3931, 'Sopas', 'Knorr', 87.00, 'Gramos', 800, 72.70, 'Sopa Crema de Arvejas con Jamón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (450, 3933, 'Sopas', 'Knorr', 98.70, 'Gramos', 800, 72.70, 'Sopa Familiar Verduras con Arroz');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (452, 3935, 'Sopas', 'Knorr', 55.00, 'Gramos', 800, 108.28, 'Sopa Vegetales Quick Light');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (453, 3936, 'Sopas', 'Knorr', 45.00, 'Gramos', 800, 108.28, 'Sopa de Choclo Quick Light');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (454, 3937, 'Sopas', 'Knorr', 115.60, 'Gramos', 800, 72.70, 'Sopa Familiar Verduras con Fideos Dedalitos');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (455, 3938, 'Sopas', 'Knorr', 84.50, 'Gramos', 800, 72.70, 'Sopa de Pollo con Fideos Cabellos de Ángel');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (456, 3939, 'Sopas', 'Knorr', 85.00, 'Gramos', 800, 108.28, 'Sopa de Choclo Quick');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (457, 3940, 'Sopas', 'Knorr', 85.00, 'Gramos', 800, 108.28, 'Sopa de Zapallo Quick');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (411, 3821, 'Caldos', 'Knorr', 4.00, 'Sobres', 798, 44.59, 'Caldo para Saborizar sabor Gallina');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (400, 3810, 'Caldos', 'Maggi', 12.00, 'Unidades', 799, 55.89, 'Caldo de Gallina');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (451, 3934, 'Sopas', 'Knorr', 55.00, 'Gramos', 790, 108.28, 'Sopa de Arvejas Quick Light');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (458, 3941, 'Sopas', 'Knorr', 75.00, 'Gramos', 800, 108.28, 'Sopa de Arvejas Quick');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (459, 3942, 'Sopas', 'Knorr', 85.00, 'Gramos', 800, 108.28, 'Sopa de Vegetales Quick');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (460, 3943, 'Sopas', 'Knorr', 55.00, 'Gramos', 800, 108.28, 'Sopa de Zapallo Quick Light');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (461, 4000, 'Saborizadores', 'Alicante', 30.00, 'Gramos', 1200, 48.17, 'Sabor en Polvo de Albahaca y Ajo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (467, 4005, 'Saborizadores', 'Alicante', 30.00, 'Gramos', 1200, 39.98, 'Sabor en Polvo de Carne');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (462, 4001, 'Saborizadores', 'Alicante', 30.00, 'Gramos', 1200, 48.17, 'Sabor en Polvo de Champignones y Hongos');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (463, 4002, 'Saborizadores', 'Alicante', 30.00, 'Gramos', 1200, 48.17, 'Sabor en Polvo de Puerro');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (464, 4003, 'Saborizadores', 'Alicante', 30.00, 'Gramos', 1200, 48.17, 'Sabor en Polvo de Panceta y Hierbas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (465, 4004, 'Saborizadores', 'Alicante', 24.00, 'Gramos', 1200, 48.53, 'Sabor en Polvo de Verdura Reducido en Sodio');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (466, 4005, 'Saborizadores', 'Alicante', 30.00, 'Gramos', 1200, 48.17, 'Sabor en Polvo de 4 Quesos');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (468, 4006, 'Saborizadores', 'Alicante', 30.00, 'Gramos', 1200, 44.69, 'Sabor en Polvo de Gallina');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (469, 4007, 'Saborizadores', 'Alicante', 30.00, 'Gramos', 1200, 39.98, 'Sabor en Polvo de Verdura');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (470, 4008, 'Saborizadores', 'Alicante', 30.00, 'Gramos', 1200, 70.45, 'Sabor en Polvo de Finas Hierbas con Bolsa de Horno');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (471, 4009, 'Saborizadores', 'Alicante', 30.00, 'Gramos', 1200, 70.45, 'Saborizador y Bolsa para Horno Tipo Criolla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (414, 3824, 'Caldos', 'Knorr', 2.00, 'Unidades', 791, 18.92, 'Caldo de Carne');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (502, 4116, 'Cereales', 'Kellogg''s', 195.00, 'Gramos', 799, 137.65, 'Choco Krispis Pops');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (412, 3822, 'Caldos', 'Knorr', 7.50, 'Gramos', 798, 11.11, 'Caldo sabor en Sobre Verduras');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (472, 4010, 'Saborizadores', 'Maggi', 30.00, 'Gramos', 1000, 60.85, 'Jugoso al Horno de Pollo al Pimentón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (473, 4011, 'Saborizadores', 'Maggi', 30.00, 'Gramos', 1000, 60.85, 'Jugoso al Horno de Estofado de Carne');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (474, 4012, 'Saborizadores', 'Maggi', 30.00, 'Gramos', 1000, 60.85, 'Jugoso al Horno de Pollo Mediterráneo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (475, 4013, 'Saborizadores', 'Maggi', 30.00, 'Gramos', 1000, 60.85, 'Jugoso al Horno de Pollo al Limón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (476, 4014, 'Saborizadores', 'Knorr', 4.00, 'Unidades', 1200, 48.65, 'Sabor en Cubos de Panceta & Cebolla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (477, 4015, 'Saborizadores', 'Knorr', 4.00, 'Unidades', 1200, 48.65, 'Sabor en Cubos de Albahaca & Ajo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (478, 4016, 'Saborizadores', 'Knorr', 4.00, 'Unidades', 1200, 48.65, 'Sabor en Cubos de Crema & Verdeo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (479, 4017, 'Saborizadores', 'Knorr', 4.00, 'Unidades', 1200, 48.65, 'Sabor en Cubos de Cuatro Quesos');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (503, 4117, 'Cereales', 'Kellogg''s', 270.00, 'Gramos', 800, 154.44, 'Zucaritas con Sabor a Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (484, 4022, 'Saborizadores', 'Knorr', 21.00, 'Gramos', 1200, 66.27, 'Sabor al Horno de Hierbas y Especias con Bolsas para Horno');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (483, 4021, 'Saborizadores', 'Knorr', 21.00, 'Gramos', 1200, 78.29, 'Sabor al Horno de Tipo Criollo con Bolsas para Horno');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (482, 4020, 'Saborizadores', 'Knorr', 21.00, 'Gramos', 1200, 78.29, 'Sabor al Horno de Romero y Tomillo con Bolsas para Horno');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (481, 4019, 'Saborizadores', 'Knorr', 21.00, 'Gramos', 1200, 78.29, 'Sabor al Horno de Ajo y Cebolla con Bolsas para Horno');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (497, 4111, 'Cereales', 'Nestle', 200.00, 'Gramos', 799, 108.52, 'Nestum Avena con Miel');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (487, 4101, 'Cereales', 'Quaker', 400.00, 'Gramos', 800, 135.38, 'Avena Instantánea Fortificada');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (489, 4103, 'Cereales', 'Quaker', 200.00, 'Gramos', 800, 162.49, 'Honey Nut Oats');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (491, 4105, 'Cereales', 'Nestle', 300.00, 'Gramos', 800, 165.20, 'Nesquik Granola Crujiente');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (492, 4106, 'Cereales', 'Nestle', 220.00, 'Gramos', 800, 153.13, 'Cookie Crisp con Forma de Galletitas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (493, 4107, 'Cereales', 'Marolio', 150.00, 'Gramos', 800, 50.24, 'Copos de Maíz Fortificada');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (494, 4108, 'Cereales', 'Marolio', 200.00, 'Gramos', 800, 64.85, 'Copos de Maíz Azucaradas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (495, 4109, 'Cereales', 'Marolio', 180.00, 'Gramos', 800, 81.65, 'Almohaditas Rellenas con Sabor Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (496, 4110, 'Cereales', 'Marolio', 180.00, 'Gramos', 800, 81.65, 'Almohaditas Rellenas con Sabor Frutilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (499, 4113, 'Cereales', 'Nestle', 500.00, 'Gramos', 800, 200.36, 'Nestum Avena Multicereal');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (500, 4114, 'Cereales', 'Nestle', 200.00, 'Gramos', 800, 108.52, 'Nestum Aven con Frutas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (501, 4115, 'Cereales', 'Nestle', 200.00, 'Gramos', 800, 73.05, 'Nestum Avena de Zapallo y Zanahoria');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (504, 4118, 'Cereales', 'Kellogg''s', 195.00, 'Gramos', 800, 137.65, 'Froot Loops con Sabor a Frutal');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (505, 4119, 'Cereales', 'Kellogg''s', 340.00, 'Gramos', 800, 194.77, 'Froot Loops con Sabor a Frutal');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (506, 4120, 'Cereales', 'Kellogg''s', 220.00, 'Gramos', 800, 107.41, 'Zucaritas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (507, 4121, 'Cereales', 'Kellogg''s', 500.00, 'Gramos', 800, 190.28, 'Zucaritas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (508, 4122, 'Cereales', 'Toddy', 200.00, 'Gramos', 800, 162.49, 'Bolitas de Cereal Cocoa Blasts');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (509, 4200, 'Cacao', 'Nestle', 800.00, 'Gramos', 800, 223.90, 'Nesquik Cacao');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (510, 4201, 'Cacao', 'Nestle', 2.00, 'Kilogramos', 300, 436.12, 'Nesquik Cacao');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (511, 4202, 'Cacao', 'Nestle', 180.00, 'Gramos', 600, 180.97, 'Nesquik Cacao');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (513, 4204, 'Cacao', 'Nestle', 150.00, 'Gramos', 600, 65.96, 'Nesquik Cacao 25% Menos Azúcar');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (515, 4206, 'Cacao', 'Zucoa', 180.00, 'Gramos', 600, 40.52, 'Cacao');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (514, 4205, 'Cacao', 'Zucoa', 800.00, 'Gramos', 300, 176.04, 'Cacao');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (516, 4207, 'Cacao', 'Zucoa', 360.00, 'Gramos', 600, 72.32, 'Cacao');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (517, 4208, 'Cacao', 'Zucoa', 180.00, 'Gramos', 600, 20.99, 'Licuado Sabor a Banana');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (518, 4209, 'Cacao', 'Zucoa', 180.00, 'Gramos', 600, 20.99, 'Licuado Sabor a Frutilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (520, 4211, 'Cacao', 'La Virginia', 180.00, 'Gramos', 800, 59.25, 'Cacao Chocolino con Chispitas Granuladas Fortificado Plus');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (519, 4210, 'Cacao', 'La Virginia', 360.00, 'Gramos', 800, 121.97, 'Cacao Chocolino con Chispitas Granuladas Fortiticado Plus');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (521, 4212, 'Cacao', 'La Virginia', 800.00, 'Gramos', 600, 269.81, 'Cacao Chocolino con Chispitas Granuladas Fortificado Plus');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (522, 4213, 'Cacao', 'Toddy', 360.00, 'Gramos', 800, 98.80, 'Chocolatada Extremo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (523, 4214, 'Cacao', 'Toddy', 180.00, 'Gramos', 800, 48.04, 'Chocolatada Original');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (524, 4215, 'Cacao', 'Toddy', 800.00, 'Gramos', 600, 201.49, 'Chocolatada Extremo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (527, 4301, 'Endulzantes', 'Chango', 1.00, 'Kilogramos', 1000, 62.59, 'Azúcar Premium Blanco Refinado');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (480, 4018, 'Saborizadores', 'Knorr', 21.00, 'Gramos', 1199, 78.29, 'Sabor al Horno de Limón y Orégano con Bolsas para Horno');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (512, 4203, 'Cacao', 'Nestle', 360.00, 'Gramos', 598, 113.01, 'Nesquik Cacao');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (529, 4303, 'Endulzantes', 'Chango', 500.00, 'Gramos', 800, 83.89, 'Azúcar Bajas Calorías con Stevia y Sucralosa');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (530, 4304, 'Endulzantes', 'Chango', 100.00, 'Sobres', 800, 132.04, 'Azúcar Común Tipo "A"');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (531, 4305, 'Endulzantes', 'Chango', 1000.00, 'Sobres', 300, 939.57, 'Azúcar Común Tipo "A"');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (532, 4306, 'Endulzantes', 'Ledesma', 1.00, 'Kilogramos', 800, 64.40, 'Azúcar Clásica Común Tipo "A"');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (533, 4307, 'Endulzantes', 'Ledesma', 800.00, 'Gramos', 800, 85.12, 'Azúcar Rubio Mascabo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (534, 4308, 'Endulzantes', 'Ledesma', 500.00, 'Gramos', 600, 56.57, 'Azúcar Light');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (535, 4309, 'Endulzantes', 'Ledesma', 800.00, 'Sobres', 400, 683.77, 'Azúcar Común Tipo "A"');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (536, 4310, 'Endulzantes', 'Dos Anclas', 250.00, 'Gramos', 800, 62.61, 'Azúcar de Fantasía Negra');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (537, 4311, 'Endulzantes', 'Marolio', 1.00, 'Kilogramos', 1000, 58.13, 'Azúcar Común Tipo "A"');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (538, 4312, 'Endulzantes', 'Chango', 250.00, 'Gramos', 800, 64.84, 'Azúcar Impalpable');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (539, 4313, 'Endulzantes', 'Dos Anclas', 250.00, 'Gramos', 800, 50.29, 'Azúcar Impalpable');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (540, 4314, 'Endulzantes', 'Ledesma', 50.00, 'Sobres', 600, 68.32, 'Edulcorante 0% Calorías');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (541, 4315, 'Endulzantes', 'Ledesma', 400.00, 'Sobres', 300, 335.88, 'Edulcorante 0% Calorías');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (559, 4417, 'Leche en Polvo', 'Nestle', 800.00, 'Gramos', 400, 466.06, 'Nidina Bebé 1');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (560, 4418, 'Leche en Polvo', 'Nestle', 800.00, 'Gramos', 400, 433.53, 'Nidina Bebé 2');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (544, 4402, 'Leche en Polvo', 'Nestle', 800.00, 'Gramos', 800, 447.89, 'Nido 3D FortiGrow en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (542, 4400, 'Leche en Polvo', 'Nestle', 400.00, 'Gramos', 600, 223.88, 'Nido 3 Primera Infancia en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (543, 4401, 'Leche en Polvo', 'Nestle', 800.00, 'Gramos', 600, 447.89, 'Nido 3 Primera Infancia en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (546, 4404, 'Leche en Polvo', 'Nestle', 800.00, 'Gramos', 600, 447.89, 'Nido 4 Preescolar en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (525, 4216, 'Cacao', 'Ravana', 180.00, 'Gramos', 799, 42.45, 'Cacao Instantáneo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (486, 4100, 'Cereales', 'Quaker', 500.00, 'Gramos', 791, 174.82, 'Avena Extra Fina');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (485, 4023, 'Saborizadores', 'Knorr', 7.50, 'Gramos', 1192, 13.42, 'Sabor en Sobrecitors de Finas Hierbas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (490, 4104, 'Cereales', 'Quaker', 300.00, 'Gramos', 812, 270.01, 'Quadritos de Avena');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (561, 4500, 'Leche Larga Vida', 'Ilolay', 1.00, 'Litro', 600, 88.48, 'Leche Chocolata con Sabor a Dulce de Leche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (562, 4501, 'Leche Larga Vida', 'Ilolay', 1.00, 'Litro', 1000, 104.05, 'Leche Chocolatada');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (547, 4405, 'Leche en Polvo', 'Nestle', 800.00, 'Gramos', 400, 612.78, 'Nido Deslactosada FortiGrow en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (67, 2022, 'Arroz', 'Knorr', 185.00, 'Gramos', 1198, 147.58, 'Arroz a la Paella');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (488, 4102, 'Cereales', 'Quaker', 500.00, 'Gramos', 799, 162.62, 'Avena Tradicional Fortificada');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (526, 4300, 'Endulzantes', 'Chango', 1.00, 'Kilogramos', 996, 61.49, 'Azúcar Común Tipo "A"');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (147, 3212, 'Vinagres', 'Molto', 500.00, 'Centímetro Cúbico', 998, 55.89, 'Vinagre Vino');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (563, 4502, 'Leche Larga Vida', 'Ilolay', 200.00, 'Mililitro', 600, 33.49, 'Leche Chocolata con Sabor a Dulce de Leche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (565, 4504, 'Leche Larga Vida', 'Ilolay', 1.00, 'Litro', 600, 79.87, 'Leche + Hierro');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (566, 4505, 'Leche Larga Vida', 'Ilolay', 1.00, 'Litro', 800, 86.12, 'Leche Reducida en Lactosa');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (549, 4407, 'Leche en Polvo', 'Nestle', 800.00, 'Gramos', 600, 447.89, 'Nido Liviana FortiGrow en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (550, 4408, 'Leche en Polvo', 'SanCor', 400.00, 'Gramos', 600, 164.64, 'Entera Instantánea Fortificada con Vitaminas A y D en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (551, 4409, 'Leche en Polvo', 'SanCor', 800.00, 'Gramos', 500, 760.47, 'Bebé 1 Nitricción Completa + Defensas en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (552, 4410, 'Leche en Polvo', 'SanCor', 375.00, 'Gramos', 500, 390.88, 'Bebé 1 Nitricción Completa + Defensas en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (553, 4411, 'Leche en Polvo', 'SanCor', 800.00, 'Gramos', 500, 816.48, 'Bebé 2 Nutricción Completa + Defensas en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (554, 4412, 'Leche en Polvo', 'SanCor', 375.00, 'Gramos', 500, 469.27, 'Bebé 2 Nutricción Completa + Defensas en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (555, 4413, 'Leche en Polvo', 'SanCor', 800.00, 'Gramos', 500, 861.28, 'Bebé 3 Nutricción Completa en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (556, 4414, 'Leche en Polvo', 'SanCor', 375.00, 'Gramos', 500, 323.68, 'Bebé 3 Nutricción Completa + Defensas en Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (557, 4415, 'Leche en Polvo', 'Nestle', 800.00, 'Gramos', 600, 436.69, 'La Lechera Nutrición Balanceada con Zinc');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (558, 4416, 'Leche en Polvo', 'Nestle', 400.00, 'Gramos', 600, 179.09, 'La Lechera Nutrición Balanceada Vitaminas A, D, C + Calcio');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (568, 4507, 'Leche Larga Vida', 'Ilolay', 1.00, 'Litro', 1000, 81.65, 'Leche Descremada');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (570, 4509, 'Leche Larga Vida', 'La Serenisima', 1.00, 'Litro', 600, 87.60, 'Leche Clásica en Botella');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (571, 4510, 'Leche Larga Vida', 'La Serenisima', 1.00, 'Litro', 800, 84.00, 'Leche Liviana');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (572, 4511, 'Leche Larga Vida', 'La Serenisima', 1.00, 'Litro', 600, 87.60, 'Leche Liviana en Botella');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (574, 4513, 'Leche Larga Vida', 'La Serenisima', 1.00, 'Litro', 500, 102.06, 'Leche Entera Fortificada con Hierro');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (575, 4514, 'Leche Larga Vida', 'La Serenisima', 1.00, 'Litro', 500, 102.06, 'Leche Parcialmente Descremada Fortificada con Hierro');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (576, 4515, 'Leche Larga Vida', 'Milkaut', 1.00, 'Litro', 800, 81.65, 'Leche Parcialmente Descremada Fortificada con Vitaminas A y D');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (577, 4516, 'Leche Larga Vida', 'Milkaut', 1.00, 'Litro', 1200, 81.65, 'Leche Entera Fortificada con Vitaminas A y D');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (578, 4517, 'Leche Larga Vida', 'Milkaut', 1.00, 'Litro', 800, 106.29, 'Leche Chocolatada');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (579, 4518, 'Leche Larga Vida', 'Milkaut', 200.00, 'Centímetro Cúbico', 500, 44.70, 'Leche Chocolatada');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (580, 4519, 'Leche Larga Vida', 'Baggio', 1.00, 'Litro', 800, 81.26, 'Latte Shake Chocolatada');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (581, 4520, 'Leche Larga Vida', 'Baggio', 200.00, 'Mililitro', 400, 19.87, 'Latte Shake Chocolatada');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (582, 4521, 'Leche Larga Vida', 'Marolio', 1.00, 'Litro', 800, 67.08, 'Leche Entera');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (583, 4522, 'Leche Larga Vida', 'Marolio', 1.00, 'Litro', 500, 67.08, 'Leche Parcialmente Descremada');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (584, 4523, 'Leche Larga Vida', 'Nestle', 200.00, 'Mililitro', 400, 51.40, 'Nesquik Chocolatada');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (585, 4524, 'Leche Larga Vida', 'Nestle', 200.00, 'Mililitro', 400, 51.40, 'Nesquik Liviana Menos Azúcar');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (586, 4525, 'Leche Larga Vida', 'SanCor', 1.00, 'Litro', 800, 115.19, 'Leche Chocolatada Shake');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (587, 4526, 'Leche Larga Vida', 'SanCor', 250.00, 'Centímetro Cúbico', 400, 63.69, 'Leche Chocolatada Shake');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (588, 4527, 'Leche Larga Vida', 'Verónica', 1.00, 'Litro', 800, 72.70, 'Leche Parcialmente Descremada');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (589, 4528, 'Leche Larga Vida', 'Verónica', 1.00, 'Litro', 900, 72.70, 'Leche Entera');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (590, 4600, 'Tomates', 'Molto', 400.00, 'Gramos', 1000, 53.65, 'Tomates Peritas en Latas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (592, 4602, 'Tomates', 'Molto', 340.00, 'Gramos', 1200, 40.21, 'Puré de Tomate en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (564, 4503, 'Leche Larga Vida', 'Ilolay', 1.00, 'Litro', 795, 52.72, 'Leche + Proteína');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (593, 4603, 'Tomates', 'Molto', 520.00, 'Gramos', 1200, 42.00, 'Pulpa de Tomate en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (594, 4604, 'Tomates', 'Molto', 980.00, 'Gramos', 800, 106.29, 'Tomate Triturado en Botella');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (595, 4605, 'Tomates', 'Molto', 500.00, 'Gramos', 1200, 50.29, 'Tomate Triturado en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (597, 4607, 'Tomates', 'Molto', 400.00, 'Gramos', 1200, 39.17, 'Tomate Cubeteado en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (599, 4608, 'Tomates', 'Molto', 210.00, 'Gramos', 1200, 32.37, 'Extracto Simple de Tomates en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (600, 4609, 'Tomates', 'Marolio', 520.00, 'Gramos', 1200, 39.08, 'Puré de Tomate en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (601, 4610, 'Tomates', 'Marolio', 400.00, 'Gramos', 800, 46.94, 'Tomates Peladdos Peritas Entera Comunes en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (603, 4612, 'Tomates', 'Marolio', 400.00, 'Gramos', 1200, 35.27, 'Tomate Pelado Cubeteado en Jugo de Tomate en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (604, 4613, 'Tomates', 'Marolio', 340.00, 'Gramos', 1200, 36.40, 'Puré de Tomate en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (605, 4614, 'Tomates', 'Marolio', 980.00, 'Gramos', 800, 95.09, 'Tomate Triturado en Botella');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (606, 4615, 'Tomates', 'Marolio', 500.00, 'Gramos', 1200, 43.57, 'Tomate Triturado en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (607, 4616, 'Tomates', 'Marolio', 200.00, 'Gramos', 1200, 25.64, 'Puré de Tomate en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (608, 4617, 'Tomates', 'Marolio', 210.00, 'Gramos', 1200, 29.00, 'Extracto Simple de Tomates en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (609, 4618, 'Tomates', 'La Campagnola', 400.00, 'Gramos', 800, 71.69, 'Salsati Cubitos + Puré en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (610, 4619, 'Tomates', 'La Campagnola', 400.00, 'Gramos', 1000, 67.63, 'Salsati Perita + Puré en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (611, 4620, 'Tomates', 'La Campagnola', 520.00, 'Gramos', 1200, 46.94, 'Salsati Pulpa en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (613, 4622, 'Tomates', 'La Campagnola', 520.00, 'Gramos', 1200, 51.36, 'Pulpa de Tomate en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (614, 4623, 'Tomates', 'La Campagnola', 520.00, 'Gramos', 1200, 64.92, 'Puré de Tomate en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (591, 4601, 'Tomates', 'Molto', 520.00, 'Gramos', 1191, 44.70, 'Puré de Tomate en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (602, 4611, 'Tomates', 'Marolio', 520.00, 'Gramos', 1185, 36.84, 'Pulpa de Tomate en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (569, 4508, 'Leche Larga Vida', 'La Serenisima', 1.00, 'Litro', 796, 84.00, 'Leche Clásica');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (616, 4625, 'Tomates', 'Baggio', 530.00, 'Gramos', 1000, 57.12, 'De La Huerta Puré de Tomate en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (617, 4626, 'Tomates', 'Baggio', 210.00, 'Gramos', 1000, 33.93, 'De La Huerta Puré de Tomate en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (618, 4627, 'Tomates', 'Baggio', 1030.00, 'Centímetro Cúbico', 1000, 101.70, 'De La Huerta Puré de Tomate en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (619, 4628, 'Tomates', 'Noel', 530.00, 'Gramos', 1200, 48.65, 'Puré de Tomate con Azucares Agregados en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (620, 4629, 'Tomates', 'Noel', 400.00, 'Gramos', 800, 54.58, 'Tomates Peritas Enteros en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (622, 4631, 'Tomates', 'Cica', 1.02, 'Kilogramos', 800, 117.43, 'Purecica Puré de Tomate en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (623, 4632, 'Tomates', 'Santa Isabel', 520.00, 'Gramos', 1200, 36.84, 'Puré de Tomate en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (624, 4700, 'Conservas y Legumbres', 'Marolio', 350.00, 'Gramos', 1000, 53.65, 'Lentejas Secas Remojadas en Conserva en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (625, 4701, 'Conservas y Legumbres', 'Marolio', 280.00, 'Gramos', 800, 134.29, 'Champignones Enteros en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (627, 4703, 'Conservas y Legumbres', 'Marolio', 400.00, 'Gramos', 800, 111.89, 'Palmitos en Rodajas en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (628, 4704, 'Conservas y Legumbres', 'Marolio', 400.00, 'Gramos', 800, 123.09, 'Champignones en Trozos en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (629, 4705, 'Conservas y Legumbres', 'Marolio', 340.00, 'Gramos', 1200, 27.89, 'Arvejas en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (630, 4706, 'Conservas y Legumbres', 'Marolio', 340.00, 'Gramos', 1200, 39.08, 'Garbanzos en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (631, 4707, 'Conservas y Legumbres', 'Marolio', 340.00, 'Gramos', 1200, 43.57, 'Jardineras en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (632, 4708, 'Conservas y Legumbres', 'Marolio', 340.00, 'Gramos', 1200, 43.57, 'Lentejas en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (633, 4709, 'Conservas y Legumbres', 'Marolio', 340.00, 'Gramos', 1200, 49.16, 'Porotos Pallares en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (634, 4710, 'Conservas y Legumbres', 'Marolio', 340.00, 'Gramos', 1000, 43.57, 'Porotos Alubia en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (635, 4711, 'Conservas y Legumbres', 'Marolio', 350.00, 'Gramos', 800, 41.32, 'Choclo Amarillo Cremoso en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (636, 4712, 'Conservas y Legumbres', 'Marolio', 800.00, 'Gramos', 600, 246.28, 'Palmitos Entero en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (637, 4713, 'Conservas y Legumbres', 'Marolio', 350.00, 'Gramos', 1000, 27.89, 'Arvejas Secas Remojadas en Conserva en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (638, 4714, 'Conservas y Legumbres', 'Marolio', 350.00, 'Gramos', 1000, 41.32, 'Garbanzos Secos Remojados en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (639, 4715, 'Conservas y Legumbres', 'Marolio', 350.00, 'Gramos', 1000, 49.16, 'Jardinera de Hortalizas y Legumbres en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (640, 4716, 'Conservas y Legumbres', 'Marolio', 350.00, 'Gramos', 1000, 41.32, 'Granos de Choclo Blanco Tipo Cremoso en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (642, 4718, 'Conservas y Legumbres', 'Marolio', 300.00, 'Gramos', 1000, 50.28, 'Granos de Choclo Amarillo Enteros en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (643, 4719, 'Conservas y Legumbres', 'Marolio', 300.00, 'Gramos', 1000, 50.28, 'Granos de Choclo Amarillo Enteros');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (644, 4720, 'Conservas y Legumbres', 'Marolio', 400.00, 'Gramos', 1000, 134.29, 'Palmitos Entero en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (645, 4721, 'Conservas y Legumbres', 'Molto', 350.00, 'Gramos', 1000, 55.89, 'Porotos en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (646, 4722, 'Conservas y Legumbres', 'Molto', 350.00, 'Gramos', 1000, 46.49, 'Garbanzos Secos Remojados en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (647, 4723, 'Conservas y Legumbres', 'Molto', 350.00, 'Gramos', 1000, 55.89, 'Jardinera de Hortalizas y Legumbres en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (648, 4724, 'Conservas y Legumbres', 'Molto', 340.00, 'Gramos', 1000, 31.25, 'Arvejas Secas Remojadas en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (649, 4725, 'Conservas y Legumbres', 'Molto', 340.00, 'Gramos', 1000, 49.19, 'Lentejas Secas Remojadas en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (650, 4726, 'Conservas y Legumbres', 'Molto', 340.00, 'Gramos', 1000, 49.16, 'Jardinera de Hortalizas y Legumbres en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (651, 4727, 'Conservas y Legumbres', 'Molto', 340.00, 'Gramos', 1000, 55.89, 'Porotos Pallares Secos Remojados en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (652, 4728, 'Conservas y Legumbres', 'Molto', 340.00, 'Gramos', 1000, 44.69, 'Garbanzos Secos Remojados en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (653, 4729, 'Conservas y Legumbres', 'Molto', 340.00, 'Gramos', 1000, 49.16, 'Porotos Alubias Secos Remojados en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (654, 4730, 'Conservas y Legumbres', 'Molto', 400.00, 'Gramos', 800, 145.48, 'Palmitos Entero en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (655, 4731, 'Conservas y Legumbres', 'Molto', 800.00, 'Gramos', 600, 268.68, 'Palmitos Enteros en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (656, 4732, 'Conservas y Legumbres', 'Molto', 350.00, 'Gramos', 1000, 46.49, 'Choclo Amarillo Cremoso en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (657, 4733, 'Conservas y Legumbres', 'Molto', 300.00, 'Gramos', 1000, 55.89, 'Choclo Amarillo en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (658, 4734, 'Conservas y Legumbres', 'Molto', 350.00, 'Gramos', 1000, 31.25, 'Arvejas Secas Remojadas en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (659, 4735, 'Conservas y Legumbres', 'Molto', 350.00, 'Gramos', 1000, 46.49, 'Choclo Blanco Cremoso en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (660, 4736, 'Conservas y Legumbres', 'Molto', 350.00, 'Gramos', 1000, 59.25, 'Lentejas en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (621, 4630, 'Tomates', 'Cica', 520.00, 'Gramos', 1197, 63.72, 'Purecica Puré de Tomates en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (641, 4717, 'Conservas y Legumbres', 'Marolio', 350.00, 'Gramos', 997, 49.16, 'Porotos Secos Remojadas en Conserva en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (661, 4737, 'Conservas y Legumbres', 'La Campagnola', 300.00, 'Gramos', 1000, 44.70, 'Arvejas en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (662, 4738, 'Conservas y Legumbres', 'La Campagnola', 240.00, 'Gramos', 800, 101.51, 'Choclo Entero en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (663, 4739, 'Conservas y Legumbres', 'La Campagnola', 300.00, 'Gramos', 1000, 78.29, 'Arvejas Verde Mediana Fresca en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (664, 4740, 'Conservas y Legumbres', 'La Campagnola', 300.00, 'Gramos', 800, 81.18, 'Choclo Cremoso en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (665, 4741, 'Conservas y Legumbres', 'Bahía', 800.00, 'Gramos', 600, 235.67, 'Palmitos en Cubos en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (667, 4743, 'Conservas y Legumbres', 'Bahía', 320.00, 'Gramos', 600, 77.11, 'Choclos en Grano Amarillos Enteros en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (668, 4744, 'Conservas y Legumbres', 'Noel', 350.00, 'Gramos', 800, 68.79, 'Choclo Amarillo Cremoso en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (669, 4745, 'Conservas y Legumbres', 'Noel', 320.00, 'Gramos', 800, 68.79, 'Choclo Amarillo Entero en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (672, 4748, 'Conservas y Legumbres', 'Marolio', 400.00, 'Gramos', 600, 100.25, 'Lentejas en Bolsa');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (673, 4749, 'Conservas y Legumbres', 'Marolio', 400.00, 'Gramos', 800, 59.25, 'Arvejas Partidas en Bolsa');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (674, 4750, 'Conservas y Legumbres', 'Marolio', 400.00, 'Gramos', 800, 52.52, 'Maíz Pisingallo en Bolsa');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (675, 4751, 'Conservas y Legumbres', 'Marolio', 400.00, 'Gramos', 800, 73.81, 'Maíz Pisado Blanco en Bolsa');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (678, 4754, 'Conservas y Legumbres', 'Marolio', 400.00, 'Gramos', 800, 115.25, 'Lentejones en Bolsa');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (679, 4755, 'Conservas y Legumbres', 'Fabiola', 1.00, 'Kilogramos', 800, 67.94, 'Maíz Pisado Colorado en Bolsa');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (680, 4756, 'Conservas y Legumbres', 'Marolio', 220.00, 'Gramos', 600, 83.89, 'Pimientos Morrones Enteros Comunes en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (681, 4757, 'Conservas y Legumbres', 'Marolio', 800.00, 'Gramos', 300, 246.28, 'Pimientos Morrones Enteros Comunes en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (682, 4758, 'Conservas y Legumbres', 'Bahía', 220.00, 'Gramos', 300, 108.28, 'Pimientos Morrones Enteros Comunes en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (677, 4753, 'Conservas y Legumbres', 'Marolio', 400.00, 'Gramos', 797, 61.48, 'Garbanzos en Bolsa');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (615, 4624, 'Tomates', 'La Campagnola', 400.00, 'Gramos', 793, 68.64, 'Tomates Peritas en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (683, 4759, 'Conservas y Legumbres', 'Marolio', 170.00, 'Gramos', 500, 151.08, 'Lomitos de Atún en Aceite y Agua en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (684, 4760, 'Conservas y Legumbres', 'Marolio', 170.00, 'Gramos', 500, 151.08, 'Lomitos de Atún al Natural en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (685, 4761, 'Conservas y Legumbres', 'Marolio', 425.00, 'Gramos', 500, 145.49, 'Jurel en Aceite en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (686, 4762, 'Conservas y Legumbres', 'Marolio', 425.00, 'Centímetro Cúbico', 500, 145.49, 'Jurel al Natural en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (687, 4763, 'Conservas y Legumbres', 'Marolio', 380.00, 'Gramos', 500, 162.29, 'Caballa en Aceite en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (689, 4765, 'Conservas y Legumbres', 'Marolio', 215.00, 'Gramos', 500, 156.68, 'Sardinela en Agua y Aceite en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (690, 4766, 'Conservas y Legumbres', 'Marolio', 125.00, 'Gramos', 500, 97.33, 'Sardinela en Agua y Aceite en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (691, 4767, 'Conservas y Legumbres', 'Marolio', 1.80, 'Kilogramos', 200, 1231.88, 'Atún en Trozos en Aceite y Aguan en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (692, 4768, 'Conservas y Legumbres', 'Marolio', 1.80, 'Kilogramos', 200, 1231.88, 'Atún en Trozoss al Natural en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (693, 4769, 'Conservas y Legumbres', 'La Campagnola', 300.00, 'Gramos', 300, 419.98, 'Atún al Natural en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (694, 4770, 'Conservas y Legumbres', 'La Campagnola', 170.00, 'Gramos', 300, 243.80, 'Atún al Natural Libre de Gluten en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (695, 4771, 'Conservas y Legumbres', 'La Campagnola', 300.00, 'Gramos', 300, 419.98, 'Atún en Aceite en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (696, 4772, 'Conservas y Legumbres', 'La Campagnola', 170.00, 'Gramos', 300, 243.80, 'Atún en Aceite Libre de Gluten en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (697, 4773, 'Conservas y Legumbres', 'La Campagnola', 300.00, 'Gramos', 300, 230.25, 'Caballa en Aceite en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (698, 4774, 'Conservas y Legumbres', 'La Campagnola', 300.00, 'Gramos', 300, 230.25, 'Caballa al Natural en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (699, 4775, 'Conservas y Legumbres', 'La Campagnola', 300.00, 'Gramos', 300, 230.25, 'Caballa en Salsa de Tomate en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (700, 4776, 'Conservas y Legumbres', 'El Dique', 170.00, 'Gramos', 300, 71.57, 'Atún Desmenuzado al Natural en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (701, 4777, 'Conservas y Legumbres', 'El Dique', 170.00, 'Gramos', 300, 71.57, 'Atún Desmenuzado en Aceite y Agua en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (702, 4778, 'Conservas y Legumbres', 'Molto', 170.00, 'Gramos', 300, 167.88, 'Lomitos de Atún al Natural en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (703, 4779, 'Conservas y Legumbres', 'Molto', 170.00, 'Gramos', 300, 167.89, 'Lomitos de Atún en Aceite de Girasol en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (704, 4780, 'Conservas y Legumbres', 'Bahía', 125.00, 'Gramos', 300, 115.06, 'Sardinas en Aceite y Agua en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (705, 4800, 'Harinas y Premezclas', 'Marolio', 1.00, 'Kilogramos', 2000, 40.21, 'Harina de Trigo 000');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (706, 4801, 'Harinas y Premezclas', 'Marolio', 1.00, 'Kilogramos', 2000, 50.28, 'Harina de Trigo 0000');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (707, 4802, 'Harinas y Premezclas', 'Marolio', 1.00, 'Kilogramos', 2000, 55.88, 'Harina Leudante');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (708, 4803, 'Harinas y Premezclas', 'Marolio', 500.00, 'Gramos', 2000, 37.97, 'Polenta Instantánea');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (709, 4804, 'Harinas y Premezclas', 'Marolio', 500.00, 'Gramos', 2000, 39.08, 'Polenta Tradicional de Maíz de Harina');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (710, 4805, 'Harinas y Premezclas', 'Marolio', 1.00, 'Kilogramos', 2000, 72.25, 'Polenta Tradicional de Maíz de Harina');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (711, 4806, 'Harinas y Premezclas', 'Marolio', 400.00, 'Gramos', 2000, 58.81, 'Sémola de Trigo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (712, 4807, 'Harinas y Premezclas', 'Marolio', 250.00, 'Gramos', 2000, 39.08, 'Almidón de Maíz');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (713, 4808, 'Harinas y Premezclas', 'Pureza', 1.00, 'Kilogramos', 2000, 67.09, 'Harina Integral');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (715, 48010, 'Harinas y Premezclas', 'Pureza', 1.00, 'Kilogramos', 2000, 63.73, 'Harina Leudante');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (716, 4811, 'Harinas y Premezclas', 'Pureza', 1.00, 'Kilogramos', 2000, 67.10, 'Harina con Levadura');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (717, 4812, 'Harinas y Premezclas', 'Pureza', 1.00, 'Kilogramos', 2000, 67.10, 'Harina Especial para Pizzas Caseras con Levadura');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (718, 4813, 'Harinas y Premezclas', 'Pureza', 1.00, 'Kilogramos', 2000, 43.12, 'Harina Ultra Refinada 000');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (720, 4815, 'Harinas y Premezclas', 'Blancaflor', 1.00, 'Kilogramos', 2000, 44.69, 'Harina 000');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (721, 4816, 'Harinas y Premezclas', 'Blancaflor', 1.00, 'Kilogramos', 2000, 53.65, 'Harina 0000');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (722, 4817, 'Harinas y Premezclas', 'Blancaflor', 1.00, 'Kilogramos', 2000, 78.29, 'Harina con Levadura Lista para Pizza');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (723, 4818, 'Harinas y Premezclas', 'Cañuelas', 1.00, 'Kilogramos', 2000, 44.68, 'Harina 000');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (724, 4819, 'Harinas y Premezclas', 'Cañuelas', 1.00, 'Kilogramos', 2000, 33.49, 'Harina 0000');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (725, 4820, 'Harinas y Premezclas', 'Cañuelas', 1.00, 'Kilogramos', 2000, 59.81, 'Harina Leudante');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (676, 4752, 'Conservas y Legumbres', 'Marolio', 400.00, 'Gramos', 799, 96.20, 'Porotos Alubia en Bolsa');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (670, 4746, 'Conservas y Legumbres', 'Arcor', 300.00, 'Gramos', 798, 50.01, 'Arvejas Secas en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (731, 4826, 'Harinas y Premezclas', 'Maizena', 215.00, 'Gramos', 1799, 67.08, 'Almidón de Maíz');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (727, 4822, 'Harinas y Premezclas', 'Favorita', 1.00, 'Kilogramos', 2000, 61.92, 'Harina de Trigo 0000');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (728, 4823, 'Harinas y Premezclas', 'Reinharina', 1.00, 'Kilogramos', 2000, 39.48, 'Harina de Trigo 000');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (729, 4824, 'Harinas y Premezclas', 'Reinharina', 1.00, 'Kilogramos', 2000, 62.99, 'Harina de Trigo 0000');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (730, 4825, 'Harinas y Premezclas', 'Reinharina', 1.00, 'Kilogramos', 2000, 62.99, 'Harina Leudante');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (732, 4827, 'Harinas y Premezclas', 'Maizena', 520.00, 'Gramos', 1200, 149.97, 'Almidón de Maíz');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (733, 4828, 'Harinas y Premezclas', 'Maizena', 1.10, 'Kilogramos', 800, 196.55, 'Almidón de Maíz');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (736, 4831, 'Harinas y Premezclas', 'Presto Pronta', 500.00, 'Gramos', 1800, 71.81, 'Polenta Instantánea');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (737, 4832, 'Harinas y Premezclas', 'Presto Pronta', 750.00, 'Gramos', 1500, 106.93, 'Polenta Instantánea');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (738, 4833, 'Harinas y Premezclas', 'Presto Pronta', 250.00, 'Gramos', 1500, 44.70, 'Polenta Instantánea Sabor a Espinaca a la Crema');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (739, 4834, 'Harinas y Premezclas', 'Presto Pronta', 250.00, 'Gramos', 1500, 44.70, 'Polenta Instantánea Sabor a Panceta y Queso');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (777, 4937, 'Polvo para Postres', 'Exquisita', 40.00, 'Gramos', 1500, 40.21, 'Gelatina Sabor a Durazno');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (780, 4940, 'Polvo para Postres', 'Exquisita', 40.00, 'Gramos', 1500, 40.21, 'Gelatina Sabor a Naranja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (781, 4941, 'Polvo para Postres', 'Exquisita', 40.00, 'Gramos', 1500, 40.21, 'Gelatina Sabor a Frutilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (782, 4942, 'Polvo para Postres', 'Exquisita', 60.00, 'Gramos', 1500, 39.08, 'Flan Sabor a Dulce de Leche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (768, 4928, 'Polvo para Postres', 'Royal', 40.00, 'Gramos', 1500, 37.81, 'Flan Sabor a Dulce de Leche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (745, 4905, 'Polvo para Postres', 'Ravana', 50.00, 'Gramos', 1500, 44.70, 'Gelatina Sabor a Durazno');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (743, 4903, 'Polvo para Postres', 'Ravana', 50.00, 'Gramos', 1500, 44.70, 'Gelatina Sabor a Cereza');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (744, 4904, 'Polvo para Postres', 'Ravana', 50.00, 'Gramos', 1500, 44.70, 'Gelatina Sabor a Frambuesa');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (741, 4901, 'Polvo para Postres', 'Ravana', 42.00, 'Gramos', 1500, 80.53, 'Gelatina Sin Sabor');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (742, 4902, 'Polvo para Postres', 'Ravana', 50.00, 'Gramos', 1497, 44.70, 'Gelatina Sabor a Ananá');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (740, 4900, 'Polvo para Postres', 'Ravana', 50.00, 'Gramos', 1500, 44.70, 'Gelatina Sabor a Frutilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (746, 4906, 'Polvo para Postres', 'Ravana', 50.00, 'Gramos', 1500, 44.70, 'Gelatina Sabor a Manzana');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (747, 4907, 'Polvo para Postres', 'Ravana', 25.00, 'Gramos', 1500, 51.40, 'Gelatina Light Sabor a Manzana');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (748, 4908, 'Polvo para Postres', 'Ravana', 25.00, 'Gramos', 1500, 51.40, 'Gelatina Light Sabor a Frutilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (749, 4909, 'Polvo para Postres', 'Ravana', 100.00, 'Gramos', 1500, 42.00, 'Flan Sabor a Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (751, 4911, 'Polvo para Postres', 'Ravana', 60.00, 'Gramos', 1500, 29.00, 'Flan Sabor a Vainilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (752, 4912, 'Polvo para Postres', 'Ravana', 16.00, 'Gramos', 1500, 29.00, 'Flan Light Sabor a Vainilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (753, 4913, 'Polvo para Postres', 'Ravana', 120.00, 'Gramos', 1500, 35.27, 'Postre Sabor a Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (754, 4914, 'Polvo para Postres', 'Ravana', 120.00, 'Gramos', 1500, 24.08, 'Postre Sabor a Vainilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (755, 4915, 'Polvo para Postres', 'Ravana', 100.00, 'Gramos', 1500, 67.08, 'Mousse Sabor a Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (756, 4916, 'Polvo para Postres', 'Ravana', 100.00, 'Gramos', 1500, 67.08, 'Mousse Sabor a Limón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (757, 4917, 'Polvo para Postres', 'Royal', 40.00, 'Gramos', 1500, 47.30, 'Gelatina Sabor a Durazno');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (758, 4918, 'Polvo para Postres', 'Royal', 40.00, 'Gramos', 1500, 47.30, 'Gelatina Sabor a Frambuesa');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (759, 4919, 'Polvo para Postres', 'Royal', 14.00, 'Gramos', 1500, 37.17, 'Gelatina Sin Sabor');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (760, 4920, 'Polvo para Postres', 'Royal', 25.00, 'Gramos', 1500, 55.43, 'Gelatina Light Sabor a Frutilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (761, 4921, 'Polvo para Postres', 'Royal', 25.00, 'Gramos', 1500, 55.43, 'Gelatina Light Sabor a Cereza');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (763, 4923, 'Polvo para Postres', 'Royal', 25.00, 'Gramos', 1500, 55.43, 'Gelatina Light Sabor a Durazno');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (764, 4924, 'Polvo para Postres', 'Royal', 40.00, 'Gramos', 1500, 47.30, 'Gelatina Sabor a Frutilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (765, 4925, 'Polvo para Postres', 'Royal', 40.00, 'Gramos', 1500, 47.30, 'Gelatina Sabor a Cereza');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (766, 4926, 'Polvo para Postres', 'Royal', 60.00, 'Gramos', 1500, 37.81, 'Flan Sabor a Vainilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (767, 4927, 'Polvo para Postres', 'Royal', 80.00, 'Gramos', 1500, 51.36, 'Flan Sabor a Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (769, 4929, 'Polvo para Postres', 'Royal', 90.00, 'Gramos', 1500, 45.94, 'Postre Sabor a Frutilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (770, 4930, 'Polvo para Postres', 'Royal', 70.00, 'Gramos', 1500, 44.59, 'Postre Sabor a Caramelo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (771, 4931, 'Polvo para Postres', 'Royal', 75.00, 'Gramos', 1500, 45.95, 'Postre Sabor a Vainilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (772, 4932, 'Polvo para Postres', 'Royal', 65.00, 'Gramos', 1500, 45.94, 'Postre Sabor a Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (773, 4933, 'Polvo para Postres', 'Royal', 50.00, 'Gramos', 1500, 50.01, 'Postre Light Sabor a Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (774, 4934, 'Polvo para Postres', 'Exquisita', 25.00, 'Gramos', 1500, 51.40, 'Gelatina Light Sabor a Frutilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (775, 4935, 'Polvo para Postres', 'Exquisita', 25.00, 'Gramos', 1500, 51.40, 'Gelatina Light Sabor a Cereza');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (776, 4936, 'Polvo para Postres', 'Exquisita', 25.00, 'Gramos', 1500, 51.40, 'Gelatina Light Sabor a Durazno');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (783, 4943, 'Polvo para Postres', 'Exquisita', 60.00, 'Gramos', 1500, 39.08, 'Flan Sabor a Vainilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (784, 4944, 'Polvo para Postres', 'Exquisita', 80.00, 'Gramos', 1500, 41.33, 'Postre Sabor a Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (785, 4945, 'Polvo para Postres', 'Marolio', 50.00, 'Gramos', 1500, 40.21, 'Gelatina Sabor a Frutilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (786, 4946, 'Polvo para Postres', 'Marolio', 50.00, 'Gramos', 1500, 40.21, 'Gelatina Sabor a Frambuesa');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (787, 4947, 'Polvo para Postres', 'Marolio', 50.00, 'Gramos', 1500, 40.21, 'Gelatina Sabor a Ananá');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (788, 4948, 'Polvo para Postres', 'Marolio', 50.00, 'Gramos', 1500, 40.21, 'Gelatina Sabor a Cereza');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (789, 4949, 'Polvo para Postres', 'Marolio', 60.00, 'Gramos', 1500, 25.65, 'Flan Sabor a Dulce de Leche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (791, 4951, 'Polvo para Postres', 'Marolio', 100.00, 'Gramos', 1500, 38.64, 'Flan Sabor a Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (792, 4952, 'Polvo para Postres', 'La Campagnola', 20.00, 'Gramos', 1500, 54.07, 'Gelatina Sabor a Frutilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (793, 4953, 'Polvo para Postres', 'La Campagnola', 20.00, 'Gramos', 1500, 54.07, 'Gelatina Sabor a Cereza');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (790, 4950, 'Polvo para Postres', 'Marolio', 60.00, 'Gramos', 1498, 25.65, 'Flan Sabor a Vainilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (734, 4829, 'Harinas y Premezclas', 'Chango', 220.00, 'Gramos', 998, 58.14, 'Almidón de Maíz');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (795, 4955, 'Polvo para Postres', 'Noel', 30.00, 'Gramos', 1200, 35.10, 'Gelatina Sabor a Cereza');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (796, 4956, 'Polvo para Postres', 'Dos Anclas', 360.00, 'Centímetro Cúbico', 600, 135.41, 'Salsa de Chocolate en Pomo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (797, 4957, 'Polvo para Postres', 'Dos Anclas', 365.00, 'Centímetro Cúbico', 600, 152.21, 'Salsa de Frutilla en Pomo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (798, 4958, 'Polvo para Postres', 'Dos Anclas', 375.00, 'Centímetro Cúbico', 600, 139.89, 'Salsa de Caramelo en Pomo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (799, 4959, 'Polvo para Postres', 'Aguila', 320.00, 'Gramos', 300, 230.25, 'Salsa de Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (800, 5000, 'Polvo para Repostería', 'Ravana', 540.00, 'Gramos', 1000, 86.13, 'Bizcochuelo Sabor a Vainilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (801, 5001, 'Polvo para Repostería', 'Ravana', 540.00, 'Gramos', 1000, 97.33, 'Bizcochuelo Sabor a Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (802, 5002, 'Polvo para Repostería', 'Ravana', 540.00, 'Gramos', 1000, 86.13, 'Bizcochuelo Sabor a Naranja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (803, 5003, 'Polvo para Repostería', 'Ravana', 540.00, 'Gramos', 1000, 86.13, 'Bizcochuelo Sabor a Limón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (804, 5004, 'Polvo para Repostería', 'Ravana', 425.00, 'Gramos', 800, 123.09, 'Brownie Sabor a Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (805, 5005, 'Polvo para Repostería', 'Exquisita', 540.00, 'Gramos', 1000, 115.24, 'Bizcochuelo Sabor a Limón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (806, 5006, 'Polvo para Repostería', 'Exquisita', 540.00, 'Gramos', 1000, 115.24, 'Bizcochuelo Sabor a Vainilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (807, 5007, 'Polvo para Repostería', 'Exquisita', 540.00, 'Gramos', 1000, 154.01, 'Bizcochuelo Sabor a Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (808, 5008, 'Polvo para Repostería', 'Exquisita', 540.00, 'Gramos', 1000, 115.24, 'Bizcochuelo Sabor a Naranja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (809, 5009, 'Polvo para Repostería', 'Godet', 540.00, 'Gramos', 1000, 78.29, 'Bizcochuelo Sabor a Naranja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (810, 5010, 'Polvo para Repostería', 'Godet', 480.00, 'Gramos', 1000, 78.29, 'Bizcochuelo Sabor a Vainilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (811, 5011, 'Polvo para Repostería', 'Godet', 480.00, 'Gramos', 1000, 98.51, 'Bizcochuelo Sabor a Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (812, 5012, 'Polvo para Repostería', 'Godet', 500.00, 'Gramos', 1000, 87.88, 'Bizcochuelo Sabor a Marmolado');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (813, 5013, 'Polvo para Repostería', 'Noel', 480.00, 'Gramos', 800, 59.25, 'Bizcochuelo Sabor a Vainilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (814, 5014, 'Polvo para Repostería', 'Noel', 480.00, 'Gramos', 800, 71.56, 'Bizcochuelo Sabor a Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (816, 5016, 'Polvo para Repostería', 'Marolio', 480.00, 'Gramos', 800, 67.08, 'Bizcochuelo Sabor a Vainilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (817, 5017, 'Polvo para Repostería', 'Marolio', 480.00, 'Gramos', 800, 67.08, 'Bizcochuelo Sabor a Naranja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (818, 5018, 'Polvo para Repostería', 'Marolio', 480.00, 'Gramos', 800, 80.37, 'Bizcochuelo Sabor a Vainilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (815, 5015, 'Polvo para Repostería', 'Marolio', 480.00, 'Gramos', 797, 82.76, 'Bizcochuelo Sabor a Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (794, 4954, 'Polvo para Postres', 'Noel', 30.00, 'Gramos', 1194, 35.10, 'Gelatina Sabor a Frutilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (819, 5019, 'Polvo para Repostería', 'Marolio', 540.00, 'Gramos', 800, 93.97, 'Bizcochuelo Sabor a Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (820, 5020, 'Polvo para Repostería', 'Marolio', 540.00, 'Gramos', 800, 80.37, 'Bizcochuelo Sabor a Limón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (821, 5021, 'Polvo para Repostería', 'Marolio', 540.00, 'Gramos', 800, 80.37, 'Bizcochuelo Sabor a Naranja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (822, 5022, 'Polvo para Repostería', 'Marolio', 425.00, 'Gramos', 600, 111.89, 'Brownie Sabor a Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (823, 5023, 'Polvo para Repostería', 'Marolio', 25.00, 'Gramos', 800, 27.89, 'Coco Rallado');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (824, 5024, 'Polvo para Repostería', 'Marolio', 110.00, 'Centímetro Cúbico', 300, 41.33, 'Extracto Aromatizante Artifial a Vainilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (825, 5025, 'Polvo para Repostería', 'Maizena', 500.00, 'Gramos', 600, 94.73, 'Bizcochuelo Sabor a Vainilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (826, 5026, 'Polvo para Repostería', 'Maizena', 500.00, 'Gramos', 600, 110.99, 'Bizcochuelo Sabor a Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (829, 5029, 'Polvo para Repostería', 'Valente', 750.00, 'Gramos', 300, 193.66, 'Bizcochuelo Sabor a Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (830, 5030, 'Polvo para Repostería', 'Aguila', 450.00, 'Gramos', 200, 111.89, 'Torta Húmeda Sabor a Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (833, 5033, 'Polvo para Repostería', 'Aguila', 150.00, 'Gramos', 300, 169.27, 'Chocolitos de Chocolate Semiamargo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (831, 5031, 'Polvo para Repostería', 'Aguila', 150.00, 'Gramos', 300, 148.94, 'Baño de Repostería de Chocolate Semiamargo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (832, 5032, 'Polvo para Repostería', 'Aguila', 150.00, 'Gramos', 300, 148.94, 'Baño de Repostería de Chocolate con Leche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (834, 5034, 'Polvo para Repostería', 'Dos Anclas', 40.00, 'Gramos', 300, 42.45, 'Coco Rallado');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (835, 5035, 'Polvo para Repostería', 'Dos Anclas', 100.00, 'Centímetro Cúbico', 200, 63.72, 'Extracto Aromatizante Artifial a Vainilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (836, 5036, 'Polvo para Repostería', 'Georgalos', 150.00, 'Gramos', 300, 128.61, 'Baño de Repostería de Chocolate con Leche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (837, 5037, 'Polvo para Repostería', 'Georgalos', 150.00, 'Gramos', 300, 128.61, 'Baño de Repostería de Chocolate Semiamargo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (838, 5038, 'Polvo para Repostería', 'La Serenisima', 300.00, 'Gramos', 200, 113.57, 'Relleno a Base de Dulce de Leche Mezcla para Chocotorta');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (839, 5039, 'Polvo para Repostería', 'La Serenisima', 300.00, 'Gramos', 200, 115.35, 'Relleno a Base de Dulce de Leche y Cacao Mezcla para Chocotorta');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (840, 5040, 'Polvo para Repostería', 'Nestle', 395.00, 'Gramos', 200, 134.29, 'Leche Condensada');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (841, 5041, 'Polvo para Repostería', 'Nestle', 395.00, 'Gramos', 200, 134.29, 'Leche Condensada Azucarada Descremada');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (842, 5042, 'Polvo para Repostería', 'Alicante', 100.00, 'Centímetro Cúbico', 350, 89.48, 'Extracto Aromatizante Artifial a Vainilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (843, 5043, 'Polvo para Repostería', 'Chango', 50.00, 'Gramos', 200, 57.00, 'Coco Rallado');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (844, 5044, 'Polvo para Repostería', 'Royal', 50.00, 'Gramos', 400, 50.01, 'Polvo para Hornear');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (845, 5100, 'Mermeladas', 'Marolio', 500.00, 'Gramos', 1000, 52.53, 'Mermelada de Durazno en Pote');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (846, 5101, 'Mermeladas', 'Marolio', 500.00, 'Gramos', 1000, 52.53, 'Mermelada de Ciruela en Pote');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (847, 5102, 'Mermeladas', 'Marolio', 500.00, 'Gramos', 1000, 65.52, 'Mermelada de Damasco en Pote');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (848, 5103, 'Mermeladas', 'Marolio', 500.00, 'Gramos', 1000, 52.53, 'Mermelada de Frutilla en Pote');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (849, 5104, 'Mermeladas', 'Mermeladas', 500.00, 'Gramos', 1000, 52.53, 'Mermelada de Naranja en Pote');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (850, 5105, 'Mermeladas', 'Marolio', 420.00, 'Gramos', 1000, 59.08, 'Mermelada Light de Durazno en Pote');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (851, 5106, 'Mermeladas', 'Marolio', 420.00, 'Gramos', 1000, 70.83, 'Mermelada Light de Frutilla en Pote');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (852, 5107, 'Mermeladas', 'Marolio', 454.00, 'Gramos', 800, 68.61, 'Mermelada de Higo en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (854, 5109, 'Mermeladas', 'Marolio', 454.00, 'Gramos', 800, 68.21, 'Mermelada de Ciruela en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (855, 5110, 'Mermeladas', 'Marolio', 454.00, 'Gramos', 800, 68.21, 'Mermelada de Damasco en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (856, 5111, 'Mermeladas', 'Marolio', 454.00, 'Gramos', 800, 77.16, 'Mermelada de Durazno en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (857, 5112, 'Mermeladas', 'Marolio', 454.00, 'Gramos', 800, 68.21, 'Mermelada de Naranja en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (858, 5113, 'Mermeladas', 'Marolio', 390.00, 'Gramos', 800, 107.41, 'Mermelada Light de Frutilla en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (859, 5114, 'Mermeladas', 'Marolio', 390.00, 'Gramos', 800, 72.25, 'Mermelada Light de Ciruela en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (860, 5115, 'Mermeladas', 'Marolio', 390.00, 'Gramos', 800, 72.25, 'Mermelada Light de Damasco en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (861, 5116, 'Mermeladas', 'Marolio', 390.00, 'Gramos', 800, 85.01, 'Mermelada Light de Durazno en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (862, 5117, 'Mermeladas', 'Dulciora', 500.00, 'Gramos', 800, 25.75, 'Mermelada de Frutilla en Pote');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (863, 5118, 'Mermeladas', 'Dulciora', 500.00, 'Gramos', 800, 20.33, 'Mermelada de Durazno en Pote');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (864, 5119, 'Mermeladas', 'Cormillot', 390.00, 'Gramos', 800, 98.80, 'Mermelada Light de Durazno en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (865, 5120, 'Mermeladas', 'Cormillot', 390.00, 'Gramos', 800, 120.84, 'Mermelada Light de Frutilla en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (866, 5121, 'Mermeladas', 'Cormillot', 390.00, 'Gramos', 800, 98.80, 'Mermelada Light de Ciruela en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (867, 5122, 'Mermeladas', 'Cormillot', 390.00, 'Gramos', 800, 92.13, 'Mermelada Light de Damasco en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (868, 5123, 'Mermeladas', 'Cormillot', 390.00, 'Gramos', 800, 92.13, 'Mermelada Light de Naranja en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (869, 5124, 'Mermeladas', 'Cormillot', 390.00, 'Gramos', 800, 130.92, 'Mermelada Light de Durazno Sin Azúcar en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (870, 5125, 'Mermeladas', 'Cormillot', 390.00, 'Gramos', 800, 158.92, 'Mermelada Light de Frutilla Sin Azúcar en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (871, 5126, 'Mermeladas', 'Cormillot', 390.00, 'Gramos', 800, 92.13, 'Mermelada Light de Higo en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (872, 5127, 'Mermeladas', 'Cormillot', 390.00, 'Gramos', 800, 159.32, 'Mermelada Light de Frambuesa Sin Azúcar en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (873, 5128, 'Mermeladas', 'Cormillot', 390.00, 'Gramos', 800, 122.64, 'Mermelada Light de Higo Sin Azúcar en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (874, 5129, 'Mermeladas', 'Cormillot', 390.00, 'Gramos', 800, 92.13, 'Mermelada Light de Membrillo en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (875, 5130, 'Mermeladas', 'Cormillot', 390.00, 'Gramos', 800, 108.08, 'Jalea Light de Membrillo en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (878, 5133, 'Mermeladas', 'La Campagnola', 454.00, 'Gramos', 800, 188.37, 'Mermelada de Frutilla en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (879, 5134, 'Mermeladas', 'La Campagnola', 454.00, 'Gramos', 800, 143.52, 'Mermelada de Naranja en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (880, 5135, 'Mermeladas', 'La Campagnola', 454.00, 'Gramos', 800, 143.52, 'Mermelada de Ciruela en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (881, 5136, 'Mermeladas', 'La Campagnola', 454.00, 'Gramos', 800, 143.52, 'Mermelada de Durazno en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (882, 5137, 'Mermeladas', 'La Campagnola', 454.00, 'Gramos', 800, 188.37, 'Mermelada de Frambuesa en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (885, 5140, 'Mermeladas', 'La Campagnola', 454.00, 'Gramos', 800, 188.37, 'Mermelada de Frutos Rojos en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (887, 5142, 'Mermeladas', 'La Campagnola', 454.00, 'Gramos', 800, 192.37, 'Mermelada de Arándano en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (888, 5143, 'Mermeladas', 'La Campagnola', 390.00, 'Gramos', 800, 153.00, 'Mermelada de Ciruela en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (889, 5144, 'Mermeladas', 'BC La Campagnola', 390.00, 'Gramos', 800, 153.00, 'Mermelada de Naranja en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (828, 5028, 'Polvo para Repostería', 'Valente', 750.00, 'Gramos', 297, 193.66, 'Bizcochuelo Sabor a Vainilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (876, 5131, 'Mermeladas', 'BC La Campagnola', 390.00, 'Gramos', 800, 153.00, 'Mermelada de Durazno en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (877, 5132, 'Mermeladas', 'BC La Campagnola', 390.00, 'Gramos', 800, 207.21, 'Mermelada de Frutilla en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (883, 5138, 'Mermeladas', 'BC La Campagnola', 390.00, 'Gramos', 800, 207.21, 'Mermelada de Frambuesa en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (886, 5141, 'Mermeladas', 'BC La Campagnola', 390.00, 'Gramos', 800, 182.82, 'Mermelada de Arándano en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (890, 5145, 'Mermeladas', 'BC La Campagnola', 390.00, 'Gramos', 800, 182.82, 'Jalea de Membrillo en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (891, 5146, 'Mermeladas', 'La Campagnola', 454.00, 'Gramos', 800, 169.27, 'Jalea de Membrillo en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (892, 5147, 'Mermeladas', 'Molto', 454.00, 'Gramos', 800, 79.41, 'Mermelada de Ciruela en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (893, 5148, 'Mermeladas', 'Molto', 454.00, 'Gramos', 800, 79.41, 'Mermelada de Damasco en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (894, 5149, 'Mermeladas', 'Molto', 454.00, 'Gramos', 800, 85.01, 'Mermelada de Durazno en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (895, 5150, 'Mermeladas', 'Molto', 454.00, 'Gramos', 800, 79.41, 'Mermelada de Naranja en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (896, 5151, 'Mermeladas', 'Molto', 454.00, 'Gramos', 800, 109.65, 'Mermelada de Frutilla en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (897, 5152, 'Mermeladas', 'Molto', 390.00, 'Gramos', 800, 89.48, 'Mermelada Light de Ciruela en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (898, 5153, 'Mermeladas', 'Molto', 390.00, 'Gramos', 800, 89.48, 'Mermelada Light de Damasco en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (899, 5154, 'Mermeladas', 'Molto', 390.00, 'Gramos', 800, 96.21, 'Mermelada Light de Durazno en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (900, 5155, 'Mermeladas', 'Molto', 390.00, 'Gramos', 800, 89.48, 'Mermelada Light de Naranja en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (902, 5157, 'Mermeladas', 'Noel', 454.00, 'Gramos', 800, 92.02, 'Mermelada de Ciruela en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (903, 5158, 'Mermeladas', 'Noel', 454.00, 'Gramos', 800, 92.02, 'Mermelada de Naranja en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (905, 5160, 'Mermeladas', 'Noel', 454.00, 'Gramos', 800, 79.41, 'Mermelada de Damasco en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (904, 5159, 'Mermeladas', 'Noel', 454.00, 'Gramos', 800, 69.33, 'Mermelada de Durazno en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (908, 5163, 'Mermeladas', 'Noel', 390.00, 'Gramos', 800, 104.22, 'Mermelada Light de Durazno en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (909, 5164, 'Mermeladas', 'Noel', 390.00, 'Gramos', 800, 104.22, 'Mermelada Light de Ciruela en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (910, 5165, 'Mermeladas', 'Noel', 390.00, 'Gramos', 800, 104.22, 'Mermelada Light de Damasco en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (911, 5166, 'Mermeladas', 'Noel', 390.00, 'Gramos', 800, 104.22, 'Mermelada Light de Naranja en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (906, 5161, 'Mermeladas', 'Noel', 454.00, 'Gramos', 800, 121.83, 'Mermelada de Frutilla en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (912, 5167, 'Mermeladas', 'Arcor', 454.00, 'Gramos', 800, 162.49, 'Mermelada de Frutilla en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (913, 5168, 'Mermeladas', 'Arcor', 454.00, 'Gramos', 800, 116.41, 'Mermelada de Ciruela en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (915, 5170, 'Mermeladas', 'Arcor', 390.00, 'Gramos', 800, 139.45, 'Mermelada Light de Ciruela en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (916, 5171, 'Mermeladas', 'Arcor', 390.00, 'Gramos', 800, 139.45, 'Mermelada Light de Durazno en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (917, 5172, 'Mermeladas', 'Arcor', 390.00, 'Gramos', 800, 139.45, 'Mermelada Light de Damasco en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (919, 5174, 'Mermeladas', 'Arcor', 390.00, 'Gramos', 800, 157.07, 'Mermelada de Durazno Sin Azúcar en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (921, 5201, 'Dulces', 'La Serenisima', 400.00, 'Gramos', 800, 138.33, 'Dulce de Leche Estilo Colonial');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (923, 5203, 'Dulces', 'La Serenisima', 1.00, 'Kilogramos', 300, 248.98, 'Dulce de Leche Estilo Colonial');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (926, 5206, 'Dulces', 'Ilolay', 1.00, 'Kilogramos', 600, 262.09, 'Dulce de Leche Clásico en Pote');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (924, 5204, 'Dulces', 'La Serenisima', 400.00, 'Gramos', 800, 155.69, 'Dulce de Leche Repostero');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (920, 5200, 'Dulces', 'La Serenisima', 250.00, 'Gramos', 800, 82.76, 'Dulce de Leche Estilo Colonial');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (918, 5173, 'Mermeladas', 'Arcor', 390.00, 'Gramos', 799, 189.59, 'Mermelada Light de Frutilla en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (925, 5205, 'Dulces', 'La Serenisima', 400.00, 'Gramos', 800, 89.49, 'Dulce de Leche Tradición Argentina');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (927, 5207, 'Dulces', 'Ilolay', 200.00, 'Gramos', 800, 50.40, 'Dulce de Leche Clásico');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (928, 5208, 'Dulces', 'Ilolay', 1.00, 'Kilogramos', 400, 234.09, 'Dulce de Leche Repostero');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (929, 5209, 'Dulces', 'Ilolay', 400.00, 'Gramos', 800, 110.88, 'Dulce de Leche Clásico');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (930, 5210, 'Dulces', 'Ilolay', 400.00, 'Gramos', 800, 110.88, 'Dulce de Leche Repostero');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (931, 5211, 'Dulces', 'Milkaut', 250.00, 'Gramos', 800, 77.27, 'Dulce de Leche Clásico');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (932, 5212, 'Dulces', 'Milkaut', 400.00, 'Gramos', 800, 88.48, 'Dulce de Leche Clásico');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (933, 5213, 'Dulces', 'Milkaut', 400.00, 'Gramos', 800, 122.08, 'Dulce de Leche Repostero');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (934, 5214, 'Dulces', 'Milkaut', 1.00, 'Kilogramos', 300, 256.48, 'Dulce de Leche Clásico');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (935, 5215, 'Dulces', 'Milkaut', 1.00, 'Kilogramos', 300, 267.68, 'Dulce de Leche Repostero');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (936, 5216, 'Dulces', 'La Paulina', 250.00, 'Gramos', 800, 78.29, 'Dulce de Leche Familiar');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (937, 5217, 'Dulces', 'La Paulina', 400.00, 'Gramos', 800, 133.95, 'Dulce de Leche Repostero');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (938, 5218, 'Dulces', 'La Paulina', 400.00, 'Gramos', 800, 112.00, 'Dulce de Leche Familiar');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (939, 5219, 'Dulces', 'SanCor', 1.00, 'Kilogramos', 400, 162.39, 'Dulce de Leche Tradicional');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (940, 5220, 'Dulces', 'SanCor', 400.00, 'Gramos', 800, 81.76, 'Dulce de Leche Repostero Tradicional');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (941, 5221, 'Dulces', 'SanCor', 400.00, 'Gramos', 800, 68.32, 'Dulce de Leche Libre de Gluten');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (943, 5223, 'Dulces', 'Verónica', 400.00, 'Gramos', 600, 85.01, 'Dulce de Leche Clásico');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (944, 5224, 'Dulces', 'Marolio', 400.00, 'Gramos', 800, 84.23, 'Dulce de Leche ');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (945, 5225, 'Dulces', 'Marolio', 1.00, 'Kilogramos', 300, 210.44, 'Dulce de Leche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (946, 5226, 'Dulces', 'Marolio', 400.00, 'Gramos', 600, 90.94, 'Dulce de Leche Repostero');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (947, 5227, 'Dulces', 'Marolio', 5.00, 'Kilogramos', 200, 559.89, 'Dulce de Batata en Cajón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (948, 5228, 'Dulces', 'Marolio', 5.00, 'Kilogramos', 200, 559.89, 'Dulce de Batata con Chocolate en Cajón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (949, 5229, 'Dulces', 'Marolio', 5.00, 'Kilogramos', 200, 615.89, 'Dulce de Membrillo en Cajón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (950, 5230, 'Dulces', 'Marolio', 5.00, 'Kilogramos', 200, 587.89, 'Dulce de Batata a la Vainilla en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (951, 5231, 'Dulces', 'Marolio', 5.00, 'Kilogramos', 200, 587.89, 'Dulce de Batata con Chocolate en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (952, 5232, 'Dulces', 'Marolio', 500.00, 'Gramos', 500, 60.38, 'Dulce de Batata en Estuche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (953, 5233, 'Dulces', 'Marolio', 500.00, 'Gramos', 500, 60.38, 'Dulce de Batata con Chocolate en Estuche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (954, 5234, 'Dulces', 'Marolio', 500.00, 'Gramos', 500, 74.92, 'Dulce de Membrillo en Estuche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (955, 5235, 'Dulces', 'Arcor', 5.00, 'Kilogramos', 200, 947.28, 'Dulce de Membrillo en Cajón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (956, 5236, 'Dulces', 'Arcor', 5.00, 'Kilogramos', 200, 691.02, 'Dulce de Batata con Chocolate en Cajón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (957, 5237, 'Dulces', 'Arcor', 5.00, 'Kilogramos', 200, 691.02, 'Dulce de Batata en Cajón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (914, 5169, 'Mermeladas', 'Arcor', 454.00, 'Gramos', 797, 116.41, 'Mermelada de Durazno en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (958, 5238, 'Dulces', 'Arcor', 5.00, 'Kilogramos', 200, 906.63, 'Dulce de Batata con Chocolate en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (960, 5240, 'Dulces', 'Arcor', 5.00, 'Kilogramos', 200, 1150.57, 'Dulce de Membrillo en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (961, 5241, 'Dulces', 'Arcor', 500.00, 'Gramos', 500, 94.73, 'Dulce de Batata en Estuche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (962, 5242, 'Dulces', 'Arcor', 500.00, 'Gramos', 500, 94.73, 'Dulce de Batata con Chocolate en Estuche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (963, 5243, 'Dulces', 'Arcor', 500.00, 'Gramos', 500, 110.99, 'Dulce de Membrillo en Estuche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (964, 5244, 'Dulces', 'Noel', 5.00, 'Kilogramos', 200, 663.91, 'Dulce de Batata con Chocolate en Cajón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (965, 5245, 'Dulces', 'Noel', 5.00, 'Kilogramos', 200, 784.66, 'Dulce de Membrillo en Cajón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (966, 5246, 'Dulces', 'Noel', 5.00, 'Kilogramos', 200, 663.91, 'Dulce de Batata en Cajón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (967, 5247, 'Dulces', 'Noel', 5.00, 'Kilogramos', 200, 784.66, 'Dulce de Batata en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (968, 5248, 'Dulces', 'Noel', 5.00, 'Kilogramos', 200, 784.66, 'Dulce de Batata con Chocolate en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (970, 5250, 'Dulces', 'esnaola', 5.00, 'Kilogramos', 200, 748.05, 'Dulce de Membrillo en Cajón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (971, 5251, 'Dulces', 'esnaola', 5.00, 'Kilogramos', 200, 609.71, 'Dulce de Batata con Vainilla en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (973, 5253, 'Dulces', 'esnaola', 350.00, 'Gramos', 500, 70.00, 'Dulce de Batata con Chocolate en Pote');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (974, 5254, 'Dulces', 'esnaola', 350.00, 'Gramos', 500, 76.05, 'Dulce de Membrillo en Pote');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (975, 5255, 'Dulces', 'esnaola', 1.00, 'Kilogramos', 150, 141.69, 'Dulce de Batata a la Vainilla en Estuche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (976, 5256, 'Dulces', 'esnaola', 1.00, 'Kilogramos', 150, 146.45, 'Dulce de Batata a la Vainilla con Chocolate en Estuche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (978, 5258, 'Dulces', 'esnaola', 500.00, 'Gramos', 500, 89.48, 'Dulce de Batata en Estuche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (980, 5260, 'Dulces', 'Cormillot', 430.00, 'Gramos', 500, 88.37, 'Dulce Light de Membrillo en Estuche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (981, 5261, 'Dulces', 'Cormillot', 430.00, 'Gramos', 500, 78.29, 'Dulce Light de Batata en Estuche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (982, 5300, 'Miel', 'ALELUYA', 500.00, 'Gramos', 300, 284.46, 'Miel Líquida en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (983, 5301, 'Miel', 'ALELUYA', 190.00, 'Gramos', 500, 148.94, 'Miel en Pote');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (984, 5302, 'Miel', 'Aleluya', 250.00, 'Gramos', 300, 189.59, 'Miel Líquida en Squeeze');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (985, 5304, 'Miel', 'ALELUYA', 300.00, 'Gramos', 300, 203.15, 'Miel Untable en Pote');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (987, 5401, 'Galletitas', '9 DE ORO', 180.00, 'Gramos', 1800, 54.76, 'Cookies con Chips de Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (988, 5402, 'Galletitas', '9 DE ORO', 160.00, 'Gramos', 1500, 62.38, 'Brigitte de Vainilla y Limón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (989, 5403, 'Galletitas', '9 DE ORO', 160.00, 'Gramos', 1500, 62.38, 'Brigitte de Chocolate y Limón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (990, 5404, 'Galletitas', '9 DE ORO', 100.00, 'Gramos', 1500, 30.13, 'Obleas de Vainilla y Naranja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (991, 5405, 'Galletitas', '9 DE ORO', 100.00, 'Gramos', 1500, 30.13, 'Obleas de Chocolate y Naranja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (992, 5406, 'Galletitas', '9 DE ORO', 120.00, 'Gramos', 1800, 26.77, 'Anillos de Vainilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (993, 5407, 'Galletitas', '9 DE ORO', 120.00, 'Gramos', 1500, 26.77, 'Anillos de Chcolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (994, 5408, 'Galletitas', '9 DE ORO', 210.00, 'Gramos', 1500, 70.45, 'Miniflora con Dulce de Membrillo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (996, 5410, 'Galletitas', '9 DE ORO', 210.00, 'Gramos', 2000, 33.49, 'Bizcochos Azucarados');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (997, 5411, 'Galletitas', '9 DE ORO', 200.00, 'Gramos', 2000, 33.49, 'Bizcochos Agridulces');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (998, 5412, 'Galletitas', '9 DE ORO', 200.00, 'Gramos', 2000, 33.49, 'Bizcochos con Salvado');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (999, 5413, 'Galletitas', '9 DE ORO', 170.00, 'Gramos', 2000, 33.49, 'Bizcochos Light Sin Colesterol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (995, 5409, 'Galletitas', '9 DE ORO', 200.00, 'Gramos', 1998, 33.49, 'Bizcochos Clásicos');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (977, 5257, 'Dulces', 'esnaola', 1.00, 'Kilogramos', 149, 187.89, 'Dulce de Membrillo en Estuche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (972, 5252, 'Dulces', 'esnaola', 350.00, 'Gramos', 497, 70.00, 'Dulce de Batata a la Vainilla en Pote');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (942, 5222, 'Dulces', 'Ser', 400.00, 'Gramos', 299, 167.96, 'Dulce de Leche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1001, 5415, 'Galletitas', '9 DE ORO', 200.00, 'Gramos', 200, 45.38, 'Pepas con Membrillo Natural');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1002, 5416, 'Galletitas', '9 DE ORO', 200.00, 'Gramos', 2000, 51.40, 'Scons con Sabor a Limón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1036, 5450, 'Galletitas', 'Bagley', 169.00, 'Gramos', 1799, 66.27, 'Salvado Original');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1003, 5417, 'Galletitas', '9 DE ORO', 380.00, 'Gramos', 2000, 76.05, 'Pepas con Membrillo Natural');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1004, 5418, 'Galletitas', '9 DE ORO', 180.00, 'Gramos', 1500, 49.72, 'Avena con Pasas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1005, 5419, 'Galletitas', '9 DE ORO', 180.00, 'Gramos', 1500, 49.72, 'Avena con Miel');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1006, 5420, 'Galletitas', 'DON SATUR', 200.00, 'Gramos', 1800, 33.77, 'Bizcocho Dulce Azucarados');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1007, 5421, 'Galletitas', 'DON SATUR', 200.00, 'Gramos', 1800, 33.77, 'Bizcocho Salado ');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1009, 5423, 'Galletitas', 'DON SATUR', 140.00, 'Gramos', 1500, 48.42, 'Talitas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1013, 5427, 'Galletitas', 'DON SATUR', 300.00, 'Gramos', 1800, 48.65, 'Pepas con Membrillo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1012, 5426, 'Galletitas', 'DON SATUR', 220.00, 'Gramos', 1500, 62.61, 'Magdalenas Sabor Vainilla Rellena con Dulce de Leche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (986, 5400, 'Galletitas', '9 DE ORO', 200.00, 'Gramos', 1000, 49.27, 'Magdalenas de Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1011, 5425, 'Galletitas', 'DON SATUR', 200.00, 'Gramos', 1500, 62.61, 'Magdalenas Vainilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1014, 5428, 'Galletitas', 'DON SATUR', 200.00, 'Gramos', 1500, 62.61, 'Magdalenas Marmoladas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1015, 5429, 'Galletitas', 'DON SATUR', 220.00, 'Gramos', 1500, 62.61, 'Magdalenas Sabor Chocolate Rellenas con Dulce de Leche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1016, 5430, 'Galletitas', 'Tía Maruca', 250.00, 'Gramos', 1500, 33.87, 'Anillos de Coco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1017, 5431, 'Galletitas', 'Tía Maruca', 300.00, 'Gramos', 1500, 35.22, 'Pepas con Membrillo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1018, 5432, 'Galletitas', 'Tía Maruca', 200.00, 'Gramos', 1500, 35.90, 'Varitas de Hojaldre');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1019, 5433, 'Galletitas', 'Tía Maruca', 350.00, 'Gramos', 1500, 33.87, 'Marineras Clásicas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1021, 5435, 'Galletitas', 'Tía Maruca', 200.00, 'Gramos', 1500, 35.90, 'Triangulitos de Hojaldre');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1022, 5436, 'Galletitas', 'Tía Maruca', 140.00, 'Gramos', 1400, 47.42, 'Biscuits ');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1024, 5438, 'Galletitas', 'Tía Maruca', 250.00, 'Gramos', 1500, 45.39, 'Magdalenas Rellenas con Dulce de Leche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1025, 5439, 'Galletitas', 'Tía Maruca', 200.00, 'Gramos', 1500, 35.90, 'Palmeritas de Hojaldre');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1026, 5440, 'Galletitas', 'Tía Maruca', 210.00, 'Gramos', 1600, 25.06, 'Crackers Salvado');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1027, 5441, 'Galletitas', 'Tía Maruca', 318.00, 'Gramos', 1600, 33.87, 'Crackres Original');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1029, 5443, 'Galletitas', 'Bagley', 140.00, 'Gramos', 1600, 13.00, 'Criollitas 3 Cereales');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1030, 5444, 'Galletitas', 'Bagley', 100.00, 'Gramos', 2000, 32.39, 'Criollitas Original');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1062, 5476, 'Galletitas', 'Bagley', 245.00, 'Gramos', 1800, 34.55, 'Vainitas Sabor Vainilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1031, 5445, 'Galletitas', 'Bagley', 504.00, 'Gramos', 1600, 157.07, 'Criollitas Sin Sal');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1028, 5442, 'Galletitas', 'Bagley', 300.00, 'Gramos', 2000, 54.07, 'Criollitas Original');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (959, 5239, 'Dulces', 'Arcor', 5.00, 'Kilogramos', 197, 906.63, 'Dulce de Batata en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1010, 5424, 'Galletitas', 'DON SATUR', 180.00, 'Gramos', 1794, 28.45, 'Palmeritas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1032, 5446, 'Galletitas', 'Bagley', 507.00, 'Gramos', 1600, 131.32, 'Criollitas Más Grandes');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1033, 5447, 'Galletitas', 'Bagley', 200.00, 'Gramos', 1600, 83.89, 'Criollitas Tostadas Clásicas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1035, 5449, 'Galletitas', 'Bagley', 500.00, 'Gramos', 1600, 134.03, 'Criollitas Original');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1037, 5451, 'Galletitas', 'Bagley', 400.00, 'Gramos', 2000, 102.86, 'Surtido');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1038, 5452, 'Galletitas', 'Bagley', 214.00, 'Gramos', 1600, 20.32, 'Salvado Sin Sal');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1039, 5453, 'Galletitas', 'Bagley', 507.00, 'Gramos', 1600, 163.41, 'Salvado Original');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1040, 5454, 'Galletitas', 'Bagley', 75.00, 'Gramos', 1800, 59.50, 'Kesitas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1041, 5455, 'Galletitas', 'Bagley', 125.00, 'Gramos', 1800, 89.31, 'Kesitas en Estuche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1042, 5456, 'Galletitas', 'Bagley', 101.00, 'Gramos', 2500, 36.46, 'Traviata Original');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1043, 5457, 'Galletitas', 'Bagley', 303.00, 'Gramos', 2000, 92.02, 'Traviata Original');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1045, 5459, 'Galletitas', 'Bagley', 118.00, 'Gramos', 2000, 56.79, 'Sonrisas Relleno de Frambuesa');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1046, 5460, 'Galletitas', 'Bagley', 354.00, 'Gramos', 1800, 162.49, 'Sonrisas Triple Relleno de Frambuesa');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1047, 5461, 'Galletitas', 'Bagley', 112.00, 'Gramos', 2000, 56.79, 'Rumba Relleno Original');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1048, 5462, 'Galletitas', 'Bagley', 336.00, 'Gramos', 1600, 162.49, 'Rumba Triple Relleno Original');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1050, 5464, 'Galletitas', 'Bagley', 125.00, 'Gramos', 1500, 89.31, 'Rex Original en Estuche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1051, 5465, 'Galletitas', 'Bagley', 220.00, 'Gramos', 1600, 121.83, 'Opera Obleas Rellenas Sabor Naranja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1052, 5466, 'Galletitas', 'Bagley', 55.00, 'Gramos', 1800, 37.97, 'Opera Obleas Rellenas Sabor Naranja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1055, 5469, 'Galletitas', 'Bagley', 170.00, 'Gramos', 1700, 69.33, 'Chocolinas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1056, 5470, 'Galletitas', 'Bagley', 250.00, 'Gramos', 1600, 98.80, 'Chocolinas Original');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1057, 5471, 'Galletitas', 'Bagley', 90.00, 'Gramos', 1200, 98.80, 'Chocolina Original Mini Bolsa');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1058, 5472, 'Galletitas', 'Bagley', 112.00, 'Gramos', 1500, 56.79, 'Mellizas Rellenas Sabor Limón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1059, 5473, 'Galletitas', 'Bagley', 336.00, 'Gramos', 1200, 162.49, 'Mellizas Triple Rellenas Sabor Limón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1060, 5474, 'Galletitas', 'Bagley', 93.00, 'Gramos', 1500, 56.79, 'Merengadas Rellenas de Frutilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1061, 5475, 'Galletitas', 'Bagley', 279.00, 'Gramos', 1200, 162.49, 'Merengadas Triple Rellenas de Frutilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1063, 5477, 'Galletitas', 'Bagley', 170.00, 'Gramos', 1300, 20.99, 'Melitta Clásicas con Miel');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1064, 5478, 'Galletitas', 'Bagley', 112.00, 'Gramos', 1000, 56.79, 'Amor Cupido Rellenas Sabor Almendra');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1065, 5479, 'Galletitas', 'Bagley', 336.00, 'Gramos', 1000, 162.49, 'Amor Cupido Triple Rellenas Sabor Almendra');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1066, 5480, 'Galletitas', 'Arcor', 336.00, 'Gramos', 2200, 89.31, 'Serranas Sandwich');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1068, 5482, 'Galletitas', 'Arcor', 100.00, 'Gramos', 2000, 64.92, 'Saladix Snacks Sabor Calabresa en Estuche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1069, 5483, 'Galletitas', 'Arcor', 100.00, 'Gramos', 2000, 64.92, 'Saladix Snacks Sabor Jamón en Estuche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1070, 5484, 'Galletitas', 'Arcor', 100.00, 'Gramos', 2000, 64.92, 'Saladix Snacks Sabor Parmesano en Estuche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1071, 5485, 'Galletitas', 'Arcor', 80.00, 'Gramos', 2000, 64.92, 'Saladix Duo Jamón y Queso');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1072, 5486, 'Galletitas', 'Arcor', 165.00, 'Gramos', 2000, 60.85, 'Maná Vainilla Rellenas Sabor a Frutilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1000, 5414, 'Galletitas', '9 DE ORO', 180.00, 'Gramos', 1997, 40.21, 'Scons con Sabor a Limón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1054, 5468, 'Galletitas', 'Bagley', 50.00, 'Gramos', 1599, 20.32, 'Opera Remix Sabor Frutilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1008, 5422, 'Galletitas', 'DON SATUR', 200.00, 'Gramos', 1797, 33.77, 'Bizcocho Negrito');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1073, 5487, 'Galletitas', 'Arcor', 165.00, 'Gramos', 2000, 60.85, 'Maná Chocolate Rellenas Sabor a Vainilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1074, 5488, 'Galletitas', 'Arcor', 165.00, 'Gramos', 2000, 60.85, 'Maná Vainilla Rellenas Sabor a Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1076, 5490, 'Galletitas', 'Arcor', 145.00, 'Gramos', 2000, 51.36, 'Maná Livianas con Leche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1077, 5491, 'Galletitas', 'Arcor', 393.00, 'Gramos', 1800, 134.03, 'Maná Livianas Sabor Vainilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1078, 5492, 'Galletitas', 'Arcor', 200.00, 'Gramos', 1800, 59.49, 'Hogareñas Salvado');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1079, 5493, 'Galletitas', 'Arcor', 600.00, 'Gramos', 1500, 162.36, 'Hogareñas Salvado');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1080, 5494, 'Galletitas', 'Arcor', 189.00, 'Gramos', 1600, 64.92, 'Hogareñas Mix de Cereales');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1081, 5495, 'Galletitas', 'Arcor', 189.00, 'Gramos', 1800, 64.91, 'Hogareñas 7 Semillas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1082, 5496, 'Galletitas', 'Arcor', 543.00, 'Gramos', 1500, 176.04, 'Hogareñas 7 Semillas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1083, 5497, 'Galletitas', 'Arcor', 124.00, 'Gramos', 1600, 67.63, 'Cofler Block con Maní y Chips de Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1084, 5498, 'Galletitas', 'Arcor', 118.00, 'Gramos', 1800, 75.76, 'Rocklets con Mini Rocklets y Chips de Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1085, 5499, 'Galletitas', 'OREO', 117.00, 'Gramos', 1800, 49.16, 'Oreo de Chocolate Rellenas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1086, 5500, 'Galletitas', 'OREO', 351.00, 'Gramos', 1300, 223.61, 'Oreo Clásicas de Chocolate Rellenas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1087, 5501, 'Galletitas', 'OREO', 181.00, 'Gramos', 1500, 83.50, 'Oreo Clásicas de Chocolate Rellenas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1088, 5502, 'Galletitas', 'OREO', 117.00, 'Gramos', 1700, 33.75, 'Oreo Sabor a Choco Brownie');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1089, 5503, 'Galletitas', 'OREO', 119.00, 'Gramos', 1000, 143.52, 'Oreo Bañadas en Chocolate Milka');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1090, 5504, 'Galletitas', 'OREO', 119.00, 'Gramos', 1000, 143.52, 'Oreo Bañadas en Chocolate Blanco Milka');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1091, 5505, 'Galletitas', 'Milka', 158.00, 'Gramos', 1500, 54.07, 'Cookies con Perlitas de Chocolate con Leche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1092, 5506, 'Galletitas', 'milka', 158.00, 'Gramos', 1500, 54.07, 'Cookie Choco con Perlitas de Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1093, 5507, 'Galletitas', 'milka', 65.00, 'Gramos', 1000, 43.23, 'Choco Minis');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1094, 5508, 'Galletitas', 'Toddy', 178.00, 'Gramos', 1200, 74.87, 'Chispas de Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1095, 5509, 'Galletitas', 'Toddy', 115.00, 'Gramos', 1000, 13.54, 'Chocolat Relleno Sabor a Vainilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1096, 5510, 'Galletitas', 'Toddy', 115.00, 'Gramos', 1000, 18.28, 'Chocolat Mousse de Dulce de Leche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1097, 5511, 'Galletitas', 'Toddy', 115.00, 'Gramos', 1000, 18.28, 'Mousse de Chocolate con Rellenos de Frutilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1098, 5512, 'Galletitas', 'Toddy', 126.00, 'Gramos', 1000, 35.10, 'Black con Chispas Blanca y Negra de Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1099, 5513, 'Galletitas', 'Toddy', 210.00, 'Gramos', 1000, 17.61, 'Chips de Dulce de Leche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1100, 5514, 'Galletitas', 'Toddy', 150.00, 'Gramos', 1000, 27.09, 'Chips Rellena');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1101, 5515, 'Galletitas', 'Toddy', 126.00, 'Gramos', 1000, 60.25, 'Chips Choco Clásica');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1102, 5516, 'Galletitas', 'Terrabusi', 160.00, 'Gramos', 1500, 33.49, 'Anillos Surtidas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1103, 5517, 'Galletitas', 'Terrabusi', 300.00, 'Gramos', 1800, 89.48, 'Variedad Sabor Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1104, 5518, 'Galletitas', 'Terrabusi', 300.00, 'Gramos', 1800, 89.48, 'Variedad Dorada');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1105, 5519, 'Galletitas', 'Terrabusi', 600.00, 'Gramos', 1800, 155.71, 'Variedad');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1106, 5520, 'Galletitas', 'Terrabusi', 400.00, 'Gramos', 1800, 87.95, 'Variedad');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1107, 5521, 'Galletitas', 'Terrabusi', 160.00, 'Gramos', 1800, 40.52, 'Variedad');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1053, 5467, 'Galletitas', 'Bagley', 92.00, 'Gramos', 1797, 54.07, 'Opera Obleas Rellenas Sabor Naranja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1108, 5522, 'Galletitas', 'Terrabusi', 108.00, 'Gramos', 2000, 31.04, 'Express Clásicas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1109, 5523, 'Galletitas', 'Terrabusi', 324.00, 'Gramos', 2000, 95.09, 'Express Clásicas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1111, 5525, 'Galletitas', 'Terrabusi', 120.00, 'Gramos', 2000, 53.80, 'Melba con Relleno Sabor a Limón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1112, 5526, 'Galletitas', 'Terrabusi', 157.00, 'Gramos', 1800, 48.65, 'Melba con Relleno Sabor a Limón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1114, 5528, 'Galletitas', 'Terrabusi', 140.00, 'Gramos', 1800, 49.22, 'Champagne Rellenas de 2 Sabores Frutilla & Vainilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1115, 5529, 'Galletitas', 'Terrabusi', 115.00, 'Gramos', 1800, 48.65, 'Duquesa con Relleno Sabor a Limón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1116, 5530, 'Galletitas', 'Terrabusi', 153.00, 'Gramos', 2000, 52.53, 'Lincoln ');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1117, 5531, 'Galletitas', 'Quaker', 187.00, 'Gramos', 2200, 64.92, 'Galleta de Avena con Manzana');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1118, 5532, 'Galletitas', 'Quaker', 187.00, 'Gramos', 2200, 68.98, 'Galleta de Avena con Pasas de Uva');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1119, 5533, 'Galletitas', 'Quaker', 187.00, 'Gramos', 2200, 68.98, 'Galleta Tipo Casera Granola');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1120, 5534, 'Galletitas', 'Quaker', 157.00, 'Gramos', 2200, 68.98, 'Galleta Tipo Casera con Chispas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1121, 5535, 'Galletitas', 'Quaker', 110.00, 'Gramos', 2200, 23.84, 'Galletas con Frutas Rellenas con Yogurt Sabor Frutilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1122, 5536, 'Galletitas', 'Pepitos!', 118.00, 'Gramos', 1800, 53.49, 'Galletita Original');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1123, 5537, 'Galletitas', 'Pepitos!', 354.00, 'Gramos', 800, 162.43, 'Galletita Original');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1124, 5538, 'Galletitas', 'Pepitos!', 124.00, 'Gramos', 1500, 22.91, 'Galletita Tortita Black');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1125, 5539, 'Galletitas', 'Pepitos!', 50.00, 'Gramos', 1500, 30.79, 'Galletita Mini');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1131, 5605, 'Papas Fritas', 'Pringles', 124.00, 'Gramos', 1000, 238.43, 'Papa Frita Sabor Crema y Cebolla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1132, 5606, 'Papas Fritas', 'Pringles', 40.00, 'Gramos', 1000, 83.44, 'Papa Frita Sabor Crema y Cebolla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1129, 5603, 'Papas Fritas', 'Pringles', 124.00, 'Gramos', 1000, 238.44, 'Papa Frita Original');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1130, 5604, 'Papas Fritas', 'Pringles', 124.00, 'Gramos', 1000, 218.28, 'Papa Frita Sabor a Pizza');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1126, 5600, 'Papas Fritas', 'Pringles', 40.00, 'Gramos', 1500, 83.44, 'Papa Frita Sabor a Queso');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1127, 5601, 'Papas Fritas', 'Pringles', 37.00, 'Gramos', 1500, 83.44, 'Papa Frita Sabor a Queso');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1133, 5607, 'Papas Fritas', 'Pringles', 124.00, 'Gramos', 1000, 238.44, 'Papa Frita Sabor a Jamón Serrano');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1128, 5602, 'Papas Fritas', 'Pringles', 124.00, 'Gramos', 1000, 238.44, 'Papa Frita Sabor a Queso');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1134, 5608, 'Papas Fritas', 'Lay''s', 250.00, 'Gramos', 1200, 237.03, 'Papa Frita Clásicas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1136, 5610, 'Papas Fritas', 'Lay''s', 150.00, 'Gramos', 1200, 174.82, 'Papa Frita Clásicas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1138, 5612, 'Papas Fritas', 'Pahuamar', 550.00, 'Gramos', 1000, 251.89, 'Papas Fritas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1139, 5613, 'Papas Fritas', 'Pehuamar', 280.00, 'Gramos', 1000, 151.09, 'Papa Frita');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1140, 5614, 'Papas Fritas', 'Pahuamar', 550.00, 'Gramos', 1000, 251.89, 'Papas Acanaladas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1141, 5650, 'Snack', 'Doritos', 250.00, 'Gramos', 1000, 237.03, 'Snack Copetín a Base de Maíz con Sabor a Queso');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1142, 5651, 'Snack', 'Doritos', 150.00, 'Gramos', 1000, 148.94, 'Snack Copetín a Base de Maíz con Sabor a Queso');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1143, 5652, 'Snack', 'Cheetos', 165.00, 'Gramos', 1200, 133.28, 'Snack Horneados Clásico Queso');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1144, 5653, 'Snack', 'Pehuamar', 300.00, 'Gramos', 1000, 148.94, 'Maicitos Horneados');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1145, 5654, 'Snack', 'Pepsico', 105.00, 'Gramos', 1000, 101.51, '3 D''S Megatube Queso');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1195, 5749, 'Café y Maltas', 'NESCAFÉ', 100.00, 'Gramos', 800, 291.08, 'Café Clásico en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1147, 5701, 'Café y Maltas', 'La Virginia', 1.00, 'Kilogramos', 500, 614.78, 'Café Molido en Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1146, 5700, 'Café y Maltas', 'La Virginia', 275.00, 'Gramos', 1200, 275.40, 'Cappuccino Tradicional en Doy Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1148, 5702, 'Café y Maltas', 'La Virginia', 250.00, 'Gramos', 1800, 154.46, 'Café Molido en Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1150, 5704, 'Café y Maltas', 'La Virginia', 155.00, 'Gramos', 1000, 165.65, 'Cappuccino Sabor Mousse de Chocolate y Avellana en Doy Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1153, 5707, 'Café y Maltas', 'La Virginia', 10.00, 'Unidades', 800, 339.25, 'Café Espresso Sutil N°5');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1154, 5708, 'Café y Maltas', 'La Virginia', 10.00, 'Unidades', 800, 339.25, 'Café Espresso Equilibrado N° 7');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1155, 5709, 'Café y Maltas', 'La Virginia', 10.00, 'Unidades', 800, 339.25, 'Café Espresso Intenso N° 9');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1156, 5710, 'Café y Maltas', 'La Virginia', 125.00, 'Gramos', 1000, 137.65, 'Latte Doy Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1158, 5712, 'Café y Maltas', 'La Virginia', 500.00, 'Gramos', 1000, 309.01, 'Café Molido en Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1160, 5714, 'Café y Maltas', 'La Virginia', 100.00, 'Gramos', 1000, 205.98, 'Café Instantánea Suave en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1149, 5703, 'Café y Maltas', 'La Virginia', 50.00, 'Gramos', 1800, 111.89, 'Café Instantánea Suave en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1152, 5706, 'Café y Maltas', 'La Virginia', 170.00, 'Gramos', 1800, 301.17, 'Café Instantánea Suave en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1161, 5715, 'Café y Maltas', 'La Virginia', 50.00, 'Gramos', 1800, 111.89, 'Café Instantánea Clásico en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1162, 5716, 'Café y Maltas', 'La Virginia', 20.00, 'Unidades', 1000, 148.84, 'Café Saquito Puro Aroma');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1163, 5717, 'Café y Maltas', 'La Virginia', 125.00, 'Gramos', 1000, 129.81, 'Cappuccino Tradicional en Doy Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1164, 5718, 'Café y Maltas', 'La Virginia', 100.00, 'Gramos', 1500, 205.98, 'Café Instantánea Clásico en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1165, 5719, 'Café y Maltas', 'La Virginia', 170.00, 'Gramos', 1000, 301.17, 'Café Instantánea Clásico en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1166, 5720, 'Café y Maltas', 'La Virginia', 210.00, 'Gramos', 1000, 279.89, 'Cappuccino Tradicional en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1167, 5721, 'Café y Maltas', 'La Virginia', 100.00, 'Gramos', 1000, 137.65, 'Cappuccino Light Doy Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1168, 5722, 'Café y Maltas', 'La Virginia', 36.00, 'Sobres', 1000, 231.73, 'Café Instantánea Clásico');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1170, 5724, 'Café y Maltas', 'NESCAFÉ', 170.00, 'Gramos', 800, 302.29, 'Café Dolca Tradicional en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1171, 5725, 'Café y Maltas', 'NESCAFÉ', 100.00, 'Gramos', 1000, 223.90, 'Café Dolca Tradicional en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1172, 5726, 'Café y Maltas', 'NESCAFÉ', 170.00, 'Gramos', 800, 302.29, 'Café Dolca Suave en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1173, 5727, 'Café y Maltas', 'NESCAFÉ', 100.00, 'Gramos', 800, 223.90, 'Café Dolca Suave en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1174, 5728, 'Café y Maltas', 'NESCAFÉ', 50.00, 'Gramos', 1000, 134.29, 'Café Dolca Suave en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1175, 5729, 'Café y Maltas', 'NESCAFÉ', 125.00, 'Gramos', 1000, 123.09, 'Café Dolca Cappuccino en Doy Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1176, 5730, 'Café y Maltas', 'NESCAFÉ', 170.00, 'Gramos', 800, 246.30, 'Café Dolca Formato Ecónomico Tradicional en Doy Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1177, 5731, 'Café y Maltas', 'NESCAFÉ', 170.00, 'Gramos', 800, 246.30, 'Café Dolca Suave en Doy Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1178, 5732, 'Café y Maltas', 'NESCAFÉ', 500.00, 'Gramos', 800, 380.68, 'Café Dolca Suave Familiar Económico en Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1179, 5733, 'Café y Maltas', 'NESCAFÉ', 100.00, 'Gramos', 800, 123.09, 'Café Dolca Cappuccino Light en Doy Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1137, 5611, 'Papas Fritas', 'Lay''s', 380.00, 'Gramos', 1197, 298.01, 'Papa Frita Clásicas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1157, 5711, 'Café y Maltas', 'La Virginia', 125.00, 'Gramos', 995, 137.65, 'Café Cortado en Doy Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1159, 5713, 'Café y Maltas', 'La Virginia', 125.00, 'Gramos', 999, 86.13, 'Café Molido en Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1180, 5734, 'Café y Maltas', 'NESCAFÉ', 50.00, 'Gramos', 1000, 134.29, 'Café Dolce Tradicional en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1181, 5735, 'Café y Maltas', 'NESCAFÉ', 1.00, 'Kilogramos', 600, 1136.55, 'Café Dolca en Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1183, 5737, 'Café y Maltas', 'NESCAFÉ', 125.00, 'Gramos', 1000, 123.09, 'Café Dolca Cortado en Doy Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1196, 5750, 'Café y Maltas', 'NESCAFÉ', 95.00, 'Gramos', 800, 425.50, 'Café Descafeinado en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1182, 5736, 'Café y Maltas', 'NESCAFÉ', 125.00, 'Gramos', 1000, 123.09, 'Café Dolca con Leche en Doy Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1184, 5738, 'Café y Maltas', 'NESCAFÉ', 125.00, 'Gramos', 1000, 100.09, 'Café Dolca Caffe Latte en Doy Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1185, 5739, 'Café y Maltas', 'NESCAFÉ', 200.00, 'Gramos', 800, 559.89, 'Café Dolce Gusto Cappuccino');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1187, 5741, 'Café y Maltas', 'NESCAFÉ', 270.00, 'Gramos', 800, 365.77, 'Café Dolce Gusto Chococino');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1188, 5742, 'Café y Maltas', 'NESCAFÉ', 216.00, 'Gramos', 800, 365.77, 'Café Dolce Gusto Mocha');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1189, 5743, 'Café y Maltas', 'NESCAFÉ', 112.00, 'Gramos', 800, 559.89, 'Café Dolce Gusto Lungo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1190, 5744, 'Café y Maltas', 'NESCAFÉ', 100.80, 'Gramos', 800, 559.89, 'Café Dolce Gusto Latte Macchiato');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1191, 5745, 'Café y Maltas', 'NESCAFÉ', 160.00, 'Gramos', 800, 559.89, 'Café Dolce Gusto AU Lait');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1192, 5746, 'Café y Maltas', 'NESCAFÉ', 250.00, 'Gramos', 800, 403.09, 'Café Molido Gold Suave en Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1194, 5748, 'Café y Maltas', 'NESCAFÉ', 250.00, 'Gramos', 800, 403.09, 'Café Molido Gold Equilibrado en Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1197, 5751, 'Café y Maltas', 'NESCAFÉ', 170.00, 'Gramos', 800, 470.28, 'Café Clásico en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1198, 5752, 'Café y Maltas', 'NESCAFÉ', 100.00, 'Gramos', 800, 559.89, 'Café Espresso en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1200, 5754, 'Café y Maltas', 'NESCAFÉ', 170.00, 'Gramos', 1000, 167.89, 'Crema Coffee Mate Light en Pote');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1199, 5753, 'Café y Maltas', 'NESCAFÉ', 170.00, 'Gramos', 1200, 167.89, 'Crema Coffee Matte en Pote');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1202, 5756, 'Café y Maltas', 'Cabrales', 20.00, 'Unidades', 1000, 146.23, 'Café en Saquitos');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1203, 5757, 'Café y Maltas', 'Cabrales', 250.00, 'Gramos', 1200, 183.56, 'Café Tostado Molido Super en Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1204, 5758, 'Café y Maltas', 'Cabrales', 500.00, 'Gramos', 1000, 342.61, 'Café Tostado Molido Super en Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1205, 5759, 'Café y Maltas', 'Cabrales', 210.00, 'Gramos', 1500, 224.83, 'Cappuccino Instantáneo en Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1206, 5760, 'Café y Maltas', 'Cabrales', 50.00, 'Gramos', 1800, 67.75, 'Café Instantáneo Clásico en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1208, 5762, 'Café y Maltas', 'Cabrales', 500.00, 'Gramos', 1000, 677.47, 'Café Oro Super Tostado en Grano en Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1209, 5763, 'Café y Maltas', 'Cabrales', 125.00, 'Gramos', 1600, 153.00, 'Cappuccino Instantáneo en Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1210, 5764, 'Café y Maltas', 'Cabrales', 84.00, 'Gramos', 1000, 406.43, 'Café Espresso');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1211, 5765, 'Café y Maltas', 'Cabrales', 98.00, 'Gramos', 1000, 406.42, 'Café Lungo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1212, 5766, 'Café y Maltas', 'Cabrales', 88.00, 'Gramos', 1000, 406.43, 'Café Cortado');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1213, 5767, 'Café y Maltas', 'Cabrales', 168.00, 'Gramos', 1000, 406.43, 'Café Cappuccino');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1151, 5705, 'Café y Maltas', 'La Virginia', 155.00, 'Gramos', 999, 163.41, 'Cappuccino Sabor Espuma de Vainilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1169, 5723, 'Café y Maltas', 'NESCAFÉ', 125.00, 'Gramos', 997, 123.09, 'Café Dolca Mocha Doy Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1217, 5803, 'Té', 'La Virginia', 20.00, 'Unidades', 3000, 91.73, 'Té de Limón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1218, 5804, 'Té', 'La Virginia', 20.00, 'Unidades', 3000, 106.29, 'Té de Maracuyá');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1221, 5807, 'Té', 'La Virginia', 25.00, 'Unidades', 2500, 89.48, 'Té Tilo con Manzanilla y Cedrón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1272, 5918, 'Yerbas', 'Taragüi', 25.00, 'Unidades', 6000, 55.80, 'Yerba en Saquito');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1222, 5808, 'Té', 'La Virginia', 20.00, 'Unidades', 2000, 101.80, 'Té Verde Jazmín');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1223, 5809, 'Té', 'La Virginia', 25.00, 'Unidades', 2000, 44.71, 'Té Hierbas Alimonadas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1224, 5810, 'Té', 'La Virginia', 25.00, 'Unidades', 2000, 44.71, 'Té Hierbas Mentoladas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1225, 5811, 'Té', 'La Virginia', 20.00, 'Unidades', 2000, 93.97, 'Té Rosa Mosqueta y Manzanilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1226, 5812, 'Té', 'La Virginia', 20.00, 'Unidades', 2500, 93.97, 'Té Manazana con Canela');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1227, 5813, 'Té', 'La Virginia', 20.00, 'Unidades', 2000, 81.65, 'Té Frutilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1228, 5814, 'Té', 'La Virginia', 25.00, 'Unidades', 3000, 73.79, 'Té Boldo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1229, 5815, 'Té', 'La Virginia', 25.00, 'Unidades', 2500, 55.89, 'Té Hierbas Menta Peperina');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1230, 5816, 'Té', 'La Virginia', 25.00, 'Unidades', 2500, 55.89, 'Té Hierbas Manzanilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1231, 5817, 'Té', 'La Virginia', 25.00, 'Unidades', 2500, 67.08, 'Té Hierbas Cedrón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1232, 5818, 'Té', 'La Virginia', 20.00, 'Unidades', 2200, 81.65, 'Té Durazno');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1233, 5819, 'Té', 'La Virginia', 20.00, 'Unidades', 2000, 82.43, 'Té Canela');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1234, 5820, 'Té', 'La Virginia', 25.00, 'Unidades', 2000, 124.21, 'Té Hierbas Tilo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1235, 5821, 'Té', 'La Virginia', 25.00, 'Unidades', 2000, 61.49, 'Té Hierbas Mezcla de Hierbas Naturales');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1237, 5823, 'Té', 'Taragüi', 25.00, 'Unidades', 3000, 37.03, 'Té Negro');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1215, 5801, 'Té', 'La Virginia', 100.00, 'Unidades', 3500, 161.17, 'Té Negro');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1216, 5802, 'Té', 'La Virginia', 25.00, 'Unidades', 4000, 40.21, 'Té Negro');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1238, 5824, 'Té', 'Taragüi', 50.00, 'Unidades', 3000, 83.89, 'Té Negro');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1243, 5829, 'Té', 'Taragüi', 20.00, 'Unidades', 2000, 130.69, 'Té Placeres 6 Variedades');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1246, 5832, 'Té', 'Taragüi', 25.00, 'Unidades', 2000, 96.45, 'Té Hierbas Silvestres Manzanilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1240, 5826, 'Té', 'Taragüi', 10.00, 'Unidades', 2000, 44.96, 'Té Hierbas Silvestres Boldo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1244, 5830, 'Té', 'Taragüi', 25.00, 'Unidades', 2000, 162.09, 'Té Hierbas Silvestres  Tilo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1242, 5828, 'Té', 'Taragüi', 10.00, 'Unidades', 2000, 44.96, 'Té Hierbas Silvestres Manzanilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1247, 5833, 'Té', 'Taragüi', 20.00, 'Unidades', 2000, 109.53, 'Té Placeres Frutas Rojas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1248, 5834, 'Té', 'Taragüi', 25.00, 'Unidades', 2000, 96.45, 'Té Hierbas Silvestres Mezcla de Hierbas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1249, 5835, 'Té', 'Taragüi', 10.00, 'Unidades', 2000, 44.96, 'Té Hierbas Silvestres Mezcla de Hierbas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1250, 5836, 'Té', 'Taragüi', 180.00, 'Gramos', 2000, 180.10, 'Té Negro en Hebra Blend');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1275, 5921, 'Yerbas', 'Taragüi', 250.00, 'Gramos', 8000, 107.40, 'Yerba Mate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1254, 5900, 'Yerbas', 'CBSé', 500.00, 'Gramos', 8000, 132.93, 'Yerba Mate Frutos Tropicales');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1274, 5920, 'Yerbas', 'Taragüi', 500.00, 'Gramos', 5000, 60.33, 'Yerba Mate Cítricos del Litoral');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1271, 5917, 'Yerbas', 'CBSé', 500.00, 'Gramos', 5000, 120.84, 'Yerba Mate Limón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1255, 5901, 'Yerbas', 'CBSé', 500.00, 'Gramos', 6000, 132.93, 'Yerba Mate con Miel');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1256, 5902, 'Yerbas', 'CBSé', 500.00, 'Gramos', 6000, 132.93, 'Yerba Mate Silueta');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1239, 5825, 'Té', 'Taragüi', 20.00, 'Unidades', 1997, 95.80, 'Té Verde');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1219, 5805, 'Té', 'La Virginia', 20.00, 'Unidades', 2997, 78.29, 'Té Verde');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1257, 5903, 'Yerbas', 'CBSé', 500.00, 'Gramos', 5000, 132.93, 'Yerba Mate Regulasé');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1258, 5904, 'Yerbas', 'CBSé', 500.00, 'Gramos', 5000, 132.93, 'Yerba Mate ENDUlife');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1259, 5905, 'Yerbas', 'CBSé', 500.00, 'Gramos', 5000, 132.93, 'Yerba Mate Energía Guarana');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1260, 5906, 'Yerbas', 'CBSé', 500.00, 'Gramos', 5000, 132.93, 'Yerba Mate Silueta Naranja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1270, 5916, 'Yerbas', 'CBSé', 500.00, 'Gramos', 5000, 120.84, 'Yerba Mate Pomelo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1273, 5919, 'Yerbas', 'Taragüi', 500.00, 'Gramos', 5000, 60.31, 'Yerba Mate Naranja de Oriente');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1268, 5914, 'Yerbas', 'CBSé', 500.00, 'Gramos', 5000, 132.93, 'Yerba Mate Naranja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1269, 5915, 'Yerbas', 'CBSé', 250.00, 'Gramos', 8000, 44.71, 'Yerba Mate Hierbas Serranas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1267, 5913, 'Yerbas', 'CBSé', 1.00, 'Kilogramos', 5000, 246.27, 'Yerba Mate Hierbas Serranas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1266, 5912, 'Yerbas', 'CBSé', 500.00, 'Gramos', 8000, 132.96, 'Yerba Mate Hierbas Serranas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1261, 5907, 'Yerbas', 'CBSé', 500.00, 'Gramos', 6000, 132.93, 'Yerba Mate Hierbas Cuyanas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1263, 5909, 'Yerbas', 'CBSé', 500.00, 'Gramos', 5000, 132.93, 'Yerba Mate Frutos del Valle');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1264, 5910, 'Yerbas', 'CBSé', 500.00, 'Gramos', 5000, 132.93, 'Yerba Mate Hierbas del Litoral');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1265, 5911, 'Yerbas', 'CBSé', 500.00, 'Gramos', 8000, 209.32, 'Yerba Mate Etiqueta Negra Hierbas Serranas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1262, 5908, 'Yerbas', 'CBSé', 500.00, 'Gramos', 5000, 132.93, 'Yerba Mate Frutos del Bosque');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1276, 5922, 'Yerbas', 'Taragüi', 500.00, 'Gramos', 7000, 160.05, 'Yerba Mate Despalada');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1288, 5934, 'Yerbas', 'Unión', 500.00, 'Gramos', 6000, 151.41, 'Yerba Mate Suave Bajo Contenido de Polvo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1280, 5926, 'Yerbas', 'Taragüi', 1.00, 'Kilogramos', 6000, 247.89, 'Yerba Mate Liviana');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1282, 5928, 'Yerbas', 'Taragüi', 500.00, 'Gramos', 500, 177.28, 'Yerba Mate 4 Flex');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1281, 5927, 'Yerbas', 'Taragüi', 500.00, 'Gramos', 6000, 127.25, 'Yerba Mate Liviana');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1283, 5929, 'Yerbas', 'Taragüi', 1.00, 'Kilogramos', 8000, 357.14, 'Yerba Mate 4 Flex');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1284, 5930, 'Yerbas', 'Taragüi', 500.00, 'Gramos', 6000, 160.03, 'Yerba Mate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1285, 5931, 'Yerbas', 'Taragüi', 100.00, 'Unidades', 3000, 195.77, 'Yerba en Saquito');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1286, 5932, 'Yerbas', 'Taragüi', 50.00, 'Unidades', 3000, 110.76, 'Yerba en Saquito');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1287, 5933, 'Yerbas', 'Unión', 500.00, 'Gramos', 6000, 187.15, 'Yerba Mate Suave Hierbas Serranas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1289, 5935, 'Yerbas', 'Unión', 500.00, 'Gramos', 6000, 160.03, 'Yerba Mate Suave Original');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1290, 5936, 'Yerbas', 'Unión', 1.00, 'Kilogramos', 6000, 322.16, 'Yerba Mate Suave Bajo Contenido de Polvo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1252, 5838, 'Té', 'ROSAMONTE', 50.00, 'Unidades', 3000, 78.47, 'Té Negro');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1236, 5822, 'Té', 'Taragüi', 100.00, 'Unidades', 2799, 155.11, 'Té Negro');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1220, 5806, 'Té', 'La Virginia', 25.00, 'Unidades', 1999, 123.09, 'Té Manzanilla y Anis');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1277, 5923, 'Yerbas', 'Taragüi', 1.00, 'Kilogramos', 7999, 348.53, 'Yerba Mate Despalada');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1291, 5937, 'Yerbas', 'Unión', 250.00, 'Gramos', 4000, 89.82, 'Yerba Mate Suave Original');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1292, 5938, 'Yerbas', 'Unión', 1.00, 'Kilogramos', 6000, 320.20, 'Yerba Mate Suave Original');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1293, 5939, 'Yerbas', 'Unión', 500.00, 'Gramos', 5000, 115.06, 'Yerba Mate Suave Relax Bajo Contenido de Mateina');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1294, 5940, 'Yerbas', 'Unión', 1.50, 'Kilogramos', 6000, 335.89, 'Yerba Mate Suave Original');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1295, 5941, 'Yerbas', 'Unión', 500.00, 'Gramos', 2500, 38.76, 'Yerba Mate bio Suave con Prebioticos');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1296, 5942, 'Yerbas', 'Unión', 500.00, 'Gramos', 3000, 177.28, 'Yerba Mate 4 Flex');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1297, 5943, 'Yerbas', 'Unión', 500.00, 'Gramos', 3000, 187.15, 'Yerba Mate Suave Hierbas del Litoral');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1298, 5944, 'Yerbas', 'Unión', 1.00, 'Kilogramos', 3000, 357.14, 'Yerba Mate Suave 4 Flex');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1299, 5945, 'Yerbas', 'Unión', 25.00, 'Unidades', 2500, 61.48, 'Yerba Suave en Saquito');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1300, 5946, 'Yerbas', 'Unión', 50.00, 'Unidades', 2500, 110.76, 'Yerba Suave en Saquito');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1301, 5947, 'Yerbas', 'Unión', 100.00, 'Unidades', 2500, 195.77, 'Yerba Suave en Saquito');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1302, 5948, 'Yerbas', 'amanda', 1.00, 'Kilogramos', 6000, 295.55, 'Yerba Mate Despalada');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1303, 5949, 'Yerbas', 'amanda', 2.00, 'Kilogramos', 3000, 490.09, 'Yerba Mate ');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1304, 5950, 'Yerbas', 'amanda', 500.00, 'Gramos', 2500, 156.68, 'Yerba Mate Compuesta con Hierbas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1305, 5951, 'Yerbas', 'amanda', 500.00, 'Gramos', 3000, 152.65, 'Yerba Mate Despalada Azul');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1306, 5952, 'Yerbas', 'amanda', 250.00, 'Gramos', 5000, 69.60, 'Yerba Mate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1307, 5953, 'Yerbas', 'amanda', 500.00, 'Gramos', 3000, 199.46, 'Yerba Mate Premium');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1308, 5954, 'Yerbas', 'amanda', 500.00, 'Gramos', 7500, 139.10, 'Yerba Mate Tradicional');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1309, 5955, 'Yerbas', 'amanda', 1.00, 'Kilogramos', 6500, 314.03, 'Yerba Mate Tradicional');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1310, 5956, 'Yerbas', 'amanda', 500.00, 'Gramos', 5000, 147.72, 'Yerba Mate Campo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1311, 5957, 'Yerbas', 'amanda', 1.00, 'Kilogramos', 5300, 240.68, 'Yerba Mate Campo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1312, 5958, 'Yerbas', 'amanda', 25.00, 'Unidades', 2500, 49.84, 'Yerba en Saquito');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1313, 5959, 'Yerbas', 'amanda', 50.00, 'Unidades', 3000, 139.83, 'Yerba en Saquito');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1314, 5960, 'Yerbas', 'LA TRANQUERA', 500.00, 'Gramos', 4800, 135.39, 'Yerba Mate Tradicional');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1316, 5962, 'Yerbas', 'LA TRANQUERA', 500.00, 'Gramos', 3600, 135.39, 'Yerba Mate Suave');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1317, 5963, 'Yerbas', 'LA TRANQUERA', 1.00, 'Kilogramos', 3400, 270.91, 'Yerba Mate Suave');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1318, 5964, 'Yerbas', 'LA TRANQUERA', 25.00, 'Unidades', 2500, 53.83, 'Yerba en Saquito');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1319, 5965, 'Yerbas', 'LA TRANQUERA', 50.00, 'Unidades', 2300, 89.82, 'Yerba en Saquito');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1320, 5966, 'Yerbas', 'LA TRANQUERA', 100.00, 'Unidades', 2000, 168.90, 'Yerba en Saquito');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1321, 5967, 'Yerbas', 'PLAYADITO', 500.00, 'Gramos', 3600, 182.82, 'Yerba Mate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1322, 5968, 'Yerbas', 'PLAYADITO', 1.00, 'Kilogramos', 3300, 319.08, 'Yerba Mate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1323, 5969, 'Yerbas', 'PLAYADITO', 2.00, 'Kilogramos', 2500, 405.20, 'Yerba Mate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1324, 5970, 'Yerbas', 'PLAYADITO', 500.00, 'Gramos', 3200, 242.83, 'Yerba Mate Compuesta con Hierbas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1325, 5971, 'Yerbas', 'PLAYADITO', 25.00, 'Unidades', 2600, 78.34, 'Yerba en Saquito');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1326, 5972, 'Yerbas', 'PLAYADITO', 50.00, 'Unidades', 2200, 153.37, 'Yerba en Saquito');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1327, 5973, 'Yerbas', 'ROMANCE', 250.00, 'Gramos', 6000, 80.54, 'Yerba Mate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1330, 5976, 'Yerbas', 'ROMANCE', 2.00, 'Kilogramos', 7000, 517.65, 'Yerba Mate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1331, 5977, 'Yerbas', 'ROMANCE', 500.00, 'Gramos', 6000, 184.75, 'Yerba Mate Suave');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1333, 5979, 'Yerbas', 'LA MERCED', 500.00, 'Gramos', 3000, 229.03, 'Yerba Mate de Campo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1334, 5980, 'Yerbas', 'LA MERCED', 500.00, 'Gramos', 3000, 229.03, 'Yerba Mate de Campo Sur');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1335, 5981, 'Yerbas', 'LA MERCED', 500.00, 'Gramos', 3000, 229.03, 'Yerba Mate de Monte');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1336, 5982, 'Yerbas', 'LA MERCED', 500.00, 'Gramos', 3000, 229.03, 'Yerba Mate de Campo & Monte');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1337, 5983, 'Yerbas', 'LA MERCED', 500.00, 'Gramos', 3000, 229.03, 'Yerba Mate Barbacuá');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1279, 5925, 'Yerbas', 'Taragüi', 1.50, 'Kilogramos', 7997, 335.89, 'Yerba Mate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1253, 5839, 'Té', 'Virgin Islands', 25.00, 'Unidades', 2998, 69.96, 'Té Negro Clásico Fino');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1338, 5984, 'Yerbas', 'NOBLEZA GAUCHA', 500.00, 'Gramos', 2500, 167.42, 'Yerba Mate Selección');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1341, 5987, 'Yerbas', 'NOBLEZA GAUCHA', 500.00, 'Gramos', 3000, 123.09, 'Yerba Mate Molienda Equilibrada Azul');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1342, 5988, 'Yerbas', 'NOBLEZA GAUCHA', 1.00, 'Kilogramos', 2400, 207.08, 'Yerba Mate Molienda Equilibrada Azul');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1251, 5837, 'Té', 'ROSAMONTE', 25.00, 'Unidades', 3000, 44.59, 'Té Negro Clásico');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1343, 5989, 'Yerbas', 'ROSAMONTE', 500.00, 'Gramos', 6000, 189.11, 'Yerba Mate Selección Especial');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1344, 5990, 'Yerbas', 'ROSAMONTE', 1.00, 'Kilogramos', 6000, 342.61, 'Yerba Mate Selección Especial');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1345, 5991, 'Yerbas', 'ROSAMONTE', 500.00, 'Gramos', 6000, 163.73, 'Yerba Mate Tradicional Plus');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1346, 5992, 'Yerbas', 'ROSAMONTE', 1.00, 'Kilogramos', 5000, 297.81, 'Yerba Mate Tradicional Plus');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1349, 5995, 'Yerbas', 'Primicia', 500.00, 'Gramos', 3000, 135.38, 'Yerba Mate Tradicional');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1350, 5996, 'Yerbas', 'Primicia', 1.00, 'Kilogramos', 2800, 269.69, 'Yerba Mate Tradicional');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1351, 6100, 'Limpieza de Baño', 'Glade', 27.50, 'Gramos', 2000, 65.17, 'Pastilla Campos de Lavanda Incluye Red Protectora');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1352, 6101, 'Limpieza de Baño', 'Glade', 25.00, 'Gramos', 2000, 54.09, 'Pastilla Lavanda Incluye Red Protectora');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1353, 6102, 'Limpieza de Baño', 'Glade', 25.00, 'Gramos', 2000, 54.09, 'Pastilla Bosque de Pinos Incluye Red Protectora');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1354, 6103, 'Limpieza de Baño', 'Glade', 25.00, 'Gramos', 2000, 54.09, 'Pastilla Mañana de Campo Incluye Red Protectora');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1358, 6107, 'Limpieza de Baño', 'Glade', 50.00, 'Mililitro', 2000, 169.90, 'Repuesto Canasta Líquida Campos de Lavanda');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1359, 6108, 'Limpieza de Baño', 'Glade', 50.00, 'Mililitro', 2000, 211.79, 'Aparato Canasta Líquida Mañana de Campo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1355, 6104, 'Limpieza de Baño', 'Glade', 50.00, 'Mililitro', 2000, 169.90, 'Repuesto Canasta Líquida Brisa de las Cumbres');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1357, 6106, 'Limpieza de Baño', 'Glade', 50.00, 'Mililitro', 2000, 169.90, 'Repuesto Canasta Líquida I Love You');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1356, 6105, 'Limpieza de Baño', 'Glade', 50.00, 'Mililitro', 2000, 169.90, 'Repuesto Canasta Líquida Mañana de Campo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1361, 6110, 'Limpieza de Baño', 'Glade', 50.00, 'Mililitro', 2000, 211.79, 'Aparato Canasta Líquida Campos de Lavanda');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1347, 5993, 'Yerbas', 'ROSAMONTE', 500.00, 'Gramos', 5599, 178.51, 'Yerba Mate Suave Plus');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1348, 5994, 'Yerbas', 'ROSAMONTE', 1.00, 'Kilogramos', 4998, 376.87, 'Yerba Mate Suave Plus');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1329, 5975, 'Yerbas', 'ROMANCE', 1.00, 'Kilogramos', 7499, 295.72, 'Yerba Mate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1340, 5986, 'Yerbas', 'NOBLEZA GAUCHA', 500.00, 'Gramos', 2599, 135.40, 'Yerba Mate Suave');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1328, 5974, 'Yerbas', 'ROMANCE', 500.00, 'Gramos', 7998, 156.38, 'Yerba Mate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1391, 6206, 'Papel Higiénico', 'Esencial', 4.00, 'Rollos', 2600, 70.10, 'Papel Tissue Natural 50 Metros por 10 Centímetro de ancho c/u.');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1392, 6207, 'Papel Higiénico', 'Esencial', 4.00, 'Rollos', 2700, 128.01, 'Papel Tissue Max Textura Micro Gofrada 80 Metros por 10 Centímetro de ancho c/u.');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1362, 6111, 'Limpieza de Baño', 'Glade', 35.00, 'Gramos', 2000, 102.87, 'Repuesto Canasta 2 en 1 Campos de Lavanda + Cloro');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1364, 6113, 'Limpieza de Baño', 'Glade', 24.50, 'Gramos', 1800, 65.17, 'Limpiador Adhesivo de Campos de Lavanda');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1365, 6114, 'Limpieza de Baño', 'Glade', 38.00, 'Mililitro', 1800, 243.80, 'Aparato Discos Activos de Campos de Lavanda');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1366, 6115, 'Limpieza de Baño', 'poett', 32.00, 'Gramos', 2000, 75.03, 'Canasta Full Primavera');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1367, 6116, 'Limpieza de Baño', 'poett', 32.00, 'Gramos', 1800, 65.17, 'Repuesto Primavera');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1368, 6117, 'Limpieza de Baño', 'poett', 25.00, 'Gramos', 1800, 57.78, 'Pastilla Lavanda');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1369, 6118, 'Limpieza de Baño', 'poett', 25.00, 'Gramos', 1800, 57.78, 'Pastilla Primavera');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1370, 6119, 'Limpieza de Baño', 'poett', 55.00, 'Gramos', 1600, 150.92, 'Pack Canasta Lavanda');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1372, 6121, 'Limpieza de Baño', 'poett', 55.00, 'Mililitro', 1600, 110.76, 'Canasta Refresh Frescura Cítrica');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1373, 6122, 'Limpieza de Baño', 'Vim', 35.00, 'Gramos', 2000, 95.25, 'Canasta 3 en 1 Citrus');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1374, 6123, 'Limpieza de Baño', 'Vim', 35.00, 'Gramos', 2000, 86.60, 'Canasta 3 en 1 Pino');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1375, 6124, 'Limpieza de Baño', 'Vim', 55.00, 'Gramos', 1800, 119.11, 'Canasta Poder X 5 Citrus');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1376, 6125, 'Limpieza de Baño', 'Vim', 55.00, 'Gramos', 1800, 108.22, 'Canasta Poder X 5 Pino');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1377, 6126, 'Limpieza de Baño', 'Vim', 30.00, 'Gramos', 1500, 77.37, 'Pastilla Adhesiva Citrus');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1378, 6127, 'Limpieza de Baño', 'Vim', 30.00, 'Gramos', 1500, 77.37, 'Pastilla Adhesiva Oceano');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1379, 6128, 'Limpieza de Baño', 'HARPIC', 50.00, 'Gramos', 1600, 93.51, 'Bloque para Mochila Power Plus');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1380, 6129, 'Limpieza de Baño', 'HARPIC', 27.00, 'Gramos', 1600, 67.64, 'Pastillas Adhesivas Power Plus');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1381, 6130, 'Limpieza de Baño', 'HARPIC', 20.00, 'Gramos', 1600, 67.64, 'Pastilla Fragancia Lavanda');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1382, 6131, 'Limpieza de Baño', 'Lysoform', 50.00, 'Mililitro', 1800, 209.32, 'Repuesto Canasta Líquida Pino');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1383, 6132, 'Limpieza de Baño', 'Lysoform', 50.00, 'Mililitro', 1800, 209.32, 'Repuesto Canasta Líquida Original');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1384, 6133, 'Limpieza de Baño', 'Lysoform', 38.00, 'Mililitro', 1500, 307.87, 'Aparato Discos Activos Completo Lavanda');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1393, 6208, 'Papel Higiénico', 'Esencial', 6.00, 'Rollos', 2600, 196.99, 'Papel Tissue Max Textura Micro Gofrada 80 Metros por 10 Centímetro de ancho c/u.');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1397, 6212, 'Papel Higiénico', 'Esencial', 6.00, 'Rollos', 2800, 98.43, 'Papel Tissue Blanco Extra Suavidad 30 Metros por 10 Centímetro de ancho c/u.');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1398, 6213, 'Papel Higiénico', 'Esencial', 4.00, 'Rollos', 2600, 56.54, 'Papel Tissue Texturado 30 Metros por 10 Centímetro de ancho c/u.');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1399, 6214, 'Papel Higiénico', 'Higienol', 4.00, 'Rollos', 2900, 172.37, 'Papel Max Plus Hoja Simple 100 Metros c/u.');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1385, 6200, 'Papel Higiénico', 'Esencial', 6.00, 'Rollos', 2600, 88.58, 'Papel Texturado 30 Metros por 10 Centímetro de ancho c/u.');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1386, 6201, 'Papel Higiénico', 'Esencial', 4.00, 'Rollos', 2700, 63.94, 'Papel Tissue Blanco Extra Suavidad 30 Metros por 10 Centímetro de ancho c/u.');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1395, 6210, 'Papel Higiénico', 'Esencial', 4.00, 'Rollos', 2800, 101.80, 'Papel Tissue Super Absorbente Deco Doble Hoja 30 Metros por 10 Centímetro de ancho c/u.');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1394, 6209, 'Papel Higiénico', 'Esencial', 4.00, 'Rollos', 2800, 101.80, 'Papel Tissue Super Absorbente Ultra Doble Hoja 30 Metros por 10 Centímetro de ancho c/u.');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1387, 6202, 'Papel Higiénico', 'Esencial', 1.00, 'Rollos', 2600, 34.38, 'Papel Tissue Natural 50 Metros por 10 Centímetro de ancho c/u.');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1388, 6203, 'Papel Higiénico', 'Esencial', 6.00, 'Rollos', 2800, 105.83, 'Papel Tissue Natural 50 Metros por 10 Centímetro de ancho c/u.');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1389, 6204, 'Papel Higiénico', 'Esencial', 6.00, 'Rollos', 2800, 52.84, 'Papel Tissue Natural 30 Metros por 10 Centímetro de ancho c/u.');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1390, 6205, 'Papel Higiénico', 'Esencial', 4.00, 'Rollos', 2800, 50.38, 'Papel Tissue Natural 30 Metros por 10 Centímetro de ancho c/u.');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1407, 6222, 'Papel Higiénico', 'Higienol', 4.00, 'Rollos', 2700, 79.41, 'Papel Rinde Hoja Simple 50 Metros c/u.');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1363, 6112, 'Limpieza de Baño', 'Glade', 27.50, 'Gramos', 1797, 83.66, 'Canasta Brisa de Mar');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1404, 6219, 'Papel Higiénico', 'Higienol', 4.00, 'Rollos', 2900, 76.99, 'Papel Export Hoja Simple 30 Metros c/u.');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1371, 6120, 'Limpieza de Baño', 'poett', 55.00, 'Mililitro', 1599, 130.46, 'Canasta Refresh Frescura Herbal');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1403, 6218, 'Papel Higiénico', 'Higienol', 6.00, 'Rollos', 2600, 216.05, 'Papel Max Hoja Simple 80 Metros c/u.');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1402, 6217, 'Papel Higiénico', 'Higienol', 4.00, 'Rollos', 2600, 96.21, 'Papel Premium 30 Metros c/u.');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1401, 6216, 'Papel Higiénico', 'Higienol', 4.00, 'Rollos', 2600, 105.83, 'Papel Doble Hoja 30 Metros c/u.');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1410, 6225, 'Papel Higiénico', 'Elite', 4.00, 'Rollos', 2600, 106.29, 'Papel Ultra Doble Hoja 30 Metros c/u.');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1408, 6223, 'Papel Higiénico', 'Higienol', 4.00, 'Rollos', 2600, 221.64, 'Papel Dúo Doble Hoja 50 Metros c/u.');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1409, 6224, 'Papel Higiénico', 'Elite', 12.00, 'Rollos', 2800, 201.49, 'Papel Hoja Simple 30 Metros c/u.');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1411, 6226, 'Papel Higiénico', 'Elite', 6.00, 'Rollos', 2600, 199.24, 'Papel Ultra Doble Hoja Máxima Suavidad 30 Metros c/u.');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1412, 6227, 'Papel Higiénico', 'Elite', 4.00, 'Rollos', 2600, 162.29, 'Papel Hoja Simple 80 Metros c/u.');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1413, 6228, 'Papel Higiénico', 'Elite', 4.00, 'Rollos', 2800, 78.27, 'Papel Doble Hoja 20 Metros c/u.');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1414, 6229, 'Papel Higiénico', 'Elite', 4.00, 'Rollos', 2700, 68.21, 'Papel Hoja Simple 30 Metros c/u.');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1418, 6303, 'Desinfectante de Ambientes', 'Lysoform', 360.00, 'Centímetro Cúbico', 2800, 132.05, 'Aerosol Desinfectante Cítrica');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1415, 6300, 'Desinfectante de Ambientes', 'Lysoform', 360.00, 'Centímetro Cúbico', 2600, 132.05, 'Aerosol Desinfectante Aire de Montaña');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1417, 6302, 'Desinfectante de Ambientes', 'Lysoform', 360.00, 'Centímetro Cúbico', 2900, 132.05, 'Aerosol Desinfectante Bebé');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1416, 6301, 'Desinfectante de Ambientes', 'Lysoform', 360.00, 'Centímetro Cúbico', 2800, 132.05, 'Aerosol Desinfectante Original');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1419, 6304, 'Desinfectante de Ambientes', 'Lysoform', 360.00, 'Centímetro Cúbico', 2800, 132.05, 'Aerosol Desinfectante Lavanda');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1420, 6305, 'Desinfectante de Ambientes', 'Lysoform', 360.00, 'Centímetro Cúbico', 2800, 132.05, 'Aerosol Desinfectante Floral');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1421, 6306, 'Desinfectante de Ambientes', 'Lysoform', 285.00, 'Centímetro Cúbico', 2800, 102.92, 'Aerosol Desinfectante Original');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1405, 6220, 'Papel Higiénico', 'Higienol', 6.00, 'Rollos', 2798, 97.33, 'Papel Export Hoja Simple 30 Metros c/u.');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1422, 6307, 'Desinfectante de Ambientes', 'Ayudín', 332.00, 'Mililitro', 2800, 127.57, 'Aerosol Desinfectante Original');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1423, 6308, 'Desinfectante de Ambientes', 'Ayudín', 332.00, 'Mililitro', 2800, 127.57, 'Aerosol Desinfectante Bebé');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1424, 6309, 'Desinfectante de Ambientes', 'Ayudín', 332.00, 'Mililitro', 2800, 131.68, 'Aerosol Desinfectante Frescura Matinal');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1425, 6350, 'Desodorante de Ambiente', 'Glade', 360.00, 'Mililitro', 2800, 87.25, 'Aerosol Paraíso Azul');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1426, 6351, 'Desodorante de Ambiente', 'Glade', 360.00, 'Mililitro', 2800, 87.25, 'Aerosol Antitabaco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1427, 6352, 'Desodorante de Ambiente', 'Glade', 360.00, 'Mililitro', 2800, 87.25, 'Aerosol I Love You');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1428, 6353, 'Desodorante de Ambiente', 'Glade', 360.00, 'Mililitro', 2800, 87.25, 'Aerosol Campos de Lavanda');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1429, 6354, 'Desodorante de Ambiente', 'Glade', 360.00, 'Mililitro', 2800, 87.25, 'Aerosol Carrias de Algodón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1430, 6355, 'Desodorante de Ambiente', 'Glade', 360.00, 'Mililitro', 2800, 87.25, 'Aerosol Placer Floral y Frutos Rojos');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1431, 6356, 'Desodorante de Ambiente', 'Glade', 360.00, 'Mililitro', 2800, 87.25, 'Aerosol Mañana de Campo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1432, 6357, 'Desodorante de Ambiente', 'Glade', 360.00, 'Mililitro', 2800, 87.25, 'Aerosol Potpourri');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1433, 6358, 'Desodorante de Ambiente', 'Glade', 360.00, 'Gramos', 2800, 87.25, 'Aerosol Harmony');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1434, 6359, 'Desodorante de Ambiente', 'Glade', 360.00, 'Mililitro', 2800, 87.25, 'Aerosol Vainilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1435, 6360, 'Desodorante de Ambiente', 'Glade', 360.00, 'Mililitro', 2800, 87.25, 'Aerosol Limón Refrescante');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1437, 6362, 'Desodorante de Ambiente', 'Glade', 360.00, 'Mililitro', 2800, 87.25, 'Aerosol Jazmín');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1439, 6364, 'Desodorante de Ambiente', 'poett', 360.00, 'Mililitro', 2500, 110.78, 'Aerosol Flores de Primavera');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1440, 6365, 'Desodorante de Ambiente', 'poett', 360.00, 'Mililitro', 2500, 110.78, 'Aerosol Bebé');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1441, 6366, 'Desodorante de Ambiente', 'poett', 360.00, 'Mililitro', 2500, 110.78, 'Aerosol Suavidad de Algodón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1442, 6367, 'Desodorante de Ambiente', 'poett', 360.00, 'Mililitro', 2500, 110.78, 'Aerosol Espíritu Jóven');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1443, 6368, 'Desodorante de Ambiente', 'poett', 360.00, 'Mililitro', 2500, 110.78, 'Aerosol Música en Primavera');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1444, 6369, 'Desodorante de Ambiente', 'poett', 360.00, 'Mililitro', 2500, 110.78, 'Aerosol Lov(e)volution');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1445, 6370, 'Desodorante de Ambiente', 'poett', 360.00, 'Mililitro', 2500, 110.78, 'Aerosol Momentos Deja Vu');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1446, 6371, 'Desodorante de Ambiente', 'poett', 360.00, 'Mililitro', 2500, 110.78, 'Aerosol Sólo Para Ti');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1447, 6372, 'Desodorante de Ambiente', 'poett', 360.00, 'Mililitro', 2500, 110.78, 'Aerosol Despertar de Energía');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1449, 6390, 'Desinfectante de Ambientes Líquido', 'FLUIDO MANCHESTER', 350.00, 'Centímetro Cúbico', 3000, 180.11, 'Antiséptico, Desinfectante Solución');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1450, 6391, 'Desinfectante de Ambientes Líquido', 'FLUIDO MANCHESTER', 700.00, 'Centímetro Cúbico', 2500, 388.81, 'Antiséptico, Desinfectante Solución');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1451, 6400, 'Limpieza de Pisos', 'LA GAUCHITA', 1.00, 'Unidad', 2500, 64.84, 'Pala Plásticas ');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1452, 6401, 'Limpieza de Pisos', 'LA GAUCHITA', 1.00, 'Unidad', 2500, 163.41, 'Escoba Bombay');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1453, 6402, 'Limpieza de Pisos', 'LA GAUCHITA', 1.00, 'Unidad', 2500, 239.57, 'Cepillo de Techo Sin Cabo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1454, 6403, 'Limpieza de Pisos', 'LA GAUCHITA', 1.00, 'Unidad', 2300, 233.97, 'Escobilla Match');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1455, 6404, 'Limpieza de Pisos', 'LA GAUCHITA', 1.00, 'Unidad', 2500, 201.49, 'Escoba Veronna');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1456, 6405, 'Limpieza de Pisos', 'LA GAUCHITA', 1.00, 'Unidad', 2400, 125.33, 'Cepillo Planchita');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1457, 6406, 'Limpieza de Pisos', 'LA GAUCHITA', 1.00, 'Unidad', 2300, 117.48, 'Cepillo Sanitario');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1458, 6407, 'Limpieza de Pisos', 'LA GAUCHITA', 1.00, 'Unidad', 2000, 73.81, 'Escobilla Baño');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1459, 6408, 'Limpieza de Pisos', 'LA GAUCHITA', 1.00, 'Unidad', 2300, 100.70, 'Cepillo Mano Ropa');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1460, 6409, 'Limpieza de Pisos', 'LA GAUCHITA', 1.00, 'Unidad', 2200, 204.85, 'Escoba Barremas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1461, 6410, 'Limpieza de Pisos', 'LA GAUCHITA', 1.00, 'Unidad', 2300, 107.41, 'Cepillo Multiuso');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1463, 6412, 'Limpieza de Pisos', 'LA GAUCHITA', 1.00, 'Unidad', 2000, 154.46, 'Escobilla Chica Junior');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1464, 6413, 'Limpieza de Pisos', 'LA GAUCHITA', 1.00, 'Unidad', 2000, 170.13, 'Cepillo Bols Sanitario');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1465, 6414, 'Limpieza de Pisos', 'LA GAUCHITA', 1.00, 'Unidad', 2100, 104.05, 'Cepillo Antómico');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1466, 6415, 'Limpieza de Pisos', 'LA GAUCHITA', 1.00, 'Unidad', 2000, 261.98, 'Escobilla Interior');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1467, 6416, 'Limpieza de Pisos', 'LA GAUCHITA', 1.00, 'Unidad', 2000, 237.32, 'Escobilla Grande Exterior');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1400, 6215, 'Papel Higiénico', 'Higienol', 6.00, 'Rollos', 2698, 175.72, 'Papel Premium Doble Hoja 30 Metros c/u.');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1448, 6373, 'Desodorante de Ambiente', 'poett', 400.00, 'Mililitro', 2588, 167.50, 'Aerosol Natural Blends Frutal');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1468, 6417, 'Limpieza de Pisos', 'Virulana', 1.00, 'Unidad', 1600, 223.90, 'Escobilla Clásico');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1469, 6418, 'Limpieza de Pisos', 'Virulana', 1.00, 'Unidad', 2000, 190.28, 'Escobilla Multiuso');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1470, 6419, 'Limpieza de Pisos', 'Virulana', 1.00, 'Unidad', 2000, 236.22, 'Escobilla Exterior Suave');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1479, 6428, 'Limpieza de Pisos', 'blem', 450.00, 'Mililitro', 1200, 117.48, 'Repuesto 3 en 1 Limpiador Multipisos Floral en Doy Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1474, 6423, 'Limpieza de Pisos', 'blem', 2.00, 'Litro', 1200, 541.97, 'Autobrillo Incolora para Pisos Fríos Brillo Líquido en Botella');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1478, 6427, 'Limpieza de Pisos', 'blem', 450.00, 'Mililitro', 1200, 115.24, 'Repuesto 3 en 1 Limpiador Multipisos Aloe y Pepino en Doy Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1477, 6426, 'Limpieza de Pisos', 'blem', 900.00, 'Mililitro', 1200, 212.68, 'Limpiador 3 en 1 V-LAV para Multipisos Vainilla y Lavanda en Botella');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1472, 6421, 'Limpieza de Pisos', 'blem', 1.00, 'Litro', 2000, 391.88, 'Cera Líquida de Roble Claro para Pisos de Maderas en Botella');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1473, 6422, 'Limpieza de Pisos', 'blem', 1.00, 'Litro', 2000, 391.88, 'Cera Líquida de Roble Oscuro para Pisos de Madera en Botella');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1483, 6432, 'Limpieza de Pisos', 'blem', 900.00, 'Mililitro', 1600, 311.25, 'Autobrillo para Pisos Fríos Brillo Líquido Negro en Botella');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1482, 6431, 'Limpieza de Pisos', 'blem', 900.00, 'Mililitro', 1600, 311.25, 'Autobrillo para Pisos Fríos Brillo Líquido Rojo en Botella');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1471, 6420, 'Limpieza de Pisos', 'blem', 450.00, 'Mililitro', 2500, 190.28, 'Repuesto Autobrillo para Pisos Fríos Brillo Líquido Rojo en Doy Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1475, 6424, 'Limpieza de Pisos', 'blem', 450.00, 'Mililitro', 1600, 190.28, 'Repuesto Autobrillo para Pisos Fríos Brillo Líquido Floral en Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1462, 6411, 'Limpieza de Pisos', 'LA GAUCHITA', 1.00, 'Unidad', 2149, 235.09, 'Cepillo Lava Autos');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1481, 6430, 'Limpieza de Pisos', 'blem', 450.00, 'Mililitro', 1199, 190.28, 'Repuesto Autobrillo Incolora para Pisos Fríos Brillo Líquido en Doy Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1436, 6361, 'Desodorante de Ambiente', 'Glade', 360.00, 'Mililitro', 2798, 87.25, 'Aerosol Floral Perfection');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1438, 6363, 'Desodorante de Ambiente', 'poett', 360.00, 'Mililitro', 2499, 110.78, 'Aerosol Frescura de Lavanda');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1476, 6425, 'Limpieza de Pisos', 'blem', 900.00, 'Mililitro', 1200, 158.92, 'Cera Líquida para Pisos Plastificados con Aceite de Almendras en Botella');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1486, 6435, 'Limpieza de Pisos', 'Suiza', 850.00, 'Centímetro Cúbico', 1000, 313.49, 'Cera Líquida para Pisos Plastificados y Flotantes de Roble Oscuro en Botella');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1485, 6434, 'Limpieza de Pisos', 'Suiza', 850.00, 'Centímetro Cúbico', 1000, 313.49, 'Cera Líquida para Pisos Plastificados y Flotantes de Roble Claro en Botella');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (714, 4809, 'Harinas y Premezclas', 'Pureza', 1.00, 'Kilogramos', 1998, 53.65, 'Harina 0000');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1396, 6211, 'Papel Higiénico', 'Esencial', 4.00, 'Rollos', 2696, 79.96, 'Papel Tissue Doble Hoja 20 Metros por 10 Centímetro de ancho c/u.');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1044, 5458, 'Galletitas', 'Bagley', 500.00, 'Gramos', 1999, 143.52, 'Traviata Original');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (287, 3511, 'Aderezos', 'Hellmann''s', 2.86, 'Kilogramos', 799, 426.75, 'Mayonesa Suave Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (750, 4910, 'Polvo para Postres', 'Ravana', 60.00, 'Gramos', 1498, 29.00, 'Flan Sabor a Dulce Leche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1193, 5747, 'Café y Maltas', 'NESCAFÉ', 250.00, 'Gramos', 799, 403.09, 'Café Molido Golde Intenso en Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (779, 4939, 'Polvo para Postres', 'Exquisita', 40.00, 'Gramos', 1498, 40.21, 'Gelatina Sabor a Frambuesa');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1034, 5448, 'Galletitas', 'Bagley', 200.00, 'Gramos', 1599, 83.89, 'Criollitas Tostadas de Salvados');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (688, 4764, 'Conservas y Legumbres', 'Marolio', 380.00, 'Gramos', 498, 162.29, 'Caballa al Natural en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (223, 3409, 'Condimentos y Especias', 'Alicante', 25.00, 'Gramos', 599, 44.70, 'Provenzal');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (853, 5108, 'Mermeladas', 'Marolio', 454.00, 'Gramos', 799, 100.70, 'Mermelada de Frutilla en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (596, 4606, 'Tomates', 'Molto', 200.00, 'Gramos', 1187, 29.00, 'Puré de Tomate en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (353, 3638, 'Condimentos', 'Dos Anclas', 500.00, 'Gramos', 1198, 36.46, 'Sal Fina en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1245, 5831, 'Té', 'Taragüi', 25.00, 'Unidades', 1999, 96.33, 'Té Hierbas Silvestres Boldo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (79, 3005, 'Aceites', 'Cañuelas', 900.00, 'Centímetro Cúbico', 1590, 145.59, 'Aceite Girasol Oleico');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (5, 1005, 'Pastas', 'Terrabusi', 500.00, 'Gramos', 2783, 51.32, 'Fideo Spaghetti');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (57, 2012, 'Arroz', 'Molto', 1.00, 'Kilogramos', 1294, 118.60, 'Arroz Parboil');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (233, 3419, 'Condimentos y Especias', 'Alicante', 50.00, 'Gramos', 597, 82.76, 'Provenzal');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (407, 3817, 'Caldos', 'Knorr', 6.00, 'Unidades', 798, 46.94, 'Caldo de Carne');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (289, 3513, 'Aderezos', 'Hellmann''s', 475.00, 'Gramos', 1197, 11.89, 'Mayonesa Clásica Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (90, 3016, 'Aceites', 'Natura', 900.00, 'Centímetro Cúbico', 2093, 107.58, 'Aceite Girasol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (719, 4814, 'Harinas y Premezclas', 'Blancaflor', 1.00, 'Kilogramos', 1997, 65.97, 'Harina Leudante con VitaZinc');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1480, 6429, 'Limpieza de Pisos', 'blem', 900.00, 'Mililitro', 1597, 311.25, 'Autobrillo Incolora para Pisos Fríos Brillo Líquido en Botella');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (324, 3609, 'Condimentos', 'Celusal', 230.00, 'Gramos', 1197, 115.54, 'Sal con Especias en Salero');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1113, 5527, 'Galletitas', 'Terrabusi', 160.00, 'Gramos', 1792, 50.38, 'Boca de Dama');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (272, 3458, 'Condimentos y Especias', 'Marolio', 25.00, 'Gramos', 597, 30.92, 'Provenzal');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (370, 3708, 'Salsas', 'Cica', 340.00, 'Gramos', 1197, 35.10, 'Salsa Lista Filetto en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (612, 4621, 'Tomates', 'La Campagnola', 520.00, 'Gramos', 1191, 67.63, 'Salsati Puré en Caja');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1339, 5985, 'Yerbas', 'NOBLEZA GAUCHA', 1.00, 'Kilogramos', 1997, 295.55, 'Yerba Mate Selección');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (84, 3010, 'Aceites', 'Cañuelas', 5.00, 'Litro', 1505, 508.47, 'Aceite Girasol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (175, 3311, 'Aderezos', 'Savora', 60.00, 'Gramos', 1203, 32.37, 'Mostaza Original');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (498, 4112, 'Cereales', 'Nestle', 200.00, 'Gramos', 796, 108.52, 'Nestum Avena de Arroz');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (726, 4821, 'Harinas y Premezclas', 'Favorita', 1.00, 'Kilogramos', 1995, 35.70, 'Harina de Trigo 000');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (762, 4922, 'Polvo para Postres', 'Royal', 25.00, 'Gramos', 1494, 55.43, 'Gelatina Light Sabor a Ananá');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1214, 5800, 'Té', 'La Virginia', 50.00, 'Unidades', 3497, 77.17, 'Té Negro');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1110, 5524, 'Galletitas', 'Terrabusi', 330.00, 'Gramos', 1797, 102.86, 'Express Light');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (969, 5249, 'Dulces', 'Noel', 5.00, 'Kilogramos', 197, 920.18, 'Dulce de Membrillo en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (29, 1029, 'Pastas', 'Cica', 500.00, 'Gramos', 2091, 33.49, 'Fideo Tirabuzón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (161, 3227, 'Vinagres', 'Menoyo', 500.00, 'Centímetro Cúbico', 1197, 44.06, 'Vinagre Blanco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (827, 5027, 'Polvo para Repostería', 'Maizena', 500.00, 'Gramos', 397, 142.16, 'Brownie Sabor a Chocolate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1049, 5463, 'Galletitas', 'Bagley', 75.00, 'Gramos', 1797, 59.50, 'Rex Original');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (248, 3434, 'Condimentos y Especias', 'Dos Anclas', 25.00, 'Gramos', 597, 55.89, 'Pimienta Negra Molida');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (101, 3027, 'Aceites', 'Natura', 500.00, 'Centímetro Cúbico', 1197, 279.44, 'Aceite Oliva Extra Virgen Petaca');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1207, 5761, 'Café y Maltas', 'Cabrales', 110.00, 'Gramos', 1597, 104.34, 'Café Instantánea Clásico en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1332, 5978, 'Yerbas', 'ROMANCE', 1.00, 'Kilogramos', 5797, 306.82, 'Yerba Mate Suave');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (86, 3012, 'Aceites', 'Cañuelas', 187.00, 'Centímetro Cúbico', 1483, 120.48, 'Aceite Aerosol Oliva');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (17, 1017, 'Pastas', 'Lucchetti', 500.00, 'Gramos', 2540, 44.71, 'Fideo Ave Maria');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (91, 3017, 'Aceites', 'Natura', 1.50, 'Litro', 1996, 165.32, 'Aceite Girasol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (13, 1013, 'Pastas', 'Don Vicente', 500.00, 'Gramos', 2294, 98.45, 'Fideo Caserito');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (598, 4608, 'Tomates', 'Molto', 800.00, 'Gramos', 788, 47.30, 'Tomates Peritas en Latas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (666, 4742, 'Conservas y Legumbres', 'Bahía', 400.00, 'Gramos', 585, 125.90, 'Palmitos en Cubos en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (671, 4747, 'Conservas y Legumbres', 'Fabiola', 1.00, 'Kilogramos', 797, 159.53, 'Porotos Negro en Bolsa');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (385, 3723, 'Salsas', 'Knorr', 200.00, 'Gramos', 1184, 36.46, 'Salsa Lista Pizza en Sobre');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (567, 4506, 'Leche Larga Vida', 'Ilolay', 1.00, 'Litro', 1170, 81.65, 'Leche Entera');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (440, 3923, 'Sopas', 'Knorr', 5.00, 'Porciones', 794, 72.70, 'Sopa Familiar Caserísimo Verduras');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1406, 6221, 'Papel Higiénico', 'Higienol', 4.00, 'Rollos', 2594, 158.32, 'Papel Max Hoja Simple 80 Metros c/u.');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (922, 5202, 'Dulces', 'La Serenisima', 400.00, 'Gramos', 797, 110.87, 'Dulce de Leche Clásico');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (60, 2015, 'Arroz', 'Fabiola', 1.00, 'Kilogramos', 1582, 93.38, 'Arroz Largo Fino 00000');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1135, 5609, 'Papas Fritas', 'Lay''s', 51.00, 'Gramos', 1197, 73.05, 'Papa Frita Clásicas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (36, 1036, 'Pastas', 'Knorr', 500.00, 'Gramos', 1785, 37.93, 'Fideo Spaghetti Integral');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (232, 3418, 'Condimentos y Especias', 'Alicante', 25.00, 'Gramos', 594, 62.61, 'Perejil Deshidratado');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1278, 5924, 'Yerbas', 'Taragüi', 1.00, 'Kilogramos', 7997, 291.10, 'Yerba Mate');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (449, 3932, 'Sopas', 'Knorr', 76.00, 'Gramos', 788, 72.70, 'Sopa Crema Queso');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (130, 3055, 'Aceites', 'Cocinero', 1.50, 'Litro', 1197, 184.68, 'Aceite Mezcla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (545, 4403, 'Leche en Polvo', 'Nestle', 400.00, 'Gramos', 794, 223.87, 'Nido 3D FortiGrow en Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (205, 3341, 'Aderezos', 'Fanacoa', 250.00, 'Gramos', 797, 42.69, 'Mostaza Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (192, 3328, 'Aderezos', 'Hellmann''s', 125.00, 'Gramos', 794, 52.72, 'Salsa Golf Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (61, 2016, 'Arroz', 'Lucchetti', 500.00, 'Gramos', 1982, 50.29, 'Arroz Parboil');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (393, 3803, 'Caldos', 'Molto', 6.00, 'Unidades', 794, 33.49, 'Caldo de Gallina');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (907, 5162, 'Mermeladas', 'Noel', 390.00, 'Gramos', 797, 121.83, 'Mermelada Light de Frutilla en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1487, 6436, 'Limpieza de Pisos', 'Suiza', 450.00, 'Centímetro Cúbico', 997, 194.77, 'Cera al Solvente para Madera de Roble Oscuro en Botella');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (979, 5259, 'Dulces', 'esnaola', 500.00, 'Gramos', 497, 115.24, 'Dulce de Membrillo en Estuche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1020, 5434, 'Galletitas', 'Tía Maruca', 320.00, 'Gramos', 1494, 33.87, 'Marineras Sin Sal');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1315, 5961, 'Yerbas', 'LA TRANQUERA', 1.00, 'Kilogramos', 3497, 271.05, 'Yerba Mate Tradicional');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (7, 1007, 'Pastas', 'Matarazzo', 250.00, 'Gramos', 1639, 86.61, 'Lasagna');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (69, 2024, 'Arroz', 'Gallo', 500.00, 'Gramos', 1288, 102.92, 'Arroz Doble');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (120, 3045, 'Aceites', 'Marolio', 1.50, 'Litro', 996, 235.09, 'Aceite Girasol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (56, 2011, 'Arroz', 'Molto', 500.00, 'Gramos', 1991, 49.60, 'Arroz Largo Fino');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1360, 6109, 'Limpieza de Baño', 'Glade', 50.00, 'Mililitro', 1997, 211.79, 'Aparato Canasta Líquida I Love You');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1186, 5740, 'Café y Maltas', 'NESCAFÉ', 153.00, 'Gramos', 797, 593.48, 'Café Dolce Gusto Latte Macchiato');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1067, 5481, 'Galletitas', 'Arcor', 100.00, 'Gramos', 1997, 64.92, 'Saladix Snacks Sabor Pizza en Estuche');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (51, 2006, 'Arroz', 'Molto', 1.00, 'Kilogramos', 2594, 113.01, 'Arroz Doble Carolina');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (185, 3321, 'Aderezos', 'Dos Anclas', 380.00, 'Centímetro Cúbico', 795, 121.97, 'Salsa Chimichurri Pomo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (626, 4702, 'Conservas y Legumbres', 'Marolio', 400.00, 'Gramos', 797, 151.09, 'Champignones Enteros en Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (778, 4938, 'Polvo para Postres', 'Exquisita', 40.00, 'Gramos', 1491, 40.21, 'Gelatina Sabor a Cereza');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (884, 5139, 'Mermeladas', 'BC La Campagnola', 390.00, 'Gramos', 797, 207.21, 'Mermelada de Frutos Rojos en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (367, 3705, 'Salsas', 'Arcor', 340.00, 'Gramos', 1197, 58.14, 'Salsa Lista Pizza en Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (573, 4512, 'Leche Larga Vida', 'La Serenisima', 1.00, 'Litro', 797, 76.11, 'Leche Clásica más Liviana');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1023, 5437, 'Galletitas', 'Tía Maruca', 250.00, 'Gramos', 1494, 45.39, 'Magdalenas Clásicas');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (171, 3307, 'Aderezos', 'Marolio', 280.00, 'Gramos', 1194, 57.02, 'Salsa Criolla Pomo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (163, 3229, 'Vinagres', 'Menoyo', 500.00, 'Centímetro Cúbico', 1197, 58.27, 'Vinagre Vino');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1201, 5755, 'Café y Maltas', 'NESCAFÉ', 150.00, 'Gramos', 797, 331.42, 'Café Clásico en Doy Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1075, 5489, 'Galletitas', 'Arcor', 145.00, 'Gramos', 1994, 51.36, 'Maná Livianas Sabor a Vainilla');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (328, 3613, 'Condimentos', 'Celusal', 250.00, 'Gramos', 1197, 77.23, 'Sal Fina en Salero');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (127, 3052, 'Aceites', 'Cocinero', 900.00, 'Centímetro Cúbico', 1188, 139.89, 'Aceite Girasol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (189, 3325, 'Aderezos', 'Dos Anclas', 360.00, 'Centímetro Cúbico', 797, 152.21, 'Salsa Caesar Light Pomo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (548, 4406, 'Leche en Polvo', 'Nestle', 930.00, 'Gramos', 590, 447.89, 'Nido 3D FortiGrow en Pack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (735, 4830, 'Harinas y Premezclas', 'Chango', 500.00, 'Gramos', 797, 116.37, 'Almidón de Maíz');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (528, 4302, 'Endulzantes', 'Chango', 1.00, 'Kilogramos', 794, 147.72, 'Azúcar Orgánico AP');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (144, 3209, 'Vinagres', 'Molto', 1.00, 'Litro', 1197, 55.89, 'Vinagre Alcohol');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (280, 3504, 'Aderezos', 'Hellmann''s', 950.00, 'Gramos', 1197, 182.27, 'Mayonesa Clásica Doypack');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1241, 5827, 'Té', 'Taragüi', 10.00, 'Unidades', 1997, 67.87, 'Té Hierbas Silvestres Tilo');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (901, 5156, 'Mermeladas', 'Molto', 390.00, 'Gramos', 797, 119.73, 'Mermelada Light de Frutilla en Frasco');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (1484, 6433, 'Limpieza de Pisos', 'Suiza', 850.00, 'Centímetro Cúbico', 997, 313.49, 'Cera Líquida para Pisos Plastificados y Flotantes de Brillo Natural en Botella');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (3, 1002, 'Pastas', 'Knorr', 500.00, 'Gramos', 3575, 39.92, 'Fideo Tirabuzón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (64, 2019, 'Arroz', 'Lucchetti', 1.00, 'Kilogramos', 1694, 91.72, 'Arroz Parboil');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (99, 3025, 'Aceites', 'Natura', 1.00, 'Litro', 595, 609.71, 'Aceite Oliva Extra Virgen Clásico Lata');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (8, 1008, 'Pastas', 'Favorita', 500.00, 'Gramos', 2696, 33.49, 'Fideo Tirabuzón');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (9, 1009, 'Pastas', 'Favorita', 500.00, 'Gramos', 1629, 33.49, 'Fideo Codo Rayado');
INSERT INTO public.producto ("idProducto", codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (10, 1010, 'Pastas', 'Favorita', 500.00, 'Gramos', 2531, 33.49, 'Fideo Spaghetti');


--
-- TOC entry 3101 (class 0 OID 58683)
-- Dependencies: 213
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.usuario ("idUsuario", mail, nick, contrasena, rol, "idCliente") VALUES (1, 'crisanz89@gmail.com', 'cristian89', '\xc30d04070302d6ad8e979792727b7ed23b01db55971a13a30648faae893beab2f5e0a23440dee609c513ff0ec4636a32ec2eefb82013455127d19036023cae44a7df731004d52231353dfae1', 'admin', 1);
INSERT INTO public.usuario ("idUsuario", mail, nick, contrasena, rol, "idCliente") VALUES (2, 'juan2021@email.com', 'juan21', '\xc30d0407030276b7db0723fc063f62d239011f8e1409648433a3a42b06c15cf5ca8f43cf3e1b6872ffca047b06998789cd636737e4bcfccb0c07b50218f76af34a8e6eeac8b5b136d1e8', 'cliente', 2);
INSERT INTO public.usuario ("idUsuario", mail, nick, contrasena, rol, "idCliente") VALUES (3, 'maria76@mail.com', 'maria76', '\xc30d040703020761ff0003a7491079d239013743770ee121d92a73aee13fa5478b136f71da572bb8ad7c5015973bad1bd4a5ba31b4a35efa9113b254444f68f02ca9fcd85510840c9a92', 'cliente', 3);
INSERT INTO public.usuario ("idUsuario", mail, nick, contrasena, rol, "idCliente") VALUES (4, 'carlos82@mail.com', 'carlos82', '\xc30d040703025bb8a773a4e0fd3176d23901deeef2c02dcabbc7a1bffd6411fd2424818b996cf28d7f1bb17ffaa27a9ec8a9e2daad2fed07129ef263bc35a3bbee2fbe73875298a17a65', 'cliente', 4);
INSERT INTO public.usuario ("idUsuario", mail, nick, contrasena, rol, "idCliente") VALUES (5, 'julian74@mail.com', 'julian74', '\xc30d040703024ccf315f6abb277973d239015921a09d0ac986b35cf89f60c48b7f4e2d385563257aabd248b3392abccd47fc39a2c3baed7614c7d3053ae2d8b0558c9f92552886ac417f', 'cliente', 5);
INSERT INTO public.usuario ("idUsuario", mail, nick, contrasena, rol, "idCliente") VALUES (6, 'antonieta83@mail.com', 'antonieta83', '\xc30d0407030217ff0adce668e80272d2390146d23b08681f5f054f79a5a5c1f5b809c8e2f0ed7d9997576a12ff3b6783320843dcd2483be76a4c47dbfa8f1fecfb274f35f31f708d2bfa', 'cliente', 6);
INSERT INTO public.usuario ("idUsuario", mail, nick, contrasena, rol, "idCliente") VALUES (7, 'fernando86@mail.com', 'fernando86', '\xc30d040703025aa11d471587eb007cd239012744cbc49554532fe05c27a7fed2f036b1380c04c009b317c2e7bcba796b476f1e65ed9dc3e04731bc28f5a83e0951d4a622603b7c017f12', 'cliente', 7);
INSERT INTO public.usuario ("idUsuario", mail, nick, contrasena, rol, "idCliente") VALUES (8, 'emilia77@mail.com', 'emilia77', '\xc30d04070302b484c88c1f0d924770d23901923d3da41eed64a77f49f32229e8b559256a599bb157c70027a2d406e982cf9fd3a50282fa65c21641502600fdcbee1b997931b1de9311a5', 'cliente', 8);
INSERT INTO public.usuario ("idUsuario", mail, nick, contrasena, rol, "idCliente") VALUES (9, 'antonio88@mail.com', 'antonio88', '\xc30d0407030211b4469c7832a95279d239015cfb517b675d280e57d069aeb0bee0b5a9db656846d6d20b72e65eff5ca8ea03999148f289db5cdc4f06d64fd176cbcee3a0ae06bde9dabd', 'cliente', 9);
INSERT INTO public.usuario ("idUsuario", mail, nick, contrasena, rol, "idCliente") VALUES (10, 'ruben86@mail.com', 'ruben86', '\xc30d04070302cee67c84fb22506d7ed23901674df487685839a2723d9c896d50377ece682d7401dda7ac0de39a786e09b11afcb056cfa6dcd8ca4fa1dd49d5797ca28c988eaf8051e21b', 'cliente', 10);
INSERT INTO public.usuario ("idUsuario", mail, nick, contrasena, rol, "idCliente") VALUES (11, 'anamaria79@mail.com', 'anamaria79', '\xc30d0407030236c362a6f7cd1b2f66d2390192799c27a9633701d49048d5023c22c8245cf920045d6bbd7203ee302f059043ab602ca8cd3c148a475a17e9807eaaeefa436196baf53cca', 'cliente', 11);
INSERT INTO public.usuario ("idUsuario", mail, nick, contrasena, rol, "idCliente") VALUES (12, 'daniela90@mail.com', 'daniela90', '\xc30d04070302a48af88d3b4090d97bd239017821a664b3296989c7648378ee4a07bfb12e9846e5cbb1fab1723b3cdbc3bdf3c7f4b64395aff87d7296239f22b87c091d5cec975bc981f7', 'cliente', 12);


--
-- TOC entry 3114 (class 0 OID 0)
-- Dependencies: 204
-- Name: cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cliente_id_seq', 12, true);


--
-- TOC entry 3115 (class 0 OID 0)
-- Dependencies: 206
-- Name: clientepreferencial_idClientePreferencial_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."clientepreferencial_idClientePreferencial_seq"', 12, true);


--
-- TOC entry 3116 (class 0 OID 0)
-- Dependencies: 208
-- Name: detallepedido_idDetallePedido_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."detallepedido_idDetallePedido_seq"', 173, true);


--
-- TOC entry 3117 (class 0 OID 0)
-- Dependencies: 209
-- Name: pedido_idpedido_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pedido_idpedido_seq', 35, true);


--
-- TOC entry 3118 (class 0 OID 0)
-- Dependencies: 212
-- Name: producto_idProducto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."producto_idProducto_seq"', 1487, true);


--
-- TOC entry 3119 (class 0 OID 0)
-- Dependencies: 214
-- Name: usuario_idUsuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."usuario_idUsuario_seq"', 12, true);


--
-- TOC entry 2949 (class 2606 OID 58694)
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY ("idCliente");


--
-- TOC entry 2951 (class 2606 OID 58696)
-- Name: clientepreferencial clientepreferencial_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientepreferencial
    ADD CONSTRAINT clientepreferencial_pkey PRIMARY KEY ("idClientePreferencial");


--
-- TOC entry 2953 (class 2606 OID 58698)
-- Name: detallepedido detallepedido_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detallepedido
    ADD CONSTRAINT detallepedido_pkey PRIMARY KEY ("idDetallePedido");


--
-- TOC entry 2955 (class 2606 OID 58700)
-- Name: pedido pedidos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedidos_pkey PRIMARY KEY ("idPedido");


--
-- TOC entry 2957 (class 2606 OID 58702)
-- Name: producto producto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY ("idProducto");


--
-- TOC entry 2959 (class 2606 OID 58704)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY ("idUsuario");


--
-- TOC entry 2963 (class 2620 OID 58762)
-- Name: pedido updatedescuentocliente; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER updatedescuentocliente AFTER UPDATE ON public.pedido FOR EACH ROW EXECUTE FUNCTION public.actualizardescuentocliente();


--
-- TOC entry 2964 (class 2620 OID 58705)
-- Name: pedido updateproductospedido; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER updateproductospedido AFTER UPDATE ON public.pedido FOR EACH ROW EXECUTE FUNCTION public.sumarstockenpedidonulado();


--
-- TOC entry 2962 (class 2606 OID 58706)
-- Name: usuario cliente_pkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT cliente_pkey FOREIGN KEY ("idCliente") REFERENCES public.cliente("idCliente");


--
-- TOC entry 2960 (class 2606 OID 58711)
-- Name: clientepreferencial cliente_pkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientepreferencial
    ADD CONSTRAINT cliente_pkey FOREIGN KEY ("idCliente") REFERENCES public.cliente("idCliente");


--
-- TOC entry 2961 (class 2606 OID 58716)
-- Name: detallepedido producto_pkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detallepedido
    ADD CONSTRAINT producto_pkey FOREIGN KEY (idproducto) REFERENCES public.producto("idProducto");


-- Completed on 2021-03-04 11:40:16 -03

--
-- PostgreSQL database dump complete
--

