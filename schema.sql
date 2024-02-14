--
-- PostgreSQL database dump
--

-- Dumped from database version 13.13 (Debian 13.13-1.pgdg120+1)
-- Dumped by pg_dump version 14.9 (Homebrew)

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

-- DROP DATABASE IF EXISTS postgres;
-- --
-- -- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
-- --
--
-- CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO postgres;

-- connect postgres

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
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: authtoken_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authtoken_token (
    key character varying(40) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.authtoken_token OWNER TO postgres;

--
-- Name: core_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.core_categories (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.core_categories OWNER TO postgres;

--
-- Name: core_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.core_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_categories_id_seq OWNER TO postgres;

--
-- Name: core_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.core_categories_id_seq OWNED BY public.core_categories.id;


--
-- Name: core_orderitem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.core_orderitem (
    id bigint NOT NULL,
    quantity integer NOT NULL,
    total_price numeric(10,2) NOT NULL,
    discount numeric(10,2),
    order_id bigint NOT NULL,
    product_id bigint NOT NULL,
    item_price numeric(10,2) NOT NULL
);


ALTER TABLE public.core_orderitem OWNER TO postgres;

--
-- Name: core_orderitem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.core_orderitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_orderitem_id_seq OWNER TO postgres;

--
-- Name: core_orderitem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.core_orderitem_id_seq OWNED BY public.core_orderitem.id;


--
-- Name: core_orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.core_orders (
    id bigint NOT NULL,
    order_status character varying(20) NOT NULL,
    payment_mode character varying(255) NOT NULL,
    tracking_number character varying(150),
    is_paid boolean NOT NULL,
    order_date date NOT NULL,
    updated_date timestamp with time zone NOT NULL,
    shipped_date timestamp with time zone,
    user_id bigint NOT NULL,
    order_total numeric(10,2)
);


ALTER TABLE public.core_orders OWNER TO postgres;

--
-- Name: core_orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.core_orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_orders_id_seq OWNER TO postgres;

--
-- Name: core_orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.core_orders_id_seq OWNED BY public.core_orders.id;


--
-- Name: core_products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.core_products (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description text NOT NULL,
    price numeric(10,2) NOT NULL,
    weight character varying(50) NOT NULL,
    units character varying(50) NOT NULL,
    featured boolean NOT NULL,
    image character varying(100),
    user_id bigint NOT NULL,
    discount numeric(10,2)
);


ALTER TABLE public.core_products OWNER TO postgres;

--
-- Name: core_products_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.core_products_category (
    id bigint NOT NULL,
    products_id bigint NOT NULL,
    categories_id bigint NOT NULL
);


ALTER TABLE public.core_products_category OWNER TO postgres;

--
-- Name: core_products_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.core_products_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_products_category_id_seq OWNER TO postgres;

--
-- Name: core_products_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.core_products_category_id_seq OWNED BY public.core_products_category.id;


--
-- Name: core_products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.core_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_products_id_seq OWNER TO postgres;

--
-- Name: core_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.core_products_id_seq OWNED BY public.core_products.id;


--
-- Name: core_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.core_user (
    id bigint NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    email character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    is_active boolean NOT NULL,
    is_staff boolean NOT NULL,
    address character varying(255) NOT NULL,
    city character varying(50) NOT NULL,
    id_number integer NOT NULL,
    id_type character varying(20) NOT NULL,
    last_name character varying(255) NOT NULL,
    phone character varying(20) NOT NULL,
    state character varying(50) NOT NULL,
    zip_code integer NOT NULL
);


ALTER TABLE public.core_user OWNER TO postgres;

--
-- Name: core_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.core_user_groups (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.core_user_groups OWNER TO postgres;

--
-- Name: core_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.core_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_user_groups_id_seq OWNER TO postgres;

--
-- Name: core_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.core_user_groups_id_seq OWNED BY public.core_user_groups.id;


--
-- Name: core_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.core_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_user_id_seq OWNER TO postgres;

--
-- Name: core_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.core_user_id_seq OWNED BY public.core_user.id;


--
-- Name: core_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.core_user_user_permissions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.core_user_user_permissions OWNER TO postgres;

--
-- Name: core_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.core_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: core_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.core_user_user_permissions_id_seq OWNED BY public.core_user_user_permissions.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id bigint NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: core_categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_categories ALTER COLUMN id SET DEFAULT nextval('public.core_categories_id_seq'::regclass);


--
-- Name: core_orderitem id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_orderitem ALTER COLUMN id SET DEFAULT nextval('public.core_orderitem_id_seq'::regclass);


--
-- Name: core_orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_orders ALTER COLUMN id SET DEFAULT nextval('public.core_orders_id_seq'::regclass);


--
-- Name: core_products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_products ALTER COLUMN id SET DEFAULT nextval('public.core_products_id_seq'::regclass);


--
-- Name: core_products_category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_products_category ALTER COLUMN id SET DEFAULT nextval('public.core_products_category_id_seq'::regclass);


--
-- Name: core_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_user ALTER COLUMN id SET DEFAULT nextval('public.core_user_id_seq'::regclass);


--
-- Name: core_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_user_groups ALTER COLUMN id SET DEFAULT nextval('public.core_user_groups_id_seq'::regclass);


--
-- Name: core_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.core_user_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (13, 'Can add content type', 4, 'add_contenttype');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (14, 'Can change content type', 4, 'change_contenttype');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (15, 'Can delete content type', 4, 'delete_contenttype');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (16, 'Can view content type', 4, 'view_contenttype');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (17, 'Can add session', 5, 'add_session');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (18, 'Can change session', 5, 'change_session');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (19, 'Can delete session', 5, 'delete_session');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (20, 'Can view session', 5, 'view_session');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (21, 'Can add Token', 6, 'add_token');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (22, 'Can change Token', 6, 'change_token');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (23, 'Can delete Token', 6, 'delete_token');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (24, 'Can view Token', 6, 'view_token');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (25, 'Can add token', 7, 'add_tokenproxy');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (26, 'Can change token', 7, 'change_tokenproxy');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (27, 'Can delete token', 7, 'delete_tokenproxy');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (28, 'Can view token', 7, 'view_tokenproxy');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (29, 'Can add user', 8, 'add_user');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (30, 'Can change user', 8, 'change_user');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (31, 'Can delete user', 8, 'delete_user');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (32, 'Can view user', 8, 'view_user');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (33, 'Can add categories', 9, 'add_categories');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (34, 'Can change categories', 9, 'change_categories');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (35, 'Can delete categories', 9, 'delete_categories');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (36, 'Can view categories', 9, 'view_categories');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (37, 'Can add products', 10, 'add_products');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (38, 'Can change products', 10, 'change_products');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (39, 'Can delete products', 10, 'delete_products');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (40, 'Can view products', 10, 'view_products');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (41, 'Can add orders', 11, 'add_orders');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (42, 'Can change orders', 11, 'change_orders');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (43, 'Can delete orders', 11, 'delete_orders');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (44, 'Can view orders', 11, 'view_orders');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (45, 'Can add order item', 12, 'add_orderitem');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (46, 'Can change order item', 12, 'change_orderitem');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (47, 'Can delete order item', 12, 'delete_orderitem');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (48, 'Can view order item', 12, 'view_orderitem');


--
-- Data for Name: authtoken_token; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: core_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: core_orderitem; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: core_orders; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: core_products; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: core_products_category; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: core_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.core_user (id, password, last_login, is_superuser, email, name, is_active, is_staff, address, city, id_number, id_type, last_name, phone, state, zip_code) VALUES (1, 'pbkdf2_sha256$320000$GjbtOj3smlJGsoOB6b9m2k$XiHM9H9V7qUsyP3E7KqAU4PxItOXlPWDXlGwnp0PGR4=', NULL, true, 'admin@local.com', '', true, true, '', '', 1000, '', '', '', '', 1000);


--
-- Data for Name: core_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: core_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.django_content_type (id, app_label, model) VALUES (1, 'admin', 'logentry');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (2, 'auth', 'permission');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (3, 'auth', 'group');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (4, 'contenttypes', 'contenttype');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (5, 'sessions', 'session');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (6, 'authtoken', 'token');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (7, 'authtoken', 'tokenproxy');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (8, 'core', 'user');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (9, 'core', 'categories');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (10, 'core', 'products');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (11, 'core', 'orders');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (12, 'core', 'orderitem');


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.django_migrations (id, app, name, applied) VALUES (1, 'contenttypes', '0001_initial', '2024-01-08 21:04:11.1978+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (2, 'contenttypes', '0002_remove_content_type_name', '2024-01-08 21:04:11.206548+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (3, 'auth', '0001_initial', '2024-01-08 21:04:11.232182+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (4, 'auth', '0002_alter_permission_name_max_length', '2024-01-08 21:04:11.235122+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (5, 'auth', '0003_alter_user_email_max_length', '2024-01-08 21:04:11.238273+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (6, 'auth', '0004_alter_user_username_opts', '2024-01-08 21:04:11.24163+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (7, 'auth', '0005_alter_user_last_login_null', '2024-01-08 21:04:11.244858+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (8, 'auth', '0006_require_contenttypes_0002', '2024-01-08 21:04:11.245664+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (9, 'auth', '0007_alter_validators_add_error_messages', '2024-01-08 21:04:11.247813+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (10, 'auth', '0008_alter_user_username_max_length', '2024-01-08 21:04:11.250055+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (11, 'auth', '0009_alter_user_last_name_max_length', '2024-01-08 21:04:11.252023+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (12, 'auth', '0010_alter_group_name_max_length', '2024-01-08 21:04:11.256423+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (13, 'auth', '0011_update_proxy_permissions', '2024-01-08 21:04:11.260884+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (14, 'auth', '0012_alter_user_first_name_max_length', '2024-01-08 21:04:11.26323+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (15, 'core', '0001_initial', '2024-01-08 21:04:11.29677+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (16, 'admin', '0001_initial', '2024-01-08 21:04:11.309483+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (17, 'admin', '0002_logentry_remove_auto_add', '2024-01-08 21:04:11.313338+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (18, 'admin', '0003_logentry_add_action_flag_choices', '2024-01-08 21:04:11.316622+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (19, 'authtoken', '0001_initial', '2024-01-08 21:04:11.32562+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (20, 'authtoken', '0002_auto_20160226_1747', '2024-01-08 21:04:11.338217+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (21, 'authtoken', '0003_tokenproxy', '2024-01-08 21:04:11.340046+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (22, 'core', '0002_user_address_user_city_user_id_number_user_id_type_and_more', '2024-01-08 21:04:11.374152+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (23, 'core', '0003_alter_user_address_alter_user_city_and_more', '2024-01-08 21:04:11.395193+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (24, 'core', '0004_orders_orderitem', '2024-01-08 21:04:11.41066+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (25, 'core', '0005_remove_orders_user_delete_orderitem_delete_orders', '2024-01-08 21:04:11.423435+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (26, 'core', '0006_orders_orderitem', '2024-01-08 21:04:11.440824+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (27, 'core', '0007_orders_order_status', '2024-01-08 21:04:11.446301+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (28, 'core', '0008_remove_orders_user_delete_orderitem_delete_orders', '2024-01-08 21:04:11.455758+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (29, 'core', '0009_orders_orderitem', '2024-01-08 21:04:11.478782+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (30, 'core', '0010_remove_orders_address', '2024-01-08 21:04:11.500049+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (31, 'core', '0011_alter_orderitem_order', '2024-01-08 21:04:11.50599+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (32, 'core', '0012_products_discount', '2024-01-08 21:04:11.512026+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (33, 'core', '0013_alter_orderitem_discount', '2024-01-08 21:04:11.51568+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (34, 'core', '0014_orders_order_total_alter_orders_tracking_number', '2024-01-08 21:04:11.528111+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (35, 'core', '0015_orderitem_item_price', '2024-01-08 21:04:11.53275+00');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (36, 'sessions', '0001_initial', '2024-01-08 21:04:11.538975+00');


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 48, true);


--
-- Name: core_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.core_categories_id_seq', 1, false);


--
-- Name: core_orderitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.core_orderitem_id_seq', 1, false);


--
-- Name: core_orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.core_orders_id_seq', 1, false);


--
-- Name: core_products_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.core_products_category_id_seq', 1, false);


--
-- Name: core_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.core_products_id_seq', 1, false);


--
-- Name: core_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.core_user_groups_id_seq', 1, false);


--
-- Name: core_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.core_user_id_seq', 1, true);


--
-- Name: core_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.core_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 12, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 36, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: authtoken_token authtoken_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_pkey PRIMARY KEY (key);


--
-- Name: authtoken_token authtoken_token_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_key UNIQUE (user_id);


--
-- Name: core_categories core_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_categories
    ADD CONSTRAINT core_categories_pkey PRIMARY KEY (id);


--
-- Name: core_orderitem core_orderitem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_orderitem
    ADD CONSTRAINT core_orderitem_pkey PRIMARY KEY (id);


--
-- Name: core_orders core_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_orders
    ADD CONSTRAINT core_orders_pkey PRIMARY KEY (id);


--
-- Name: core_orders core_orders_tracking_number_e91367ed_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_orders
    ADD CONSTRAINT core_orders_tracking_number_e91367ed_uniq UNIQUE (tracking_number);


--
-- Name: core_products_category core_products_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_products_category
    ADD CONSTRAINT core_products_category_pkey PRIMARY KEY (id);


--
-- Name: core_products_category core_products_category_products_id_categories_id_87b97b0c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_products_category
    ADD CONSTRAINT core_products_category_products_id_categories_id_87b97b0c_uniq UNIQUE (products_id, categories_id);


--
-- Name: core_products core_products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_products
    ADD CONSTRAINT core_products_pkey PRIMARY KEY (id);


--
-- Name: core_user core_user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_user
    ADD CONSTRAINT core_user_email_key UNIQUE (email);


--
-- Name: core_user_groups core_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_user_groups
    ADD CONSTRAINT core_user_groups_pkey PRIMARY KEY (id);


--
-- Name: core_user_groups core_user_groups_user_id_group_id_c82fcad1_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_user_groups
    ADD CONSTRAINT core_user_groups_user_id_group_id_c82fcad1_uniq UNIQUE (user_id, group_id);


--
-- Name: core_user core_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_user
    ADD CONSTRAINT core_user_pkey PRIMARY KEY (id);


--
-- Name: core_user_user_permissions core_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_user_user_permissions
    ADD CONSTRAINT core_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: core_user_user_permissions core_user_user_permissions_user_id_permission_id_73ea0daa_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_user_user_permissions
    ADD CONSTRAINT core_user_user_permissions_user_id_permission_id_73ea0daa_uniq UNIQUE (user_id, permission_id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: authtoken_token_key_10f0b77e_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX authtoken_token_key_10f0b77e_like ON public.authtoken_token USING btree (key varchar_pattern_ops);


--
-- Name: core_categories_user_id_ac763e37; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_categories_user_id_ac763e37 ON public.core_categories USING btree (user_id);


--
-- Name: core_orderitem_order_id_30929c10; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_orderitem_order_id_30929c10 ON public.core_orderitem USING btree (order_id);


--
-- Name: core_orderitem_product_id_0c2047cd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_orderitem_product_id_0c2047cd ON public.core_orderitem USING btree (product_id);


--
-- Name: core_orders_tracking_number_e91367ed_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_orders_tracking_number_e91367ed_like ON public.core_orders USING btree (tracking_number varchar_pattern_ops);


--
-- Name: core_orders_user_id_a6e5f620; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_orders_user_id_a6e5f620 ON public.core_orders USING btree (user_id);


--
-- Name: core_products_category_categories_id_c1c6b399; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_products_category_categories_id_c1c6b399 ON public.core_products_category USING btree (categories_id);


--
-- Name: core_products_category_products_id_26ca3379; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_products_category_products_id_26ca3379 ON public.core_products_category USING btree (products_id);


--
-- Name: core_products_user_id_3493aed5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_products_user_id_3493aed5 ON public.core_products USING btree (user_id);


--
-- Name: core_user_email_92a71487_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_user_email_92a71487_like ON public.core_user USING btree (email varchar_pattern_ops);


--
-- Name: core_user_groups_group_id_fe8c697f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_user_groups_group_id_fe8c697f ON public.core_user_groups USING btree (group_id);


--
-- Name: core_user_groups_user_id_70b4d9b8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_user_groups_user_id_70b4d9b8 ON public.core_user_groups USING btree (user_id);


--
-- Name: core_user_user_permissions_permission_id_35ccf601; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_user_user_permissions_permission_id_35ccf601 ON public.core_user_user_permissions USING btree (permission_id);


--
-- Name: core_user_user_permissions_user_id_085123d3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX core_user_user_permissions_user_id_085123d3 ON public.core_user_user_permissions USING btree (user_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authtoken_token authtoken_token_user_id_35299eff_fk_core_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_35299eff_fk_core_user_id FOREIGN KEY (user_id) REFERENCES public.core_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_categories core_categories_user_id_ac763e37_fk_core_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_categories
    ADD CONSTRAINT core_categories_user_id_ac763e37_fk_core_user_id FOREIGN KEY (user_id) REFERENCES public.core_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_orderitem core_orderitem_order_id_30929c10_fk_core_orders_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_orderitem
    ADD CONSTRAINT core_orderitem_order_id_30929c10_fk_core_orders_id FOREIGN KEY (order_id) REFERENCES public.core_orders(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_orderitem core_orderitem_product_id_0c2047cd_fk_core_products_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_orderitem
    ADD CONSTRAINT core_orderitem_product_id_0c2047cd_fk_core_products_id FOREIGN KEY (product_id) REFERENCES public.core_products(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_orders core_orders_user_id_a6e5f620_fk_core_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_orders
    ADD CONSTRAINT core_orders_user_id_a6e5f620_fk_core_user_id FOREIGN KEY (user_id) REFERENCES public.core_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_products_category core_products_catego_categories_id_c1c6b399_fk_core_cate; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_products_category
    ADD CONSTRAINT core_products_catego_categories_id_c1c6b399_fk_core_cate FOREIGN KEY (categories_id) REFERENCES public.core_categories(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_products_category core_products_category_products_id_26ca3379_fk_core_products_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_products_category
    ADD CONSTRAINT core_products_category_products_id_26ca3379_fk_core_products_id FOREIGN KEY (products_id) REFERENCES public.core_products(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_products core_products_user_id_3493aed5_fk_core_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_products
    ADD CONSTRAINT core_products_user_id_3493aed5_fk_core_user_id FOREIGN KEY (user_id) REFERENCES public.core_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_user_groups core_user_groups_group_id_fe8c697f_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_user_groups
    ADD CONSTRAINT core_user_groups_group_id_fe8c697f_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_user_groups core_user_groups_user_id_70b4d9b8_fk_core_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_user_groups
    ADD CONSTRAINT core_user_groups_user_id_70b4d9b8_fk_core_user_id FOREIGN KEY (user_id) REFERENCES public.core_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_user_user_permissions core_user_user_permi_permission_id_35ccf601_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_user_user_permissions
    ADD CONSTRAINT core_user_user_permi_permission_id_35ccf601_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_user_user_permissions core_user_user_permissions_user_id_085123d3_fk_core_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.core_user_user_permissions
    ADD CONSTRAINT core_user_user_permissions_user_id_085123d3_fk_core_user_id FOREIGN KEY (user_id) REFERENCES public.core_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_core_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_core_user_id FOREIGN KEY (user_id) REFERENCES public.core_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

