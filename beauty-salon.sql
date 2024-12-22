--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

-- Started on 2024-12-22 16:59:30

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 226 (class 1259 OID 25500)
-- Name: admins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admins (
    id integer NOT NULL,
    full_name character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(100) NOT NULL,
    role character varying(50) NOT NULL
);


ALTER TABLE public.admins OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 25499)
-- Name: admins_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admins_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admins_id_seq OWNER TO postgres;

--
-- TOC entry 4901 (class 0 OID 0)
-- Dependencies: 225
-- Name: admins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admins_id_seq OWNED BY public.admins.id;


--
-- TOC entry 224 (class 1259 OID 25478)
-- Name: appointments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.appointments (
    id integer NOT NULL,
    client_id integer NOT NULL,
    service_id integer NOT NULL,
    master_id integer NOT NULL,
    appointment_time timestamp without time zone NOT NULL
);


ALTER TABLE public.appointments OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 25477)
-- Name: appointments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.appointments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.appointments_id_seq OWNER TO postgres;

--
-- TOC entry 4902 (class 0 OID 0)
-- Dependencies: 223
-- Name: appointments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.appointments_id_seq OWNED BY public.appointments.id;


--
-- TOC entry 218 (class 1259 OID 25451)
-- Name: clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clients (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    phone character varying(15) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying NOT NULL
);


ALTER TABLE public.clients OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 25450)
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clients_id_seq OWNER TO postgres;

--
-- TOC entry 4903 (class 0 OID 0)
-- Dependencies: 217
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clients_id_seq OWNED BY public.clients.id;


--
-- TOC entry 222 (class 1259 OID 25471)
-- Name: masters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.masters (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    specialization character varying(100) NOT NULL
);


ALTER TABLE public.masters OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 25470)
-- Name: masters_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.masters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.masters_id_seq OWNER TO postgres;

--
-- TOC entry 4904 (class 0 OID 0)
-- Dependencies: 221
-- Name: masters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.masters_id_seq OWNED BY public.masters.id;


--
-- TOC entry 220 (class 1259 OID 25462)
-- Name: services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.services (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    price numeric(10,2) NOT NULL,
    duration_minutes integer NOT NULL,
    CONSTRAINT services_duration_minutes_check CHECK ((duration_minutes > 0)),
    CONSTRAINT services_price_check CHECK ((price > (0)::numeric))
);


ALTER TABLE public.services OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 25461)
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.services_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.services_id_seq OWNER TO postgres;

--
-- TOC entry 4905 (class 0 OID 0)
-- Dependencies: 219
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.services_id_seq OWNED BY public.services.id;


--
-- TOC entry 4719 (class 2604 OID 25503)
-- Name: admins id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins ALTER COLUMN id SET DEFAULT nextval('public.admins_id_seq'::regclass);


--
-- TOC entry 4718 (class 2604 OID 25481)
-- Name: appointments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments ALTER COLUMN id SET DEFAULT nextval('public.appointments_id_seq'::regclass);


--
-- TOC entry 4715 (class 2604 OID 25454)
-- Name: clients id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients ALTER COLUMN id SET DEFAULT nextval('public.clients_id_seq'::regclass);


--
-- TOC entry 4717 (class 2604 OID 25474)
-- Name: masters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.masters ALTER COLUMN id SET DEFAULT nextval('public.masters_id_seq'::regclass);


--
-- TOC entry 4716 (class 2604 OID 25465)
-- Name: services id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services ALTER COLUMN id SET DEFAULT nextval('public.services_id_seq'::regclass);


--
-- TOC entry 4895 (class 0 OID 25500)
-- Dependencies: 226
-- Data for Name: admins; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.admins VALUES (1, 'Алексей Смирнов', 'admin1@example.com', 'password123', 'admin');
INSERT INTO public.admins VALUES (2, 'Мария Иванова', 'admin2@example.com', 'adminpassword', 'admin');
INSERT INTO public.admins VALUES (3, 'Елена Орлова', 'admin3@example.com', 'securepass', 'admin');
INSERT INTO public.admins VALUES (4, 'Олег Павлов', 'admin4@example.com', 'mypassword', 'admin');
INSERT INTO public.admins VALUES (5, 'Николай Соколов', 'admin5@example.com', 'admin123', 'admin');
INSERT INTO public.admins VALUES (6, 'Анна Белова', 'admin6@example.com', 'password', 'admin');


--
-- TOC entry 4893 (class 0 OID 25478)
-- Dependencies: 224
-- Data for Name: appointments; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.appointments VALUES (1, 1, 1, 1, '2024-12-21 10:00:00');
INSERT INTO public.appointments VALUES (2, 2, 2, 3, '2024-12-21 12:00:00');
INSERT INTO public.appointments VALUES (3, 3, 3, 4, '2024-12-21 15:00:00');
INSERT INTO public.appointments VALUES (4, 4, 5, 5, '2024-12-22 10:00:00');
INSERT INTO public.appointments VALUES (5, 5, 4, 2, '2024-12-22 12:00:00');
INSERT INTO public.appointments VALUES (6, 6, 6, 6, '2024-12-22 14:00:00');
INSERT INTO public.appointments VALUES (7, 1, 2, 2, '2025-01-28 11:00:00');
INSERT INTO public.appointments VALUES (8, 1, 6, 1, '2024-12-30 10:00:00');
INSERT INTO public.appointments VALUES (9, 1, 4, 5, '2024-12-25 16:00:00');


--
-- TOC entry 4887 (class 0 OID 25451)
-- Dependencies: 218
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.clients VALUES (1, 'Анна Иванова', '+79161112233', 'anna.ivanova@example.com', 'password1');
INSERT INTO public.clients VALUES (2, 'Иван Петров', '+79163334455', 'ivan.petrov@example.com', 'password2');
INSERT INTO public.clients VALUES (3, 'Екатерина Сидорова', '+79265557788', 'ekaterina.sidorova@example.com', 'password3');
INSERT INTO public.clients VALUES (4, 'Сергей Кузнецов', '+79336668899', 'sergey.kuznetsov@example.com', 'password4');
INSERT INTO public.clients VALUES (5, 'Ольга Смирнова', '+79447770011', 'olga.smirnova@example.com', 'password5');
INSERT INTO public.clients VALUES (6, 'Дмитрий Орлов', '+79558881122', 'dmitry.orlov@example.com', 'password6');


--
-- TOC entry 4891 (class 0 OID 25471)
-- Dependencies: 222
-- Data for Name: masters; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.masters VALUES (1, 'Мария Волкова', 'Парикмахер');
INSERT INTO public.masters VALUES (2, 'Олег Соколов', 'Парикмахер');
INSERT INTO public.masters VALUES (3, 'Анна Романова', 'Мастер маникюра');
INSERT INTO public.masters VALUES (4, 'Татьяна Климова', 'Мастер педикюра');
INSERT INTO public.masters VALUES (5, 'Игорь Михайлов', 'Колорист');
INSERT INTO public.masters VALUES (6, 'Александра Белова', 'Массажист');


--
-- TOC entry 4889 (class 0 OID 25462)
-- Dependencies: 220
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.services VALUES (1, 'Стрижка', 1500.00, 60);
INSERT INTO public.services VALUES (2, 'Маникюр', 1200.00, 90);
INSERT INTO public.services VALUES (3, 'Педикюр', 1800.00, 120);
INSERT INTO public.services VALUES (4, 'Укладка волос', 2000.00, 75);
INSERT INTO public.services VALUES (5, 'Окрашивание волос', 4500.00, 180);
INSERT INTO public.services VALUES (6, 'Массаж головы', 1000.00, 30);


--
-- TOC entry 4906 (class 0 OID 0)
-- Dependencies: 225
-- Name: admins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admins_id_seq', 6, true);


--
-- TOC entry 4907 (class 0 OID 0)
-- Dependencies: 223
-- Name: appointments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.appointments_id_seq', 9, true);


--
-- TOC entry 4908 (class 0 OID 0)
-- Dependencies: 217
-- Name: clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clients_id_seq', 6, true);


--
-- TOC entry 4909 (class 0 OID 0)
-- Dependencies: 221
-- Name: masters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.masters_id_seq', 6, true);


--
-- TOC entry 4910 (class 0 OID 0)
-- Dependencies: 219
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.services_id_seq', 6, true);


--
-- TOC entry 4735 (class 2606 OID 25507)
-- Name: admins admins_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_email_key UNIQUE (email);


--
-- TOC entry 4737 (class 2606 OID 25505)
-- Name: admins admins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);


--
-- TOC entry 4733 (class 2606 OID 25483)
-- Name: appointments appointments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (id);


--
-- TOC entry 4723 (class 2606 OID 25460)
-- Name: clients clients_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_email_key UNIQUE (email);


--
-- TOC entry 4725 (class 2606 OID 25458)
-- Name: clients clients_phone_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_phone_key UNIQUE (phone);


--
-- TOC entry 4727 (class 2606 OID 25456)
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- TOC entry 4731 (class 2606 OID 25476)
-- Name: masters masters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.masters
    ADD CONSTRAINT masters_pkey PRIMARY KEY (id);


--
-- TOC entry 4729 (class 2606 OID 25469)
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- TOC entry 4738 (class 2606 OID 25484)
-- Name: appointments appointments_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.clients(id) ON DELETE CASCADE;


--
-- TOC entry 4739 (class 2606 OID 25494)
-- Name: appointments appointments_master_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_master_id_fkey FOREIGN KEY (master_id) REFERENCES public.masters(id) ON DELETE CASCADE;


--
-- TOC entry 4740 (class 2606 OID 25489)
-- Name: appointments appointments_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(id) ON DELETE CASCADE;


-- Completed on 2024-12-22 16:59:30

--
-- PostgreSQL database dump complete
--

