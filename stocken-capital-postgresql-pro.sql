--
-- PostgreSQL database dump
--

-- Dumped from database version 13.10
-- Dumped by pg_dump version 15.4

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


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
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
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
    user_id integer NOT NULL
);


ALTER TABLE public.authtoken_token OWNER TO postgres;

--
-- Name: capital_increases_capitalincrease; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.capital_increases_capitalincrease (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    max_shares integer NOT NULL,
    min_shares integer NOT NULL,
    deadline date NOT NULL,
    amount_per_share numeric(20,2) NOT NULL,
    state character varying(32) NOT NULL,
    company_id integer NOT NULL,
    issue_premium numeric(20,2) NOT NULL,
    new_share_capital numeric(20,2),
    CONSTRAINT capital_increases_capitalincrease_max_shares_check CHECK ((max_shares >= 0)),
    CONSTRAINT capital_increases_capitalincrease_min_shares_check CHECK ((min_shares >= 0))
);


ALTER TABLE public.capital_increases_capitalincrease OWNER TO postgres;

--
-- Name: capital_increases_capitalincrease_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.capital_increases_capitalincrease_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.capital_increases_capitalincrease_id_seq OWNER TO postgres;

--
-- Name: capital_increases_capitalincrease_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.capital_increases_capitalincrease_id_seq OWNED BY public.capital_increases_capitalincrease.id;


--
-- Name: companies_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.companies_category (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.companies_category OWNER TO postgres;

--
-- Name: companies_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.companies_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.companies_category_id_seq OWNER TO postgres;

--
-- Name: companies_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.companies_category_id_seq OWNED BY public.companies_category.id;


--
-- Name: companies_company; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.companies_company (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    social_denomination character varying(100),
    cif character varying(100),
    constitution_date date,
    street_address character varying(200),
    city character varying(100),
    postal_code character varying(10),
    state character varying(100),
    country character varying(2),
    logo character varying(100),
    description text,
    registration_data text,
    governing_bodies text,
    shares integer,
    share_capital numeric(20,2),
    par_value_per_share numeric(20,2),
    status character varying(32) NOT NULL,
    published boolean NOT NULL,
    slug character varying(50),
    right_conditions boolean NOT NULL,
    right_conditions_days integer,
    stocken_invests boolean NOT NULL,
    code character varying(4),
    legal_representative_id integer,
    governing_bodies_legal_representative_full_name character varying(100),
    governing_bodies_legal_representative_position character varying(100),
    governing_bodies_legal_representative_powers_date date,
    governing_bodies_notary_city character varying(100),
    governing_bodies_notary_full_name character varying(100),
    governing_bodies_notary_number character varying(100),
    registration_data_date date,
    registration_data_inscription_date date,
    registration_data_inscription_number character varying(100),
    registration_data_notary_city character varying(100),
    registration_data_notary_full_name character varying(100),
    registration_data_notary_number character varying(100),
    registration_data_number character varying(100),
    registration_data_page_number character varying(100),
    registration_data_sheet_number character varying(100),
    registration_data_state character varying(100),
    registration_data_volume_number character varying(100),
    automation_corporate_management boolean NOT NULL,
    capture_private_financing boolean NOT NULL,
    management_transparency boolean NOT NULL,
    otra boolean NOT NULL,
    otra_description text,
    categories_id integer,
    cod character varying(30),
    mangopay_id character varying(32),
    investor boolean NOT NULL,
    CONSTRAINT companies_company_shares_2e6779ac_check CHECK ((shares >= 0))
);


ALTER TABLE public.companies_company OWNER TO postgres;

--
-- Name: companies_company_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.companies_company_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.companies_company_id_seq OWNER TO postgres;

--
-- Name: companies_company_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.companies_company_id_seq OWNED BY public.companies_company.id;


--
-- Name: companies_company_investors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.companies_company_investors (
    id integer NOT NULL,
    company_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.companies_company_investors OWNER TO postgres;

--
-- Name: companies_company_investors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.companies_company_investors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.companies_company_investors_id_seq OWNER TO postgres;

--
-- Name: companies_company_investors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.companies_company_investors_id_seq OWNED BY public.companies_company_investors.id;


--
-- Name: conversations_contact; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conversations_contact (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    subject character varying(255) NOT NULL,
    email character varying(254) NOT NULL,
    message text NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.conversations_contact OWNER TO postgres;

--
-- Name: conversations_contact_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.conversations_contact_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.conversations_contact_id_seq OWNER TO postgres;

--
-- Name: conversations_contact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.conversations_contact_id_seq OWNED BY public.conversations_contact.id;


--
-- Name: conversations_conversation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conversations_conversation (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    subject character varying(128) NOT NULL,
    body text NOT NULL,
    is_from_company boolean NOT NULL,
    company_id integer NOT NULL,
    creator_id integer NOT NULL,
    blockchain_link text,
    blockchain_transaction_id text,
    cod character varying(30),
    transaction_hash text
);


ALTER TABLE public.conversations_conversation OWNER TO postgres;

--
-- Name: conversations_conversation_documents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conversations_conversation_documents (
    id integer NOT NULL,
    conversation_id integer NOT NULL,
    document_id integer NOT NULL
);


ALTER TABLE public.conversations_conversation_documents OWNER TO postgres;

--
-- Name: conversations_conversation_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.conversations_conversation_documents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.conversations_conversation_documents_id_seq OWNER TO postgres;

--
-- Name: conversations_conversation_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.conversations_conversation_documents_id_seq OWNED BY public.conversations_conversation_documents.id;


--
-- Name: conversations_conversation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.conversations_conversation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.conversations_conversation_id_seq OWNER TO postgres;

--
-- Name: conversations_conversation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.conversations_conversation_id_seq OWNED BY public.conversations_conversation.id;


--
-- Name: conversations_conversation_partners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conversations_conversation_partners (
    id integer NOT NULL,
    conversation_id integer NOT NULL,
    partner_id integer NOT NULL
);


ALTER TABLE public.conversations_conversation_partners OWNER TO postgres;

--
-- Name: conversations_conversation_partners_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.conversations_conversation_partners_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.conversations_conversation_partners_id_seq OWNER TO postgres;

--
-- Name: conversations_conversation_partners_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.conversations_conversation_partners_id_seq OWNED BY public.conversations_conversation_partners.id;


--
-- Name: conversations_conversationhistory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conversations_conversationhistory (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    transaction_hash text,
    conversation_id integer,
    creator_id integer,
    blockchain_link text,
    blockchain_transaction_id text
);


ALTER TABLE public.conversations_conversationhistory OWNER TO postgres;

--
-- Name: conversations_conversationhistory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.conversations_conversationhistory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.conversations_conversationhistory_id_seq OWNER TO postgres;

--
-- Name: conversations_conversationhistory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.conversations_conversationhistory_id_seq OWNED BY public.conversations_conversationhistory.id;


--
-- Name: conversations_message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conversations_message (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    body text NOT NULL,
    conversation_id integer NOT NULL,
    creator_id integer NOT NULL,
    blockchain_link text,
    blockchain_transaction_id text,
    transaction_hash text,
    cod character varying(30)
);


ALTER TABLE public.conversations_message OWNER TO postgres;

--
-- Name: conversations_message_documents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conversations_message_documents (
    id integer NOT NULL,
    message_id integer NOT NULL,
    document_id integer NOT NULL
);


ALTER TABLE public.conversations_message_documents OWNER TO postgres;

--
-- Name: conversations_message_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.conversations_message_documents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.conversations_message_documents_id_seq OWNER TO postgres;

--
-- Name: conversations_message_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.conversations_message_documents_id_seq OWNED BY public.conversations_message_documents.id;


--
-- Name: conversations_message_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.conversations_message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.conversations_message_id_seq OWNER TO postgres;

--
-- Name: conversations_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.conversations_message_id_seq OWNED BY public.conversations_message.id;


--
-- Name: currencies_currency; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.currencies_currency (
    code character varying(3) NOT NULL,
    currency_asset_id integer NOT NULL
);


ALTER TABLE public.currencies_currency OWNER TO postgres;

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
    user_id integer NOT NULL,
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
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
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
-- Name: django_site; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.django_site OWNER TO postgres;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_site_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_site_id_seq OWNER TO postgres;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_site_id_seq OWNED BY public.django_site.id;


--
-- Name: documents_document; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.documents_document (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    name character varying(100) NOT NULL,
    description text NOT NULL,
    file character varying(100) NOT NULL,
    visibility character varying(16) NOT NULL,
    company_id integer NOT NULL,
    creator_id integer,
    file_hash text,
    stellar_transaction_hash text,
    related_meeting_id integer,
    related_operation_id integer,
    type character varying(16),
    blockchain_link text,
    blockchain_transaction_id text,
    cod character varying(30),
    transaction_hash text
);


ALTER TABLE public.documents_document OWNER TO postgres;

--
-- Name: documents_document_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.documents_document_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.documents_document_id_seq OWNER TO postgres;

--
-- Name: documents_document_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.documents_document_id_seq OWNED BY public.documents_document.id;


--
-- Name: documents_document_related_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.documents_document_related_users (
    id integer NOT NULL,
    document_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.documents_document_related_users OWNER TO postgres;

--
-- Name: documents_document_related_users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.documents_document_related_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.documents_document_related_users_id_seq OWNER TO postgres;

--
-- Name: documents_document_related_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.documents_document_related_users_id_seq OWNED BY public.documents_document_related_users.id;


--
-- Name: documents_historydocument; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.documents_historydocument (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    transaction_hash text,
    creator_id integer,
    document_id integer,
    blockchain_link text,
    blockchain_transaction_id text,
    cod character varying(30)
);


ALTER TABLE public.documents_historydocument OWNER TO postgres;

--
-- Name: documents_historydocument_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.documents_historydocument_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.documents_historydocument_id_seq OWNER TO postgres;

--
-- Name: documents_historydocument_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.documents_historydocument_id_seq OWNED BY public.documents_historydocument.id;


--
-- Name: documents_useractiondetail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.documents_useractiondetail (
    id integer NOT NULL,
    action character varying(255) NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    details text,
    company_id integer,
    session_id integer NOT NULL
);


ALTER TABLE public.documents_useractiondetail OWNER TO postgres;

--
-- Name: documents_useractiondetail_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.documents_useractiondetail_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.documents_useractiondetail_id_seq OWNER TO postgres;

--
-- Name: documents_useractiondetail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.documents_useractiondetail_id_seq OWNED BY public.documents_useractiondetail.id;


--
-- Name: documents_usersessionlog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.documents_usersessionlog (
    id integer NOT NULL,
    start_time timestamp with time zone NOT NULL,
    end_time timestamp with time zone,
    user_id integer NOT NULL
);


ALTER TABLE public.documents_usersessionlog OWNER TO postgres;

--
-- Name: documents_usersessionlog_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.documents_usersessionlog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.documents_usersessionlog_id_seq OWNER TO postgres;

--
-- Name: documents_usersessionlog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.documents_usersessionlog_id_seq OWNED BY public.documents_usersessionlog.id;


--
-- Name: mangopay_basemangopaytransaction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mangopay_basemangopaytransaction (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    transaction_id character varying(32) NOT NULL,
    status character varying(32) NOT NULL,
    amount numeric(20,2) NOT NULL,
    currency character varying(3) NOT NULL,
    fees numeric(20,2) NOT NULL,
    cod character varying(30) NOT NULL
);


ALTER TABLE public.mangopay_basemangopaytransaction OWNER TO postgres;

--
-- Name: mangopay_basemangopaytransaction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mangopay_basemangopaytransaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mangopay_basemangopaytransaction_id_seq OWNER TO postgres;

--
-- Name: mangopay_basemangopaytransaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mangopay_basemangopaytransaction_id_seq OWNED BY public.mangopay_basemangopaytransaction.id;


--
-- Name: mangopay_mangopaybankaccount; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mangopay_mangopaybankaccount (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    bank_account_id character varying(32) NOT NULL,
    iban character varying(100) NOT NULL,
    is_active boolean NOT NULL,
    owner_name character varying(200) NOT NULL,
    owner_street_address character varying(200) NOT NULL,
    owner_city character varying(100) NOT NULL,
    owner_postal_code character varying(10) NOT NULL,
    owner_state character varying(100) NOT NULL,
    owner_country character varying(2) NOT NULL,
    user_id integer NOT NULL,
    cod character varying(30) NOT NULL
);


ALTER TABLE public.mangopay_mangopaybankaccount OWNER TO postgres;

--
-- Name: mangopay_mangopaybankaccount_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mangopay_mangopaybankaccount_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mangopay_mangopaybankaccount_id_seq OWNER TO postgres;

--
-- Name: mangopay_mangopaybankaccount_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mangopay_mangopaybankaccount_id_seq OWNED BY public.mangopay_mangopaybankaccount.id;


--
-- Name: mangopay_mangopaybankwiredeposit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mangopay_mangopaybankwiredeposit (
    basemangopaytransaction_ptr_id integer NOT NULL,
    wire_reference character varying(64) NOT NULL,
    bank_account character varying(64) NOT NULL,
    to_user_id integer NOT NULL
);


ALTER TABLE public.mangopay_mangopaybankwiredeposit OWNER TO postgres;

--
-- Name: mangopay_mangopaydeposit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mangopay_mangopaydeposit (
    language character varying(8) NOT NULL,
    redirect_url character varying(200) NOT NULL,
    return_url character varying(200) NOT NULL,
    to_user_id integer NOT NULL,
    basemangopaytransaction_ptr_id integer NOT NULL
);


ALTER TABLE public.mangopay_mangopaydeposit OWNER TO postgres;

--
-- Name: mangopay_mangopaykycdocument; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mangopay_mangopaykycdocument (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    status character varying(32) NOT NULL,
    type character varying(32) NOT NULL,
    document_id character varying(32) NOT NULL,
    user_id integer NOT NULL,
    processed_date timestamp with time zone,
    refused_reason_message character varying(256),
    refused_reason_type character varying(64),
    cod character varying(30) NOT NULL
);


ALTER TABLE public.mangopay_mangopaykycdocument OWNER TO postgres;

--
-- Name: mangopay_mangopaykycdocument_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mangopay_mangopaykycdocument_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mangopay_mangopaykycdocument_id_seq OWNER TO postgres;

--
-- Name: mangopay_mangopaykycdocument_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mangopay_mangopaykycdocument_id_seq OWNED BY public.mangopay_mangopaykycdocument.id;


--
-- Name: mangopay_mangopaytransfer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mangopay_mangopaytransfer (
    from_user_id integer NOT NULL,
    to_user_id integer NOT NULL,
    basemangopaytransaction_ptr_id integer NOT NULL,
    from_cod character varying(255),
    to_cod character varying(255),
    total_amount numeric(20,2)
);


ALTER TABLE public.mangopay_mangopaytransfer OWNER TO postgres;

--
-- Name: mangopay_mangopayuser; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mangopay_mangopayuser (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    mangopay_id character varying(32) NOT NULL,
    user_id integer NOT NULL,
    kyc_level character varying(32) NOT NULL,
    cod character varying(30) NOT NULL
);


ALTER TABLE public.mangopay_mangopayuser OWNER TO postgres;

--
-- Name: mangopay_mangopayuser_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mangopay_mangopayuser_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mangopay_mangopayuser_id_seq OWNER TO postgres;

--
-- Name: mangopay_mangopayuser_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mangopay_mangopayuser_id_seq OWNED BY public.mangopay_mangopayuser.id;


--
-- Name: mangopay_mangopaywallet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mangopay_mangopaywallet (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    wallet_id character varying(32) NOT NULL,
    user_id integer,
    amount numeric(20,2) NOT NULL,
    cod character varying(30) NOT NULL
);


ALTER TABLE public.mangopay_mangopaywallet OWNER TO postgres;

--
-- Name: mangopay_mangopaywallet_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mangopay_mangopaywallet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mangopay_mangopaywallet_id_seq OWNER TO postgres;

--
-- Name: mangopay_mangopaywallet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mangopay_mangopaywallet_id_seq OWNED BY public.mangopay_mangopaywallet.id;


--
-- Name: meetings_agendaitem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.meetings_agendaitem (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    proposal text NOT NULL,
    meeting_id integer NOT NULL,
    proposal_agreement text,
    approved boolean
);


ALTER TABLE public.meetings_agendaitem OWNER TO postgres;

--
-- Name: meetings_agendaitem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.meetings_agendaitem_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.meetings_agendaitem_id_seq OWNER TO postgres;

--
-- Name: meetings_agendaitem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.meetings_agendaitem_id_seq OWNED BY public.meetings_agendaitem.id;


--
-- Name: meetings_document; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.meetings_document (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    file character varying(100) NOT NULL,
    hash text,
    agenda_item_id integer,
    creator_id integer,
    stellar_transaction_hash text,
    blockchain_link text,
    blockchain_transaction_id text
);


ALTER TABLE public.meetings_document OWNER TO postgres;

--
-- Name: meetings_document_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.meetings_document_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.meetings_document_id_seq OWNER TO postgres;

--
-- Name: meetings_document_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.meetings_document_id_seq OWNED BY public.meetings_document.id;


--
-- Name: meetings_historymeetingsdocument; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.meetings_historymeetingsdocument (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    transaction_hash text,
    blockchain_transaction_id text,
    blockchain_link text,
    creator_id integer,
    document_id integer
);


ALTER TABLE public.meetings_historymeetingsdocument OWNER TO postgres;

--
-- Name: meetings_historymeetingsdocument_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.meetings_historymeetingsdocument_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.meetings_historymeetingsdocument_id_seq OWNER TO postgres;

--
-- Name: meetings_historymeetingsdocument_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.meetings_historymeetingsdocument_id_seq OWNED BY public.meetings_historymeetingsdocument.id;


--
-- Name: meetings_meeting; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.meetings_meeting (
    id integer NOT NULL,
    planned_date date NOT NULL,
    celebration_date date,
    "time" time without time zone NOT NULL,
    finish timestamp with time zone,
    date_of_call date,
    state character varying(32) NOT NULL,
    type character varying(32) NOT NULL,
    place character varying(256) NOT NULL,
    company_id integer NOT NULL,
    creator_id integer,
    minutes_id integer,
    footer text,
    header text,
    review_date date,
    call_id integer
);


ALTER TABLE public.meetings_meeting OWNER TO postgres;

--
-- Name: meetings_meeting_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.meetings_meeting_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.meetings_meeting_id_seq OWNER TO postgres;

--
-- Name: meetings_meeting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.meetings_meeting_id_seq OWNED BY public.meetings_meeting.id;


--
-- Name: meetings_participant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.meetings_participant (
    id integer NOT NULL,
    shares integer NOT NULL,
    attendant boolean NOT NULL,
    vote_datetime timestamp with time zone,
    meeting_id integer NOT NULL,
    user_id integer NOT NULL,
    read_call timestamp with time zone,
    read_minutes timestamp with time zone,
    cod character varying(10),
    CONSTRAINT meetings_participant_shares_check CHECK ((shares >= 0))
);


ALTER TABLE public.meetings_participant OWNER TO postgres;

--
-- Name: meetings_participant_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.meetings_participant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.meetings_participant_id_seq OWNER TO postgres;

--
-- Name: meetings_participant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.meetings_participant_id_seq OWNED BY public.meetings_participant.id;


--
-- Name: oauth2_provider_accesstoken; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth2_provider_accesstoken (
    id bigint NOT NULL,
    token character varying(255) NOT NULL,
    expires timestamp with time zone NOT NULL,
    scope text NOT NULL,
    application_id bigint,
    user_id integer,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    source_refresh_token_id bigint,
    id_token_id bigint
);


ALTER TABLE public.oauth2_provider_accesstoken OWNER TO postgres;

--
-- Name: oauth2_provider_accesstoken_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oauth2_provider_accesstoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oauth2_provider_accesstoken_id_seq OWNER TO postgres;

--
-- Name: oauth2_provider_accesstoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oauth2_provider_accesstoken_id_seq OWNED BY public.oauth2_provider_accesstoken.id;


--
-- Name: oauth2_provider_application; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth2_provider_application (
    id bigint NOT NULL,
    client_id character varying(100) NOT NULL,
    redirect_uris text NOT NULL,
    client_type character varying(32) NOT NULL,
    authorization_grant_type character varying(32) NOT NULL,
    client_secret character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    user_id integer,
    skip_authorization boolean NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    algorithm character varying(5) NOT NULL,
    post_logout_redirect_uris text NOT NULL
);


ALTER TABLE public.oauth2_provider_application OWNER TO postgres;

--
-- Name: oauth2_provider_application_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oauth2_provider_application_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oauth2_provider_application_id_seq OWNER TO postgres;

--
-- Name: oauth2_provider_application_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oauth2_provider_application_id_seq OWNED BY public.oauth2_provider_application.id;


--
-- Name: oauth2_provider_grant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth2_provider_grant (
    id bigint NOT NULL,
    code character varying(255) NOT NULL,
    expires timestamp with time zone NOT NULL,
    redirect_uri text NOT NULL,
    scope text NOT NULL,
    application_id bigint NOT NULL,
    user_id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    code_challenge character varying(128) NOT NULL,
    code_challenge_method character varying(10) NOT NULL,
    nonce character varying(255) NOT NULL,
    claims text NOT NULL
);


ALTER TABLE public.oauth2_provider_grant OWNER TO postgres;

--
-- Name: oauth2_provider_grant_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oauth2_provider_grant_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oauth2_provider_grant_id_seq OWNER TO postgres;

--
-- Name: oauth2_provider_grant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oauth2_provider_grant_id_seq OWNED BY public.oauth2_provider_grant.id;


--
-- Name: oauth2_provider_idtoken; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth2_provider_idtoken (
    id bigint NOT NULL,
    jti uuid NOT NULL,
    expires timestamp with time zone NOT NULL,
    scope text NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    application_id bigint,
    user_id integer
);


ALTER TABLE public.oauth2_provider_idtoken OWNER TO postgres;

--
-- Name: oauth2_provider_idtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oauth2_provider_idtoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oauth2_provider_idtoken_id_seq OWNER TO postgres;

--
-- Name: oauth2_provider_idtoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oauth2_provider_idtoken_id_seq OWNED BY public.oauth2_provider_idtoken.id;


--
-- Name: oauth2_provider_refreshtoken; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth2_provider_refreshtoken (
    id bigint NOT NULL,
    token character varying(255) NOT NULL,
    access_token_id bigint,
    application_id bigint NOT NULL,
    user_id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    revoked timestamp with time zone
);


ALTER TABLE public.oauth2_provider_refreshtoken OWNER TO postgres;

--
-- Name: oauth2_provider_refreshtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oauth2_provider_refreshtoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oauth2_provider_refreshtoken_id_seq OWNER TO postgres;

--
-- Name: oauth2_provider_refreshtoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oauth2_provider_refreshtoken_id_seq OWNED BY public.oauth2_provider_refreshtoken.id;


--
-- Name: offers_document; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offers_document (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    file character varying(100) NOT NULL,
    hash text,
    stellar_transaction_hash text,
    proposal_id integer NOT NULL,
    blockchain_link text,
    blockchain_transaction_id text
);


ALTER TABLE public.offers_document OWNER TO postgres;

--
-- Name: offers_document_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.offers_document_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.offers_document_id_seq OWNER TO postgres;

--
-- Name: offers_document_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.offers_document_id_seq OWNED BY public.offers_document.id;


--
-- Name: offers_historyoffersdocument; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offers_historyoffersdocument (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    cod character varying(30),
    transaction_hash text,
    blockchain_transaction_id text,
    blockchain_link text,
    creator_id integer,
    document_id integer
);


ALTER TABLE public.offers_historyoffersdocument OWNER TO postgres;

--
-- Name: offers_historyoffersdocument_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.offers_historyoffersdocument_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.offers_historyoffersdocument_id_seq OWNER TO postgres;

--
-- Name: offers_historyoffersdocument_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.offers_historyoffersdocument_id_seq OWNED BY public.offers_historyoffersdocument.id;


--
-- Name: offers_offer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offers_offer (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    shares integer NOT NULL,
    amount_per_share numeric(20,2) NOT NULL,
    company_id integer NOT NULL,
    user_id integer,
    for_user_id integer,
    is_family boolean NOT NULL,
    concept character varying(32) NOT NULL,
    capital_increase_id integer,
    is_canceled boolean NOT NULL,
    status character varying(32) NOT NULL,
    cod character varying(255),
    CONSTRAINT offers_offer_shares_check CHECK ((shares >= 0))
);


ALTER TABLE public.offers_offer OWNER TO postgres;

--
-- Name: offers_offer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.offers_offer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.offers_offer_id_seq OWNER TO postgres;

--
-- Name: offers_offer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.offers_offer_id_seq OWNED BY public.offers_offer.id;


--
-- Name: offers_proposal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offers_proposal (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    shares integer NOT NULL,
    amount_per_share numeric(20,2) NOT NULL,
    state character varying(9) NOT NULL,
    offer_id integer NOT NULL,
    user_id integer NOT NULL,
    operation_id integer,
    payment_id integer,
    shares_range_end integer,
    shares_range_start integer,
    fees numeric(20,2) NOT NULL,
    total_amount numeric(20,2),
    cod character varying(255),
    CONSTRAINT offers_proposal_shares_check CHECK ((shares >= 0)),
    CONSTRAINT offers_proposal_shares_range_end_check CHECK ((shares_range_end >= 0)),
    CONSTRAINT offers_proposal_shares_range_start_check CHECK ((shares_range_start >= 0))
);


ALTER TABLE public.offers_proposal OWNER TO postgres;

--
-- Name: offers_proposal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.offers_proposal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.offers_proposal_id_seq OWNER TO postgres;

--
-- Name: offers_proposal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.offers_proposal_id_seq OWNED BY public.offers_proposal.id;


--
-- Name: operations_operation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.operations_operation (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    type character varying(32) NOT NULL,
    status character varying(32) NOT NULL,
    shares integer NOT NULL,
    amount numeric(20,2),
    date date NOT NULL,
    concept character varying(256),
    range_start integer,
    range_end integer,
    company_id integer NOT NULL,
    from_user_id integer,
    to_user_id integer NOT NULL,
    from_shares_after_operation integer,
    to_shares_after_operation integer,
    amount_per_share numeric(20,2),
    stellar_transaction_hash text,
    issue_premium numeric(20,2),
    from_cod character varying(30),
    to_cod character varying(30),
    CONSTRAINT operations_operation_from_shares_after_operation_check CHECK ((from_shares_after_operation >= 0)),
    CONSTRAINT operations_operation_range_end_check CHECK ((range_end >= 0)),
    CONSTRAINT operations_operation_range_start_check CHECK ((range_start >= 0)),
    CONSTRAINT operations_operation_shares_check CHECK ((shares >= 0)),
    CONSTRAINT operations_operation_to_shares_after_operation_check CHECK ((to_shares_after_operation >= 0))
);


ALTER TABLE public.operations_operation OWNER TO postgres;

--
-- Name: operations_operation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.operations_operation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.operations_operation_id_seq OWNER TO postgres;

--
-- Name: operations_operation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.operations_operation_id_seq OWNED BY public.operations_operation.id;


--
-- Name: options_option; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.options_option (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    public_name character varying(255) NOT NULL,
    type integer NOT NULL,
    value character varying(256),
    is_list boolean NOT NULL,
    file character varying(100),
    is_public boolean NOT NULL,
    help_text text,
    CONSTRAINT options_option_type_check CHECK ((type >= 0))
);


ALTER TABLE public.options_option OWNER TO postgres;

--
-- Name: options_option_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.options_option_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.options_option_id_seq OWNER TO postgres;

--
-- Name: options_option_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.options_option_id_seq OWNED BY public.options_option.id;


--
-- Name: options_useroption; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.options_useroption (
    id integer NOT NULL,
    public_name character varying(255) NOT NULL,
    type integer NOT NULL,
    value character varying(256),
    is_list boolean NOT NULL,
    name character varying(255) NOT NULL,
    user_id integer NOT NULL,
    file character varying(100),
    is_public boolean NOT NULL,
    help_text text,
    CONSTRAINT options_useroption_type_check CHECK ((type >= 0))
);


ALTER TABLE public.options_useroption OWNER TO postgres;

--
-- Name: options_useroption_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.options_useroption_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.options_useroption_id_seq OWNER TO postgres;

--
-- Name: options_useroption_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.options_useroption_id_seq OWNED BY public.options_useroption.id;


--
-- Name: partners_partner; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.partners_partner (
    id integer NOT NULL,
    shares integer NOT NULL,
    company_id integer NOT NULL,
    user_id integer NOT NULL,
    unit_acquisition_value numeric(20,2),
    cod character varying(255),
    company_cod character varying(255),
    content_type_id integer,
    object_id integer,
    user_cod character varying(255),
    CONSTRAINT partners_partner_object_id_check CHECK ((object_id >= 0)),
    CONSTRAINT partners_partner_shares_check CHECK ((shares >= 0))
);


ALTER TABLE public.partners_partner OWNER TO postgres;

--
-- Name: partners_partner_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.partners_partner_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.partners_partner_id_seq OWNER TO postgres;

--
-- Name: partners_partner_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.partners_partner_id_seq OWNED BY public.partners_partner.id;


--
-- Name: payments_payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments_payment (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    amount numeric(20,2) NOT NULL,
    currency character varying(3) NOT NULL,
    status character varying(32) NOT NULL,
    mangopay_transaction_id integer,
    to_user_id integer,
    type character varying(32) NOT NULL,
    from_user_id integer,
    fees numeric(20,2) NOT NULL,
    from_cod character varying(30),
    to_cod character varying(30)
);


ALTER TABLE public.payments_payment OWNER TO postgres;

--
-- Name: payments_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payments_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payments_payment_id_seq OWNER TO postgres;

--
-- Name: payments_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payments_payment_id_seq OWNED BY public.payments_payment.id;


--
-- Name: snitch_event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.snitch_event (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    actor_object_id integer,
    verb character varying(255),
    trigger_object_id integer,
    target_object_id integer,
    notified boolean NOT NULL,
    actor_content_type_id integer,
    target_content_type_id integer,
    trigger_content_type_id integer,
    CONSTRAINT snitch_event_actor_object_id_check CHECK ((actor_object_id >= 0)),
    CONSTRAINT snitch_event_target_object_id_check CHECK ((target_object_id >= 0)),
    CONSTRAINT snitch_event_trigger_object_id_check CHECK ((trigger_object_id >= 0))
);


ALTER TABLE public.snitch_event OWNER TO postgres;

--
-- Name: snitch_event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.snitch_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.snitch_event_id_seq OWNER TO postgres;

--
-- Name: snitch_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.snitch_event_id_seq OWNED BY public.snitch_event.id;


--
-- Name: snitch_eventtype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.snitch_eventtype (
    id integer NOT NULL,
    verb character varying(255),
    enabled boolean NOT NULL
);


ALTER TABLE public.snitch_eventtype OWNER TO postgres;

--
-- Name: snitch_eventtype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.snitch_eventtype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.snitch_eventtype_id_seq OWNER TO postgres;

--
-- Name: snitch_eventtype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.snitch_eventtype_id_seq OWNED BY public.snitch_eventtype.id;


--
-- Name: snitch_notification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.snitch_notification (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    sent boolean NOT NULL,
    received boolean NOT NULL,
    read boolean NOT NULL,
    event_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.snitch_notification OWNER TO postgres;

--
-- Name: snitch_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.snitch_notification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.snitch_notification_id_seq OWNER TO postgres;

--
-- Name: snitch_notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.snitch_notification_id_seq OWNED BY public.snitch_notification.id;


--
-- Name: social_auth_association; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.social_auth_association (
    id bigint NOT NULL,
    server_url character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    secret character varying(255) NOT NULL,
    issued integer NOT NULL,
    lifetime integer NOT NULL,
    assoc_type character varying(64) NOT NULL
);


ALTER TABLE public.social_auth_association OWNER TO postgres;

--
-- Name: social_auth_association_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.social_auth_association_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.social_auth_association_id_seq OWNER TO postgres;

--
-- Name: social_auth_association_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.social_auth_association_id_seq OWNED BY public.social_auth_association.id;


--
-- Name: social_auth_code; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.social_auth_code (
    id bigint NOT NULL,
    email character varying(254) NOT NULL,
    code character varying(32) NOT NULL,
    verified boolean NOT NULL,
    "timestamp" timestamp with time zone NOT NULL
);


ALTER TABLE public.social_auth_code OWNER TO postgres;

--
-- Name: social_auth_code_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.social_auth_code_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.social_auth_code_id_seq OWNER TO postgres;

--
-- Name: social_auth_code_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.social_auth_code_id_seq OWNED BY public.social_auth_code.id;


--
-- Name: social_auth_nonce; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.social_auth_nonce (
    id bigint NOT NULL,
    server_url character varying(255) NOT NULL,
    "timestamp" integer NOT NULL,
    salt character varying(65) NOT NULL
);


ALTER TABLE public.social_auth_nonce OWNER TO postgres;

--
-- Name: social_auth_nonce_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.social_auth_nonce_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.social_auth_nonce_id_seq OWNER TO postgres;

--
-- Name: social_auth_nonce_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.social_auth_nonce_id_seq OWNED BY public.social_auth_nonce.id;


--
-- Name: social_auth_partial; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.social_auth_partial (
    id bigint NOT NULL,
    token character varying(32) NOT NULL,
    next_step smallint NOT NULL,
    backend character varying(32) NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    data jsonb NOT NULL,
    CONSTRAINT social_auth_partial_next_step_check CHECK ((next_step >= 0))
);


ALTER TABLE public.social_auth_partial OWNER TO postgres;

--
-- Name: social_auth_partial_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.social_auth_partial_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.social_auth_partial_id_seq OWNER TO postgres;

--
-- Name: social_auth_partial_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.social_auth_partial_id_seq OWNED BY public.social_auth_partial.id;


--
-- Name: social_auth_usersocialauth; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.social_auth_usersocialauth (
    id bigint NOT NULL,
    provider character varying(32) NOT NULL,
    uid character varying(255) NOT NULL,
    user_id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    extra_data jsonb NOT NULL
);


ALTER TABLE public.social_auth_usersocialauth OWNER TO postgres;

--
-- Name: social_auth_usersocialauth_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.social_auth_usersocialauth_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.social_auth_usersocialauth_id_seq OWNER TO postgres;

--
-- Name: social_auth_usersocialauth_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.social_auth_usersocialauth_id_seq OWNED BY public.social_auth_usersocialauth.id;


--
-- Name: stellar_asset; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stellar_asset (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    code text NOT NULL,
    issuer_public_key text NOT NULL,
    issuer_secret text NOT NULL,
    distribution_public_key text NOT NULL,
    distribution_secret text NOT NULL,
    company_id integer NOT NULL
);


ALTER TABLE public.stellar_asset OWNER TO postgres;

--
-- Name: stellar_asset_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stellar_asset_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stellar_asset_id_seq OWNER TO postgres;

--
-- Name: stellar_asset_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stellar_asset_id_seq OWNED BY public.stellar_asset.id;


--
-- Name: stellar_asset_trust_op_completed; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stellar_asset_trust_op_completed (
    id integer NOT NULL,
    asset_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.stellar_asset_trust_op_completed OWNER TO postgres;

--
-- Name: stellar_asset_trust_op_completed_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stellar_asset_trust_op_completed_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stellar_asset_trust_op_completed_id_seq OWNER TO postgres;

--
-- Name: stellar_asset_trust_op_completed_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stellar_asset_trust_op_completed_id_seq OWNED BY public.stellar_asset_trust_op_completed.id;


--
-- Name: stellar_currencyasset; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stellar_currencyasset (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    code text NOT NULL,
    issuer_public_key text NOT NULL,
    issuer_secret text NOT NULL,
    distribution_public_key text NOT NULL,
    distribution_secret text NOT NULL
);


ALTER TABLE public.stellar_currencyasset OWNER TO postgres;

--
-- Name: stellar_currencyasset_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stellar_currencyasset_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stellar_currencyasset_id_seq OWNER TO postgres;

--
-- Name: stellar_currencyasset_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stellar_currencyasset_id_seq OWNED BY public.stellar_currencyasset.id;


--
-- Name: stellar_currencyasset_trust_op_completed; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stellar_currencyasset_trust_op_completed (
    id integer NOT NULL,
    currencyasset_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.stellar_currencyasset_trust_op_completed OWNER TO postgres;

--
-- Name: stellar_currencyasset_trust_op_completed_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stellar_currencyasset_trust_op_completed_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stellar_currencyasset_trust_op_completed_id_seq OWNER TO postgres;

--
-- Name: stellar_currencyasset_trust_op_completed_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stellar_currencyasset_trust_op_completed_id_seq OWNED BY public.stellar_currencyasset_trust_op_completed.id;


--
-- Name: stellar_wallet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stellar_wallet (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    public_key text,
    secret text,
    user_id integer NOT NULL
);


ALTER TABLE public.stellar_wallet OWNER TO postgres;

--
-- Name: stellar_wallet_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stellar_wallet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stellar_wallet_id_seq OWNER TO postgres;

--
-- Name: stellar_wallet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stellar_wallet_id_seq OWNED BY public.stellar_wallet.id;


--
-- Name: users_fiscalresidence; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_fiscalresidence (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    street_address character varying(200),
    city character varying(100),
    postal_code character varying(10),
    state character varying(100),
    country character varying(2),
    user_id integer NOT NULL
);


ALTER TABLE public.users_fiscalresidence OWNER TO postgres;

--
-- Name: users_fiscalresidence_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_fiscalresidence_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_fiscalresidence_id_seq OWNER TO postgres;

--
-- Name: users_fiscalresidence_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_fiscalresidence_id_seq OWNED BY public.users_fiscalresidence.id;


--
-- Name: users_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    email character varying(254) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(150) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    restore_password_code character varying(256),
    restore_password_code_requested_at timestamp with time zone,
    is_email_verified boolean NOT NULL,
    verification_code character varying(256),
    newsletter boolean NOT NULL,
    two_factor boolean NOT NULL,
    two_factor_code character varying(10),
    two_factor_code_created timestamp with time zone,
    phone character varying(30),
    birthday date,
    id_document_image_back character varying(100),
    id_document_image_front character varying(100),
    id_document_image_me character varying(100),
    id_document_number character varying(50),
    id_document_type character varying(10),
    nationality character varying(2),
    status character varying(32) NOT NULL,
    is_blocked boolean NOT NULL,
    is_canceled boolean NOT NULL,
    deleted_date timestamp with time zone,
    is_deleted boolean NOT NULL,
    type character varying(32) NOT NULL,
    marital_status character varying(10),
    profession character varying(150),
    cod character varying(30)
);


ALTER TABLE public.users_user OWNER TO postgres;

--
-- Name: users_user_favorited_companies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_user_favorited_companies (
    id integer NOT NULL,
    user_id integer NOT NULL,
    company_id integer NOT NULL
);


ALTER TABLE public.users_user_favorited_companies OWNER TO postgres;

--
-- Name: users_user_favorited_companies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_favorited_companies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_favorited_companies_id_seq OWNER TO postgres;

--
-- Name: users_user_favorited_companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_favorited_companies_id_seq OWNED BY public.users_user_favorited_companies.id;


--
-- Name: users_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.users_user_groups OWNER TO postgres;

--
-- Name: users_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_groups_id_seq OWNER TO postgres;

--
-- Name: users_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_groups_id_seq OWNED BY public.users_user_groups.id;


--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users_user.id;


--
-- Name: users_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.users_user_user_permissions OWNER TO postgres;

--
-- Name: users_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: users_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_user_permissions_id_seq OWNED BY public.users_user_user_permissions.id;


--
-- Name: votes_vote; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.votes_vote (
    id integer NOT NULL,
    vote character varying(12),
    created timestamp with time zone NOT NULL,
    agenda_item_id integer,
    stellar_transaction_hash text,
    cod character varying(255),
    content_type_id integer,
    object_id integer,
    CONSTRAINT votes_vote_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE public.votes_vote OWNER TO postgres;

--
-- Name: votes_vote_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.votes_vote_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.votes_vote_id_seq OWNER TO postgres;

--
-- Name: votes_vote_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.votes_vote_id_seq OWNED BY public.votes_vote.id;


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
-- Name: capital_increases_capitalincrease id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.capital_increases_capitalincrease ALTER COLUMN id SET DEFAULT nextval('public.capital_increases_capitalincrease_id_seq'::regclass);


--
-- Name: companies_category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies_category ALTER COLUMN id SET DEFAULT nextval('public.companies_category_id_seq'::regclass);


--
-- Name: companies_company id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies_company ALTER COLUMN id SET DEFAULT nextval('public.companies_company_id_seq'::regclass);


--
-- Name: companies_company_investors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies_company_investors ALTER COLUMN id SET DEFAULT nextval('public.companies_company_investors_id_seq'::regclass);


--
-- Name: conversations_contact id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations_contact ALTER COLUMN id SET DEFAULT nextval('public.conversations_contact_id_seq'::regclass);


--
-- Name: conversations_conversation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations_conversation ALTER COLUMN id SET DEFAULT nextval('public.conversations_conversation_id_seq'::regclass);


--
-- Name: conversations_conversation_documents id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations_conversation_documents ALTER COLUMN id SET DEFAULT nextval('public.conversations_conversation_documents_id_seq'::regclass);


--
-- Name: conversations_conversation_partners id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations_conversation_partners ALTER COLUMN id SET DEFAULT nextval('public.conversations_conversation_partners_id_seq'::regclass);


--
-- Name: conversations_conversationhistory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations_conversationhistory ALTER COLUMN id SET DEFAULT nextval('public.conversations_conversationhistory_id_seq'::regclass);


--
-- Name: conversations_message id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations_message ALTER COLUMN id SET DEFAULT nextval('public.conversations_message_id_seq'::regclass);


--
-- Name: conversations_message_documents id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations_message_documents ALTER COLUMN id SET DEFAULT nextval('public.conversations_message_documents_id_seq'::regclass);


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
-- Name: django_site id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_site ALTER COLUMN id SET DEFAULT nextval('public.django_site_id_seq'::regclass);


--
-- Name: documents_document id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents_document ALTER COLUMN id SET DEFAULT nextval('public.documents_document_id_seq'::regclass);


--
-- Name: documents_document_related_users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents_document_related_users ALTER COLUMN id SET DEFAULT nextval('public.documents_document_related_users_id_seq'::regclass);


--
-- Name: documents_historydocument id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents_historydocument ALTER COLUMN id SET DEFAULT nextval('public.documents_historydocument_id_seq'::regclass);


--
-- Name: documents_useractiondetail id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents_useractiondetail ALTER COLUMN id SET DEFAULT nextval('public.documents_useractiondetail_id_seq'::regclass);


--
-- Name: documents_usersessionlog id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents_usersessionlog ALTER COLUMN id SET DEFAULT nextval('public.documents_usersessionlog_id_seq'::regclass);


--
-- Name: mangopay_basemangopaytransaction id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mangopay_basemangopaytransaction ALTER COLUMN id SET DEFAULT nextval('public.mangopay_basemangopaytransaction_id_seq'::regclass);


--
-- Name: mangopay_mangopaybankaccount id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mangopay_mangopaybankaccount ALTER COLUMN id SET DEFAULT nextval('public.mangopay_mangopaybankaccount_id_seq'::regclass);


--
-- Name: mangopay_mangopaykycdocument id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mangopay_mangopaykycdocument ALTER COLUMN id SET DEFAULT nextval('public.mangopay_mangopaykycdocument_id_seq'::regclass);


--
-- Name: mangopay_mangopayuser id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mangopay_mangopayuser ALTER COLUMN id SET DEFAULT nextval('public.mangopay_mangopayuser_id_seq'::regclass);


--
-- Name: mangopay_mangopaywallet id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mangopay_mangopaywallet ALTER COLUMN id SET DEFAULT nextval('public.mangopay_mangopaywallet_id_seq'::regclass);


--
-- Name: meetings_agendaitem id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meetings_agendaitem ALTER COLUMN id SET DEFAULT nextval('public.meetings_agendaitem_id_seq'::regclass);


--
-- Name: meetings_document id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meetings_document ALTER COLUMN id SET DEFAULT nextval('public.meetings_document_id_seq'::regclass);


--
-- Name: meetings_historymeetingsdocument id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meetings_historymeetingsdocument ALTER COLUMN id SET DEFAULT nextval('public.meetings_historymeetingsdocument_id_seq'::regclass);


--
-- Name: meetings_meeting id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meetings_meeting ALTER COLUMN id SET DEFAULT nextval('public.meetings_meeting_id_seq'::regclass);


--
-- Name: meetings_participant id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meetings_participant ALTER COLUMN id SET DEFAULT nextval('public.meetings_participant_id_seq'::regclass);


--
-- Name: oauth2_provider_accesstoken id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_provider_accesstoken ALTER COLUMN id SET DEFAULT nextval('public.oauth2_provider_accesstoken_id_seq'::regclass);


--
-- Name: oauth2_provider_application id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_provider_application ALTER COLUMN id SET DEFAULT nextval('public.oauth2_provider_application_id_seq'::regclass);


--
-- Name: oauth2_provider_grant id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_provider_grant ALTER COLUMN id SET DEFAULT nextval('public.oauth2_provider_grant_id_seq'::regclass);


--
-- Name: oauth2_provider_idtoken id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_provider_idtoken ALTER COLUMN id SET DEFAULT nextval('public.oauth2_provider_idtoken_id_seq'::regclass);


--
-- Name: oauth2_provider_refreshtoken id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_provider_refreshtoken ALTER COLUMN id SET DEFAULT nextval('public.oauth2_provider_refreshtoken_id_seq'::regclass);


--
-- Name: offers_document id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers_document ALTER COLUMN id SET DEFAULT nextval('public.offers_document_id_seq'::regclass);


--
-- Name: offers_historyoffersdocument id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers_historyoffersdocument ALTER COLUMN id SET DEFAULT nextval('public.offers_historyoffersdocument_id_seq'::regclass);


--
-- Name: offers_offer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers_offer ALTER COLUMN id SET DEFAULT nextval('public.offers_offer_id_seq'::regclass);


--
-- Name: offers_proposal id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers_proposal ALTER COLUMN id SET DEFAULT nextval('public.offers_proposal_id_seq'::regclass);


--
-- Name: operations_operation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operations_operation ALTER COLUMN id SET DEFAULT nextval('public.operations_operation_id_seq'::regclass);


--
-- Name: options_option id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.options_option ALTER COLUMN id SET DEFAULT nextval('public.options_option_id_seq'::regclass);


--
-- Name: options_useroption id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.options_useroption ALTER COLUMN id SET DEFAULT nextval('public.options_useroption_id_seq'::regclass);


--
-- Name: partners_partner id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partners_partner ALTER COLUMN id SET DEFAULT nextval('public.partners_partner_id_seq'::regclass);


--
-- Name: payments_payment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments_payment ALTER COLUMN id SET DEFAULT nextval('public.payments_payment_id_seq'::regclass);


--
-- Name: snitch_event id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.snitch_event ALTER COLUMN id SET DEFAULT nextval('public.snitch_event_id_seq'::regclass);


--
-- Name: snitch_eventtype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.snitch_eventtype ALTER COLUMN id SET DEFAULT nextval('public.snitch_eventtype_id_seq'::regclass);


--
-- Name: snitch_notification id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.snitch_notification ALTER COLUMN id SET DEFAULT nextval('public.snitch_notification_id_seq'::regclass);


--
-- Name: social_auth_association id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.social_auth_association ALTER COLUMN id SET DEFAULT nextval('public.social_auth_association_id_seq'::regclass);


--
-- Name: social_auth_code id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.social_auth_code ALTER COLUMN id SET DEFAULT nextval('public.social_auth_code_id_seq'::regclass);


--
-- Name: social_auth_nonce id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.social_auth_nonce ALTER COLUMN id SET DEFAULT nextval('public.social_auth_nonce_id_seq'::regclass);


--
-- Name: social_auth_partial id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.social_auth_partial ALTER COLUMN id SET DEFAULT nextval('public.social_auth_partial_id_seq'::regclass);


--
-- Name: social_auth_usersocialauth id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.social_auth_usersocialauth ALTER COLUMN id SET DEFAULT nextval('public.social_auth_usersocialauth_id_seq'::regclass);


--
-- Name: stellar_asset id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stellar_asset ALTER COLUMN id SET DEFAULT nextval('public.stellar_asset_id_seq'::regclass);


--
-- Name: stellar_asset_trust_op_completed id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stellar_asset_trust_op_completed ALTER COLUMN id SET DEFAULT nextval('public.stellar_asset_trust_op_completed_id_seq'::regclass);


--
-- Name: stellar_currencyasset id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stellar_currencyasset ALTER COLUMN id SET DEFAULT nextval('public.stellar_currencyasset_id_seq'::regclass);


--
-- Name: stellar_currencyasset_trust_op_completed id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stellar_currencyasset_trust_op_completed ALTER COLUMN id SET DEFAULT nextval('public.stellar_currencyasset_trust_op_completed_id_seq'::regclass);


--
-- Name: stellar_wallet id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stellar_wallet ALTER COLUMN id SET DEFAULT nextval('public.stellar_wallet_id_seq'::regclass);


--
-- Name: users_fiscalresidence id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_fiscalresidence ALTER COLUMN id SET DEFAULT nextval('public.users_fiscalresidence_id_seq'::regclass);


--
-- Name: users_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user ALTER COLUMN id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Name: users_user_favorited_companies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_favorited_companies ALTER COLUMN id SET DEFAULT nextval('public.users_user_favorited_companies_id_seq'::regclass);


--
-- Name: users_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_groups ALTER COLUMN id SET DEFAULT nextval('public.users_user_groups_id_seq'::regclass);


--
-- Name: users_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.users_user_user_permissions_id_seq'::regclass);


--
-- Name: votes_vote id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes_vote ALTER COLUMN id SET DEFAULT nextval('public.votes_vote_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add permission	1	add_permission
2	Can change permission	1	change_permission
3	Can delete permission	1	delete_permission
4	Can view permission	1	view_permission
5	Can add group	2	add_group
6	Can change group	2	change_group
7	Can delete group	2	delete_group
8	Can view group	2	view_group
9	Can add content type	3	add_contenttype
10	Can change content type	3	change_contenttype
11	Can delete content type	3	delete_contenttype
12	Can view content type	3	view_contenttype
13	Can add session	4	add_session
14	Can change session	4	change_session
15	Can delete session	4	delete_session
16	Can view session	4	view_session
17	Can add site	5	add_site
18	Can change site	5	change_site
19	Can delete site	5	delete_site
20	Can view site	5	view_site
21	Can add log entry	6	add_logentry
22	Can change log entry	6	change_logentry
23	Can delete log entry	6	delete_logentry
24	Can view log entry	6	view_logentry
25	Can add user	7	add_user
26	Can change user	7	change_user
27	Can delete user	7	delete_user
28	Can view user	7	view_user
29	Can add fiscal residence	8	add_fiscalresidence
30	Can change fiscal residence	8	change_fiscalresidence
31	Can delete fiscal residence	8	delete_fiscalresidence
32	Can view fiscal residence	8	view_fiscalresidence
33	Can add company	9	add_company
34	Can change company	9	change_company
35	Can delete company	9	delete_company
36	Can view company	9	view_company
37	Can add document	10	add_document
38	Can change document	10	change_document
39	Can delete document	10	delete_document
40	Can view document	10	view_document
41	Can add wallet	11	add_wallet
42	Can change wallet	11	change_wallet
43	Can delete wallet	11	delete_wallet
44	Can view wallet	11	view_wallet
45	Can add asset	12	add_asset
46	Can change asset	12	change_asset
47	Can delete asset	12	delete_asset
48	Can view asset	12	view_asset
49	Can add currency asset	13	add_currencyasset
50	Can change currency asset	13	change_currencyasset
51	Can delete currency asset	13	delete_currencyasset
52	Can view currency asset	13	view_currencyasset
53	Can add partner	14	add_partner
54	Can change partner	14	change_partner
55	Can delete partner	14	delete_partner
56	Can view partner	14	view_partner
57	Can add meeting	15	add_meeting
58	Can change meeting	15	change_meeting
59	Can delete meeting	15	delete_meeting
60	Can view meeting	15	view_meeting
61	Can add agenda item	16	add_agendaitem
62	Can change agenda item	16	change_agendaitem
63	Can delete agenda item	16	delete_agendaitem
64	Can view agenda item	16	view_agendaitem
65	Can add document	17	add_document
66	Can change document	17	change_document
67	Can delete document	17	delete_document
68	Can view document	17	view_document
69	Can add participant	18	add_participant
70	Can change participant	18	change_participant
71	Can delete participant	18	delete_participant
72	Can view participant	18	view_participant
73	Can add vote	19	add_vote
74	Can change vote	19	change_vote
75	Can delete vote	19	delete_vote
76	Can view vote	19	view_vote
77	Can add operation	20	add_operation
78	Can change operation	20	change_operation
79	Can delete operation	20	delete_operation
80	Can view operation	20	view_operation
81	Can add conversation	21	add_conversation
82	Can change conversation	21	change_conversation
83	Can delete conversation	21	delete_conversation
84	Can view conversation	21	view_conversation
85	Can add message	22	add_message
86	Can change message	22	change_message
87	Can delete message	22	delete_message
88	Can view message	22	view_message
89	Can add offer	23	add_offer
90	Can change offer	23	change_offer
91	Can delete offer	23	delete_offer
92	Can view offer	23	view_offer
93	Can add proposal	24	add_proposal
94	Can change proposal	24	change_proposal
95	Can delete proposal	24	delete_proposal
96	Can view proposal	24	view_proposal
97	Can add proposal document	25	add_document
98	Can change proposal document	25	change_document
99	Can delete proposal document	25	delete_document
100	Can view proposal document	25	view_document
101	Can add capital increase	26	add_capitalincrease
102	Can change capital increase	26	change_capitalincrease
103	Can delete capital increase	26	delete_capitalincrease
104	Can view capital increase	26	view_capitalincrease
105	Can add mangopay user	27	add_mangopayuser
106	Can change mangopay user	27	change_mangopayuser
107	Can delete mangopay user	27	delete_mangopayuser
108	Can view mangopay user	27	view_mangopayuser
109	Can add Mangopay KYC Document	28	add_mangopaykycdocument
110	Can change Mangopay KYC Document	28	change_mangopaykycdocument
111	Can delete Mangopay KYC Document	28	delete_mangopaykycdocument
112	Can view Mangopay KYC Document	28	view_mangopaykycdocument
113	Can add mangopay wallet	29	add_mangopaywallet
114	Can change mangopay wallet	29	change_mangopaywallet
115	Can delete mangopay wallet	29	delete_mangopaywallet
116	Can view mangopay wallet	29	view_mangopaywallet
117	Can add Mangopay Transfers	30	add_mangopaytransfer
118	Can change Mangopay Transfers	30	change_mangopaytransfer
119	Can delete Mangopay Transfers	30	delete_mangopaytransfer
120	Can view Mangopay Transfers	30	view_mangopaytransfer
121	Can add base mangopay transaction	31	add_basemangopaytransaction
122	Can change base mangopay transaction	31	change_basemangopaytransaction
123	Can delete base mangopay transaction	31	delete_basemangopaytransaction
124	Can view base mangopay transaction	31	view_basemangopaytransaction
125	Can add Mangopay Deposit	32	add_mangopaydeposit
126	Can change Mangopay Deposit	32	change_mangopaydeposit
127	Can delete Mangopay Deposit	32	delete_mangopaydeposit
128	Can view Mangopay Deposit	32	view_mangopaydeposit
129	Can add Mangopay bank account	33	add_mangopaybankaccount
130	Can change Mangopay bank account	33	change_mangopaybankaccount
131	Can delete Mangopay bank account	33	delete_mangopaybankaccount
132	Can view Mangopay bank account	33	view_mangopaybankaccount
133	Can add Mangopay Bankwire Deposit	34	add_mangopaybankwiredeposit
134	Can change Mangopay Bankwire Deposit	34	change_mangopaybankwiredeposit
135	Can delete Mangopay Bankwire Deposit	34	delete_mangopaybankwiredeposit
136	Can view Mangopay Bankwire Deposit	34	view_mangopaybankwiredeposit
137	Can add payment	35	add_payment
138	Can change payment	35	change_payment
139	Can delete payment	35	delete_payment
140	Can view payment	35	view_payment
141	Can add currency	36	add_currency
142	Can change currency	36	change_currency
143	Can delete currency	36	delete_currency
144	Can view currency	36	view_currency
145	Can add Token	37	add_token
146	Can change Token	37	change_token
147	Can delete Token	37	delete_token
148	Can view Token	37	view_token
149	Can add token	38	add_tokenproxy
150	Can change token	38	change_tokenproxy
151	Can delete token	38	delete_tokenproxy
152	Can view token	38	view_tokenproxy
153	Can add option	39	add_option
154	Can change option	39	change_option
155	Can delete option	39	delete_option
156	Can view option	39	view_option
157	Can add user option	40	add_useroption
158	Can change user option	40	change_useroption
159	Can delete user option	40	delete_useroption
160	Can view user option	40	view_useroption
161	Can add event type	41	add_eventtype
162	Can change event type	41	change_eventtype
163	Can delete event type	41	delete_eventtype
164	Can view event type	41	view_eventtype
165	Can add event	42	add_event
166	Can change event	42	change_event
167	Can delete event	42	delete_event
168	Can view event	42	view_event
169	Can add notification	43	add_notification
170	Can change notification	43	change_notification
171	Can delete notification	43	delete_notification
172	Can view notification	43	view_notification
173	Can add application	44	add_application
174	Can change application	44	change_application
175	Can delete application	44	delete_application
176	Can view application	44	view_application
177	Can add access token	45	add_accesstoken
178	Can change access token	45	change_accesstoken
179	Can delete access token	45	delete_accesstoken
180	Can view access token	45	view_accesstoken
181	Can add grant	46	add_grant
182	Can change grant	46	change_grant
183	Can delete grant	46	delete_grant
184	Can view grant	46	view_grant
185	Can add refresh token	47	add_refreshtoken
186	Can change refresh token	47	change_refreshtoken
187	Can delete refresh token	47	delete_refreshtoken
188	Can view refresh token	47	view_refreshtoken
189	Can add id token	48	add_idtoken
190	Can change id token	48	change_idtoken
191	Can delete id token	48	delete_idtoken
192	Can view id token	48	view_idtoken
193	Can add association	49	add_association
194	Can change association	49	change_association
195	Can delete association	49	delete_association
196	Can view association	49	view_association
197	Can add code	50	add_code
198	Can change code	50	change_code
199	Can delete code	50	delete_code
200	Can view code	50	view_code
201	Can add nonce	51	add_nonce
202	Can change nonce	51	change_nonce
203	Can delete nonce	51	delete_nonce
204	Can view nonce	51	view_nonce
205	Can add user social auth	52	add_usersocialauth
206	Can change user social auth	52	change_usersocialauth
207	Can delete user social auth	52	delete_usersocialauth
208	Can view user social auth	52	view_usersocialauth
209	Can add partial	53	add_partial
210	Can change partial	53	change_partial
211	Can delete partial	53	delete_partial
212	Can view partial	53	view_partial
213	Can add multi factor auth	54	add_multifactorauth
214	Can change multi factor auth	54	change_multifactorauth
215	Can delete multi factor auth	54	delete_multifactorauth
216	Can view multi factor auth	54	view_multifactorauth
217	Can add category	55	add_category
218	Can change category	55	change_category
219	Can delete category	55	delete_category
220	Can view category	55	view_category
221	Can add history document	56	add_historydocument
222	Can change history document	56	change_historydocument
223	Can delete history document	56	delete_historydocument
224	Can view history document	56	view_historydocument
225	Can add user session log	57	add_usersessionlog
226	Can change user session log	57	change_usersessionlog
227	Can delete user session log	57	delete_usersessionlog
228	Can view user session log	57	view_usersessionlog
229	Can add user action detail	58	add_useractiondetail
230	Can change user action detail	58	change_useractiondetail
231	Can delete user action detail	58	delete_useractiondetail
232	Can view user action detail	58	view_useractiondetail
233	Can add contact	59	add_contact
234	Can change contact	59	change_contact
235	Can delete contact	59	delete_contact
236	Can view contact	59	view_contact
237	Can add conversation history	60	add_conversationhistory
238	Can change conversation history	60	change_conversationhistory
239	Can delete conversation history	60	delete_conversationhistory
240	Can view conversation history	60	view_conversationhistory
241	Can add history meetings document	61	add_historymeetingsdocument
242	Can change history meetings document	61	change_historymeetingsdocument
243	Can delete history meetings document	61	delete_historymeetingsdocument
244	Can view history meetings document	61	view_historymeetingsdocument
245	Can add history offers document	62	add_historyoffersdocument
246	Can change history offers document	62	change_historyoffersdocument
247	Can delete history offers document	62	delete_historyoffersdocument
248	Can view history offers document	62	view_historyoffersdocument
\.


--
-- Data for Name: authtoken_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authtoken_token (key, created, user_id) FROM stdin;
\.


--
-- Data for Name: capital_increases_capitalincrease; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.capital_increases_capitalincrease (id, created, modified, max_shares, min_shares, deadline, amount_per_share, state, company_id, issue_premium, new_share_capital) FROM stdin;
3	2023-05-09 11:48:58.906137+00	2023-05-09 11:48:58.906137+00	500	500	2023-06-30	1.00	pending	13	99.00	\N
12	2023-11-03 15:33:50.306402+00	2023-11-11 11:10:31.456957+00	1000	500	2023-12-31	1.00	pending	4	1.00	4000.00
13	2023-11-14 21:36:44.40789+00	2023-11-14 21:36:44.40789+00	2000	1	2025-10-10	1.00	pending	4	1.00	\N
\.


--
-- Data for Name: companies_category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.companies_category (id, name) FROM stdin;
1	Juego
2	Tecnología
3	Real Estate
4	Energías Renovables
5	Startups
6	Plataformas
7	Otras
9	Capital Riesgo
\.


--
-- Data for Name: companies_company; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.companies_company (id, created, modified, social_denomination, cif, constitution_date, street_address, city, postal_code, state, country, logo, description, registration_data, governing_bodies, shares, share_capital, par_value_per_share, status, published, slug, right_conditions, right_conditions_days, stocken_invests, code, legal_representative_id, governing_bodies_legal_representative_full_name, governing_bodies_legal_representative_position, governing_bodies_legal_representative_powers_date, governing_bodies_notary_city, governing_bodies_notary_full_name, governing_bodies_notary_number, registration_data_date, registration_data_inscription_date, registration_data_inscription_number, registration_data_notary_city, registration_data_notary_full_name, registration_data_notary_number, registration_data_number, registration_data_page_number, registration_data_sheet_number, registration_data_state, registration_data_volume_number, automation_corporate_management, capture_private_financing, management_transparency, otra, otra_description, categories_id, cod, mangopay_id, investor) FROM stdin;
8	2022-09-27 11:16:40.864473+00	2023-09-17 22:06:23.498586+00	Twoforall International Investment, S.L.	B09952383	2022-04-11	Calle Fuencarral 133, 4D	MADRID	28010	Madrid	ES	logos/c13ca754120da6c64fbb561677eb8b88cd2366c27adb84d6bff3932ef5e66945.png	Empresa de Tokenización de Activos Inmobiliarios			5000	5000.00	1.00	validated	t	twoforall-international-investment-sl	f	\N	f	twof	26	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f		3	pj_8	\N	f
2	2022-08-09 14:57:20.344724+00	2023-09-02 22:40:49.706183+00	Equilibre Consulting SL	B06854442	2021-06-02	Carrer Anibal, 5	Eivissa	07800	Eivissa	ES	logos/e67d1f467ae2e8125b39c311d928c12821d818594485f540f26323b9e790580e.png	Equilibre Consulting es una empresa que está desarrollado un proyecto de ocio nocturo utilizando tecnología blockchain.			3000	3000.00	1.00	validated	f	equilibre-consulting-sl	f	\N	f	EQC1	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	\N	\N	pj_2	\N	f
7	2022-08-09 18:13:53.920326+00	2023-09-17 22:06:37.606898+00	Tierra Audio SL	B88145941	2018-06-29	C/ Aguila Real, 29	Batres	28976	Madrid	ES	logos/276fe73296905e1c37125fe34b463834d773830d244794a4935bc354302943b6.png	En Junio de 2018, tras varios años de investigación y desarrollo, fundamos TIERRA Audio en Madrid, España, con el firme propósito de proporcionar a los artistas, productores e ingenieros de sonido de todo el mundo productos de ProAudio de gama premium y precio asequible.\r\n\r\nNuestros productos son piezas únicas hechas a mano. Son el resultado de años de investigación y desarrollo, reuniones de ingeniería, prototipos y noches sin dormir.\r\n\r\nAbsolutamente todos los componentes con los que están construidos nuestros productos han sido seleccionados para garantizar las mejores prestaciones de funcionamiento y la máxima durabilidad. Nos tomamos muy en serio el diseño técnico y estético de nuestros productos. También nuestro compromiso con el medio ambiente. Por eso, desde el diseño de las placas electrónicas hasta el embalaje final, cuidamos con mimo cada detalle con el firme propósito de ofrecerte una calidad sonora incuestionable junto a la mejor experiencia de usuario y unos acabados premium que sean ecológicamente responsables.\r\n\r\nSomos unos enamorados del sonido analógico, de su pureza y de su capacidad única para lograr mezclas increíbles. Hemos dedicado grandes esfuerzos técnicos y humanos para diseñar y lograr un sonido 100% analógico con personalidad propia que sea reconocible en todos y cada uno de nuestros dispositivos. Un sonido avalado por grandes profesionales en todo el mundo. Un sonido que enriquezca e impulse tus producciones hacia al más alto nivel dentro de la industria.\r\n\r\nDesde el comienzo, hemos asumido la búsqueda de la identidad sonora de nuestros productos no solo como un objetivo cualitativo desde el punto de vista de la amplitud del rango dinámico (SNR), situándonos a la vanguardia del sector, sino proponiendo también una evolución técnico-artística necesaria dentro del mundo del ProAudio.			4100000	41000.00	0.01	validated	f	tierra-audio-sl	f	\N	f	TIAU	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f		7	pj_7	\N	f
5	2022-08-09 17:55:47.381006+00	2023-11-12 02:08:53.956665+00	Big Election SL	B87924833	2017-10-04	C/ Nuñez De Balboa, 114	Madrid	28001	Madrid	ES	logos/14c29e61370adeba3407720f586fef3e70c16fcc8ef08d76facd023d45f2a416.png	Empresa relacionada con el comercio exterior, exportación e importación de materiales ocupándose de la logística, aspectos legales, políticas arancelarias y seguros internacionales.			3000	3000.00	1.00	validated	t	big-election-sl	f	\N	f	BIG1	196	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f		6	pj_5	\N	f
6	2022-08-09 18:06:02.872312+00	2023-09-17 22:06:46.515293+00	Barbatus Aeronautics SL	B04963518	2021-03-16	Pque Tecnologico Walqa	Cuarte	22002	Huesca	ES	logos/87ed710feeb35ff236bdd3ada9fd8639f2add6e3cd50050d2bccde33b0d04834.png	Empresa dedicada a la Consultoría y Educación Aeronáutica.			600	3000.00	5.00	validated	t	barbatus-aeronautics-sl	f	\N	f	BAER	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f		7	pj_6	\N	f
3	2022-08-09 17:44:51.95993+00	2023-09-17 22:07:23.01991+00	CLADDING AND FLOORS SL	B67719773	2021-11-04	Calle Tutor 43	Madrid	28008	Madrid	ES	logos/39136b7bf8ddf14ff5e3368b3a100963ed1f76e3f9904e8e6686fa30cd87e182.webp	Cladding & Floors es una herramienta para conocer con un solo click desde nuestro calculador online, los precios de los sistemas de fachadas ventiladas y Suelos Técnicos registrables.			3000	3000.00	1.00	validated	t	cladding-and-floors-sl	f	\N	f	CAF1	9	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f		6	pj_3	\N	f
1	2022-08-09 14:52:22.618529+00	2023-09-17 22:07:42.442286+00	White Bear Trading SL	B87727038	2017-01-10	Calle Gascones, 13	Madrid	28035	Madrid	ES	logos/14cf7054739be6d60799866b0a251bb150354812e3846870f8ef7c78263108d5.png	White Bear Trading es una empresa de distribución de productos FMCG.			103000	103000.00	1.00	validated	t	white-bear-trading-sl	f	\N	f	WBT1	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f		6	pj_1	\N	f
4	2022-08-09 17:50:25.9039+00	2023-10-31 09:53:13.554687+00	Block Impulse SL	B88157573	2018-07-05	C/ Francisco Valles 8 - Parque Tecnologico De Boecillo	Boecillo	47151	Valladolid	ES	logos/2e6cdda8a315107a22ff36be50977278fef91257b79fd889168554dee00a5507.png	Empresa de consultoría, formación y desarrollo de soluciones basadas en tecnología blockchain para el sector empresarial e industrial desde el 2018.			3000	3000.00	1.00	validated	t	block-impulse-sl	f	\N	f	BI1	23	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f		2	pj_4	\N	f
10	2022-10-14 10:42:22.619982+00	2023-09-17 22:05:09.776811+00	SERSEO INBOUND MARKETING SL	B39847330	2017-03-07	Hernan Cortes 31 - 2	Santander	39003	Cantabria	ES	logos/908b02fbbc99dff57521f35639abcd010c8481abd9e13138426abb20e68a5e51.png	SERSEO Marketing Digital, es la primera red de agencias de  marketing digital orientada a pequeñas empresas.\r\n \r\nPioneros en los servicios de marketing digital LowCost para pymes, buscamos la eficiencia en todos nuestros métodos usando la transformación digital en toda la organización, haciendo que los costes finales se reduzcan y permitan a cualquier empresa conseguir beneficiarse de técnicas profesionales a un precio justo.\r\n\r\nGarantizamos a nuestros clientes “Más Clientes y Más Ventas” a partir de 30/60 días	SERSEO INBOUND MARKETING SL, con domicilio en HERNAN CORTES 31 2º, CIF/NIF núm. B39847330 e inscrita en: REGISTRO MERCANTIL DE CANTABRIA, con los siguientes datos: Tomo 1153 INSCRIPCION 1ª Folio 26 HOJA S31640.		100	3000.00	30.00	validated	t	serseo-inbound-marketing-sl	f	\N	f	sers	39	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f		2	pj_10	\N	f
26	2023-10-05 11:30:19.828356+00	2023-10-05 11:30:19.92628+00	Otro Enfoque	B-70251954	\N	Rosalia de Castro nº1 piso 2ºH,	Cambre	15679	La Coruña	ES	logos/a96864a0ec42bfeebe4d106426d1d28519513a4b70e8c4440b543d44e1bb6306.jpg	Somos una empresa que apuesta por la investigación y el desarrollo con perspectivas innovadoras, sus creadores tienen una patente y en este momento estamos desarrollandola.	\N	\N	\N	\N	\N	in_validation	f	otro-enfoque	f	\N	f	\N	273	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	t	f		2	pj_26	\N	f
14	2023-04-26 15:08:39.772175+00	2023-09-17 22:04:16.730573+00	MENTORIA DEL HOGAR, SL	B44917516	2023-03-23	CALLE REAL Nº 55, BAJO C	LAS ROZAS DE MADRID (MADRID)	28231	Madrid	ES	logos/34bd2aa6f81c1cebf31c178fb24e81ed8ea8c222ec5e5a55cd2bfaa8ab69f320.jpeg	En Mentoria del Hogar hemos creado y patentado las persianas enrollables solares que van a evolucionar el panorama de autoconsumo de todos los hogares con ventanas.		Administrador Único	1000000	10000.00	0.01	validated	t	mentoria-del-hogar-sl	t	15	f	MENT	84	David Julio Estrella Sánchez	Administrador Único	2023-03-23	Madrid	Ignacio Gil-Antuñano Vizcaíno	1418	2023-03-30	2023-03-30	1	MADRID	Ignacio Gil-Antuñano Vizcaíno	1418	\N	200	M-791440	Madrid	44959	f	f	f	f		6	pj_14	\N	f
13	2023-02-27 10:07:31.898309+00	2023-09-17 22:04:51.897041+00	ESCRITOR TOKENIZADO SL	B44583896	2023-01-18	Paseo de la Castellana 194	Madrid	28046	Madrid	ES	logos/d5d9767f00f823c72af17bcca369d41f61792114bd118d1a59877f9a71c97e97.jpg	Hay una nueva forma de hacer libros y puedes participar.\r\nESCRITOR TOKENIZADO produce series de novelas, en un entorno digital y de forma democrática. Crea un sistema autogestivo en el que cualquiera puede convertirse en socio editor de proyectos literarios globales. Inversores, lectores y fans al mismo modo, participan no solo de las letras, sino también de los números.\r\nRiccardo Braccaioli revoluciona el mercado de la editorial gracias a la tecnología Blockchain. Escritor Tokenizado es uno de los proyecto más ambicioso de autopublicación global y una oportunidad de inversión. Riccardo te brinda la oportunidad de acompañarle en este reto. Participa en el primer proyecto a escala global de un escritor autopublicado en Amazon. Si quieres más información la encontrarás en: www.escritortokenizado.com.		Administrador único	3000	3000.00	1.00	validated	t	escritor-tokenizado-sl	t	15	f	escr	74	Riccardo Braccaioli	Administrador Único	2023-01-23	Madrid	Segismundo Álvarez Royo-Villanova	124	2023-01-23	2023-01-23	1	Madrid	Segismundo Álvarez Royo-Villanova	124	124	169	M-786149	Madrid	44636	f	f	f	f		2	pj_13	\N	f
24	2023-09-06 07:47:08.408252+00	2023-09-17 22:04:56.874503+00	Triac Soluctions	D14546261	\N	Calle uno	Valencia	46008	valencia	ES	logos/d5f55379fea5ff669a8ef8a694bfe3047a1f644a4d206dd88f38666e33455eb7.jpg	Triac Soluctions se destaca como líder en diseño y construcción de proyectos electrónicos de alta tecnología. Fusionamos la innovación con soluciones prácticas, superando las expectativas de nuestros clientes. Con un equipo de expertos en tecnología, transformamos ideas en dispositivos y sistemas electrónicos que moldean el futuro, abarcando desde soluciones para hogares inteligentes hasta sistemas corporativos integrados. En Triac Soluctions, visionamos un futuro más conectado, eficiente y sostenible.			1002	1.00	1.00	validated	f	triac-soluctions	f	\N	f	tria	266	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	f	f	f		2	pj_24	\N	f
28	2023-10-24 21:33:24.481145+00	2023-10-24 21:33:24.632013+00	ARBO & CASTELLVI & REVERTE ECONOMISTES ASSOCIATS SL	B43888825	\N	CALLE DE SANT ISIDRE, 163 - EN 3	LA RAPITA	43540	Tarragona	ES	logos/64bdb146410110794625d630484802b5d7d08868c42470fa57cfebf2240e9466.jpeg	CNAE 6920.\r\n\r\nACTIVIDADES DE CONTABILIDAD, TENEDURÍA DE LIBROS, AUDITORÍA Y ASESORÍA FISCAL.\r\n\r\n    Esta clase comprende:\r\n\r\n \r\n\r\n1.el registro contable de las transacciones comerciales de empresas u otras entidades\r\n2.la preparación o auditoría de cuentas financieras\r\n3.la inspección de cuentas financieras y la certificación de su exactitud\r\n4.la preparación de declaraciones del impuesto sobre la renta de las personas físicas y del impuesto sobre sociedades\r\n5.las actividades de asesoramiento y representación ejercidas ante la administración tributaria en nombre de sus clientes\r\n6.las actividades de servicios de cálculo de aranceles aduaneros y tributarios (Febrero 2017)	\N	\N	\N	\N	\N	in_validation	f	arbo-castellvi-reverte-economistes-associats-sl	f	\N	f	\N	100	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	t	Como inversora	7	pj_28	\N	t
29	2023-11-07 17:15:12.75179+00	2023-11-11 10:55:13.812235+00	Magistralem	42069	\N	Col Los Angeles Frente Estadio Los Angeles	Tegucigalpa	11101	Francisco Morazán	HN	logos/b3ce8d361803078bc7e34edfd644c99838cae3593213c74e0660fb3e3e8b992b.webp	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	\N	\N	\N	\N	\N	in_validation	f	magistralem	f	\N	f	blok	23	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f		7	pj_29	\N	f
30	2023-11-11 07:09:38.337505+00	2023-11-15 14:40:57.155789+00	el cabaler de cal barrina slu	b62742317	\N	rafael casanova,6	sant vicenç dels horts	08620	barcelona	ES	logos/92dd8ab38968d36245ca768ece60ea61116141241005c2d36e4c4ac89116169b.jpeg	empresa patrimonial	\N	\N	\N	\N	\N	in_validation	f	el-cabaler-de-cal-barrina-slu	f	\N	f	wwww	342	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	t	participar como inversor enn un proyecto	3	pj_30	\N	t
\.


--
-- Data for Name: companies_company_investors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.companies_company_investors (id, company_id, user_id) FROM stdin;
\.


--
-- Data for Name: conversations_contact; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conversations_contact (id, name, subject, email, message, created_at) FROM stdin;
\.


--
-- Data for Name: conversations_conversation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conversations_conversation (id, created, subject, body, is_from_company, company_id, creator_id, blockchain_link, blockchain_transaction_id, cod, transaction_hash) FROM stdin;
26	2023-09-19 04:43:45.957838+00	Quiero saber las cuentas del próximo año	Hola, quiero saber que cuentas se manejan de cara al 2024.	f	4	23	https://mumbai.polygonscan.com/tx/0xb2f5e4689a62178f292ffb567ea9075da115990b58a08e5a5cdf9f2de45d86c7	0xb2f5e4689a62178f292ffb567ea9075da115990b58a08e5a5cdf9f2de45d86c7	pf_23	e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
27	2023-09-19 06:21:10.737869+00	Reunión martes inversión stratup	Recordaros que el próximo martes 27 de octubre tenemos una reunión importante en Madrid, de forma presencial a las 11h en la calle López Vázquez 12 - Oficina 2 piso.	f	4	23	https://mumbai.polygonscan.com/tx/0x3cedbfe22a2b1b13a84599d5e982d5ca0d97da67b09d89a46f5979627d87b306	0x3cedbfe22a2b1b13a84599d5e982d5ca0d97da67b09d89a46f5979627d87b306	pj_4	e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
28	2023-10-26 21:11:54.047771+00	Prueba 1	lorem ipsum	f	4	23	https://mumbai.polygonscan.com/tx/0xc46af14ae5b0c32132391df3dc132c40c9e93406a30609c6cd8e45a192702bda	0xc46af14ae5b0c32132391df3dc132c40c9e93406a30609c6cd8e45a192702bda	pf_23	e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
29	2023-11-08 22:05:12.466946+00	Probando dev right now	lorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsum	f	4	82	https://polygonscan.com/tx/0x36fa97449546897b55702f9ba699ef08e4e8779eb04380bc371c783781062796	0x36fa97449546897b55702f9ba699ef08e4e8779eb04380bc371c783781062796	pf_82	e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
25	2023-09-19 04:39:41.964597+00	Quiero recibir informacion de la empresa	Hola, quiero saber las próximas acciones de la empresa durante este 2024.	f	4	28	https://mumbai.polygonscan.com/tx/0x6946450caaff0b02d8715ff45f1db314202326bfced201a5da51875a706ac2b4	0x6946450caaff0b02d8715ff45f1db314202326bfced201a5da51875a706ac2b4	pf_28	e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
\.


--
-- Data for Name: conversations_conversation_documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conversations_conversation_documents (id, conversation_id, document_id) FROM stdin;
\.


--
-- Data for Name: conversations_conversation_partners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conversations_conversation_partners (id, conversation_id, partner_id) FROM stdin;
8	27	16
9	27	15
\.


--
-- Data for Name: conversations_conversationhistory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conversations_conversationhistory (id, created, modified, transaction_hash, conversation_id, creator_id, blockchain_link, blockchain_transaction_id) FROM stdin;
23	2023-09-18 20:00:21.257281+00	2023-09-18 20:00:21.257281+00	6aa59b1f813b80c88b1becc8be65615065882f2574d63ab64ccc80e90faa3a05	\N	23	https://mumbai.polygonscan.com/tx/0x5a30be018ab729d7b84a8371cc89017229ad296ee660ebbea3e5e25574bd245f	0x5a30be018ab729d7b84a8371cc89017229ad296ee660ebbea3e5e25574bd245f
24	2023-09-18 20:02:11.436577+00	2023-09-18 20:02:11.436577+00	66389bdd82dc764564232761798a4a8964c4b6a6b1e3f5a8f794704590aaf778	\N	23	https://mumbai.polygonscan.com/tx/0x0a9d11537b3dc7b5726c56ec85e81278bc385438ef7bccf7ba0728b708743b84	0x0a9d11537b3dc7b5726c56ec85e81278bc385438ef7bccf7ba0728b708743b84
28	2023-09-19 04:39:54.536921+00	2023-09-19 04:39:54.536921+00	e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855	25	28	https://mumbai.polygonscan.com/tx/0x6946450caaff0b02d8715ff45f1db314202326bfced201a5da51875a706ac2b4	0x6946450caaff0b02d8715ff45f1db314202326bfced201a5da51875a706ac2b4
29	2023-09-19 04:43:50.208012+00	2023-09-19 04:43:50.208012+00	e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855	26	23	https://mumbai.polygonscan.com/tx/0xb2f5e4689a62178f292ffb567ea9075da115990b58a08e5a5cdf9f2de45d86c7	0xb2f5e4689a62178f292ffb567ea9075da115990b58a08e5a5cdf9f2de45d86c7
20	2023-09-18 17:29:05.258347+00	2023-09-18 17:29:05.258347+00	e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855	\N	23	https://mumbai.polygonscan.com/tx/0x3e8c336900b86c2dc96f0c9c213d86f3c0077a6600b5bebe0df45cf43ba7f9ac	0x3e8c336900b86c2dc96f0c9c213d86f3c0077a6600b5bebe0df45cf43ba7f9ac
21	2023-09-18 17:36:57.280265+00	2023-09-18 17:36:57.280265+00	e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855	\N	23	https://mumbai.polygonscan.com/tx/0xba5b35a38abbeca6eced212b01340f8f87021b335b51e9635f0e2cf47d8ad184	0xba5b35a38abbeca6eced212b01340f8f87021b335b51e9635f0e2cf47d8ad184
22	2023-09-18 17:37:45.367481+00	2023-09-18 17:37:45.367481+00	e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855	\N	23	https://mumbai.polygonscan.com/tx/0x535a7ade4a6f1615e6d604c8edb0e797e8124c6ce82bb6a7e39d68eea3417df3	0x535a7ade4a6f1615e6d604c8edb0e797e8124c6ce82bb6a7e39d68eea3417df3
25	2023-09-18 20:59:20.448535+00	2023-09-18 20:59:20.448535+00	e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855	\N	13	https://mumbai.polygonscan.com/tx/0x7ed620e75bfd9b8df43c071f1f11bb7f43bd28d235cd671e5cfece13cf92629e	0x7ed620e75bfd9b8df43c071f1f11bb7f43bd28d235cd671e5cfece13cf92629e
26	2023-09-18 21:02:00.271785+00	2023-09-18 21:02:00.271785+00	e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855	\N	23	https://mumbai.polygonscan.com/tx/0xef296e71eff713225248e06a9440190250583f5e17d37d5f8e8614fe0744d17a	0xef296e71eff713225248e06a9440190250583f5e17d37d5f8e8614fe0744d17a
27	2023-09-18 21:13:48.315966+00	2023-09-18 21:13:48.315966+00	e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855	\N	23	https://mumbai.polygonscan.com/tx/0xcf0d2c7ae149910ced0d5d9a4bca9fe37dfa2230ec1258bd7f14bbb202c051ad	0xcf0d2c7ae149910ced0d5d9a4bca9fe37dfa2230ec1258bd7f14bbb202c051ad
30	2023-09-19 06:21:15.279284+00	2023-09-19 06:21:15.279284+00	e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855	27	23	https://mumbai.polygonscan.com/tx/0x3cedbfe22a2b1b13a84599d5e982d5ca0d97da67b09d89a46f5979627d87b306	0x3cedbfe22a2b1b13a84599d5e982d5ca0d97da67b09d89a46f5979627d87b306
31	2023-09-22 16:28:47.38636+00	2023-09-22 16:28:47.38636+00	04c75b2722ffdb73832cc2f4622364089f24154ef4154d870ada69c750bc2229	\N	23	https://mumbai.polygonscan.com/tx/0x6a6eac2dc22d9d00ab04c5afa5e7d8165e63d72e2bdce7a54c84eced00725dee	0x6a6eac2dc22d9d00ab04c5afa5e7d8165e63d72e2bdce7a54c84eced00725dee
32	2023-09-23 10:56:09.32738+00	2023-09-23 10:56:09.32738+00	c33e362a02a1f47452063d62e47d4c40af3ae7db57dfe9ffea1219c015c57cd3	\N	23	https://mumbai.polygonscan.com/tx/0xd852adece1f77ff7ff17481f4138ad9348fec88759c47b8262dda18549f4bffb	0xd852adece1f77ff7ff17481f4138ad9348fec88759c47b8262dda18549f4bffb
33	2023-10-26 21:11:57.322697+00	2023-10-26 21:11:57.322697+00	e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855	28	23	https://mumbai.polygonscan.com/tx/0xc46af14ae5b0c32132391df3dc132c40c9e93406a30609c6cd8e45a192702bda	0xc46af14ae5b0c32132391df3dc132c40c9e93406a30609c6cd8e45a192702bda
34	2023-11-08 22:05:16.259916+00	2023-11-08 22:05:16.259916+00	e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855	29	82	https://polygonscan.com/tx/0x36fa97449546897b55702f9ba699ef08e4e8779eb04380bc371c783781062796	0x36fa97449546897b55702f9ba699ef08e4e8779eb04380bc371c783781062796
\.


--
-- Data for Name: conversations_message; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conversations_message (id, created, body, conversation_id, creator_id, blockchain_link, blockchain_transaction_id, transaction_hash, cod) FROM stdin;
11	2023-09-22 16:28:18.44821+00	Esto es un mensaje de prueba	26	23	https://mumbai.polygonscan.com/tx/0xd852adece1f77ff7ff17481f4138ad9348fec88759c47b8262dda18549f4bffb	0xd852adece1f77ff7ff17481f4138ad9348fec88759c47b8262dda18549f4bffb	c33e362a02a1f47452063d62e47d4c40af3ae7db57dfe9ffea1219c015c57cd3	pj_4
\.


--
-- Data for Name: conversations_message_documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conversations_message_documents (id, message_id, document_id) FROM stdin;
\.


--
-- Data for Name: currencies_currency; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.currencies_currency (code, currency_asset_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2022-07-12 07:08:49.492818+00	1	stockencapital@mecexis.com	2	[{"changed": {"fields": ["Email", "First name", "Last name"]}}]	7	1
2	2022-07-21 07:27:25.474433+00	1	stockencapital@mecexis.com	2	[{"changed": {"fields": ["Id document image front"]}}]	7	1
3	2022-08-09 14:41:33.80642+00	9	admin@claddingprices.com	2	[{"changed": {"fields": ["Type", "Status"]}}]	7	1
4	2022-08-09 14:42:24.80498+00	10	r@whitebear.trading	2	[{"changed": {"fields": ["Type", "Status"]}}]	7	1
5	2022-08-09 14:43:43.66113+00	11	david.ramon.riera@gmail.com	2	[{"changed": {"fields": ["Type", "Status"]}}]	7	1
6	2022-08-09 14:46:23.760732+00	12	jflores@email4job.com	2	[{"changed": {"fields": ["Type", "Status"]}}]	7	1
7	2022-08-09 14:49:35.988176+00	13	vcallejo@blockimpulse.com	2	[{"changed": {"fields": ["Type", "Status"]}}]	7	1
8	2022-08-09 14:52:22.806039+00	1	White Bear Trading SL	1	[{"added": {}}]	9	1
9	2022-08-09 14:53:26.2508+00	1	MangopayUser object (1)	1	[{"added": {}}]	27	1
10	2022-08-09 14:53:55.044806+00	1	Wallet for r@whitebear.trading	1	[{"added": {}}]	29	1
11	2022-08-09 14:57:20.528784+00	2	Equilibre Consulting SL	1	[{"added": {}}]	9	1
12	2022-08-09 14:57:49.713626+00	2	MangopayUser object (2)	1	[{"added": {}}]	27	1
13	2022-08-09 14:58:13.442837+00	2	Wallet for david.ramon.riera@gmail.com	1	[{"added": {}}]	29	1
14	2022-08-09 17:44:52.145817+00	3	CLADDING AND FLOORS SL	1	[{"added": {}}]	9	1
15	2022-08-09 17:46:05.38939+00	3	MangopayUser object (3)	1	[{"added": {}}]	27	1
16	2022-08-09 17:46:31.465265+00	3	Wallet for admin@claddingprices.com	1	[{"added": {}}]	29	1
17	2022-08-09 17:50:26.063338+00	4	Block Impulse SL	1	[{"added": {}}]	9	1
18	2022-08-09 17:51:00.175364+00	4	MangopayUser object (4)	1	[{"added": {}}]	27	1
19	2022-08-09 17:51:26.830879+00	4	Wallet for vcallejo@blockimpulse.com	1	[{"added": {}}]	29	1
20	2022-08-09 17:55:47.503865+00	5	Big Election SL	1	[{"added": {}}]	9	1
21	2022-08-09 17:59:00.141691+00	14	barbatusaeronautics@gmail.com	2	[{"changed": {"fields": ["Type", "Status"]}}]	7	1
22	2022-08-09 18:06:03.020314+00	6	Barbatus Aeronautics SL	1	[{"added": {}}]	9	1
23	2022-08-09 18:06:29.287465+00	5	MangopayUser object (5)	1	[{"added": {}}]	27	1
24	2022-08-09 18:08:22.346382+00	15	javier@tierra.audio	2	[{"changed": {"fields": ["Type", "Status"]}}]	7	1
25	2022-08-09 18:13:54.104015+00	7	Tierra Audio SL	1	[{"added": {}}]	9	1
26	2022-08-09 18:13:59.608165+00	7	Tierra Audio SL	2	[{"changed": {"fields": ["Published"]}}]	9	1
27	2022-08-09 18:14:03.46271+00	6	Barbatus Aeronautics SL	2	[{"changed": {"fields": ["Published"]}}]	9	1
28	2022-08-09 18:14:06.878629+00	5	Big Election SL	2	[]	9	1
29	2022-08-09 18:14:11.530378+00	4	Block Impulse SL	2	[]	9	1
30	2022-08-09 18:14:14.626578+00	3	CLADDING AND FLOORS SL	2	[]	9	1
31	2022-08-30 07:37:41.149808+00	1	Block Impulse SL 6000 2022-11-09	2	[{"changed": {"fields": ["State"]}}]	26	1
32	2022-08-30 07:59:01.528152+00	7	ccallejo@stockencapital.com	2	[{"changed": {"fields": ["Marital status", "Status"]}}]	7	1
33	2022-08-30 08:00:44.422203+00	7	ccallejo@stockencapital.com	2	[]	7	1
34	2022-08-30 09:12:15.224764+00	1	Block Impulse SL 6000 2022-11-09	3		26	1
35	2022-09-26 15:45:55.509373+00	24	acallejo48@gmail.com	2	[{"changed": {"fields": ["Phone number", "Birthday", "Nationality", "Marital status", "Profession", "Id document number", "Id document type", "Id document image front", "Id document image back", "Id document image me", "Status"]}}]	7	1
36	2022-09-27 09:23:14.044773+00	24	acallejo48@gmail.com	2	[{"changed": {"fields": ["Status"]}}]	7	1
37	2022-09-29 10:02:28.595945+00	7	ccallejo@stockencapital.com	3		7	1
38	2022-09-29 10:40:59.961334+00	7	Tierra Audio SL	2	[{"changed": {"fields": ["Published"]}}]	9	1
39	2022-09-30 08:55:59.785916+00	25	test1@mecexis.com	2	[{"changed": {"fields": ["Status"]}}]	7	1
40	2022-09-30 08:56:25.557142+00	25	test1@mecexis.com	2	[{"changed": {"fields": ["Status"]}}]	7	1
41	2022-10-07 10:33:52.571662+00	31	racomo@yahoo.com	1	[{"added": {}}]	7	1
42	2022-10-07 16:30:22.812386+00	32	vila.ma@me.com	2	[{"changed": {"fields": ["Phone number", "Birthday", "Nationality", "Marital status", "Id document number", "Id document type", "Id document image front", "Id document image back", "Id document image me", "Status"]}}]	7	1
43	2022-10-07 16:31:04.865452+00	32	vila.ma@me.com	2	[{"changed": {"fields": ["Newsletter"]}}]	7	1
44	2022-10-07 16:34:10.127021+00	12	MangopayUser object (12)	1	[{"added": {}}]	27	1
45	2022-10-07 16:39:06.158841+00	8	Wallet for vila.ma@me.com	1	[{"added": {}}]	29	1
46	2022-10-17 10:30:08.662886+00	32	vila.ma@me.com	2	[{"changed": {"fields": ["Birthday"]}}]	7	1
47	2023-01-30 17:01:45.542217+00	69	xperiend@gmail.com	2	[{"changed": {"fields": ["First name", "Phone number", "Birthday", "Nationality", "Marital status", "Profession", "Id document number", "Id document type", "Id document image front", "Id document image back", "Id document image me", "Status"]}}]	7	1
48	2023-01-30 17:02:29.929424+00	69	xperiend@gmail.com	2	[]	7	1
49	2023-01-30 17:06:13.374555+00	69	xperiend@gmail.com	2	[{"changed": {"fields": ["Status"]}}]	7	1
50	2023-01-30 17:07:20.665832+00	69	xperiend@gmail.com	2	[{"changed": {"fields": ["Status"]}}]	7	1
51	2023-01-30 17:17:45.577159+00	11	XPERIEND INVESTMENT SL	1	[{"added": {}}]	9	1
52	2023-01-30 17:19:28.767704+00	69	xperiend@gmail.com	2	[{"changed": {"fields": ["Status"]}}]	7	1
53	2023-01-30 17:24:17.082753+00	69	xperiend@gmail.com	2	[{"changed": {"fields": ["Type"]}}]	7	1
54	2023-01-30 17:25:03.632237+00	69	xperiend@gmail.com	2	[{"changed": {"fields": ["Status"]}}]	7	1
55	2023-01-30 17:25:34.121231+00	11	XPERIEND INVESTMENT SL	2	[{"changed": {"fields": ["Status"]}}]	9	1
56	2023-01-30 17:27:24.250071+00	11	XPERIEND INVESTMENT SL	2	[{"changed": {"fields": ["Status"]}}]	9	1
57	2023-01-30 17:30:36.825462+00	70	kallejo+30@gmail.com	2	[{"changed": {"fields": ["Type", "Phone number", "Birthday", "Nationality", "Marital status", "Profession", "Id document number", "Id document type", "Id document image front", "Id document image back", "Id document image me", "Status"]}}]	7	1
58	2023-01-30 17:33:23.073156+00	12	Nike SL	1	[{"added": {}}]	9	1
59	2023-01-30 17:35:30.097524+00	11	XPERIEND INVESTMENT SL	2	[{"changed": {"fields": ["Status"]}}]	9	1
60	2023-01-30 17:36:13.657678+00	11	XPERIEND INVESTMENT SL	2	[{"changed": {"fields": ["Status"]}}]	9	1
61	2023-01-30 17:38:03.786387+00	70	kallejo+30@gmail.com	2	[{"changed": {"fields": ["Status"]}}]	7	1
62	2023-01-30 17:38:27.454343+00	70	kallejo+30@gmail.com	2	[{"changed": {"fields": ["Status"]}}]	7	1
63	2023-02-27 09:51:03.824966+00	12	Nike SL	3		9	1
64	2023-02-27 09:52:00.834744+00	11	XPERIEND INVESTMENT SL	3		9	1
65	2023-02-27 10:07:32.167353+00	13	ESCRITOR TOKENIZADO SL	1	[{"added": {}}]	9	1
66	2023-02-27 10:08:59.633242+00	74	riccardo@braccaioli.com	2	[{"changed": {"fields": ["Type"]}}]	7	1
667	2023-09-08 08:05:59.339392+00	7	No cod	3		23	1
67	2023-02-27 10:50:32.329754+00	13	ESCRITOR TOKENIZADO SL	2	[{"changed": {"fields": ["Description"]}}]	9	1
68	2023-04-11 07:23:59.048723+00	80	rdelcastillo@gmail.com	2	[{"changed": {"fields": ["Status"]}}]	7	1
69	2023-04-11 07:25:50.215434+00	80	rdelcastillo@gmail.com	2	[{"changed": {"fields": ["Status"]}}]	7	1
70	2023-04-11 07:26:12.827998+00	80	rdelcastillo@gmail.com	2	[{"changed": {"fields": ["Status"]}}]	7	1
71	2023-04-11 07:41:27.050778+00	80	rdelcastillo@gmail.com	2	[]	7	1
72	2023-04-11 07:44:02.988307+00	80	rdelcastillo@gmail.com	2	[{"changed": {"fields": ["Status"]}}]	7	1
73	2023-04-11 07:44:20.273146+00	80	rdelcastillo@gmail.com	2	[{"changed": {"fields": ["Status"]}}]	7	1
74	2023-04-11 17:10:07.344702+00	1	[ASSIGNMENT] rdelcastillo@gmail.com: 1500	1	[{"added": {}}]	20	1
75	2023-04-14 11:40:41.67568+00	1	[ASSIGNMENT] rdelcastillo@gmail.com: 1500	3		20	1
76	2023-04-21 11:06:10.399039+00	13	Portfolio 2023	3		10	1
77	2023-04-21 11:06:10.400606+00	12	Portfolio 2023	3		10	1
78	2023-04-21 11:06:10.40252+00	11	Portfolio 2023	3		10	1
79	2023-04-26 14:51:38.112799+00	84	exitoprospero@hotmail.com	2	[{"changed": {"fields": ["Type", "Marital status"]}}]	7	1
80	2023-04-26 15:08:39.971363+00	14	MENTORIA DEL HOGAR, SL	1	[{"added": {}}]	9	1
81	2023-04-26 15:09:01.454782+00	14	MENTORIA DEL HOGAR, SL	2	[{"changed": {"fields": ["Published"]}}]	9	1
82	2023-04-26 15:10:25.591708+00	14	MENTORIA DEL HOGAR, SL	2	[{"changed": {"fields": ["Code"]}}]	9	1
83	2023-06-13 08:41:49.620415+00	95	kallejo+71@gmail.com	2	[]	7	1
84	2023-06-13 08:53:43.547427+00	15	Prueba	3		10	1
85	2023-06-13 08:53:43.548881+00	14	Portfolio v2	3		10	1
86	2023-06-13 09:52:51.255105+00	95	kallejo+71@gmail.com	2	[{"changed": {"fields": ["Id document type"]}}]	7	1
87	2023-06-23 09:32:34.86663+00	131	kallejo+17@gmail.com	2	[{"changed": {"fields": ["Status"]}}]	7	1
88	2023-06-26 21:22:39.363514+00	19	Block Impulse 2	3		9	1
89	2023-06-26 21:22:39.365249+00	18	Nike SL	3		9	1
90	2023-06-26 21:22:39.366007+00	17	Empresa Puente	3		9	1
91	2023-06-26 21:22:39.367886+00	16	Mentoria del Hogar s.l	3		9	1
92	2023-06-26 21:22:39.368988+00	15	34j32j4j3	3		9	1
93	2023-06-26 21:23:23.253262+00	20	Block Impulse 3	1	[{"added": {}}]	9	1
94	2023-06-27 10:55:35.139784+00	16	Prueba 2	3		10	1
95	2023-06-27 11:13:57.123839+00	18	Docuemnto 2	3		10	1
96	2023-06-27 11:13:57.125432+00	17	Documento 2	3		10	1
97	2023-08-08 07:33:30.525907+00	174	raquel.carrasco@me.com	2	[{"changed": {"fields": ["password"]}}]	7	1
98	2023-09-03 07:50:20.559832+00	1	Juego	1	[{"added": {}}]	55	197
99	2023-09-03 07:52:19.406389+00	2	Tecnología	1	[{"added": {}}]	55	197
100	2023-09-03 07:52:31.992708+00	3	Real Estate	1	[{"added": {}}]	55	197
101	2023-09-03 07:52:41.338836+00	4	Energías Renovables	1	[{"added": {}}]	55	197
102	2023-09-03 07:52:47.551369+00	5	Startups	1	[{"added": {}}]	55	197
103	2023-09-03 07:52:53.373287+00	6	Plataformas	1	[{"added": {}}]	55	197
104	2023-09-03 07:52:59.157777+00	7	Otras	1	[{"added": {}}]	55	197
105	2023-09-03 08:08:13.852689+00	4	fpalomar90@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
106	2023-09-03 12:11:12.03213+00	1	iwTBwWlxs7O0xi0WxZQEhdqfYuVOOacxMirDor7z	1	[{"added": {}}]	44	197
107	2023-09-03 15:18:40.81308+00	22	MangopayUser object (22)	2	[{"changed": {"fields": ["Cod"]}}]	27	197
108	2023-09-03 15:49:14.362313+00	1	stockencapital@mecexis.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
109	2023-09-03 15:49:53.276674+00	2	mgomez@vottun.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
110	2023-09-03 15:50:06.856354+00	3	snapmiguelav@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
111	2023-09-03 15:50:24.942998+00	5	adngarde19@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
112	2023-09-03 15:50:36.76645+00	6	definitive.agency@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
113	2023-09-03 15:51:04.181443+00	8	ernestoesc85@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
114	2023-09-03 15:51:13.243952+00	9	admin@claddingprices.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
115	2023-09-03 15:51:24.399852+00	10	r@whitebear.trading	2	[{"changed": {"fields": ["Cod"]}}]	7	197
116	2023-09-03 15:51:32.417635+00	11	david.ramon.riera@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
117	2023-09-03 15:51:47.040336+00	12	jflores@email4job.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
118	2023-09-03 15:51:55.225488+00	13	vcallejo@blockimpulse.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
119	2023-09-03 15:52:01.91661+00	14	barbatusaeronautics@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
120	2023-09-03 15:52:26.703238+00	15	javier@tierra.audio	2	[{"changed": {"fields": ["Cod"]}}]	7	197
121	2023-09-03 15:52:35.386869+00	16	jmbarbancho@inmobiliariabarin.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
122	2023-09-03 15:52:43.186623+00	17	marcosolvg@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
123	2023-09-03 15:52:50.5047+00	18	100432408@alumnos.uc3m.es	2	[{"changed": {"fields": ["Cod"]}}]	7	197
124	2023-09-03 15:52:58.465055+00	19	alexa.daniela.2710@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
125	2023-09-03 15:53:09.389156+00	20	alexander.a.herrera.c@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
126	2023-09-03 15:53:17.466726+00	21	jdsabinal@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
127	2023-09-03 15:53:28.363596+00	22	joaquin.lopez.lerida@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
128	2023-09-03 15:53:35.677019+00	23	kallejo@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
129	2023-09-03 15:53:46.289936+00	24	acallejo48@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
130	2023-09-03 15:53:59.673208+00	25	test1@mecexis.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
131	2023-09-03 15:54:09.847086+00	26	humberto@twoforall.eu	2	[{"changed": {"fields": ["Cod"]}}]	7	197
132	2023-09-03 15:54:17.863546+00	27	alejandro_elbaz@elbaz.es	2	[{"changed": {"fields": ["Cod"]}}]	7	197
133	2023-09-03 15:54:28.969499+00	28	ccallejo@stockencapital.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
134	2023-09-03 15:54:42.020048+00	29	cbellver@claddingprices.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
135	2023-09-03 15:54:52.335779+00	30	icastello@sgrr.es	2	[{"changed": {"fields": ["Cod"]}}]	7	197
136	2023-09-03 15:55:15.955342+00	31	racomo@yahoo.com	2	[{"changed": {"fields": ["Cod", "First name", "Last name"]}}]	7	197
137	2023-09-03 15:55:30.750687+00	32	vila.ma@me.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
138	2023-09-03 15:55:51.822036+00	33	carlosblascobueno@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
139	2023-09-03 15:56:05.630864+00	34	luisrodriguez@live.com.ar	2	[{"changed": {"fields": ["Cod"]}}]	7	197
140	2023-09-03 15:56:25.179754+00	35	byfemoweb3@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
141	2023-09-03 15:56:34.292168+00	36	byferweb3@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
142	2023-09-03 15:56:41.658519+00	37	jrperezperez22@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
143	2023-09-03 15:56:49.613007+00	38	prossenger@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
144	2023-09-03 15:56:56.738389+00	39	mmanriqueordax@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
145	2023-09-03 15:57:06.857386+00	58	test2@mecexis.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
146	2023-09-03 15:57:28.207321+00	59	pedro_ortiz70@yahoo.es	2	[{"changed": {"fields": ["Cod"]}}]	7	197
147	2023-09-03 15:57:37.257527+00	60	kallejo+20@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
148	2023-09-03 15:57:44.822725+00	61	otroenfoquesl@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
149	2023-09-03 15:57:51.852159+00	62	alejandro5284@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
150	2023-09-03 15:57:59.482926+00	63	gonzalo1987@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
151	2023-09-03 15:58:06.807161+00	64	sg@intlaw.eu	2	[{"changed": {"fields": ["Cod"]}}]	7	197
152	2023-09-03 15:58:14.428835+00	65	pyreneestimingsolutions@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
153	2023-09-03 15:59:05.952697+00	66	braccaioli.riccardo@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
154	2023-09-03 15:59:13.047251+00	67	guillermo.salazar.verdejo@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
155	2023-09-03 15:59:20.611375+00	68	crb.bellver@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
156	2023-09-03 15:59:31.021985+00	69	xperiend@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
157	2023-09-03 15:59:37.743213+00	70	kallejo+30@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
158	2023-09-03 15:59:49.672238+00	71	roberto.sanchezlar@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
159	2023-09-03 15:59:57.252124+00	72	alberto@atalayateam.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
160	2023-09-03 16:00:05.354101+00	73	micaelabuffagni@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
161	2023-09-03 16:00:12.151639+00	74	riccardo@braccaioli.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
162	2023-09-03 16:00:18.892585+00	75	eduardo@promoo.es	2	[{"changed": {"fields": ["Cod"]}}]	7	197
163	2023-09-03 16:00:26.824435+00	76	albertvaldes01@arkand-arkibit.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
164	2023-09-03 16:00:33.62137+00	77	ashok@mxicoders.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
165	2023-09-03 16:00:41.104099+00	78	kallejo+2@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
166	2023-09-03 16:00:50.265414+00	79	viktorcallejo@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
167	2023-09-03 16:00:59.755583+00	80	rdelcastillo@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
168	2023-09-03 16:01:07.010885+00	81	kallejo+1@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
169	2023-09-03 16:01:13.91711+00	82	consulting@blockimpulse.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
170	2023-09-03 16:01:21.234053+00	83	kallejo+10@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
171	2023-09-03 16:01:28.653281+00	84	exitoprospero@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
172	2023-09-03 16:01:37.314586+00	85	persianasfotovoltaicas@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
173	2023-09-03 16:01:52.718581+00	86	davidenkeeper@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
174	2023-09-03 16:01:59.073321+00	87	evadibars@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
175	2023-09-03 16:02:05.943083+00	88	kallejo+40@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
176	2023-09-03 16:02:13.119428+00	89	cerocash2020@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
177	2023-09-03 16:02:19.423769+00	90	benjaminespanolgarrigos@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
178	2023-09-03 16:02:28.172652+00	91	famartinc@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
179	2023-09-03 16:02:36.300597+00	92	thiagocmachado@yahoo.com.br	2	[{"changed": {"fields": ["Cod"]}}]	7	197
180	2023-09-03 16:02:43.877008+00	93	kallejo+69@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
181	2023-09-03 16:02:52.098633+00	94	kallejo+70@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
182	2023-09-03 16:03:00.233954+00	95	kallejo+71@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
183	2023-09-03 16:03:07.266276+00	96	legu35@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
184	2023-09-03 16:03:13.78545+00	97	ernestoguardadopartida@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
185	2023-09-03 16:03:20.334735+00	98	anayeyu@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
186	2023-09-03 16:03:25.473565+00	99	btola18@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
187	2023-09-03 16:03:36.781026+00	100	ondadali@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
188	2023-09-03 16:03:43.963094+00	101	estrellasanan@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
189	2023-09-03 16:03:49.874918+00	102	martagarcia@gmail.com.delete.a3bc54	2	[{"changed": {"fields": ["Cod"]}}]	7	197
190	2023-09-03 16:03:56.107774+00	103	adriangarciacristina@gmail.com.delete.98fa46	2	[{"changed": {"fields": ["Cod"]}}]	7	197
191	2023-09-03 16:04:01.942885+00	104	josebaiglesiasvilanova@gmail.com.delete.b6f945	2	[{"changed": {"fields": ["Cod"]}}]	7	197
192	2023-09-03 16:04:08.554857+00	105	lorena.merchan81@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
193	2023-09-03 16:04:19.408097+00	106	jadesame@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
194	2023-09-03 16:04:37.277913+00	107	rnalava@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
195	2023-09-03 16:04:43.840755+00	108	beindos@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
196	2023-09-03 16:04:50.826797+00	109	gemar68@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
197	2023-09-03 16:05:05.426135+00	110	angelmmt70@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
198	2023-09-03 16:05:11.284414+00	111	pcrsoluciones@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
199	2023-09-03 16:05:17.371113+00	112	sandracasado13@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
200	2023-09-03 16:05:24.997595+00	113	angie26504@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
201	2023-09-03 16:05:33.799573+00	114	mgoenagajuez@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
202	2023-09-03 16:05:40.398205+00	115	feli.oregi@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
203	2023-09-03 16:05:48.831941+00	116	ainhoagalarraga@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
204	2023-09-03 16:05:56.150935+00	117	natiroldos54@gmail.com.delete.e9cf86	2	[{"changed": {"fields": ["Cod"]}}]	7	197
205	2023-09-03 16:06:02.394475+00	118	albertoxav@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
206	2023-09-03 16:06:12.1848+00	119	zx10alex@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
207	2023-09-03 16:06:41.730913+00	196	kallejo+3@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
208	2023-09-03 16:07:17.717251+00	193	silvia.mayfairbar@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
209	2023-09-03 16:07:25.104585+00	30	icastello@sgrr.es	2	[{"changed": {"fields": ["Cod"]}}]	7	197
210	2023-09-03 16:07:26.798606+00	191	trabajarparati@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
211	2023-09-03 16:07:36.636778+00	190	adriangarciacristina@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
212	2023-09-03 16:07:40.114905+00	31	racomo@yahoo.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
213	2023-09-03 16:07:47.270085+00	189	roberto.espinosavera@yahoo.com.mx	2	[{"changed": {"fields": ["Cod"]}}]	7	197
214	2023-09-03 16:07:55.451086+00	188	elmeunil@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
215	2023-09-03 16:08:22.303179+00	186	nuskita555@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
216	2023-09-03 16:08:30.260346+00	185	carmenhr2006@hotmail.es	2	[{"changed": {"fields": ["Cod"]}}]	7	197
217	2023-09-03 16:08:36.361995+00	184	arrazayuya@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
218	2023-09-03 16:08:42.152182+00	183	davidruemanonelles@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
219	2023-09-03 16:09:10.251196+00	120	harka78@icloud.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
220	2023-09-03 16:09:17.119188+00	179	soniadeba@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
221	2023-09-03 16:09:20.08181+00	121	rubenalava@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
222	2023-09-03 16:09:24.775536+00	178	m.garmendia2001@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
223	2023-09-03 16:09:35.558566+00	122	dossmingo@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
224	2023-09-03 16:09:36.084165+00	175	esperanza67147@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
225	2023-09-03 16:09:42.338848+00	123	kallejo+15@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
226	2023-09-03 16:09:43.047875+00	173	mariarodriguezmena92@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
227	2023-09-03 16:09:50.803114+00	171	jesusrm.rr@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
228	2023-09-03 16:09:52.080259+00	124	kallejo+16@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
229	2023-09-03 16:10:00.682114+00	168	rossamador1122@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
230	2023-09-03 16:10:03.465777+00	125	abrujos@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
231	2023-09-03 16:10:09.560232+00	167	joitturri@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
232	2023-09-03 16:10:10.342542+00	126	jlopez@somosecoenergy.es	2	[{"changed": {"fields": ["Cod"]}}]	7	197
233	2023-09-03 16:10:17.354356+00	127	pilikim20@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
234	2023-09-03 16:10:18.566157+00	165	ligia.angela.ventura@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
235	2023-09-03 16:10:24.295883+00	128	pilichitobarias12345@gmial.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
236	2023-09-03 16:10:28.663632+00	164	liuwangpt@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
237	2023-09-03 16:10:32.043133+00	129	kimmdamm@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
238	2023-09-03 16:10:36.897275+00	163	nereplen@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
239	2023-09-03 16:10:38.058611+00	130	tiavinos@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
240	2023-09-03 16:10:44.198495+00	131	kallejo+17@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
241	2023-09-03 16:10:44.370021+00	160	javipersuasivo@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
242	2023-09-03 16:10:51.699836+00	132	kallejo+18@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
243	2023-09-03 16:10:52.321558+00	157	augustocp.coutinho@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
244	2023-09-03 16:10:59.217407+00	133	quintorro81@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
245	2023-09-03 16:11:01.287669+00	154	esterue@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
246	2023-09-03 16:11:06.027542+00	134	pilichitobarias12345@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
247	2023-09-03 16:11:14.260993+00	135	beatriche2bgt@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
248	2023-09-03 16:11:23.338451+00	136	kardaskinges2011@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
249	2023-09-03 16:11:33.87362+00	137	kallejo+22@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
250	2023-09-03 16:11:41.354675+00	138	kallejo+23@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
251	2023-09-03 16:11:45.29341+00	152	monica.villar.fernandez@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
252	2023-09-03 16:11:49.398909+00	139	kallejo+27@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
253	2023-09-03 16:11:52.194715+00	150	posesodegerasa@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
254	2023-09-03 16:11:57.100946+00	140	kallejo+28@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
255	2023-09-03 16:11:59.071364+00	147	josebaiglesiasvilanova@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
256	2023-09-03 16:12:04.486748+00	141	kallejo+31@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
257	2023-09-03 16:12:10.58704+00	144	despertandoturealidad@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
258	2023-09-03 16:12:11.360753+00	142	superfluo83@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
259	2023-09-03 16:12:20.856325+00	136	kardaskinges2011@gmail.com	2	[]	7	197
260	2023-09-03 16:12:21.566058+00	143	cio@ofisher.net	2	[{"changed": {"fields": ["Cod"]}}]	7	197
261	2023-09-03 16:12:28.970159+00	144	despertandoturealidad@gmail.com	2	[]	7	197
262	2023-09-03 16:12:35.334154+00	145	beindos@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
263	2023-09-03 16:12:42.471384+00	146	martagarciahc@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
264	2023-09-03 16:12:49.53148+00	147	josebaiglesiasvilanova@gmail.com	2	[]	7	197
265	2023-09-03 16:12:58.187189+00	148	natiroldos54@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
266	2023-09-03 16:13:25.75967+00	149	cristinaadrian@yahoo.es	2	[{"changed": {"fields": ["Cod"]}}]	7	197
267	2023-09-03 16:13:43.302742+00	150	posesodegerasa@gmail.com	2	[]	7	197
268	2023-09-03 16:13:59.917889+00	151	xavier@xepigar.com.delete.2d2470	2	[{"changed": {"fields": ["Cod"]}}]	7	197
269	2023-09-03 16:14:10.383566+00	152	monica.villar.fernandez@gmail.com	2	[]	7	197
270	2023-09-03 16:14:20.925344+00	153	josemameli40@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
271	2023-09-03 16:14:27.670227+00	154	esterue@gmail.com	2	[]	7	197
272	2023-09-03 16:14:34.239988+00	155	ikerfp@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
273	2023-09-03 16:14:41.587291+00	156	mrascongarcia@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
274	2023-09-03 16:14:48.974705+00	157	augustocp.coutinho@gmail.com	2	[]	7	197
275	2023-09-03 16:14:57.614739+00	158	rascongarciavictoria@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
276	2023-09-03 16:15:06.554265+00	159	leirecs@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
277	2023-09-03 16:15:14.855782+00	160	javipersuasivo@gmail.com	2	[]	7	197
278	2023-09-03 16:15:22.810097+00	161	marina.imagen@gmail.com.delete.87bbea	2	[{"changed": {"fields": ["Cod"]}}]	7	197
279	2023-09-03 16:15:56.109917+00	162	elmeunil@gmail.com.delete.6edd57	2	[{"changed": {"fields": ["Cod"]}}]	7	197
280	2023-09-03 16:16:06.86782+00	163	nereplen@gmail.com	2	[]	7	197
281	2023-09-03 16:16:14.403485+00	164	liuwangpt@gmail.com	2	[]	7	197
282	2023-09-03 16:16:19.996699+00	165	ligia.angela.ventura@gmail.com	2	[]	7	197
283	2023-09-03 16:16:27.692843+00	166	carradafrancisco7@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
284	2023-09-03 16:16:34.353046+00	167	joitturri@gmail.com	2	[]	7	197
285	2023-09-03 16:16:41.282417+00	168	rossamador1122@gmail.com	2	[]	7	197
286	2023-09-03 16:16:47.945601+00	169	paulanpi27@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
287	2023-09-03 16:16:56.79755+00	170	koldobikacs@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
288	2023-09-03 16:17:05.359651+00	171	jesusrm.rr@hotmail.com	2	[]	7	197
289	2023-09-03 16:17:13.967197+00	172	alberto.rf2017@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
290	2023-09-03 16:17:21.524585+00	173	mariarodriguezmena92@gmail.com	2	[]	7	197
291	2023-09-03 16:17:28.919937+00	174	raquel.carrasco@me.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
292	2023-09-03 16:17:35.546457+00	175	esperanza67147@hotmail.com	2	[]	7	197
293	2023-09-03 16:17:42.868958+00	176	yumava@hotmail.com.delete.d89d13	2	[{"changed": {"fields": ["Cod"]}}]	7	197
294	2023-09-03 16:17:50.155314+00	177	angelmnavarrol@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
295	2023-09-03 16:18:02.037597+00	178	m.garmendia2001@gmail.com	2	[]	7	197
296	2023-09-03 16:18:10.02808+00	179	soniadeba@gmail.com	2	[]	7	197
297	2023-09-03 16:18:16.538463+00	180	padreindependientef@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
298	2023-09-03 16:18:23.816643+00	181	erleitxu.t@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
299	2023-09-03 16:18:31.648547+00	182	sarahiboes@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
300	2023-09-03 16:18:42.536782+00	187	xavier@xepigar.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
301	2023-09-03 16:18:59.902341+00	192	yumava@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
302	2023-09-03 16:19:11.306122+00	194	marinaarenaza@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
303	2023-09-03 16:19:18.886759+00	195	naji.bizri@equito.app	2	[{"changed": {"fields": ["Cod"]}}]	7	197
304	2023-09-03 16:19:35.346727+00	197	marcos@admin.com	2	[{"changed": {"fields": ["Cod", "First name", "Last name"]}}]	7	197
305	2023-09-03 16:19:43.326746+00	198	rodrigoloco.595@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
306	2023-09-03 16:19:50.782977+00	199	rodri.595@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
307	2023-09-03 16:20:00.191252+00	200	ssadas@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	7	197
308	2023-09-03 16:21:51.511098+00	23	qeFE	2	[{"changed": {"fields": ["Cod"]}}]	9	197
309	2023-09-03 16:22:00.663137+00	22	Hn	2	[{"changed": {"fields": ["Cod"]}}]	9	197
310	2023-09-03 16:22:07.321936+00	21	dffef	2	[{"changed": {"fields": ["Cod"]}}]	9	197
311	2023-09-03 16:22:14.406988+00	20	Block Impulse 3	2	[{"changed": {"fields": ["Cod"]}}]	9	197
312	2023-09-03 16:22:22.423775+00	7	Tierra Audio SL	2	[{"changed": {"fields": ["Cod"]}}]	9	197
313	2023-09-03 16:25:02.469175+00	4	genial	2	[{"changed": {"fields": ["Cod"]}}]	22	197
314	2023-09-03 16:25:14.404545+00	3	aquii mensaje 4	2	[{"changed": {"fields": ["Cod"]}}]	22	197
315	2023-09-03 16:25:46.245097+00	2	hola	2	[{"changed": {"fields": ["Cod"]}}]	22	197
316	2023-09-03 16:26:02.440066+00	1	Hola Víctor, está todo ok	2	[{"changed": {"fields": ["Cod"]}}]	22	197
317	2023-09-03 16:27:08.252038+00	5	Hola probando 2	2	[{"changed": {"fields": ["Cod"]}}]	21	197
318	2023-09-03 16:27:50.308304+00	4	rod	2	[{"changed": {"fields": ["Cod"]}}]	21	197
319	2023-09-03 16:28:16.937192+00	3	Prueba	2	[{"changed": {"fields": ["Cod"]}}]	21	197
320	2023-09-03 16:28:42.389165+00	2	Hola quiero información	2	[{"changed": {"fields": ["Cod"]}}]	21	197
321	2023-09-03 16:29:06.316488+00	1	Prueba mensaje empresa	2	[{"changed": {"fields": ["Cod"]}}]	21	197
322	2023-09-03 16:38:16.474387+00	66	vcallejo@blockimpulse.com 200.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	34	197
323	2023-09-03 16:38:54.68336+00	65	vcallejo@blockimpulse.com 200.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	34	197
324	2023-09-03 16:39:33.503063+00	64	vcallejo@blockimpulse.com 200.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	34	197
325	2023-09-03 16:40:20.754428+00	63	vcallejo@blockimpulse.com 200.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	34	197
326	2023-09-03 16:41:47.570879+00	62	vcallejo@blockimpulse.com 100.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	34	197
327	2023-09-03 16:42:56.645462+00	60	jlopez@somosecoenergy.es 415.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	34	197
328	2023-09-03 16:43:44.506651+00	59	ccallejo@stockencapital.com 200.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	34	197
329	2023-09-03 16:44:36.499066+00	55	quintorro81@gmail.com 101.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	34	197
330	2023-09-03 16:47:48.201828+00	44	beatriche2bgt@hotmail.com 200.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	34	197
331	2023-09-03 16:48:41.324139+00	40	dossmingo@gmail.com 500.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	34	197
332	2023-09-03 16:51:25.489608+00	23	qeFE	3		9	197
333	2023-09-03 16:51:25.492071+00	22	Hn	3		9	197
334	2023-09-03 16:51:25.49279+00	21	dffef	3		9	197
335	2023-09-03 16:51:25.49337+00	20	Block Impulse 3	3		9	197
336	2023-09-03 17:02:24.490535+00	38	dossmingo@gmail.com 500.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	34	197
337	2023-09-03 17:02:28.610341+00	37	dossmingo@gmail.com 500.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	34	197
338	2023-09-03 17:02:33.107454+00	35	dossmingo@gmail.com 500.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	34	197
339	2023-09-03 17:04:08.027539+00	31	harka78@icloud.com 500.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	34	197
340	2023-09-03 17:04:11.941693+00	30	harka78@icloud.com 500.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	34	197
341	2023-09-03 17:04:16.401697+00	29	harka78@icloud.com 500.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	34	197
342	2023-09-03 17:05:23.744963+00	28	vcallejo@blockimpulse.com 1000.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	34	197
343	2023-09-03 17:11:34.998064+00	26	kallejo@gmail.com 1.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	34	197
344	2023-09-03 17:12:20.624804+00	21	vcallejo@blockimpulse.com 100.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	34	197
345	2023-09-03 17:13:22.960261+00	19	kallejo@gmail.com 1000.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	34	197
346	2023-09-03 17:13:42.602972+00	16	kallejo@gmail.com 100.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	34	197
347	2023-09-03 17:14:01.5182+00	13	kallejo@gmail.com 10000.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	34	197
348	2023-09-03 17:14:19.238285+00	26	kallejo@gmail.com 1.00 EUR	2	[]	34	197
668	2023-09-08 08:05:59.340867+00	6	No cod	3		23	1
349	2023-09-03 17:15:07.015694+00	9	riccardo@braccaioli.com 2000.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	34	197
350	2023-09-03 17:15:45.318229+00	7	ccallejo@stockencapital.com 20.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	34	197
351	2023-09-03 17:16:10.795217+00	6	ccallejo@stockencapital.com 100.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	34	197
352	2023-09-03 17:16:52.190336+00	4	kallejo@gmail.com 50.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	34	197
353	2023-09-03 17:20:37.176172+00	77	quintorro81@gmail.com 3.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
354	2023-09-03 17:22:14.930041+00	76	trabajarparati@gmail.com 100.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
355	2023-09-03 17:22:47.826596+00	75	abrujos@hotmail.com 500.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
356	2023-09-03 17:23:55.932574+00	74	abrujos@hotmail.com 500.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
357	2023-09-03 17:24:41.20666+00	73	monica.villar.fernandez@gmail.com 100.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
358	2023-09-03 17:25:35.627873+00	72	despertandoturealidad@gmail.com 100.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
359	2023-09-03 17:26:15.513414+00	71	pilichitobarias12345@gmail.com 180.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
360	2023-09-03 17:26:59.6047+00	68	abrujos@hotmail.com 500.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
361	2023-09-03 17:27:21.229266+00	67	abrujos@hotmail.com 500.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
362	2023-09-03 17:28:50.341769+00	61	pilichitobarias12345@gmail.com 100.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
363	2023-09-03 18:17:23.298704+00	58	ccallejo@stockencapital.com 20.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
364	2023-09-03 18:18:25.166605+00	57	jlopez@somosecoenergy.es 400.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
365	2023-09-03 18:18:57.237771+00	56	jlopez@somosecoenergy.es 400.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
366	2023-09-03 18:19:56.646887+00	54	kallejo@gmail.com 100.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
367	2023-09-03 18:20:34.423486+00	53	kallejo@gmail.com 100.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
368	2023-09-03 18:20:40.489141+00	52	kallejo@gmail.com 100.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
369	2023-09-03 18:21:24.791287+00	51	kardaskinges2011@gmail.com 100.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
370	2023-09-03 18:22:02.0364+00	50	consulting@blockimpulse.com 20.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
371	2023-09-03 18:22:38.799455+00	49	kallejo@gmail.com 20.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
372	2023-09-03 18:23:00.809085+00	48	kallejo@gmail.com 20.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
373	2023-09-03 18:23:40.850594+00	47	jlopez@somosecoenergy.es 300.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
374	2023-09-03 18:24:28.994948+00	46	pilichitobarias12345@gmail.com 20.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
375	2023-09-03 18:25:17.302834+00	43	beatriche2bgt@hotmail.com 200.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
376	2023-09-03 18:26:18.546557+00	42	pilichitobarias12345@gmail.com 200.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
377	2023-09-03 18:26:40.859173+00	41	pilichitobarias12345@gmail.com 200.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
378	2023-09-03 18:27:23.481269+00	36	evadibars@gmail.com 505.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
379	2023-09-03 18:28:08.95347+00	34	dossmingo@gmail.com 500.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
380	2023-09-03 18:28:43.460431+00	33	dossmingo@gmail.com 500.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
381	2023-09-03 18:29:25.535134+00	27	cerocash2020@gmail.com 500.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
382	2023-09-03 18:30:10.509867+00	25	kallejo@gmail.com 1.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
383	2023-09-03 18:30:39.605991+00	24	kallejo@gmail.com 200.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
384	2023-09-03 18:30:59.564974+00	23	kallejo@gmail.com 100.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
385	2023-09-03 18:31:47.238678+00	22	benjaminespanolgarrigos@gmail.com 700.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
386	2023-09-03 18:32:26.221455+00	20	vcallejo@blockimpulse.com 100.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
387	2023-09-03 18:33:02.246159+00	18	kallejo@gmail.com 100.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
388	2023-09-03 18:33:38.472828+00	17	benjaminespanolgarrigos@gmail.com 300.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
389	2023-09-03 18:34:57.262665+00	15	kallejo@gmail.com 100.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
390	2023-09-03 18:35:12.689487+00	14	kallejo@gmail.com 100.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
391	2023-09-03 18:35:17.163764+00	12	kallejo@gmail.com 1000.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
392	2023-09-03 18:35:20.867616+00	11	kallejo@gmail.com 1000.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
393	2023-09-03 18:35:25.319733+00	3	kallejo@gmail.com 100.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
394	2023-09-03 18:36:45.540476+00	10	riccardo@braccaioli.com 100.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
395	2023-09-03 18:37:38.197019+00	5	ccallejo@stockencapital.com 20.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
396	2023-09-03 18:38:51.930794+00	2	vcallejo@blockimpulse.com 10.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
397	2023-09-03 18:39:27.409616+00	1	vcallejo@blockimpulse.com 10.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	197
398	2023-09-03 20:12:12.373436+00	1	IDENTITY_PROOF for alexander.a.herrera.c@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	197
399	2023-09-03 20:13:04.634501+00	2	IDENTITY_PROOF for test1@mecexis.com	2	[{"changed": {"fields": ["Cod"]}}]	28	197
400	2023-09-03 20:14:03.705609+00	3	IDENTITY_PROOF for acallejo48@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	197
401	2023-09-03 20:14:57.527342+00	4	IDENTITY_PROOF for humberto@twoforall.eu	2	[{"changed": {"fields": ["Cod"]}}]	28	197
402	2023-09-03 20:15:48.67216+00	5	IDENTITY_PROOF for ccallejo@stockencapital.com	2	[{"changed": {"fields": ["Cod"]}}]	28	197
403	2023-09-03 20:16:38.981401+00	7	IDENTITY_PROOF for mmanriqueordax@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	197
404	2023-09-03 20:17:31.475063+00	8	IDENTITY_PROOF for cbellver@claddingprices.com	2	[{"changed": {"fields": ["Cod"]}}]	28	197
405	2023-09-03 20:18:27.393084+00	9	IDENTITY_PROOF for pyreneestimingsolutions@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	197
406	2023-09-03 20:19:05.672894+00	10	IDENTITY_PROOF for xperiend@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	197
407	2023-09-03 20:19:42.906886+00	11	IDENTITY_PROOF for riccardo@braccaioli.com	2	[{"changed": {"fields": ["Cod"]}}]	28	197
408	2023-09-03 20:20:23.924996+00	12	IDENTITY_PROOF for pyreneestimingsolutions@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	197
409	2023-09-03 20:21:10.317293+00	13	IDENTITY_PROOF for kallejo+2@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	197
410	2023-09-03 20:21:58.934957+00	14	IDENTITY_PROOF for viktorcallejo@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	197
411	2023-09-03 20:22:49.533852+00	15	IDENTITY_PROOF for rdelcastillo@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	197
412	2023-09-03 20:23:32.310531+00	16	IDENTITY_PROOF for consulting@blockimpulse.com	2	[{"changed": {"fields": ["Cod"]}}]	28	197
413	2023-09-03 20:24:40.4861+00	17	IDENTITY_PROOF for fpalomar90@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	197
414	2023-09-03 20:25:18.929611+00	18	IDENTITY_PROOF for exitoprospero@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	197
415	2023-09-03 20:26:04.15206+00	19	IDENTITY_PROOF for persianasfotovoltaicas@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	197
416	2023-09-03 20:26:43.757618+00	20	IDENTITY_PROOF for davidenkeeper@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	197
417	2023-09-03 20:27:18.963395+00	21	IDENTITY_PROOF for cerocash2020@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	197
418	2023-09-03 20:27:57.958669+00	22	IDENTITY_PROOF for benjaminespanolgarrigos@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	197
419	2023-09-03 20:28:32.276041+00	23	IDENTITY_PROOF for evadibars@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	197
420	2023-09-03 20:29:13.932491+00	24	IDENTITY_PROOF for btola18@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	197
421	2023-09-03 20:30:29.623533+00	25	IDENTITY_PROOF for angie26504@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	197
422	2023-09-03 20:31:35.857903+00	26	IDENTITY_PROOF for estrellasanan@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	197
423	2023-09-03 20:32:15.143093+00	27	IDENTITY_PROOF for legu35@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	197
424	2023-09-03 20:35:07.564474+00	28	IDENTITY_PROOF for harka78@icloud.com	2	[{"changed": {"fields": ["Cod"]}}]	28	197
425	2023-09-03 20:38:35.563601+00	29	IDENTITY_PROOF for gemar68@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	197
426	2023-09-03 22:35:12.052545+00	2	ZBWIJ16lyyMgtP6FlD35cKHWFT1QPD6pwYgLNkHM	1	[{"added": {}}]	44	1
427	2023-09-04 06:51:40.688737+00	202	jegewak414@synclane.com	2	[{"changed": {"fields": ["password"]}}]	7	1
428	2023-09-04 06:53:36.972038+00	92	thiagocmachado@yahoo.com.br	2	[{"changed": {"fields": ["password"]}}]	7	1
429	2023-09-04 11:49:27.374833+00	92	thiagocmachado@yahoo.com.br	2	[{"changed": {"fields": ["Phone number", "Birthday", "Status", "Staff status", "Superuser status"]}}]	7	1
430	2023-09-04 14:02:01.118328+00	199	rodri.595@hotmail.com	2	[{"changed": {"fields": ["password"]}}]	7	1
431	2023-09-04 19:22:28.794414+00	3	App	1	[{"added": {}}]	44	1
432	2023-09-04 20:04:33.97326+00	8	Test	1	[{"added": {}}]	55	1
433	2023-09-04 20:04:42.079223+00	8	Test	3		55	1
434	2023-09-04 20:22:02.509305+00	228	strcod@gmail.com	1	[{"added": {}}]	7	1
435	2023-09-04 20:27:06.506358+00	229	strcod1@gmail.com	1	[{"added": {}}]	7	1
436	2023-09-04 20:32:17.148973+00	230	hojewa9109@nickolis.com	2	[{"changed": {"fields": ["Verified"]}}]	7	1
437	2023-09-04 20:58:44.072387+00	231	strcod11@gmail.com	1	[{"added": {}}]	7	1
438	2023-09-06 08:04:06.716053+00	79	IDENTITY_PROOF for kallejo+3@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
439	2023-09-06 08:04:44.789358+00	78	IDENTITY_PROOF for silvia.mayfairbar@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
440	2023-09-06 08:08:13.344582+00	77	IDENTITY_PROOF for arrazayuya@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
441	2023-09-06 08:08:53.545799+00	76	IDENTITY_PROOF for raquel.carrasco@me.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
442	2023-09-06 08:09:31.142617+00	75	IDENTITY_PROOF for trabajarparati@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
443	2023-09-06 08:10:14.016973+00	74	IDENTITY_PROOF for m.garmendia2001@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
444	2023-09-06 08:11:03.366562+00	73	IDENTITY_PROOF for augustocp.coutinho@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
445	2023-09-06 08:11:49.48783+00	72	IDENTITY_PROOF for nereplen@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
446	2023-09-06 08:12:21.315464+00	71	IDENTITY_PROOF for liuwangpt@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
447	2023-09-06 08:13:06.641055+00	70	IDENTITY_PROOF for ligia.angela.ventura@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
448	2023-09-06 08:15:07.642825+00	69	IDENTITY_PROOF for adriangarciacristina@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
449	2023-09-06 08:15:41.555309+00	68	IDENTITY_PROOF for nuskita555@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
450	2023-09-06 08:16:15.667294+00	67	IDENTITY_PROOF for rossamador1122@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
451	2023-09-06 08:16:57.219924+00	66	IDENTITY_PROOF for ainhoagalarraga@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
452	2023-09-06 08:17:42.78954+00	65	IDENTITY_PROOF for roberto.espinosavera@yahoo.com.mx	2	[{"changed": {"fields": ["Cod"]}}]	28	1
453	2023-09-06 08:18:19.175081+00	64	IDENTITY_PROOF for rascongarciavictoria@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
454	2023-09-06 08:18:58.384756+00	63	IDENTITY_PROOF for elmeunil@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
455	2023-09-06 08:19:42.111885+00	62	IDENTITY_PROOF for javipersuasivo@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
456	2023-09-06 08:20:48.513576+00	61	IDENTITY_PROOF for carmenhr2006@hotmail.es	2	[{"changed": {"fields": ["Cod"]}}]	28	1
457	2023-09-06 08:21:37.484468+00	60	IDENTITY_PROOF for davidruemanonelles@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
458	2023-09-06 08:22:37.891279+00	59	IDENTITY_PROOF for joitturri@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
459	2023-09-06 08:25:10.938654+00	58	IDENTITY_PROOF for esterue@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
460	2023-09-06 08:25:59.35501+00	57	IDENTITY_PROOF for soniadeba@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
461	2023-09-06 08:26:35.898319+00	56	IDENTITY_PROOF for esperanza67147@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
462	2023-09-06 08:27:32.774569+00	55	IDENTITY_PROOF for jesusrm.rr@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
463	2023-09-06 08:28:16.353317+00	54	IDENTITY_PROOF for mariarodriguezmena92@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
464	2023-09-06 08:28:52.738578+00	53	IDENTITY_PROOF for monica.villar.fernandez@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
465	2023-09-06 08:29:49.001082+00	52	IDENTITY_PROOF for rnalava@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
466	2023-09-06 08:30:27.305476+00	51	IDENTITY_PROOF for sandracasado13@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
467	2023-09-06 08:31:04.963391+00	50	IDENTITY_PROOF for josebaiglesiasvilanova@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
468	2023-09-06 08:32:00.051289+00	49	IDENTITY_PROOF for posesodegerasa@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
469	2023-09-06 08:32:31.17752+00	48	IDENTITY_PROOF for pcrsoluciones@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
470	2023-09-06 08:33:11.572641+00	47	IDENTITY_PROOF for despertandoturealidad@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
669	2023-09-08 08:05:59.34203+00	4	No cod	3		23	1
471	2023-09-06 08:37:24.180166+00	43	IDENTITY_PROOF for kardaskinges2011@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
472	2023-09-06 08:38:10.936032+00	42	IDENTITY_PROOF for jlopez@somosecoenergy.es	2	[{"changed": {"fields": ["Cod"]}}]	28	1
473	2023-09-06 08:39:04.070693+00	41	IDENTITY_PROOF for beatriche2bgt@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
474	2023-09-06 08:40:09.725865+00	40	IDENTITY_PROOF for quintorro81@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
475	2023-09-06 08:41:57.410872+00	39	IDENTITY_PROOF for pilichitobarias12345@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
476	2023-09-06 08:42:52.249905+00	38	IDENTITY_PROOF for abrujos@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
477	2023-09-06 08:46:06.356543+00	30	IDENTITY_PROOF for albertoxav@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
478	2023-09-06 08:47:10.267013+00	31	IDENTITY_PROOF for anayeyu@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
479	2023-09-06 08:47:38.593349+00	32	IDENTITY_PROOF for rubenalava@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
480	2023-09-06 08:48:15.963204+00	33	IDENTITY_PROOF for dossmingo@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
481	2023-09-06 08:49:04.748846+00	34	IDENTITY_PROOF for kallejo+16@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
482	2023-09-06 08:49:45.466298+00	35	IDENTITY_PROOF for ondadali@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
483	2023-09-06 08:50:40.29539+00	36	IDENTITY_PROOF for kallejo+17@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	28	1
484	2023-09-06 08:53:06.924027+00	70	ccallejo@stockencapital.com transfer 1.00 EUR to kallejo@gmail.com	2	[{"changed": {"fields": ["Cod", "From cod", "To cod"]}}]	30	1
485	2023-09-06 08:54:16.666968+00	69	ccallejo@stockencapital.com transfer 1.00 EUR to kallejo@gmail.com	2	[{"changed": {"fields": ["Cod", "From cod", "To cod"]}}]	30	1
486	2023-09-06 08:56:59.059755+00	4	harka78@icloud.com ES83 0081 4257 8100 0109 5110	2	[{"changed": {"fields": ["Cod"]}}]	33	1
487	2023-09-06 08:58:50.370463+00	3	jlopez@somosecoenergy.es BE09967604028157	2	[{"changed": {"fields": ["Cod"]}}]	33	1
488	2023-09-06 09:00:07.443082+00	2	pilichitobarias12345@gmail.com ES9221001169610200125306	2	[{"changed": {"fields": ["Cod"]}}]	33	1
489	2023-09-06 09:03:09.824509+00	1	kallejo@gmail.com ES5614650100921724350028	2	[{"changed": {"fields": ["Cod"]}}]	33	1
490	2023-09-06 18:27:28.235937+00	23	kallejo@gmail.com	2	[{"changed": {"fields": ["password"]}}]	7	1
491	2023-09-06 18:48:52.556935+00	20	05/07/2023_Contrato de Compraventa_Block Impulse SL	3		10	1
492	2023-09-06 18:48:52.558507+00	19	05/07/2023_Contrato de Compraventa_Block Impulse SL	3		10	1
493	2023-09-06 18:48:52.559515+00	9	Presentación Proyecto	3		10	1
494	2023-09-06 18:48:52.560305+00	8	FORMULARIO DE PROYECTOS PARA FONDO DE RECUPERACIÓN Y RESILIENCIA NEXT GENERATION EU	3		10	1
495	2023-09-06 18:48:52.560997+00	7	Entrevista 3/04/22 en Aragón TV	3		10	1
496	2023-09-06 18:48:52.561655+00	6	PNL 61/22 sobre formación aeronáutica en Huesca	3		10	1
497	2023-09-06 18:48:52.562978+00	5	Carta de apoyo de la Cámara de Comercio de Huesca	3		10	1
498	2023-09-06 18:48:52.56386+00	4	1º Estudio de Viabilidad del Proyecto	3		10	1
499	2023-09-06 18:48:52.564647+00	3	Reporte de Asistencia Técnica del Proyecto	3		10	1
500	2023-09-06 18:48:52.56548+00	2	Carta de apoyo al proyecto del Alcalde de Huesca	3		10	1
501	2023-09-06 18:48:52.566186+00	1	Resumen Proyecto	3		10	1
502	2023-09-07 07:38:33.892929+00	90	MangopayUser object (90)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
503	2023-09-07 07:39:03.828375+00	89	MangopayUser object (89)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
504	2023-09-07 07:40:06.30862+00	88	MangopayUser object (88)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
505	2023-09-07 07:40:39.92491+00	86	MangopayUser object (86)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
506	2023-09-07 07:41:28.956839+00	85	MangopayUser object (85)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
507	2023-09-07 07:42:11.060367+00	84	MangopayUser object (84)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
508	2023-09-07 07:42:45.97058+00	83	MangopayUser object (83)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
509	2023-09-07 07:43:24.280332+00	82	MangopayUser object (82)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
510	2023-09-07 07:43:58.752042+00	81	MangopayUser object (81)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
511	2023-09-07 07:44:37.590562+00	80	MangopayUser object (80)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
512	2023-09-07 07:45:58.793175+00	79	MangopayUser object (79)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
513	2023-09-07 07:46:32.08528+00	77	MangopayUser object (77)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
514	2023-09-07 07:47:07.647172+00	76	MangopayUser object (76)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
515	2023-09-07 07:51:58.622788+00	75	MangopayUser object (75)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
516	2023-09-07 07:52:24.375668+00	74	MangopayUser object (74)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
517	2023-09-07 07:52:55.868612+00	73	MangopayUser object (73)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
518	2023-09-07 07:54:09.197446+00	71	MangopayUser object (71)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
519	2023-09-07 07:54:44.824472+00	70	MangopayUser object (70)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
520	2023-09-07 07:55:55.994114+00	69	MangopayUser object (69)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
521	2023-09-07 07:56:26.731981+00	68	MangopayUser object (68)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
522	2023-09-07 07:57:06.216893+00	67	MangopayUser object (67)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
523	2023-09-07 07:57:54.609714+00	66	MangopayUser object (66)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
524	2023-09-07 07:58:34.005952+00	65	MangopayUser object (65)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
525	2023-09-07 07:59:06.421893+00	64	MangopayUser object (64)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
526	2023-09-07 07:59:44.695734+00	63	MangopayUser object (63)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
527	2023-09-07 08:00:17.520221+00	62	MangopayUser object (62)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
528	2023-09-07 08:00:59.031221+00	61	MangopayUser object (61)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
529	2023-09-07 08:01:28.820777+00	60	MangopayUser object (60)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
530	2023-09-07 08:03:21.71473+00	59	MangopayUser object (59)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
531	2023-09-07 08:04:00.366468+00	58	MangopayUser object (58)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
532	2023-09-07 08:05:12.393703+00	57	MangopayUser object (57)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
533	2023-09-07 08:05:45.36707+00	56	MangopayUser object (56)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
534	2023-09-07 08:06:22.928062+00	55	MangopayUser object (55)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
535	2023-09-07 08:13:21.171808+00	51	MangopayUser object (51)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
536	2023-09-07 08:13:55.622867+00	50	MangopayUser object (50)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
537	2023-09-07 08:14:39.396344+00	49	MangopayUser object (49)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
538	2023-09-07 08:15:39.90233+00	48	MangopayUser object (48)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
539	2023-09-07 08:18:39.77882+00	47	MangopayUser object (47)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
540	2023-09-07 08:19:26.666124+00	45	MangopayUser object (45)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
541	2023-09-07 08:40:53.421355+00	43	MangopayUser object (43)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
542	2023-09-07 08:41:36.930912+00	42	MangopayUser object (42)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
543	2023-09-07 08:42:16.848545+00	41	MangopayUser object (41)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
544	2023-09-07 08:43:27.037883+00	40	MangopayUser object (40)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
545	2023-09-07 08:44:23.598987+00	39	MangopayUser object (39)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
546	2023-09-07 08:44:56.021985+00	38	MangopayUser object (38)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
547	2023-09-07 08:47:40.387553+00	37	MangopayUser object (37)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
548	2023-09-07 08:48:10.706927+00	36	MangopayUser object (36)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
549	2023-09-07 08:48:44.537579+00	33	MangopayUser object (33)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
550	2023-09-07 08:49:44.392649+00	32	MangopayUser object (32)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
551	2023-09-07 08:51:04.922909+00	35	MangopayUser object (35)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
552	2023-09-07 08:51:37.640967+00	31	MangopayUser object (31)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
553	2023-09-07 08:52:16.536343+00	30	MangopayUser object (30)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
554	2023-09-07 08:53:54.591149+00	29	MangopayUser object (29)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
555	2023-09-07 08:55:48.847757+00	28	MangopayUser object (28)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
556	2023-09-07 08:56:55.029861+00	27	MangopayUser object (27)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
557	2023-09-07 09:01:53.742283+00	26	MangopayUser object (26)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
558	2023-09-07 09:02:33.162572+00	25	MangopayUser object (25)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
559	2023-09-07 09:03:05.819145+00	23	MangopayUser object (23)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
560	2023-09-07 09:04:18.227981+00	21	MangopayUser object (21)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
561	2023-09-07 09:04:55.089543+00	20	MangopayUser object (20)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
562	2023-09-07 09:06:08.524269+00	19	MangopayUser object (19)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
563	2023-09-07 09:06:44.376502+00	18	MangopayUser object (18)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
564	2023-09-07 09:07:25.42623+00	17	MangopayUser object (17)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
565	2023-09-07 09:07:55.966327+00	16	MangopayUser object (16)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
566	2023-09-07 09:08:33.752034+00	14	MangopayUser object (14)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
567	2023-09-07 09:09:15.950937+00	13	MangopayUser object (13)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
568	2023-09-07 09:09:39.014549+00	15	MangopayUser object (15)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
569	2023-09-07 09:10:14.224265+00	12	MangopayUser object (12)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
570	2023-09-07 09:10:48.328768+00	11	MangopayUser object (11)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
571	2023-09-07 09:11:21.558362+00	10	MangopayUser object (10)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
572	2023-09-07 09:11:52.529196+00	9	MangopayUser object (9)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
573	2023-09-07 09:12:36.741982+00	8	MangopayUser object (8)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
574	2023-09-07 09:13:13.448534+00	7	MangopayUser object (7)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
575	2023-09-07 09:13:55.543271+00	6	MangopayUser object (6)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
576	2023-09-07 09:14:35.7683+00	5	MangopayUser object (5)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
577	2023-09-07 09:15:18.471948+00	4	MangopayUser object (4)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
578	2023-09-07 09:17:06.471152+00	3	MangopayUser object (3)	2	[]	27	1
579	2023-09-07 09:18:46.184151+00	1	MangopayUser object (1)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
580	2023-09-07 09:19:18.409563+00	2	MangopayUser object (2)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
581	2023-09-07 09:19:41.99479+00	3	MangopayUser object (3)	2	[{"changed": {"fields": ["Cod"]}}]	27	1
582	2023-09-07 11:46:09.088005+00	9	ConversationHistory object (9)	3		60	1
583	2023-09-07 11:46:09.090945+00	8	ConversationHistory object (8)	3		60	1
584	2023-09-07 11:46:09.093488+00	7	ConversationHistory object (7)	3		60	1
585	2023-09-07 11:46:09.09454+00	6	ConversationHistory object (6)	3		60	1
586	2023-09-07 11:46:09.095403+00	5	ConversationHistory object (5)	3		60	1
587	2023-09-07 11:46:09.096266+00	4	ConversationHistory object (4)	3		60	1
588	2023-09-07 11:46:09.096984+00	3	ConversationHistory object (3)	3		60	1
589	2023-09-07 11:46:09.097683+00	2	ConversationHistory object (2)	3		60	1
590	2023-09-07 11:46:09.098367+00	1	ConversationHistory object (1)	3		60	1
591	2023-09-07 12:56:09.822421+00	1	Wallet for r@whitebear.trading	2	[{"changed": {"fields": ["Cod"]}}]	29	1
592	2023-09-07 12:57:04.154831+00	15	Wallet for riccardo@braccaioli.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
593	2023-09-07 12:57:50.146878+00	66	Wallet for augustocp.coutinho@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
594	2023-09-07 17:04:09.439655+00	199	rodri.595@hotmail.com	2	[{"changed": {"fields": ["Staff status", "Superuser status"]}}]	7	1
595	2023-09-07 19:55:08.333545+00	2	Wallet for david.ramon.riera@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
596	2023-09-07 19:56:06.251593+00	3	Wallet for admin@claddingprices.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
597	2023-09-07 19:56:43.06499+00	4	Wallet for vcallejo@blockimpulse.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
598	2023-09-07 19:57:34.54835+00	5	Wallet for acallejo48@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
599	2023-09-07 19:58:08.991136+00	6	Wallet for kallejo@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
600	2023-09-07 19:58:39.369309+00	7	Wallet for ccallejo@stockencapital.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
601	2023-09-07 19:59:16.298799+00	8	Wallet for vila.ma@me.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
602	2023-09-07 19:59:38.950857+00	9	Wallet for pyreneestimingsolutions@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
603	2023-09-07 20:00:16.780678+00	10	Wallet for cbellver@claddingprices.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
604	2023-09-07 20:01:07.849077+00	11	Wallet for mmanriqueordax@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
605	2023-09-07 20:01:37.5844+00	12	Wallet for xperiend@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
606	2023-09-07 20:02:08.547857+00	13	Wallet for viktorcallejo@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
607	2023-09-07 20:02:38.129653+00	14	Wallet for humberto@twoforall.eu	2	[{"changed": {"fields": ["Cod"]}}]	29	1
608	2023-09-07 20:03:08.41469+00	16	Wallet for rdelcastillo@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
609	2023-09-07 20:03:35.659652+00	17	Wallet for consulting@blockimpulse.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
610	2023-09-07 20:03:57.541825+00	18	Wallet for fpalomar90@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
611	2023-09-07 20:04:28.743838+00	19	Wallet for persianasfotovoltaicas@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
612	2023-09-07 20:04:52.688598+00	20	Wallet for davidenkeeper@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
613	2023-09-07 20:06:00.108136+00	21	Wallet for exitoprospero@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
614	2023-09-07 20:06:25.566167+00	22	Wallet for cerocash2020@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
615	2023-09-07 20:07:01.109614+00	23	Wallet for benjaminespanolgarrigos@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
616	2023-09-07 20:07:23.223678+00	24	Wallet for evadibars@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
617	2023-09-07 20:07:53.512922+00	25	Wallet for btola18@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
618	2023-09-07 20:08:20.143119+00	26	Wallet for angie26504@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
619	2023-09-07 20:08:44.817302+00	27	Wallet for legu35@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
620	2023-09-07 20:09:06.784477+00	28	Wallet for estrellasanan@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
621	2023-09-07 20:09:41.132009+00	29	Wallet for harka78@icloud.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
622	2023-09-07 20:10:09.799751+00	30	Wallet for gemar68@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
623	2023-09-07 20:11:52.617632+00	31	Wallet for albertoxav@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
624	2023-09-07 20:12:14.298859+00	32	Wallet for anayeyu@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
625	2023-09-07 20:12:48.860646+00	33	Wallet for rubenalava@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
626	2023-09-07 20:13:11.919138+00	34	Wallet for dossmingo@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
627	2023-09-07 20:13:36.702421+00	35	Wallet for ondadali@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
628	2023-09-07 20:13:57.545631+00	36	Wallet for abrujos@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
629	2023-09-07 20:14:26.490459+00	37	Wallet for pilichitobarias12345@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
630	2023-09-07 20:14:57.273616+00	38	Wallet for quintorro81@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
631	2023-09-07 20:15:23.41322+00	39	Wallet for beatriche2bgt@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
632	2023-09-07 20:15:56.345487+00	40	Wallet for jlopez@somosecoenergy.es	2	[{"changed": {"fields": ["Cod"]}}]	29	1
633	2023-09-07 20:16:30.563446+00	41	Wallet for kardaskinges2011@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
634	2023-09-07 20:16:51.490608+00	42	Wallet for despertandoturealidad@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
635	2023-09-07 20:17:14.306943+00	43	Wallet for pcrsoluciones@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
636	2023-09-07 20:17:41.794818+00	44	Wallet for posesodegerasa@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
637	2023-09-07 20:18:18.596909+00	45	Wallet for josebaiglesiasvilanova@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
638	2023-09-07 20:18:44.994073+00	46	Wallet for sandracasado13@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
639	2023-09-07 20:19:07.18965+00	47	Wallet for monica.villar.fernandez@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
640	2023-09-07 20:19:32.799337+00	48	Wallet for jesusrm.rr@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
641	2023-09-07 20:19:55.817183+00	49	Wallet for mariarodriguezmena92@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
642	2023-09-07 20:20:17.553853+00	50	Wallet for esperanza67147@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
643	2023-09-07 20:20:57.272172+00	51	Wallet for esterue@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
644	2023-09-07 20:21:21.660953+00	52	Wallet for soniadeba@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
645	2023-09-07 20:21:43.639305+00	53	Wallet for joitturri@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
646	2023-09-07 20:22:20.939826+00	54	Wallet for davidruemanonelles@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
647	2023-09-07 20:22:45.308053+00	55	Wallet for carmenhr2006@hotmail.es	2	[{"changed": {"fields": ["Cod"]}}]	29	1
648	2023-09-07 20:23:06.884653+00	56	Wallet for javipersuasivo@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
649	2023-09-07 20:23:28.569633+00	57	Wallet for elmeunil@hotmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
650	2023-09-07 20:23:53.45981+00	58	Wallet for roberto.espinosavera@yahoo.com.mx	2	[{"changed": {"fields": ["Cod"]}}]	29	1
651	2023-09-07 20:24:13.215572+00	59	Wallet for rossamador1122@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
652	2023-09-07 20:24:34.501834+00	60	Wallet for ainhoagalarraga@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
653	2023-09-07 20:25:10.330105+00	61	Wallet for nuskita555@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
654	2023-09-07 20:25:34.179455+00	62	Wallet for adriangarciacristina@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
655	2023-09-07 20:25:54.606045+00	63	Wallet for ligia.angela.ventura@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
656	2023-09-07 20:26:13.817026+00	64	Wallet for liuwangpt@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
657	2023-09-07 20:26:33.135997+00	65	Wallet for nereplen@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
658	2023-09-07 20:27:32.643256+00	67	Wallet for m.garmendia2001@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
659	2023-09-07 20:27:55.251908+00	68	Wallet for trabajarparati@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
660	2023-09-07 20:28:16.564528+00	69	Wallet for arrazayuya@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
661	2023-09-07 20:28:37.682479+00	70	Wallet for silvia.mayfairbar@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
662	2023-09-07 20:29:19.094344+00	71	Wallet for kallejo+3@gmail.com	2	[{"changed": {"fields": ["Cod"]}}]	29	1
663	2023-09-08 08:05:59.331695+00	11	No cod	3		23	1
664	2023-09-08 08:05:59.334445+00	10	No cod	3		23	1
665	2023-09-08 08:05:59.335685+00	9	No cod	3		23	1
666	2023-09-08 08:05:59.336833+00	8	No cod	3		23	1
670	2023-09-08 08:05:59.343111+00	2	No cod	3		23	1
671	2023-09-08 08:08:33.98241+00	3	User pf_74 sell 500 shares for 1.00 each	2	[{"changed": {"fields": ["User/Company"]}}]	23	1
672	2023-09-08 08:08:40.243415+00	3	User pf_74 sell 500 shares for 1.00 each	2	[]	23	1
673	2023-09-08 08:41:49.137771+00	24	Triac soluctions	2	[{"changed": {"fields": ["Status"]}}]	9	1
674	2023-09-08 08:44:25.144307+00	92	thiagocmachado@yahoo.com.br	2	[{"changed": {"fields": ["Status"]}}]	7	1
675	2023-09-08 08:55:57.738075+00	24	Triac soluctions	2	[{"changed": {"fields": ["Published"]}}]	9	1
676	2023-09-08 09:01:44.346695+00	24	Triac Soluctions	2	[{"changed": {"fields": ["Social denomination", "Description"]}}]	9	1
677	2023-09-08 11:04:42.166715+00	1	viktorcallejo@gmail.com - ESCRITOR TOKENIZADO SL	3		14	1
678	2023-09-08 11:04:42.169982+00	2	rdelcastillo@gmail.com - ESCRITOR TOKENIZADO SL	3		14	1
679	2023-09-08 11:04:42.171458+00	3	kallejo@gmail.com - Block Impulse SL	3		14	1
680	2023-09-08 11:04:42.172424+00	4	ccallejo@stockencapital.com - Block Impulse SL	3		14	1
681	2023-09-08 11:04:42.173308+00	9	acallejo48@gmail.com - Block Impulse SL	3		14	1
682	2023-09-08 11:06:31.855687+00	4	[ASSIGNMENT] kallejo@gmail.com: 1500	3		20	1
683	2023-09-08 11:06:31.85822+00	3	[ASSIGNMENT] rdelcastillo@gmail.com: 1500	3		20	1
684	2023-09-08 11:06:31.859887+00	2	[ASSIGNMENT] viktorcallejo@gmail.com: 1500	3		20	1
685	2023-09-08 11:06:31.860889+00	6	[BUY_AND_SELL] ccallejo@stockencapital.com: 1	3		20	1
686	2023-09-08 11:06:31.862515+00	5	[BUY_AND_SELL] ccallejo@stockencapital.com: 1	3		20	1
687	2023-09-08 11:06:31.865002+00	7	[ASSIGNMENT] acallejo48@gmail.com: 1	3		20	1
688	2023-09-08 11:09:09.744759+00	23	kallejo@gmail.com	2	[{"changed": {"fields": ["password"]}}]	7	1
689	2023-09-08 13:13:49.923918+00	16	Meeting document - 740f3357c2b2a1cfdc0ea99fab97	3		17	1
690	2023-09-08 13:13:49.926202+00	15	Meeting document - c696f28112823329ec818865ba9f	3		17	1
691	2023-09-08 13:13:49.927069+00	14	Meeting document - aacd608fe0271f376264436c4723	3		17	1
692	2023-09-08 13:13:49.927825+00	13	Meeting document - 51837838988fc3b4791633286866	3		17	1
693	2023-09-08 13:13:49.928915+00	12	Meeting document - 522bbd43105043fdded0b499e68c	3		17	1
694	2023-09-08 13:13:49.929613+00	11	Meeting document - 6dbc2d07310bb8f68c61cd9b47db	3		17	1
695	2023-09-08 13:13:49.930379+00	10	Meeting document - 6dbc2d07310bb8f68c61cd9b47db	3		17	1
696	2023-09-08 13:13:49.931152+00	9	Meeting document - 002ebfc69dc339ba57642f6345a2	3		17	1
697	2023-09-08 13:13:49.931913+00	8	Meeting document - ddad0ebd47db5b7065672b71bbb3	3		17	1
698	2023-09-08 13:13:49.932664+00	7	Meeting document - d48abe2c1f093808b6e1b5aedf84	3		17	1
699	2023-09-08 13:13:49.933348+00	6	Meeting document - eeeb987b45b3e52f66615e9f59f0	3		17	1
700	2023-09-08 13:13:49.934481+00	5	Meeting document - 8fa59ad3a0784dc8131f03ac61a7	3		17	1
701	2023-09-08 13:13:49.935176+00	4	Meeting document - ea9c6aad3deb50278eece02cb206	3		17	1
702	2023-09-08 13:13:49.935864+00	3	Meeting document - a33a1a043b2e10aaad3af204039e	3		17	1
703	2023-09-08 13:13:49.936614+00	2	Meeting document - ffa69497d697a2f19672c36b5e20	3		17	1
704	2023-09-08 13:13:49.937393+00	1	Meeting document - 7517b0cd712ae30a5f33366f4e92	3		17	1
705	2023-09-08 13:13:59.73881+00	13	Triac Soluctions - 2023-09-09	3		15	1
706	2023-09-08 13:13:59.741724+00	9	Block Impulse SL - 2023-06-30	3		15	1
707	2023-09-08 13:13:59.742693+00	8	Block Impulse SL - 2023-06-21	3		15	1
708	2023-09-08 13:13:59.743689+00	6	Block Impulse SL - 2023-06-07	3		15	1
709	2023-09-08 13:21:31.847298+00	25	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo@gmail.com	2	[{"changed": {"fields": ["State"]}}]	24	1
710	2023-09-08 13:23:33.936356+00	25	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo@gmail.com	2	[]	24	1
711	2023-09-08 13:32:43.752192+00	4	Triac Soluctions 1 2023-09-15	2	[{"changed": {"fields": ["New share capital"]}}]	26	1
712	2023-09-08 13:34:49.491447+00	4	Triac Soluctions 1 2023-09-15	3		26	1
713	2023-09-08 13:36:18.369145+00	2	Block Impulse SL 100 2023-04-15	3		26	1
714	2023-09-08 13:40:45.387876+00	16	Company pj_4 sell 2 shares for 1.00 each	2	[{"changed": {"fields": ["User/Company", "For user"]}}]	23	1
715	2023-09-08 13:42:30.68734+00	16	Company pj_4 sell 2 shares for 1.00 each	2	[]	23	1
716	2023-09-09 09:08:13.378672+00	25	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo@gmail.com	2	[{"changed": {"fields": ["State"]}}]	24	1
717	2023-09-09 09:12:16.064933+00	1	benjaminespanolgarrigos@gmail.com proposes 7 shares for 1.00 each to riccardo@braccaioli.com	2	[{"changed": {"fields": ["COD"]}}]	24	1
718	2023-09-09 09:12:43.305686+00	2	cerocash2020@gmail.com proposes 5 shares for 1.00 each to riccardo@braccaioli.com	2	[{"changed": {"fields": ["COD"]}}]	24	1
719	2023-09-09 09:13:14.641963+00	3	harka78@icloud.com proposes 2 shares for 1.00 each to riccardo@braccaioli.com	2	[{"changed": {"fields": ["COD"]}}]	24	1
720	2023-09-09 09:13:34.537669+00	4	harka78@icloud.com proposes 2 shares for 1.00 each to riccardo@braccaioli.com	2	[{"changed": {"fields": ["COD"]}}]	24	1
721	2023-09-09 09:13:41.311121+00	5	harka78@icloud.com proposes 1 shares for 1.00 each to riccardo@braccaioli.com	2	[{"changed": {"fields": ["COD"]}}]	24	1
722	2023-09-09 09:14:11.005394+00	6	evadibars@gmail.com proposes 5 shares for 1.00 each to riccardo@braccaioli.com	2	[{"changed": {"fields": ["COD"]}}]	24	1
723	2023-09-09 09:14:38.218457+00	7	dossmingo@gmail.com proposes 5 shares for 1.00 each to riccardo@braccaioli.com	2	[{"changed": {"fields": ["COD"]}}]	24	1
724	2023-09-09 09:14:57.258951+00	8	pilichitobarias12345@gmail.com proposes 2 shares for 1.00 each to riccardo@braccaioli.com	2	[{"changed": {"fields": ["COD"]}}]	24	1
725	2023-09-09 09:15:15.148431+00	10	kardaskinges2011@gmail.com proposes 1 shares for 1.00 each to riccardo@braccaioli.com	2	[{"changed": {"fields": ["COD"]}}]	24	1
726	2023-09-09 09:15:33.084431+00	11	beatriche2bgt@hotmail.com proposes 2 shares for 1.00 each to riccardo@braccaioli.com	2	[{"changed": {"fields": ["COD"]}}]	24	1
727	2023-09-09 09:15:58.388781+00	12	pilichitobarias12345@gmail.com proposes 1 shares for 1.00 each to riccardo@braccaioli.com	2	[{"changed": {"fields": ["COD"]}}]	24	1
728	2023-09-09 09:16:06.250919+00	17	pilichitobarias12345@gmail.com proposes 2 shares for 1.00 each to riccardo@braccaioli.com	2	[{"changed": {"fields": ["COD"]}}]	24	1
729	2023-09-09 09:16:26.994458+00	13	jlopez@somosecoenergy.es proposes 4 shares for 1.00 each to riccardo@braccaioli.com	2	[{"changed": {"fields": ["COD"]}}]	24	1
730	2023-09-09 09:16:48.44815+00	19	despertandoturealidad@gmail.com proposes 1 shares for 1.00 each to riccardo@braccaioli.com	2	[{"changed": {"fields": ["COD"]}}]	24	1
731	2023-09-09 09:17:09.46371+00	20	monica.villar.fernandez@gmail.com proposes 1 shares for 1.00 each to riccardo@braccaioli.com	2	[{"changed": {"fields": ["COD"]}}]	24	1
732	2023-09-09 09:17:32.58035+00	22	abrujos@hotmail.com proposes 5 shares for 1.00 each to riccardo@braccaioli.com	2	[{"changed": {"fields": ["COD"]}}]	24	1
733	2023-09-09 09:17:54.53239+00	23	trabajarparati@gmail.com proposes 1 shares for 1.00 each to riccardo@braccaioli.com	2	[{"changed": {"fields": ["COD"]}}]	24	1
734	2023-09-09 09:58:45.12383+00	23	kallejo@gmail.com	2	[{"changed": {"fields": ["Staff status"]}}]	7	92
735	2023-09-09 10:13:21.788133+00	25	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo@gmail.com	2	[{"changed": {"fields": ["State"]}}]	24	92
736	2023-09-09 10:22:54.727875+00	25	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo@gmail.com	2	[{"changed": {"fields": ["State"]}}]	24	92
737	2023-09-09 10:23:53.869935+00	25	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo@gmail.com	2	[{"changed": {"fields": ["State"]}}]	24	92
738	2023-09-09 10:24:53.419294+00	25	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo@gmail.com	2	[{"changed": {"fields": ["State"]}}]	24	92
739	2023-09-09 10:32:11.921671+00	25	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo@gmail.com	2	[{"changed": {"fields": ["State"]}}]	24	92
740	2023-09-09 12:03:40.614023+00	25	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo@gmail.com	2	[{"changed": {"fields": ["State"]}}]	24	92
741	2023-09-09 12:09:25.054124+00	25	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo@gmail.com	2	[{"changed": {"fields": ["State"]}}]	24	92
742	2023-09-09 18:48:07.535435+00	25	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo@gmail.com	2	[{"changed": {"fields": ["State"]}}]	24	92
743	2023-09-09 19:31:35.443525+00	25	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo@gmail.com	2	[{"changed": {"fields": ["State"]}}]	24	92
744	2023-09-10 15:07:03.449544+00	24	teste	1	[{"added": {}}]	10	92
745	2023-09-10 15:11:47.072685+00	25	teste testeo	1	[{"added": {}}]	10	92
746	2023-09-11 06:24:42.317272+00	25	teste testeo	3		10	92
747	2023-09-11 06:24:42.320732+00	24	teste	3		10	92
748	2023-09-11 06:24:42.322058+00	23	test	3		10	92
749	2023-09-11 06:24:42.323036+00	22	test	3		10	92
750	2023-09-11 06:25:18.869683+00	26	teste	1	[{"added": {}}]	10	92
751	2023-09-11 06:29:24.919608+00	26	teste	3		10	92
752	2023-09-11 06:29:54.219636+00	27	teste testeo	1	[{"added": {}}]	10	92
753	2023-09-11 07:28:31.394536+00	266	thiagocmach@gmail.com	2	[{"changed": {"fields": ["Staff status"]}}]	7	92
754	2023-09-11 07:31:36.809719+00	28	ccallejo@stockencapital.com	2	[{"changed": {"fields": ["Staff status"]}}]	7	92
755	2023-09-11 07:33:03.042023+00	28	7487d096f7e8702c7c11c478f78194b298fe386a	1	[{"added": {}}]	38	92
756	2023-09-11 08:18:18.41035+00	28	7487d096f7e8702c7c11c478f78194b298fe386a	3		38	92
757	2023-09-11 08:22:47.473304+00	13	4974bf7466400f85fa9523842da7d801afc701f5	1	[{"added": {}}]	38	92
758	2023-09-11 08:36:21.311454+00	13	4974bf7466400f85fa9523842da7d801afc701f5	3		38	92
759	2023-09-11 08:44:53.085613+00	28	ccallejo@stockencapital.com	2	[]	7	92
760	2023-09-11 14:56:40.395125+00	25	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo@gmail.com	2	[{"changed": {"fields": ["State"]}}]	24	92
761	2023-09-11 15:03:34.684498+00	25	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo@gmail.com	2	[{"changed": {"fields": ["State"]}}]	24	92
762	2023-09-11 15:05:12.014792+00	25	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo@gmail.com	2	[{"changed": {"fields": ["State"]}}]	24	92
763	2023-09-11 15:06:42.054263+00	25	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo@gmail.com	2	[{"changed": {"fields": ["State"]}}]	24	92
764	2023-09-11 15:07:42.052751+00	25	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo@gmail.com	2	[{"changed": {"fields": ["State"]}}]	24	92
765	2023-09-11 15:48:11.136787+00	15	User pf_95 sell 2 shares for 1.00 each	2	[{"changed": {"fields": ["User/Company"]}}]	23	92
766	2023-09-12 06:19:44.016273+00	33	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo@gmail.com	2	[{"changed": {"fields": ["State"]}}]	24	92
767	2023-09-12 06:21:22.429472+00	33	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo@gmail.com	2	[{"changed": {"fields": ["State"]}}]	24	92
768	2023-09-12 07:26:02.103106+00	8	Triac Soluctions 1 2023-09-12	2	[{"changed": {"fields": ["State"]}}]	26	92
769	2023-09-12 07:39:19.337708+00	34	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to thiagocmach@gmail.com	2	[{"changed": {"fields": ["State"]}}]	24	92
770	2023-09-12 09:12:52.903641+00	6	Wallet for kallejo@gmail.com	2	[{"changed": {"fields": ["Amount"]}}]	29	1
771	2023-09-12 09:28:20.844392+00	6	Wallet for kallejo@gmail.com	2	[{"changed": {"fields": ["Amount"]}}]	29	1
772	2023-09-12 10:22:17.587608+00	24	Meeting document - b7758a5330b61e5c41adb464fa9a	1	[{"added": {}}]	17	92
773	2023-09-12 10:35:25.563404+00	25	Meeting document - b7758a5330b61e5c41adb464fa9a	1	[{"added": {}}]	17	92
774	2023-09-12 16:05:51.260336+00	10	Portfolio 2023	3		10	1
775	2023-09-12 16:14:03.769553+00	5	Hola probando 2	3		21	1
776	2023-09-12 16:14:03.77201+00	4	rod	3		21	1
777	2023-09-12 16:14:03.773028+00	3	Prueba	3		21	1
778	2023-09-12 16:14:03.774215+00	2	Hola quiero información	3		21	1
779	2023-09-12 16:14:03.775065+00	1	Prueba mensaje empresa	3		21	1
780	2023-09-12 16:17:47.340898+00	5	Hola, mensaje desde la empresa Block Impulse SL	1	[{"added": {}}]	22	1
781	2023-09-12 16:18:03.381277+00	11	ConversationHistory object (11)	2	[{"changed": {"fields": ["Conversation"]}}]	60	1
782	2023-09-13 14:56:38.638656+00	24	Block Impulse SL - 2023-09-14	2	[{"changed": {"fields": ["Planned date"]}}, {"changed": {"name": "agenda item", "object": "Nueva incorporaci\\u00f3n al departamento t\\u00e9cnico", "fields": ["Proposal agreement"]}}]	15	1
783	2023-09-14 08:10:11.809521+00	3	vcallejo@blockimpulse.com - Nueva incorporación al departamento técnico	3		19	92
784	2023-09-14 08:46:25.922833+00	6	vcallejo@blockimpulse.com - Nueva incorporación al departamento técnico	3		19	92
785	2023-09-14 09:26:24.38174+00	7	vcallejo@blockimpulse.com - Aprobación nuevo presupuesto marketing	3		19	92
786	2023-09-14 09:26:28.347475+00	8	vcallejo@blockimpulse.com - Nueva incorporación al departamento técnico	3		19	92
787	2023-09-14 10:19:21.54441+00	48	Meeting document - acd78dfc6ef8de94c8dc36584259	2	[{"changed": {"fields": ["Agenda item"]}}]	17	92
788	2023-09-14 10:25:50.929794+00	14	thiagocmachado@yahoo.com.br - Triac Soluctions	1	[{"added": {}}]	14	92
789	2023-09-14 10:26:23.668632+00	14	thiagocmachado@yahoo.com.br - Triac Soluctions	2	[]	14	92
790	2023-09-14 10:27:03.818476+00	14	thiagocmachado@yahoo.com.br - Triac Soluctions	3		14	92
791	2023-09-14 10:30:52.20121+00	26	Block Impulse SL - 2023-09-21	2	[{"changed": {"fields": ["State"]}}, {"changed": {"name": "agenda item", "object": "Orden del d\\u00eda 3", "fields": ["Proposal agreement"]}}, {"changed": {"name": "agenda item", "object": "Orden del d\\u00eda 1", "fields": ["Proposal agreement"]}}, {"changed": {"name": "agenda item", "object": "Orden del d\\u00eda 2", "fields": ["Proposal agreement"]}}]	15	92
792	2023-09-14 10:45:35.967105+00	26	Block Impulse SL - 2023-09-21	2	[{"changed": {"fields": ["State"]}}]	15	92
793	2023-09-14 10:51:16.558582+00	11	vcallejo@blockimpulse.com - Orden del día 3	3		19	92
794	2023-09-14 10:51:16.560397+00	12	vcallejo@blockimpulse.com - Orden del día 1	3		19	92
795	2023-09-14 10:51:16.562061+00	13	vcallejo@blockimpulse.com - Orden del día 2	3		19	92
796	2023-09-14 11:21:11.116487+00	13	vcallejo@blockimpulse.com	2	[{"changed": {"fields": ["Staff status"]}}]	7	92
797	2023-09-14 11:24:18.083092+00	9	vcallejo@blockimpulse.com - Nueva incorporación al departamento técnico	3		19	92
798	2023-09-14 11:24:18.085624+00	10	vcallejo@blockimpulse.com - Aprobación nuevo presupuesto marketing	3		19	92
799	2023-09-14 11:24:18.086788+00	14	vcallejo@blockimpulse.com - Orden del día 3	3		19	92
800	2023-09-14 11:24:18.088334+00	15	vcallejo@blockimpulse.com - Orden del día 1	3		19	92
801	2023-09-14 11:24:18.089109+00	16	vcallejo@blockimpulse.com - Orden del día 2	3		19	92
802	2023-09-15 14:36:33.606826+00	13	vcallejo@blockimpulse.com	2	[{"changed": {"fields": ["Status"]}}]	7	92
803	2023-09-15 14:37:02.4124+00	13	vcallejo@blockimpulse.com	2	[{"changed": {"fields": ["Status"]}}]	7	92
804	2023-09-15 15:40:24.85012+00	13	vcallejo@blockimpulse.com	2	[{"changed": {"fields": ["Cod"]}}]	7	92
805	2023-09-15 15:45:17.095564+00	13	vcallejo@blockimpulse.com	2	[{"changed": {"fields": ["Cod"]}}]	7	92
806	2023-09-15 15:48:56.782749+00	13	vcallejo@blockimpulse.com	2	[{"changed": {"fields": ["Cod"]}}]	7	92
807	2023-09-15 15:49:35.452009+00	13	vcallejo@blockimpulse.com	2	[]	7	92
808	2023-09-17 17:26:21.402117+00	13	vcallejo@blockimpulse.com	2	[{"changed": {"fields": ["Cod"]}}]	7	92
809	2023-09-17 22:01:08.868867+00	9	Block Impulse SL 10 2023-10-10	3		26	1
810	2023-09-17 22:01:08.871487+00	8	Triac Soluctions 1 2023-09-12	3		26	1
811	2023-09-17 22:01:08.872711+00	7	Triac Soluctions 1 2023-09-11	3		26	1
812	2023-09-17 22:01:08.873451+00	6	Block Impulse SL 2 2023-08-10	3		26	1
813	2023-09-17 22:01:08.874112+00	5	Triac Soluctions 2 2023-01-01	3		26	1
814	2023-09-17 22:01:27.019513+00	25	Nike SL	3		9	1
815	2023-09-17 22:03:21.805833+00	9	Capital Riesgo	1	[{"added": {}}]	55	1
816	2023-09-17 22:03:35.228364+00	10	Otros	1	[{"added": {}}]	55	1
817	2023-09-17 22:04:16.735037+00	14	MENTORIA DEL HOGAR, SL	2	[{"changed": {"fields": ["Categories"]}}]	9	1
818	2023-09-17 22:04:51.902338+00	13	ESCRITOR TOKENIZADO SL	2	[{"changed": {"fields": ["Categories"]}}]	9	1
819	2023-09-17 22:04:56.880002+00	24	Triac Soluctions	2	[]	9	1
820	2023-09-17 22:05:09.781285+00	10	SERSEO INBOUND MARKETING SL	2	[{"changed": {"fields": ["Categories"]}}]	9	1
821	2023-09-17 22:05:28.274905+00	9	BELLVER REPRESENTACIONES S.L.	2	[{"changed": {"fields": ["Categories"]}}]	9	1
822	2023-09-17 22:06:01.348155+00	10	Otros	3		55	1
823	2023-09-17 22:06:23.503671+00	8	Twoforall International Investment, S.L.	2	[{"changed": {"fields": ["Categories"]}}]	9	1
824	2023-09-17 22:06:37.611118+00	7	Tierra Audio SL	2	[{"changed": {"fields": ["Categories"]}}]	9	1
825	2023-09-17 22:06:46.519253+00	6	Barbatus Aeronautics SL	2	[{"changed": {"fields": ["Categories"]}}]	9	1
826	2023-09-17 22:06:57.761519+00	5	Big Election SL	2	[{"changed": {"fields": ["Categories"]}}]	9	1
827	2023-09-17 22:07:07.010851+00	4	Block Impulse SL	2	[{"changed": {"fields": ["Categories"]}}]	9	1
828	2023-09-17 22:07:23.028039+00	3	CLADDING AND FLOORS SL	2	[{"changed": {"fields": ["Categories"]}}]	9	1
829	2023-09-17 22:07:42.446445+00	1	White Bear Trading SL	2	[{"changed": {"fields": ["Categories"]}}]	9	1
830	2023-09-17 22:07:58.033847+00	16	Prueba 16 sept	3		21	1
831	2023-09-17 22:07:58.035202+00	15	asdasdsad	3		21	1
832	2023-09-17 22:07:58.036012+00	14	sadsadsad	3		21	1
833	2023-09-17 22:07:58.036642+00	13	1	3		21	1
834	2023-09-17 22:07:58.037414+00	12	prueba 3	3		21	1
835	2023-09-17 22:07:58.038012+00	11	teste	3		21	1
836	2023-09-17 22:07:58.038681+00	10	Assunto da conversa	3		21	1
837	2023-09-17 22:07:58.039302+00	8	transfer to other account	3		21	1
838	2023-09-17 22:07:58.039959+00	7	Kallejo@gmail.com	3		21	1
839	2023-09-17 22:08:11.865326+00	19	ConversationHistory object (19)	3		60	1
840	2023-09-17 22:08:11.866125+00	18	ConversationHistory object (18)	3		60	1
841	2023-09-17 22:08:11.866819+00	17	ConversationHistory object (17)	3		60	1
842	2023-09-17 22:08:11.867703+00	16	ConversationHistory object (16)	3		60	1
843	2023-09-17 22:08:11.868396+00	15	ConversationHistory object (15)	3		60	1
844	2023-09-17 22:08:11.869078+00	14	ConversationHistory object (14)	3		60	1
845	2023-09-17 22:08:11.869757+00	13	ConversationHistory object (13)	3		60	1
846	2023-09-17 22:08:11.870599+00	12	ConversationHistory object (12)	3		60	1
847	2023-09-17 22:08:11.871223+00	11	ConversationHistory object (11)	3		60	1
848	2023-09-17 22:08:11.872087+00	10	ConversationHistory object (10)	3		60	1
849	2023-09-17 22:08:46.774133+00	29	Prueba 3	3		10	1
850	2023-09-17 22:08:46.775337+00	28	Portfolio 2023	3		10	1
851	2023-09-17 22:08:46.776066+00	27	teste testeo	3		10	1
852	2023-09-17 22:08:46.776999+00	21	Prueba socios	3		10	1
853	2023-09-17 22:09:08.311419+00	31	Block Impulse SL - 2023-10-10	3		15	1
854	2023-09-17 22:09:08.312348+00	30	Block Impulse SL - 2023-09-17	3		15	1
855	2023-09-17 22:09:08.313037+00	29	Block Impulse SL - 2023-09-15	3		15	1
856	2023-09-17 22:09:08.313705+00	28	Triac Soluctions - 2023-09-14	3		15	1
857	2023-09-17 22:09:08.314347+00	27	Block Impulse SL - 2023-10-10	3		15	1
858	2023-09-17 22:09:08.314956+00	26	Block Impulse SL - 2023-09-21	3		15	1
859	2023-09-17 22:09:08.315574+00	25	Triac Soluctions - 2023-09-21	3		15	1
860	2023-09-17 22:09:08.316205+00	24	Block Impulse SL - 2023-09-14	3		15	1
861	2023-09-17 22:09:08.31681+00	23	Triac Soluctions - 2023-09-15	3		15	1
862	2023-09-17 22:09:08.317455+00	22	Triac Soluctions - 2023-09-15	3		15	1
863	2023-09-17 22:09:08.318053+00	21	Triac Soluctions - 2023-09-22	3		15	1
864	2023-09-17 22:09:08.318649+00	20	Triac Soluctions - 2020-10-24	3		15	1
865	2023-09-17 22:09:08.319245+00	19	Triac Soluctions - 2023-09-15	3		15	1
866	2023-09-17 22:09:08.319869+00	18	Triac Soluctions - 2023-09-22	3		15	1
867	2023-09-17 22:09:08.320532+00	17	Triac Soluctions - 2023-09-14	3		15	1
868	2023-09-17 22:09:08.321122+00	16	Triac Soluctions - 2023-09-15	3		15	1
869	2023-09-17 22:09:08.321739+00	15	Triac Soluctions - 2023-09-14	3		15	1
870	2023-09-17 22:09:08.322337+00	14	Block Impulse SL - 2023-10-10	3		15	1
871	2023-09-17 22:09:17.788842+00	61	Meeting document - d15bdc2ce605a0f96b1f32c5378e	3		17	1
872	2023-09-17 22:09:17.789778+00	60	Meeting document - 4bc9cd78a7c19522fc26bbcf733d	3		17	1
873	2023-09-17 22:09:17.790498+00	58	Meeting document - 8f80a11acc7c2014ff41d88e994f	3		17	1
874	2023-09-17 22:09:17.7912+00	56	Meeting document - db1679cc3cd64d82f121896f3393	3		17	1
875	2023-09-17 22:09:17.792463+00	55	Meeting document - 2420d10392adbdd3ba2c86d1a372	3		17	1
876	2023-09-17 22:09:17.793115+00	54	Meeting document - 2420d10392adbdd3ba2c86d1a372	3		17	1
877	2023-09-17 22:09:17.793761+00	53	Meeting document - 92900794395f3a4669bc50e24852	3		17	1
878	2023-09-17 22:09:17.794371+00	48	Meeting document - acd78dfc6ef8de94c8dc36584259	3		17	1
879	2023-09-17 22:09:17.795005+00	47	Meeting document - bc55ba466d572839c93d9bd2aacc	3		17	1
880	2023-09-17 22:09:46.081809+00	29	User pf_13 sell 1 shares for 1.00 each	3		23	1
881	2023-09-17 22:09:46.08337+00	28	User pf_23 sell 1 shares for 1.00 each	3		23	1
882	2023-09-17 22:10:06.207365+00	10	[ASSIGNMENT] kallejo@gmail.com: 1500	3		20	1
883	2023-09-17 22:10:06.208296+00	11	[ASSIGNMENT] vcallejo@blockimpulse.com: 1500	3		20	1
884	2023-09-17 22:12:52.498796+00	12	kallejo@gmail.com - Block Impulse SL	3		14	1
885	2023-09-17 22:12:52.499937+00	13	vcallejo@blockimpulse.com - Block Impulse SL	3		14	1
886	2023-09-17 22:19:02.986296+00	13	vcallejo@blockimpulse.com	2	[{"changed": {"fields": ["Phone number", "Marital status", "Id document number", "Id document type"]}}, {"changed": {"name": "fiscal residence", "object": "FiscalResidence object (120)", "fields": ["Address", "City", "Postal code", "State"]}}]	7	1
887	2023-09-17 22:20:07.559343+00	13	vcallejo@blockimpulse.com	2	[{"changed": {"name": "fiscal residence", "object": "FiscalResidence object (120)", "fields": ["Address", "City", "Postal code", "State"]}}]	7	1
888	2023-09-17 22:55:01.77547+00	10	Block Impulse SL 1000 2023-11-10	3		26	1
889	2023-09-17 22:58:05.674832+00	13	Wallet for viktorcallejo@gmail.com	2	[{"changed": {"fields": ["Wallet id"]}}]	29	1
890	2023-09-17 22:58:15.779221+00	13	Wallet for viktorcallejo@gmail.com	2	[{"changed": {"fields": ["Amount"]}}]	29	1
891	2023-09-18 08:52:56.249353+00	34	Thiago	1	[{"added": {}}]	10	92
892	2023-09-18 08:53:10.867689+00	34	Thiago	3		10	92
893	2023-09-18 12:36:14.462306+00	99	kallejo@gmail.com 5.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	92
894	2023-09-18 12:36:22.207313+00	98	kallejo@gmail.com 5.00 EUR	2	[{"changed": {"fields": ["Cod"]}}]	32	92
895	2023-09-19 04:45:17.889017+00	23	1	3		21	1
896	2023-09-19 04:45:17.890834+00	22	transfer to other account	3		21	1
897	2023-09-19 04:45:17.891685+00	20	HOLA	3		21	1
898	2023-09-19 04:45:17.892337+00	19	test5	3		21	1
899	2023-09-19 04:45:17.892927+00	18	test4	3		21	1
900	2023-09-19 04:45:17.893508+00	17	test	3		21	1
901	2023-09-19 06:15:32.024578+00	33	Block Impulse SL - 2023-09-29	3		15	1
902	2023-09-19 06:15:32.026899+00	32	Block Impulse SL - 2023-09-21	3		15	1
903	2023-09-21 10:25:53.006716+00	187	xavier@xepigar.com	2	[{"changed": {"fields": ["password"]}}]	7	1
904	2023-09-21 10:27:10.257463+00	187	xavier@xepigar.com	2	[{"changed": {"fields": ["Verified"]}}]	7	1
905	2023-09-22 16:28:47.390514+00	11	Esto es un mensaje de prueba	1	[{"added": {}}]	22	1
906	2023-09-23 10:56:09.330899+00	11	Esto es un mensaje de prueba	2	[{"changed": {"fields": ["Conversation"]}}]	22	1
907	2023-09-27 17:39:10.456055+00	159	leirecs@gmail.com	2	[{"changed": {"fields": ["password"]}}]	7	1
908	2023-09-27 17:48:50.186016+00	159	leirecs@gmail.com	2	[{"changed": {"fields": ["password"]}}]	7	1
909	2023-10-07 06:56:03.282291+00	8	pilichitobarias12345@gmail.com proposes 2 shares for 1.00 each to riccardo@braccaioli.com	2	[{"changed": {"fields": ["State"]}}]	24	1
910	2023-10-07 06:57:20.447657+00	17	pilichitobarias12345@gmail.com proposes 2 shares for 1.00 each to riccardo@braccaioli.com	2	[{"changed": {"fields": ["State"]}}]	24	1
911	2023-10-17 20:42:29.168075+00	27	Castillo Coca	2	[{"changed": {"fields": ["Constitution date", "Number of shares", "Share capital", "Par value per share", "Status"]}}]	9	1
912	2023-10-17 21:05:10.831923+00	41	consulting@blockimpulse.com proposes 1 shares for 1.00 each to kallejo@gmail.com	2	[{"changed": {"fields": ["State"]}}]	24	1
913	2023-10-17 21:05:43.061057+00	41	consulting@blockimpulse.com proposes 1 shares for 1.00 each to kallejo@gmail.com	2	[{"changed": {"fields": ["State"]}}]	24	1
914	2023-10-18 11:25:34.375847+00	185	carmenhr2006@hotmail.es	2	[{"changed": {"fields": ["First name", "Last name"]}}]	7	1
915	2023-10-18 11:27:36.852579+00	185	carmenhr2006@hotmail.es	2	[{"changed": {"fields": ["password"]}}]	7	1
916	2023-10-18 11:37:08.301385+00	185	carmenhr2006@hotmail.es	2	[{"changed": {"fields": ["password"]}}]	7	1
917	2023-10-18 12:24:20.94827+00	313	nurugu@gmail.com	2	[{"changed": {"fields": ["Verified"]}}]	7	1
918	2023-10-18 15:04:06.566224+00	100	ondadali@gmail.com	2	[{"changed": {"fields": ["Birthday"]}}]	7	1
919	2023-10-18 22:35:41.155547+00	324	alvarolinarescabre+chamo00@gmail.com	2	[{"changed": {"fields": ["Status"]}}]	7	92
920	2023-10-19 11:57:04.989342+00	188	elmeunil@hotmail.com	2	[{"changed": {"fields": ["Birthday"]}}]	7	1
921	2023-10-19 19:01:34.752497+00	96	legu35@gmail.com	2	[{"changed": {"fields": ["Birthday"]}}]	7	1
922	2023-10-22 09:09:32.664334+00	193	silvia.mayfairbar@gmail.com	2	[{"changed": {"fields": ["Birthday"]}}]	7	1
923	2023-10-22 18:00:57.25134+00	307	wysocki1810@gmail.com	2	[{"changed": {"fields": ["Verified"]}}]	7	1
924	2023-10-22 18:01:41.013103+00	111	pcrsoluciones@gmail.com	2	[{"changed": {"fields": ["Birthday"]}}]	7	1
925	2023-10-22 18:04:04.121141+00	163	nereplen@gmail.com	2	[{"changed": {"fields": ["Birthday"]}}]	7	1
926	2023-10-22 18:05:12.49787+00	313	nurugu@gmail.com	2	[{"changed": {"fields": ["Phone number"]}}]	7	1
927	2023-10-22 18:05:40.101246+00	154	esterue@gmail.com	2	[{"changed": {"fields": ["Birthday"]}}]	7	1
928	2023-10-23 14:22:54.091063+00	115	feli.oregi@gmail.com	2	[]	7	1
929	2023-10-23 14:24:12.027872+00	115	feli.oregi@gmail.com	2	[{"changed": {"fields": ["Status"]}}]	7	1
930	2023-10-23 14:51:33.35295+00	98	anayeyu@gmail.com	2	[{"changed": {"fields": ["Birthday"]}}]	7	1
931	2023-10-23 14:52:01.005114+00	101	estrellasanan@gmail.com	2	[{"changed": {"fields": ["Birthday"]}}]	7	1
932	2023-10-23 14:52:25.441725+00	118	albertoxav@hotmail.com	2	[{"changed": {"fields": ["Birthday"]}}]	7	1
933	2023-10-23 14:52:59.886407+00	330	piliychuso@hotmail.com	2	[{"changed": {"fields": ["Verified"]}}]	7	1
934	2023-10-23 14:53:26.631831+00	116	ainhoagalarraga@gmail.com	2	[{"changed": {"fields": ["Birthday"]}}]	7	1
935	2023-10-23 14:55:47.289047+00	167	joitturri@gmail.com	2	[{"changed": {"fields": ["Last name"]}}]	7	1
936	2023-10-23 15:38:59.956712+00	97	ernestoguardadopartida@gmail.com	3		7	1
937	2023-10-24 09:34:07.0154+00	310	eslavapolo@gmail.com	2	[{"changed": {"fields": ["Verified"]}}]	7	1
938	2023-10-24 09:43:30.860953+00	145	beindos@hotmail.com	2	[{"changed": {"fields": ["password"]}}]	7	1
939	2023-10-24 10:27:43.633283+00	168	rossamador1122@gmail.com	2	[{"changed": {"fields": ["Birthday"]}}]	7	1
940	2023-10-26 20:16:22.333651+00	115	feli.oregi@gmail.com	2	[{"changed": {"fields": ["Birthday"]}}]	7	1
941	2023-10-26 20:16:22.664348+00	115	feli.oregi@gmail.com	2	[]	7	1
942	2023-10-26 20:17:08.386682+00	178	m.garmendia2001@gmail.com	2	[{"changed": {"fields": ["Birthday"]}}]	7	1
943	2023-10-26 20:18:13.558327+00	318	mdiazollero@gmail.com	2	[{"changed": {"fields": ["Status", "Verified"]}}]	7	1
944	2023-10-26 20:19:28.033366+00	113	Wallet for mdiazollero@gmail.com	1	[{"added": {}}]	29	1
945	2023-10-26 20:20:32.336218+00	131	MangopayUser object (131)	1	[{"added": {}}]	27	1
946	2023-10-27 10:09:07.461905+00	9	admin@claddingprices.com	2	[{"changed": {"fields": ["password"]}}]	7	1
947	2023-10-27 10:10:40.723683+00	27	Castillo Coca	3		9	1
948	2023-10-27 11:17:59.271531+00	321	naa41160@hotmail.com	2	[{"changed": {"fields": ["Verified"]}}]	7	1
949	2023-10-27 20:38:37.278851+00	28	ccallejo@stockencapital.com	2	[{"changed": {"fields": ["password"]}}]	7	1
950	2023-10-29 16:34:24.379926+00	148	natiroldos54@gmail.com	2	[{"changed": {"fields": ["Birthday"]}}]	7	1
951	2023-10-29 16:42:19.923088+00	316	manuelmongarcia@gmail.com	2	[{"changed": {"fields": ["Verified"]}}]	7	1
952	2023-10-29 16:42:57.011741+00	158	rascongarciavictoria@gmail.com	2	[{"changed": {"fields": ["Birthday"]}}]	7	1
953	2023-10-29 17:26:10.713252+00	156	mrascongarcia@gmail.com	2	[{"changed": {"fields": ["First name", "Last name"]}}]	7	1
954	2023-10-30 08:00:22.724516+00	113	angie26504@gmail.com	2	[{"changed": {"fields": ["Birthday"]}}]	7	1
955	2023-10-30 08:00:45.317495+00	121	rubenalava@hotmail.com	2	[{"changed": {"fields": ["Birthday"]}}]	7	1
956	2023-10-30 09:17:52.666646+00	156	mrascongarcia@gmail.com	2	[{"changed": {"fields": ["First name", "Last name"]}}]	7	1
957	2023-10-30 09:34:42.104416+00	156	mrascongarcia@gmail.com	2	[{"changed": {"fields": ["First name", "Last name"]}}]	7	1
958	2023-10-30 10:08:07.01473+00	156	mrascongarcia@gmail.com	2	[{"changed": {"fields": ["Last name"]}}]	7	1
959	2023-10-30 10:08:58.709893+00	175	esperanza67147@hotmail.com	2	[{"changed": {"name": "fiscal residence", "object": "FiscalResidence object (75)", "fields": ["Address", "City", "Postal code"]}}]	7	1
960	2023-10-30 20:43:04.046542+00	114	mgoenagajuez@gmail.com	2	[{"changed": {"fields": ["Type"]}}]	7	1
961	2023-10-31 09:51:00.738143+00	304	jorge@servivuelo.com	2	[{"changed": {"fields": ["Verified"]}}]	7	1
962	2023-10-31 09:52:35.751545+00	4	Block Impulse SL	2	[{"changed": {"fields": ["Published"]}}]	9	1
963	2023-10-31 09:53:13.561766+00	4	Block Impulse SL	2	[{"changed": {"fields": ["Published"]}}]	9	1
964	2023-10-31 10:18:51.491705+00	172	alberto.rf2017@gmail.com	2	[{"changed": {"fields": ["Type"]}}]	7	1
965	2023-10-31 10:57:29.196912+00	171	jesusrm.rr@hotmail.com	2	[{"changed": {"fields": ["Birthday"]}}]	7	1
966	2023-10-31 11:00:45.747513+00	172	alberto.rf2017@gmail.com	2	[{"changed": {"fields": ["Birthday"]}}]	7	1
967	2023-10-31 12:12:36.392511+00	192	yumava@hotmail.com	2	[{"changed": {"name": "fiscal residence", "object": "FiscalResidence object (135)", "fields": ["State"]}}]	7	1
968	2023-11-01 14:08:57.353696+00	119	zx10alex@hotmail.com	2	[{"changed": {"fields": ["Type"]}}]	7	1
969	2023-11-01 17:59:47.239938+00	324	alvarolinarescabre+chamo00@gmail.com	2	[{"changed": {"fields": ["password"]}}]	7	1
970	2023-11-01 18:05:56.109799+00	13	vcallejo@blockimpulse.com	2	[{"changed": {"fields": ["password"]}}]	7	1
971	2023-11-01 18:11:45.723591+00	196	kallejo+3@gmail.com	2	[{"changed": {"fields": ["First name", "Last name"]}}]	7	1
972	2023-11-02 09:34:45.900742+00	37	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo@gmail.com	3		24	1
973	2023-11-02 09:34:45.924831+00	39	consulting@blockimpulse.com proposes 1 shares for 1.00 each to vcallejo@blockimpulse.com	3		24	1
974	2023-11-02 09:34:45.945747+00	53	consulting@blockimpulse.com proposes 1 shares for 1.00 each to kallejo+3@gmail.com	3		24	1
975	2023-11-02 09:34:45.966616+00	54	consulting@blockimpulse.com proposes 1 shares for 1.00 each to kallejo+3@gmail.com	3		24	1
976	2023-11-02 09:34:45.991974+00	55	consulting@blockimpulse.com proposes 1 shares for 1.00 each to kallejo+3@gmail.com	3		24	1
977	2023-11-02 09:34:46.016041+00	56	consulting@blockimpulse.com proposes 1 shares for 1.00 each to kallejo+3@gmail.com	3		24	1
978	2023-11-02 09:34:46.035597+00	57	consulting@blockimpulse.com proposes 1 shares for 1.00 each to kallejo+3@gmail.com	3		24	1
979	2023-11-02 09:34:46.0661+00	58	consulting@blockimpulse.com proposes 2 shares for 2.00 each to kallejo+3@gmail.com	3		24	1
980	2023-11-02 09:34:46.087192+00	59	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo+3@gmail.com	3		24	1
981	2023-11-02 09:34:46.102714+00	60	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo+3@gmail.com	3		24	1
982	2023-11-02 09:34:46.121599+00	61	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo+3@gmail.com	3		24	1
983	2023-11-02 09:34:46.143715+00	62	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo+3@gmail.com	3		24	1
984	2023-11-02 09:34:46.15788+00	63	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo+3@gmail.com	3		24	1
985	2023-11-02 09:34:46.172092+00	64	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo+3@gmail.com	3		24	1
986	2023-11-02 09:34:46.187613+00	65	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo+3@gmail.com	3		24	1
987	2023-11-02 09:34:46.206288+00	66	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo+3@gmail.com	3		24	1
988	2023-11-02 09:34:46.224116+00	67	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo+3@gmail.com	3		24	1
989	2023-11-02 09:34:46.252358+00	68	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo+3@gmail.com	3		24	1
990	2023-11-02 09:34:46.268887+00	69	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo+3@gmail.com	3		24	1
991	2023-11-02 09:34:46.285983+00	70	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo+3@gmail.com	3		24	1
992	2023-11-02 09:34:46.305869+00	71	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo+3@gmail.com	3		24	1
993	2023-11-02 09:34:46.320806+00	72	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo+3@gmail.com	3		24	1
994	2023-11-02 09:34:46.334829+00	73	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo+3@gmail.com	3		24	1
995	2023-11-02 09:34:46.349519+00	74	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo+3@gmail.com	3		24	1
996	2023-11-02 09:34:46.362594+00	75	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to kallejo+3@gmail.com	3		24	1
997	2023-11-02 09:34:46.378788+00	79	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to vcallejo@blockimpulse.com	3		24	1
998	2023-11-02 09:44:47.689115+00	87	ccallejo@stockencapital.com proposes 1 shares for 1.00 each to alvarolinarescabre+chamo00@gmail.com	2	[]	24	1
999	2023-11-02 10:06:42.587852+00	19	kallejo@gmail.com - CLADDING AND FLOORS SL	3		14	1
1000	2023-11-02 10:06:42.591172+00	23	ccallejo@stockencapital.com - CLADDING AND FLOORS SL	3		14	1
1001	2023-11-02 10:06:42.592945+00	24	kallejo@gmail.com - Block Impulse SL	3		14	1
1002	2023-11-02 10:06:42.594184+00	25	ccallejo@stockencapital.com - Block Impulse SL	3		14	1
1003	2023-11-03 08:48:58.829707+00	119	zx10alex@hotmail.com	2	[{"changed": {"fields": ["Birthday"]}}]	7	1
1004	2023-11-03 08:49:20.530275+00	297	pilar.esteban.herrera@gmail.com	2	[{"changed": {"fields": ["Verified"]}}]	7	1
1005	2023-11-03 12:58:59.983981+00	105	lorena.merchan81@gmail.com	2	[{"changed": {"fields": ["Birthday"]}}]	7	1
1006	2023-11-03 14:08:55.6586+00	138	kallejo@gmail.com 100.00 EUR	3		34	1
1007	2023-11-03 14:08:55.661171+00	135	kallejo@gmail.com 100.00 EUR	3		34	1
1008	2023-11-03 14:08:55.662701+00	134	kallejo@gmail.com 100.00 EUR	3		34	1
1009	2023-11-03 14:08:55.664196+00	114	kallejo@gmail.com 100.00 EUR	3		34	1
1010	2023-11-03 14:08:55.6656+00	113	kallejo@gmail.com 100.00 EUR	3		34	1
1011	2023-11-03 15:30:19.875727+00	11	Block Impulse SL 1000 2023-10-10	3		26	1
1012	2023-11-09 06:46:51.513956+00	114	mgoenagajuez@gmail.com	2	[{"added": {"name": "fiscal residence", "object": "FiscalResidence object (163)"}}]	7	1
1013	2023-11-10 18:07:03.668694+00	47	kallejo+3@gmail.com - White Bear Trading SL	3		14	1
1014	2023-11-11 09:24:44.512408+00	48	kallejo+3@gmail.com - White Bear Trading SL	3		14	1
1015	2023-11-11 10:17:43.749903+00	140	User pf_324 sell 1 shares for 1.00 each	3		23	1
1016	2023-11-11 10:17:43.752491+00	138	User pf_324 sell 2 shares for 2.00 each	3		23	1
1017	2023-11-11 10:17:43.753856+00	137	User pf_324 sell 2 shares for 2.00 each	3		23	1
1018	2023-11-11 10:18:01.52478+00	49	kallejo+3@gmail.com - White Bear Trading SL	3		14	1
1019	2023-11-11 10:25:09.821923+00	101	[BUY_AND_SELL] kallejo+3@gmail.com: 2	3		20	1
1020	2023-11-11 10:25:09.824261+00	99	[BUY_AND_SELL] kallejo+3@gmail.com: 2	3		20	1
1021	2023-11-11 10:25:09.825528+00	103	[BUY_AND_SELL] kallejo+3@gmail.com: 2	3		20	1
1022	2023-11-11 10:25:09.826698+00	102	[BUY_AND_SELL] kallejo+3@gmail.com: 1	3		20	1
1023	2023-11-11 10:25:36.317685+00	141	User pf_324 sell 2 shares for 2.00 each	3		23	1
1024	2023-11-11 10:26:31.313323+00	50	kallejo+3@gmail.com - White Bear Trading SL	3		14	1
1025	2023-11-11 11:10:31.461118+00	12	Block Impulse SL 1000 2023-12-31	2	[{"changed": {"fields": ["New share capital"]}}]	26	1
1026	2023-11-11 23:52:58.458938+00	105	[BUY_AND_SELL] kallejo+3@gmail.com: 2	3		20	1
1027	2023-11-11 23:53:24.339769+00	145	User pf_324 sell 2 shares for 1.00 each	3		23	1
1028	2023-11-11 23:53:24.341258+00	144	User pf_324 sell 1 shares for 1.00 each	3		23	1
1029	2023-11-11 23:53:24.342932+00	142	User pf_324 sell 2 shares for 2.00 each	3		23	1
1030	2023-11-12 00:17:26.741659+00	107	[BUY_AND_SELL] kallejo+3@gmail.com: 1	3		20	1
1031	2023-11-12 00:17:45.391771+00	51	kallejo+3@gmail.com - White Bear Trading SL	3		14	1
1032	2023-11-12 00:35:24.673384+00	146	kallejo@gmail.com proposes 1 shares for 1.00 each to alvarolinarescabre+chamo00@gmail.com	3		24	1
1033	2023-11-12 00:38:40.552175+00	147	Unknown User proposes 1 shares for 1.00 each to alvarolinarescabre+chamo00@gmail.com	2	[{"changed": {"fields": ["COD"]}}]	24	1
1034	2023-11-12 02:08:53.963322+00	5	Big Election SL	2	[{"changed": {"fields": ["Legal representative"]}}]	9	1
1035	2023-11-12 02:11:00.8912+00	131	Wallet for jflores@email4job.com	1	[{"added": {}}]	29	1
1036	2023-11-13 21:28:08.455383+00	53	kallejo+3@gmail.com - White Bear Trading SL	3		14	1
1037	2023-11-13 21:28:37.117961+00	148	User pf_324 sell 1 shares for 1.00 each	3		23	1
1038	2023-11-13 21:28:37.11991+00	147	User pf_324 sell 1 shares for 1.00 each	3		23	1
1039	2023-11-13 21:28:37.121266+00	146	User pf_324 sell 1 shares for 1.00 each	3		23	1
1040	2023-11-13 21:28:50.707015+00	110	[BUY_AND_SELL] kallejo+3@gmail.com: 1	3		20	1
1041	2023-11-14 22:23:11.138132+00	151	User pf_324 sell 1 shares for 1.00 each	3		23	1
1042	2023-11-14 22:23:11.140662+00	150	User pf_324 sell 2 shares for 1.00 each	3		23	1
1043	2023-11-14 22:23:51.847161+00	112	[BUY_AND_SELL] kallejo+3@gmail.com: 1	3		20	1
1044	2023-11-14 22:24:11.397278+00	55	kallejo+3@gmail.com - White Bear Trading SL	3		14	1
1045	2023-11-15 14:57:39.740031+00	9	admin@claddingprices.com	2	[{"added": {"name": "fiscal residence", "object": "FiscalResidence object (165)"}}]	7	1
1046	2023-11-15 14:59:25.930955+00	153	admin@claddingprices.com proposes 1 shares for 1.00 each to alvarolinarescabre+chamo00@gmail.com	2	[]	24	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	auth	permission
2	auth	group
3	contenttypes	contenttype
4	sessions	session
5	sites	site
6	admin	logentry
7	users	user
8	users	fiscalresidence
9	companies	company
10	documents	document
11	stellar	wallet
12	stellar	asset
13	stellar	currencyasset
14	partners	partner
15	meetings	meeting
16	meetings	agendaitem
17	meetings	document
18	meetings	participant
19	votes	vote
20	operations	operation
21	conversations	conversation
22	conversations	message
23	offers	offer
24	offers	proposal
25	offers	document
26	capital_increases	capitalincrease
27	mangopay	mangopayuser
28	mangopay	mangopaykycdocument
29	mangopay	mangopaywallet
30	mangopay	mangopaytransfer
31	mangopay	basemangopaytransaction
32	mangopay	mangopaydeposit
33	mangopay	mangopaybankaccount
34	mangopay	mangopaybankwiredeposit
35	payments	payment
36	currencies	currency
37	authtoken	token
38	authtoken	tokenproxy
39	options	option
40	options	useroption
41	snitch	eventtype
42	snitch	event
43	snitch	notification
44	oauth2_provider	application
45	oauth2_provider	accesstoken
46	oauth2_provider	grant
47	oauth2_provider	refreshtoken
48	oauth2_provider	idtoken
49	social_django	association
50	social_django	code
51	social_django	nonce
52	social_django	usersocialauth
53	social_django	partial
54	drf_social_oauth2	multifactorauth
55	companies	category
56	documents	historydocument
57	documents	usersessionlog
58	documents	useractiondetail
59	conversations	contact
60	conversations	conversationhistory
61	meetings	historymeetingsdocument
62	offers	historyoffersdocument
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2022-07-08 13:07:53.464317+00
2	contenttypes	0002_remove_content_type_name	2022-07-08 13:07:53.51132+00
3	auth	0001_initial	2022-07-08 13:07:53.676984+00
4	auth	0002_alter_permission_name_max_length	2022-07-08 13:07:53.690317+00
5	auth	0003_alter_user_email_max_length	2022-07-08 13:07:53.705601+00
6	auth	0004_alter_user_username_opts	2022-07-08 13:07:53.721554+00
7	auth	0005_alter_user_last_login_null	2022-07-08 13:07:53.732834+00
8	auth	0006_require_contenttypes_0002	2022-07-08 13:07:53.739087+00
9	auth	0007_alter_validators_add_error_messages	2022-07-08 13:07:53.753468+00
10	auth	0008_alter_user_username_max_length	2022-07-08 13:07:53.769547+00
11	auth	0009_alter_user_last_name_max_length	2022-07-08 13:07:53.785592+00
12	users	0001_initial	2022-07-08 13:07:53.870184+00
13	admin	0001_initial	2022-07-08 13:07:54.055713+00
14	admin	0002_logentry_remove_auto_add	2022-07-08 13:07:54.076952+00
15	admin	0003_logentry_add_action_flag_choices	2022-07-08 13:07:54.09766+00
16	auth	0010_alter_group_name_max_length	2022-07-08 13:07:54.132442+00
17	auth	0011_update_proxy_permissions	2022-07-08 13:07:54.154809+00
18	auth	0012_alter_user_first_name_max_length	2022-07-08 13:07:54.176906+00
19	authtoken	0001_initial	2022-07-08 13:07:54.234441+00
20	authtoken	0002_auto_20160226_1747	2022-07-08 13:07:54.310296+00
21	authtoken	0003_tokenproxy	2022-07-08 13:07:54.326373+00
22	companies	0001_initial	2022-07-08 13:07:54.372843+00
23	companies	0002_auto_20200706_0704	2022-07-08 13:07:54.52715+00
24	companies	0003_remove_company_validated	2022-07-08 13:07:54.543218+00
25	companies	0004_company_published	2022-07-08 13:07:54.560627+00
26	companies	0005_company_slug	2022-07-08 13:07:54.585289+00
27	companies	0006_auto_20200707_1011	2022-07-08 13:07:54.602744+00
28	companies	0007_auto_20200713_1020	2022-07-08 13:07:54.618696+00
29	companies	0008_auto_20200715_1144	2022-07-08 13:07:54.647907+00
30	companies	0009_auto_20200722_0753	2022-07-08 13:07:54.663872+00
31	companies	0010_auto_20200729_0844	2022-07-08 13:07:54.727432+00
32	companies	0011_auto_20200729_0901	2022-07-08 13:07:54.74805+00
33	companies	0012_remove_company_administrator	2022-07-08 13:07:54.783459+00
34	companies	0013_company_stocken_invests	2022-07-08 13:07:54.802203+00
35	companies	0014_auto_20200820_1056	2022-07-08 13:07:54.879181+00
36	partners	0001_initial	2022-07-08 13:07:54.91685+00
37	partners	0002_create_operation_table	2022-07-08 13:07:54.962279+00
38	partners	0003_auto_20201126_1141	2022-07-08 13:07:54.982803+00
39	companies	0015_auto_20201105_1020	2022-07-08 13:07:55.020238+00
40	companies	0016_auto_20201106_0940	2022-07-08 13:07:55.055465+00
41	partners	0004_auto_20201126_1143	2022-07-08 13:07:55.108199+00
42	partners	0005_auto_20201126_1143	2022-07-08 13:07:55.129921+00
43	partners	0006_auto_20201126_1155	2022-07-08 13:07:55.18042+00
44	partners	0007_remove_operation_to_partner	2022-07-08 13:07:55.207311+00
45	partners	0008_auto_20201126_1156	2022-07-08 13:07:55.231947+00
46	partners	0009_auto_20201126_1201	2022-07-08 13:07:55.252601+00
47	partners	0010_delete_operation	2022-07-08 13:07:55.259065+00
48	companies	0017_auto_20210128_1326	2022-07-08 13:07:55.278427+00
49	companies	0018_auto_20210203_1834	2022-07-08 13:07:55.311918+00
50	companies	0019_auto_20210217_1556	2022-07-08 13:07:55.390891+00
51	companies	0020_company_trust_op_completed	2022-07-08 13:07:55.431893+00
52	companies	0021_auto_20210308_1404	2022-07-08 13:07:55.529749+00
53	capital_increases	0001_initial	2022-07-08 13:07:55.565426+00
54	capital_increases	0002_executing	2022-07-08 13:07:55.587464+00
55	capital_increases	0003_remove_capitalincrease_user	2022-07-08 13:07:55.611442+00
56	capital_increases	0004_capitalincrease_issue_premium	2022-07-08 13:07:55.630809+00
57	capital_increases	0005_capitalincrease_new_share_capital	2022-07-08 13:07:55.645596+00
58	capital_increases	0006_alter_capitalincrease_options	2022-07-08 13:07:55.659194+00
59	companies	0022_auto_20210330_1039	2022-07-08 13:07:55.68675+00
60	companies	0023_auto_20210330_1040	2022-07-08 13:07:55.734536+00
61	companies	0024_company_code	2022-07-08 13:07:55.76929+00
62	companies	0025_choices_help_text	2022-07-08 13:07:55.798238+00
63	companies	0026_company_legal_representative	2022-07-08 13:07:55.8331+00
64	companies	0027_set_legal_representative	2022-07-08 13:07:55.864314+00
65	companies	0028_remove_company_administrators	2022-07-08 13:07:55.892279+00
66	companies	0029_auto_20220520_1030	2022-07-08 13:07:56.458205+00
67	companies	0030_auto_20220520_1038	2022-07-08 13:07:56.881043+00
68	companies	0031_auto_20220520_1041	2022-07-08 13:07:57.079684+00
69	documents	0001_initial	2022-07-08 13:07:57.113864+00
70	documents	0002_document_creator	2022-07-08 13:07:57.139445+00
71	documents	0003_auto_20200819_1237	2022-07-08 13:07:57.172675+00
72	documents	0004_auto_20201020_1145	2022-07-08 13:07:57.191394+00
73	documents	0005_document_stellar_transaction_hash	2022-07-08 13:07:57.209094+00
74	documents	0006_auto_20210203_1322	2022-07-08 13:07:57.226707+00
75	conversations	0001_initial	2022-07-08 13:07:57.279717+00
76	conversations	0002_auto_20210209_1033	2022-07-08 13:07:57.333618+00
77	conversations	0003_conversation_documents	2022-07-08 13:07:57.372965+00
78	conversations	0004_auto_20210215_1350	2022-07-08 13:07:57.43151+00
79	conversations	0005_auto_20210226_1114	2022-07-08 13:07:57.452527+00
80	conversations	0005_auto_20210226_1059	2022-07-08 13:07:57.47237+00
81	conversations	0006_merge_20210226_1358	2022-07-08 13:07:57.475341+00
82	conversations	0007_alter_conversation_is_from_company	2022-07-08 13:07:57.495757+00
83	stellar	0001_initial	2022-07-08 13:07:57.629924+00
84	stellar	0002_asset	2022-07-08 13:07:57.682975+00
85	stellar	0003_currencyasset	2022-07-08 13:07:57.732876+00
86	currencies	0001_initial	2022-07-08 13:07:57.77204+00
87	operations	0001_initial	2022-07-08 13:07:57.819612+00
88	operations	0002_auto_20210128_1326	2022-07-08 13:07:57.890741+00
89	operations	0003_auto_20210129_0955	2022-07-08 13:07:57.983952+00
90	operations	0004_auto_20210203_1726	2022-07-08 13:07:58.054667+00
91	operations	0005_auto_20210203_1803	2022-07-08 13:07:58.084227+00
92	operations	0006_auto_20210203_1834	2022-07-08 13:07:58.109999+00
93	operations	0004_auto_20210203_1322	2022-07-08 13:07:58.158213+00
94	operations	0007_merge_20210204_0956	2022-07-08 13:07:58.161852+00
95	operations	0008_auto_20210219_0845	2022-07-08 13:07:58.211032+00
96	operations	0009_operation_stellar_transaction_hash	2022-07-08 13:07:58.241673+00
97	operations	0010_operation_issue_premium	2022-07-08 13:07:58.268147+00
98	operations	0011_alter_operation_status	2022-07-08 13:07:58.402516+00
99	meetings	0001_create_meeting	2022-07-08 13:07:58.442804+00
100	meetings	0002_create_agenda_item	2022-07-08 13:07:58.486147+00
101	meetings	0003_create_agenda_item_document	2022-07-08 13:07:58.552784+00
102	meetings	0004_add_creator_meeting	2022-07-08 13:07:58.586115+00
103	meetings	0005_add_proposal_agreement_to_agenda_item	2022-07-08 13:07:58.603+00
104	meetings	0006_remove_name_in_agenda_item_document	2022-07-08 13:07:58.610565+00
105	meetings	0007_rename_document_for_meeting	2022-07-08 13:07:58.709602+00
106	meetings	0008_meeting_minutes	2022-07-08 13:07:58.74394+00
107	meetings	0009_auto_20201126_1141	2022-07-08 13:07:58.783332+00
108	meetings	0010_vote	2022-07-08 13:07:58.831318+00
109	meetings	0011_delete_vote	2022-07-08 13:07:58.837167+00
110	meetings	0012_create_participant	2022-07-08 13:07:58.912167+00
111	meetings	0013_auto_20201207_1402	2022-07-08 13:07:58.938996+00
112	meetings	0014_auto_20201216_1821	2022-07-08 13:07:58.981196+00
113	meetings	0015_auto_20210112_1546	2022-07-08 13:07:59.037395+00
114	meetings	0016_auto_20210128_1326	2022-07-08 13:07:59.066846+00
115	meetings	0017_document_stellar_transaction_hash	2022-07-08 13:07:59.20732+00
116	meetings	0018_participant_read_call	2022-07-08 13:07:59.237009+00
117	meetings	0019_meeting_review_date	2022-07-08 13:07:59.265373+00
118	meetings	0020_remove_participant_read_call	2022-07-08 13:07:59.29475+00
119	meetings	0021_auto_20210212_1331	2022-07-08 13:07:59.348517+00
120	meetings	0022_auto_20210212_1549	2022-07-08 13:07:59.409393+00
121	meetings	0023_choices_help_text	2022-07-08 13:07:59.463116+00
122	documents	0007_auto_20220527_0722	2022-07-08 13:07:59.628211+00
123	mangopay	0001_initial	2022-07-08 13:07:59.669988+00
124	mangopay	0002_mangopaypayment	2022-07-08 13:07:59.712968+00
125	payments	0001_initial	2022-07-08 13:07:59.75921+00
126	payments	0002_payment_type	2022-07-08 13:07:59.898883+00
127	payments	0003_auto_20210407_1443	2022-07-08 13:07:59.930305+00
128	payments	0004_payment_stellar_transaction_hash	2022-07-08 13:07:59.964226+00
129	payments	0005_auto_20210413_0912	2022-07-08 13:08:00.065459+00
130	payments	0006_auto_20210414_0906	2022-07-08 13:08:00.104413+00
131	mangopay	0003_auto_20210408_1511	2022-07-08 13:08:00.136192+00
132	payments	0007_auto_20210414_0933	2022-07-08 13:08:00.245115+00
133	payments	0008_auto_20210414_1318	2022-07-08 13:08:00.312896+00
134	payments	0009_choices_help_text	2022-07-08 13:08:00.371792+00
135	payments	0010_type_help_text	2022-07-08 13:08:00.403713+00
136	mangopay	0004_choices_help_text	2022-07-08 13:08:00.433987+00
137	mangopay	0005_mangopaykycdocument	2022-07-08 13:08:00.479264+00
138	mangopay	0006_mangopayuser_kyc_level	2022-07-08 13:08:00.512175+00
139	mangopay	0007_mangopaykycdocument_refused_reason	2022-07-08 13:08:00.71048+00
140	mangopay	0008_alter_mangopaykycdocument_user	2022-07-08 13:08:00.743608+00
141	mangopay	0009_mangopaywallet	2022-07-08 13:08:00.788161+00
142	mangopay	0010_mangopaytransfer	2022-07-08 13:08:00.839014+00
143	mangopay	0011_mangopaywallet_amount	2022-07-08 13:08:00.872466+00
144	mangopay	0012_rename_user_mangopaypayment_to_user	2022-07-08 13:08:00.911703+00
145	mangopay	0013_auto_20210525_1025	2022-07-08 13:08:01.592868+00
146	payments	0011_auto_20210525_1238	2022-07-08 13:08:01.730144+00
147	payments	0012_alter_payment_currency	2022-07-08 13:08:01.765408+00
148	payments	0013_rename_mangopay_payment_payment_mangopay_transaction	2022-07-08 13:08:01.932714+00
149	mangopay	0014_rename_mangopaypayment_mangopaydeposit	2022-07-08 13:08:02.003758+00
150	mangopay	0015_auto_20210527_0742	2022-07-08 13:08:02.070937+00
151	mangopay	0016_mangopaybankaccount	2022-07-08 13:08:02.124464+00
152	mangopay	0017_basemangopaytransaction_fees	2022-07-08 13:08:02.133957+00
153	mangopay	0018_alter_mangopaytransfer_users	2022-07-08 13:08:02.213144+00
154	mangopay	0019_mangopaybankwiredeposit	2022-07-08 13:08:02.264645+00
155	offers	0001_initial	2022-07-08 13:08:02.32315+00
156	offers	0002_auto_20210226_1059	2022-07-08 13:08:02.481738+00
157	offers	0003_auto_20210301_1129	2022-07-08 13:08:02.679513+00
158	offers	0004_auto_20210302_1309	2022-07-08 13:08:02.774606+00
159	offers	0005_auto_20210308_1246	2022-07-08 13:08:02.815132+00
160	offers	0006_auto_20210324_1301	2022-07-08 13:08:02.901157+00
161	offers	0007_offer_is_canceled	2022-07-08 13:08:02.943957+00
162	offers	0008_auto_20210415_1032	2022-07-08 13:08:03.038825+00
163	offers	0009_proposal_executing	2022-07-08 13:08:03.082394+00
164	offers	0010_offer_status	2022-07-08 13:08:03.12417+00
165	offers	0011_choices_help_text	2022-07-08 13:08:03.203949+00
166	offers	0012_shares_range	2022-07-08 13:08:03.405059+00
167	offers	0013_document	2022-07-08 13:08:03.465443+00
168	offers	0014_alter_proposal_payment	2022-07-08 13:08:03.516301+00
169	offers	0015_alter_proposal_payment	2022-07-08 13:08:03.566691+00
170	offers	0016_proposal_fees	2022-07-08 13:08:03.610694+00
171	offers	0017_proposal_total_amount	2022-07-08 13:08:03.65418+00
172	offers	0018_alter_offer_options	2022-07-08 13:08:03.695378+00
173	options	0001_initial	2022-07-08 13:08:03.72331+00
174	options	0002_auto_20181002_0254	2022-07-08 13:08:03.849766+00
175	options	0003_auto_20190827_0605	2022-07-08 13:08:04.140961+00
176	options	0004_auto_20190829_0936	2022-07-08 13:08:04.266715+00
177	partners	0011_auto_20210226_1059	2022-07-08 13:08:04.313145+00
178	partners	0012_partner_unit_acquisition_value	2022-07-08 13:08:04.356813+00
179	partners	0013_ordering	2022-07-08 13:08:04.39946+00
180	payments	0014_payment_fees	2022-07-08 13:08:04.441504+00
181	sessions	0001_initial	2022-07-08 13:08:04.462726+00
182	sites	0001_initial	2022-07-08 13:08:04.472457+00
183	sites	0002_alter_domain_unique	2022-07-08 13:08:04.486553+00
184	sites	0003_set_site_domain_and_name	2022-07-08 13:08:04.53635+00
185	sites	0004_auto_20200810_1145	2022-07-08 13:08:04.542605+00
186	snitch	0001_initial	2022-07-08 13:08:04.679058+00
187	users	0002_auto_20200623_0759	2022-07-08 13:08:04.761813+00
188	users	0003_auto_20200702_0719	2022-07-08 13:08:04.968029+00
189	users	0004_user_two_factor	2022-07-08 13:08:05.01478+00
190	users	0005_user_two_factor_code	2022-07-08 13:08:05.057834+00
191	users	0006_user_two_factor_code_created	2022-07-08 13:08:05.101984+00
192	users	0007_user_phone	2022-07-08 13:08:05.145863+00
193	users	0008_auto_20200713_0707	2022-07-08 13:08:05.592336+00
194	users	0009_auto_20200713_1020	2022-07-08 13:08:05.873227+00
195	users	0010_auto_20200713_1145	2022-07-08 13:08:05.959624+00
196	users	0011_user_is_blocked	2022-07-08 13:08:06.008563+00
197	users	0012_user_is_canceled	2022-07-08 13:08:06.055254+00
198	users	0013_auto_20200730_0900	2022-07-08 13:08:06.262761+00
199	users	0014_auto_20210330_1028	2022-07-08 13:08:06.314943+00
200	users	0015_auto_20210330_1034	2022-07-08 13:08:06.509708+00
201	users	0016_user_type	2022-07-08 13:08:06.564318+00
202	users	0017_set_user_type	2022-07-08 13:08:06.624749+00
203	users	0018_delete_legal_mangopay_users	2022-07-08 13:08:06.685907+00
204	users	0019_remove_user_bank_account_details	2022-07-08 13:08:06.787322+00
205	users	0020_auto_20220524_0737	2022-07-08 13:08:06.890103+00
206	votes	0001_create_vote	2022-07-08 13:08:07.0853+00
207	votes	0002_change_vote_types	2022-07-08 13:08:07.138861+00
208	votes	0003_auto_20201207_1402	2022-07-08 13:08:07.195744+00
209	votes	0004_auto_20201216_1821	2022-07-08 13:08:07.249134+00
210	votes	0005_vote_stellar_transaction_hash	2022-07-08 13:08:07.306993+00
211	votes	0006_choices_help_text	2022-07-08 13:08:07.360915+00
212	votes	0007_ordering	2022-07-08 13:08:07.414311+00
213	snitch	0002_auto_20230622_0800	2023-06-22 08:00:45.023891+00
214	companies	0032_auto_20230614_1737	2023-09-02 19:06:30.335775+00
215	companies	0033_alter_company_categories	2023-09-02 19:06:31.086163+00
216	companies	0034_alter_company_legal_representative	2023-09-02 19:06:32.100133+00
217	companies	0035_auto_20230706_1326	2023-09-02 19:06:34.084248+00
218	companies	0036_alter_company_cod	2023-09-02 19:06:35.266323+00
219	companies	0037_alter_category_options	2023-09-02 19:06:36.482044+00
220	companies	0038_auto_20230720_1425	2023-09-02 19:06:41.249315+00
221	companies	0039_auto_20230720_1437	2023-09-02 19:06:41.544701+00
222	conversations	0008_contact	2023-09-02 19:06:41.59204+00
223	conversations	0009_conversationhistory	2023-09-02 19:06:41.770549+00
224	conversations	0010_auto_20230828_1537	2023-09-02 19:06:44.084153+00
225	conversations	0011_message_cod	2023-09-02 19:06:44.284007+00
226	documents	0008_historydocument	2023-09-02 19:06:44.435988+00
227	documents	0009_useractiondetail_usersessionlog	2023-09-02 19:06:44.627893+00
228	documents	0010_auto_20230809_1619	2023-09-02 19:06:45.889346+00
229	mangopay	0020_auto_20230706_1326	2023-09-02 19:06:46.348798+00
230	mangopay	0021_auto_20230713_1139	2023-09-02 19:06:47.467202+00
231	mangopay	0022_alter_mangopaybankaccount_user	2023-09-02 19:06:47.622949+00
232	mangopay	0023_alter_mangopaybankaccount_user	2023-09-02 19:06:47.791916+00
233	mangopay	0024_alter_mangopaybankaccount_user	2023-09-02 19:06:47.972373+00
234	mangopay	0025_alter_mangopaybankaccount_user	2023-09-02 19:06:48.296022+00
235	mangopay	0022_alter_mangopaybankaccount_user	2023-09-02 19:06:48.423094+00
236	mangopay	0023_alter_mangopaybankaccount_user	2023-09-02 19:06:48.595967+00
237	mangopay	0026_auto_20230824_1254	2023-09-02 19:06:48.706532+00
238	mangopay	0024_alter_mangopaybankaccount_user	2023-09-02 19:06:48.75907+00
239	mangopay	0025_alter_mangopaybankaccount_user	2023-09-02 19:06:48.927688+00
240	oauth2_provider	0001_initial	2023-09-02 19:06:49.869751+00
241	oauth2_provider	0002_auto_20190406_1805	2023-09-02 19:06:50.11718+00
242	oauth2_provider	0003_auto_20201211_1314	2023-09-02 19:06:50.215128+00
243	oauth2_provider	0004_auto_20200902_2022	2023-09-02 19:06:50.831665+00
244	oauth2_provider	0005_auto_20211222_2352	2023-09-02 19:06:51.235201+00
245	oauth2_provider	0006_alter_application_client_secret	2023-09-02 19:06:51.399281+00
246	oauth2_provider	0007_application_post_logout_redirect_uris	2023-09-02 19:06:51.627643+00
247	offers	0019_offer_cod	2023-09-02 19:06:51.70937+00
248	offers	0020_auto_20230824_1254	2023-09-02 19:06:51.87917+00
249	operations	0012_auto_20230824_1254	2023-09-02 19:06:52.033929+00
250	options	0005_option_help_text_useroption_help_text	2023-09-02 19:06:52.116678+00
251	partners	0014_auto_20230803_1300	2023-09-02 19:06:52.750697+00
252	partners	0015_alter_partner_unique_together	2023-09-02 19:06:52.834824+00
253	payments	0015_auto_20230824_1254	2023-09-02 19:06:52.983576+00
254	default	0001_initial	2023-09-02 19:06:53.184617+00
255	social_auth	0001_initial	2023-09-02 19:06:53.18738+00
256	default	0002_add_related_name	2023-09-02 19:06:53.271478+00
257	social_auth	0002_add_related_name	2023-09-02 19:06:53.273797+00
258	default	0003_alter_email_max_length	2023-09-02 19:06:53.283391+00
259	social_auth	0003_alter_email_max_length	2023-09-02 19:06:53.285276+00
260	default	0004_auto_20160423_0400	2023-09-02 19:06:53.524616+00
261	social_auth	0004_auto_20160423_0400	2023-09-02 19:06:53.52683+00
262	social_auth	0005_auto_20160727_2333	2023-09-02 19:06:53.538883+00
263	social_django	0006_partial	2023-09-02 19:06:53.553351+00
264	social_django	0007_code_timestamp	2023-09-02 19:06:53.567457+00
265	social_django	0008_partial_timestamp	2023-09-02 19:06:53.578236+00
266	social_django	0009_auto_20191118_0520	2023-09-02 19:06:53.729492+00
267	social_django	0010_uid_db_index	2023-09-02 19:06:53.807721+00
268	social_django	0011_alter_id_fields	2023-09-02 19:06:53.964445+00
269	users	0021_auto_20230616_0947	2023-09-02 19:06:54.612888+00
270	users	0022_user_cod	2023-09-02 19:06:54.697271+00
271	users	0023_alter_user_cod	2023-09-02 19:06:54.78734+00
272	users	0024_alter_user_cod	2023-09-02 19:06:54.875342+00
273	votes	0008_auto_20230814_1539	2023-09-02 19:06:55.448812+00
274	social_django	0003_alter_email_max_length	2023-09-02 19:06:55.45635+00
275	social_django	0004_auto_20160423_0400	2023-09-02 19:06:55.458942+00
276	social_django	0001_initial	2023-09-02 19:06:55.462214+00
277	social_django	0005_auto_20160727_2333	2023-09-02 19:06:55.464702+00
278	social_django	0002_add_related_name	2023-09-02 19:06:55.467243+00
279	meetings	0024_auto_20230903_1223	2023-09-03 12:23:17.888463+00
280	offers	0021_auto_20230903_1223	2023-09-03 12:23:18.034798+00
281	snitch	0002_auto_20230903_1223	2023-09-03 12:23:18.052474+00
282	social_django	0012_usersocialauth_extra_data_new	2023-09-04 19:43:47.799744+00
283	social_django	0013_migrate_extra_data	2023-09-04 19:43:47.930971+00
284	social_django	0014_remove_usersocialauth_extra_data	2023-09-04 19:43:48.031193+00
285	social_django	0015_rename_extra_data_new_usersocialauth_extra_data	2023-09-04 19:43:48.120662+00
286	snitch	0002_auto_20230904_1945	2023-09-04 19:56:59.339827+00
287	snitch	0002_auto_20230905_1237	2023-09-05 12:38:03.002316+00
288	snitch	0002_auto_20230905_1543	2023-09-05 15:43:07.327333+00
289	snitch	0002_auto_20230914_0840	2023-09-14 08:40:50.1235+00
290	meetings	0025_participant_cod	2023-09-14 09:21:05.641244+00
291	snitch	0002_auto_20230914_0920	2023-09-14 09:21:05.677621+00
292	votes	0009_alter_vote_cod	2023-09-14 09:21:05.739483+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
onzfpvt0opedlolplc8crqj5u0b1be9d	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1oArFA:u3v5MG7_wvLD5pI4qvSakOsa6ElYWThHKVIFboPcSgs	2022-07-25 11:06:24.093164+00
8mwetkqy8rmwmss8lz6aso1ssa3y8vpp	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1oBW77:53GTqUCd0R3qQyW2bZnW_uiKGbvCPIyaUEPR8sZodYM	2022-07-27 06:44:49.521494+00
d4qd55hvlu77hfsab1o9ae7jdr544j9r	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1oL7iq:h2mHYnPjpvr26x3WK-ya0DCYj4wDO5qUQl9XjZWn8_Y	2022-08-22 18:43:28.322838+00
ma6obw18r0k60avebla6swiehp72jvkx	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1oLOGM:ApSz-_Eb_hQeDnMiSuD0Fl-pAsC9cdPU3PiNuiD2odQ	2022-08-23 12:23:10.182538+00
x90qxmlhkd5sz3uppibo3hujkcexp587	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1oLg2A:3sqXwN88UYMYOLsYA5Pj67PhrHfb5F52nXhNp0E_1HE	2022-08-24 07:21:42.381032+00
zkjkuc3i5tyku6nkso1yky6w6h7iyoa2	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1oM3UO:s_aqE8A5ywrP8sAjqdA6LWzfnbRkPyi0NClQHMjScHM	2022-08-25 08:24:24.65178+00
13vuvw8ddy9di23fesbr13amzffb1e6u	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1oSvHM:paw1vUAaatvuPYIQFKFtySWYzVzXbb1WGqm1eMl8RI8	2022-09-13 07:03:20.94893+00
u1d5fzez8olhtua0dlxf7ooej5ht8dsv	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1oWEtS:nGwi3g4eyoT-nu7qSXV6CgUH_BnwNAtkfCQMlrxcGLU	2022-09-22 10:36:22.286144+00
jqr02koefxm1om46k5uxyl2qjtu1vgn9	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1oYmAm:G_4-oCIiM3Dykq8JdcsoXP_2jNI1pkLXK0QCnbcZHuk	2022-09-29 10:32:44.370409+00
34eyl7tvevg5mcwmw6x7kpnr0cr8y9hf	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1oaBh5:nkCkcnoStUuyJZCsTFi3WvDDlQmtx3yzZiBSfCeXbpo	2022-10-03 07:59:55.921297+00
hqtr18a10zbofj2dym7spcxda9x4byo7	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1obGx9:CYUqCR5Spcd4Zazkzw4BInqvzPFbPBvpeZboE5MR8cA	2022-10-06 07:48:59.224702+00
twuzv4fhf4kq8j036356dp6y6d4mthcp	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1odqqn:gYV-BOF0qDQvkMJKFOR8HZMqtskiTqolt5NQ3dPxj0k	2022-10-13 10:33:05.975167+00
wsw88agqlg21nvaoy0mgtz8zu5x1yi08	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1ogOrs:PDptqVZ7UWqboE1cmzg-kquvL-jvBUoWWKKxanKY48U	2022-10-20 11:16:44.158363+00
f44t8on7b3qdht6abmn3nwa3eejjpzxo	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1ogQ7v:2h08ODiVQS43VdSFfxpPcegsX3JmWkoTup0WxIF2OqA	2022-10-20 12:37:23.845482+00
bnt6mc3we0d6y9l144u92641qan9e22d	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1oi1fB:DkMWZw71ZgkWvqqIYG-czUfF_ZRZxWilGcJSbctN3WY	2022-10-24 22:54:21.326393+00
7po6w8c8sm9tc56epb9ne8q5wygtw9ar	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1omrUZ:ufIGhNzaf2BtIpaywVJ1iQKjfQx8S7YypDqOY64u-U4	2022-11-07 07:03:23.039151+00
b0sj1ely70doe7cubdbyt5ard9qtfpz1	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1onE6F:GnpJu74BL5rsFrU7utHNzRnB4Luzy9GBtlMQqmnNGGQ	2022-11-08 07:11:47.695359+00
lv995bfkf7khcuuvu2jfb513mo9jpgvm	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1ondjf:sntuysQsIAlQna6oiDc8qBhMm-560GxHuABnuNn5ljQ	2022-11-09 10:34:11.198758+00
b1472qagaald19pc9iccvhdk9e251733	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1ooK1N:iSpLk0o0eVfOXtrS2iQi0G4nZA68wZ1JL_RpEAQ6uvs	2022-11-11 07:43:17.838086+00
02ilu7vafme9856z64htk9ihjbcni6qf	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1os48p:Int43h2_e2vdKCvtYbeITFmJGOWJuecBXmXgJmbzd0k	2022-11-21 15:34:27.052825+00
7u7icxrl3sj9fqv62x8a4cdrk7gm88pz	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1osP5p:pSaDe5myEMwbXVWq8FNawtxkS7uOmGcKaIrCt2vzBwY	2022-11-22 13:56:45.383652+00
sgiyavqlsspg2aozbga0igshqmrs0y0n	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1ouXYt:RXiXwtraNTS-WnXGWRNMgcwJnxWNHgV567vpxHXS_Ws	2022-11-28 11:23:35.986738+00
cy2jol0jct9tvkyqhbfn74x31xvdofft	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1oxOE6:-fpXWtdn79yHroaelJ5gycg55J6kM4_JaAxCyjOP9SY	2022-12-06 08:01:54.343176+00
nbfhrvl9ual163ttv5ha1dqpgr45rk6h	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1ozc6t:KVeDhc75UbTJBAmjiP23bWsxnFY8Cfon3AuxmMBlJjw	2022-12-12 11:15:39.757971+00
0e9pu4wtlp39bu7cs9i5la49e4wbfbd3	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1ozfJz:ONtuUPPzPSYiFJS7q06SXLx-WbfZ5P6gkyOEu7krq8Y	2022-12-12 14:41:23.138067+00
9oi0ftnav2tlnbkgzhw3tsmikwf4oqiq	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1p2T8w:s4S9eq8jb1Z2VHrLSUfpX_5c5yahOmU_dCqN6LZA8eQ	2022-12-20 08:17:34.402386+00
r50oak8088dqk8ozh15q2etcyfe3f7bo	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1prvpj:iPxnM8YTMLMfi0RlTL0GgI-riDbV775LaBf6IAslvzQ	2023-05-11 07:14:27.271639+00
9uvmdpj5tpg0zvo756lfqslz1je5y6db	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1p3ZPD:OamekF9dY69uafh35xGLsliNxnbn3y2V5P5zsSNnom4	2022-12-23 09:10:55.637287+00
6vhen66tmis7gemwf0webbqd7t7bhuj8	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1psUT4:7Ts-sZKH7FiB5BgKgSatzz_3UTT2lfuGXJHsxeGqHz0	2023-05-12 20:13:22.707529+00
xs5z1apf8ko03athtexvhrdbcgwbbj29	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1p4ezP:dG-Du28jaV6Cg95RBufNzpkhf8M9ZKJTI4hF8B5Qz20	2022-12-26 09:20:47.835376+00
0m8ksmwdogyed9v9qtslwb0s69fcld4q	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1puS37:wxF4qdWiMdL1ffl1Ups0gk64IR2GiaM0Yq_cmhAiMBo	2023-05-18 06:02:41.603076+00
vyoeg5d7e2pwef47h4fqlmnfjb1txc3w	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1p8c7Y:8mIx-RyptcmecQIbxQRezWE-nPzlipxFyZgHBTpKH14	2023-01-06 07:05:32.148877+00
7fckph6bqerzmz0vx7mudsw5t5sfrszo	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1pwKDT:7IdPjA-p_LYBbG35MyQTZwztveLkfxepzTya4dr5E_I	2023-05-23 10:05:07.427459+00
qh1xqfvnvc8tyciun9l420yigysl4wiw	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1pCrRK:Al7irU5eGDeDd1_Bu4h2m65n3-KE7P4UAWPQciaEwYo	2023-01-18 00:15:30.29485+00
jtr0t0iy0qbs1eokfnm62kz4lmdrunr8	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1pFYaB:jAznI3YWNOz55DKxEDgAARWnpTqJbxwyINDv2cQVVU8	2023-01-25 10:43:47.909069+00
ih9fuyakd4ho1c1mmko0cpu74lu8svn0	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1pL0qj:6WYg8Ia7WLnZzYaJD-Smi-k4oKzUECJDrcSRSmEtMLQ	2023-02-09 11:55:25.572597+00
5g786cco4lr3c7jqtzxpdfscwgy2frm2	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1pMUSi:gH_MewY4dA56xaIX0ulhpaOLsgkBeY1nSW9Pg2afenI	2023-02-13 13:44:44.805513+00
mm0ktar9dvldu8dl9jbghynaffg58pbw	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1pNXMn:W5b4MlOImS6MTuLV1ATbJE7q9mJNwjcP7qxXcxOzSGw	2023-02-16 11:02:57.992146+00
4duohcutkhsg0dqdyx7l5i8kfy1u31sc	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1pRkKq:GMakJwOKoeD0YBclUtCYgcERisHQNVJBkRHPoKq_8g4	2023-02-28 01:42:20.570592+00
zl8ydjz3w8i1k3uwud3lxro8blysignc	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1pSG9M:K9cAvyWDzCH5gMMsmCx9eCmOFC3RUsTerQ9-be1sBy4	2023-03-01 11:40:36.135628+00
ohxwf9ncmggexk1lki5wpw6g7twx1gdd	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1pYxB8:7AYGofw4uslEHxI844wsPnuLyy69MOGWyHS5mEeXKak	2023-03-19 22:50:06.735093+00
3owcj64jj1xx1utsucmtdwcbiztgxsxc	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1pbcCq:4BQE0QeWNSy8zB1FjZ_ixxGw0RFSfRp8H_kV0glN5oA	2023-03-27 07:02:52.270634+00
ft1pqa85xi2dnyfsmlb1azbb4plvi7wu	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1pckc8:AcbXDmfg61WBiGScyvlBNrVN68k_--QTcpgwkD69xdA	2023-03-30 10:13:40.615275+00
s5kyqwkr8l3zbu2vu2ue3qmiwha89m8o	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1php9E:Fl-ZKp43LBBN6uMvbZEAVvk0hQedIKyQrLFgM_ARDg0	2023-04-13 10:04:48.38368+00
5azuggsoeto9ers9chj5o1b8itbnr0ob	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1piGRB:SQnbwz7cHpRdTvYNIjWEQdp40XJrWyba9JS_k99r3f8	2023-04-14 15:13:09.812761+00
60qu4tqizp0b8ma3hrnts0495sjlukbt	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1pm894:hh5sGh2mlx5K7KQ39wejWPrz7i-hVy3GdLubx2NkmqA	2023-04-25 07:10:26.347695+00
d7r7bpsa0sap62vauy5ql261vfdppoba	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1pmAn9:vPyvj-Mky7s8NG8yi9leuCOiI_5rkSok3dfPNKum5J4	2023-04-25 09:59:59.186274+00
uzrm6z1bb4nmcpmmw3l3qq4a7qe979r5	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1pnG1V:JpZbVDIeB_XVcQuQ3U3yHJQVEmXIu9MKEOq0osckOOY	2023-04-28 09:47:17.036484+00
ufxk39te2wypz27rjxggmpokx9drgf1x	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1poKBJ:3Mq6dGc0m6xYbO3HJ93mhbC1AjSlwzwTO6tGI9R3LXw	2023-05-01 08:25:49.504368+00
o5hfi0dtwxpqgvl998byx6e3j72smmia	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1ppb7m:x_jG8L9oQ5zenMKXTAOfhaE6O7z67HnBZEnl-a7Nx4Y	2023-05-04 20:43:26.979611+00
vgacs3zngy5751rmqr9e3z3mqfsyg61t	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1prfn8:IUeqfJLm6gBVGw7wM8d--rIb_gHxuaNyxvC_CmQDrRQ	2023-05-10 14:06:42.31962+00
xk70s64hcmm9abf0yo1vutnqwi0wwaf5	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1pxQH9:f7nsMzxOSmqODgt2F4FtGuzXWauhwWaRxadu4wMY4H8	2023-05-26 10:45:27.250586+00
mdx6wgbx5kc9g1cka9mwzm5ggeh513wm	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1pzddR:0Ymc5B4X2_mcgvYXQBOefftnl2af3HiiEnyz6kK3GkM	2023-06-01 13:25:37.587562+00
4nb8fv1k4rzvsep6pnfusdmaxp5v4aod	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1q2UW9:piMOk6fLa3P9lVH0DvzhnZ4C3nbTyI4G6Z0halE7vWY	2023-06-09 10:17:53.398613+00
wo0tk7nfx47wsksnz005wvwdu9fx9m22	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1q93lm:K6pSqBmV8oi16jCkSMQABxoPBGsm52PAOpuVsCzPcBM	2023-06-27 13:09:10.531289+00
fek4bt3c5ykaevn1yajobf9i0d33wtg8	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1q948V:SNU-4ricMdYMh7_7TWgAurjcEU00rVuVAmtQPoAAbNk	2023-06-27 13:32:39.350732+00
obwflak73x3hz7a7qxe8ve2ebdomjz12	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1q95Xs:uIGrHFbwyx8mzgaWxXK9qwlMrVKZoo0NLTBo0uxZYPo	2023-06-27 15:02:56.583725+00
bne21oc5tbfi5aajiwk4k629nuljm19p	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1q9Lok:JMgjL6HPnBHUYAoeDpgvnAC2XaS-WWun47VNLJKQaSU	2023-06-28 08:25:26.365472+00
lzmcpxnfhrqe93poxjxdwk61ozh9p96n	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1q9Wtg:spv4he75BMTr5mXPGZFY7OahftlrkX4nsM6AUMKdoh0	2023-06-28 20:15:16.345731+00
aekw7r6menjtbzjd947nzjphlk8w2q9y	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qB7xb:EDeW-BrLj04GMzKItfWR9ZEYGdFLqiSRWL0UtB6pvyo	2023-07-03 06:01:55.303715+00
cjvt55lsi7hhqjkqrtukytlf3bep388i	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qBCYa:ECh3ytoDmBm-uzF0_I8KKjUHUO7xoKvKTHg3rSVaOMc	2023-07-03 10:56:24.175094+00
6m1wf3vnum3d0i9isnr0928rpz5f2p05	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qBsqL:9E8A3bVcuFwFMg-WOzyIfiNIR29kN9CGgP75tnWH2Nc	2023-07-05 08:05:33.286275+00
1nqc1eg9pkrot31i5mk9mb5uj032c0dv	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qCcv6:G74vzS_mIMLmOdWlW4IHg3gtrRxELBmGV7_mQGsY4xc	2023-07-07 09:17:32.384978+00
6r5uycm9i8a8gctk8agw32nzlf3ncv3s	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qCkIt:b7qUNjFm4mHeI4UM0mkecAVUOmOZfNgKv8JuM7qU3mg	2023-07-07 17:10:35.681432+00
723tvowa0twzv212od7gt248uhpeznmm	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qGCfA:5XJC7C1HYwmtTInpO2zUT2V-dcOh4g3JDvwK6vrHW90	2023-07-17 06:03:52.802345+00
4vco27yjigyuf2j3emxg07i71zziniao	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qH4CJ:G-2njn0hcpA5teAAQfaBgQu7aK-WUHgDmv5AaFQ6WVE	2023-07-19 15:13:39.909719+00
zoi60db1t0pvm572rq5lnfnfb07x7znr	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qHM2O:1FRvzE1ymEDfx8jUE2G9b8BBINNBrLL-NEFY3WuNTME	2023-07-20 10:16:36.045457+00
z6scgfqzw1joiz4o3t1z045tww008mha	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qHheU:heuoGFllmXNCYdAv6OJvCW5wfjJn7wgGrYWqiC_DAKU	2023-07-21 09:21:22.566593+00
0lrytj0wo665fo3jbp4v2pjowrcmvpbe	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qJ6B9:JnEdN5qwdFY-hlrFADD-T5QPrcCDR4J0sON_mNzntLI	2023-07-25 05:44:51.243398+00
ccqnfw8n8me59bt18p1rhh1drzwvzrvf	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qJbhE:HggEHYYXwdptE-lhFq6QesxtEGxpsr51_fwElKJlLEo	2023-07-26 15:24:04.489737+00
umcw4awb0ph6sormtnsht3perlpwxrb5	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qJtPY:W787k4ef8o7enKi1qQguZJESrRcUvSY_sydDzwvM9kc	2023-07-27 10:19:00.537668+00
5c45u88fpzq5dze1izr1eyybj7qu0922	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qMQEF:inR565rnejrpZzQy2pwqsFSFcwHzSv7YZL52us7nkhw	2023-08-03 09:45:47.140249+00
pztt5qo2ydkiahorqqpkfspog3m9mv2b	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qOvGT:lY82oJLxCSfoluGNtHi1oeoMqZEyLoQpmI0m-o3oAlU	2023-08-10 07:18:25.859427+00
p27t3lzrzl35coqateuycv0hz8tlzmo4	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qPFGE:rTQilO1NoC7ipVPRNyRVHK1Nup4UtTOhCro-Yj5qubQ	2023-08-11 04:39:30.883305+00
qgqqc82pok50l9a1ocnvb5f5820do8nr	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qQkrG:v0AMQzYpM-nF3Z7Lrg7p2MKQ-aLqXz8Jtzjvg2nPzlk	2023-08-15 08:35:58.846334+00
wzw5krg9gnjsbqujva70abjv89knjzs4	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qR9R2:sOoTlJQDQVpGvxZa4h_wibfWwyYAF1nhVMnhNnR4qjA	2023-08-16 10:50:32.123739+00
6mof1cs70gtg02iiarobqkzghw58s6be	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qTHDe:qYn2MMFwGMXIwN1m-L6aDc4PCVPcZ69bXkr2RTp6UWU	2023-08-22 07:33:30.53559+00
85b7m6gyfe8u55alppj0rmy0q6w869hn	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qTmtA:8m8tleKdh5a4agHPIBhMyi7L3Ftye-6HJSilx02-FEE	2023-08-23 17:22:28.093432+00
eoftc8ro0ptepgatgh8e0ddbxpjzu7qv	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qVZwd:Jn_-1V-DEKmpd-kzclBLyGJAEDW62dv6T1g5-NsHvvU	2023-08-28 15:57:27.923487+00
bt35aaj5u9q6e5r9ihtxzswdtcimk919	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qWBPH:XASIT1CkJQqxkbCDTJwviEW5p_CgdXGIg6vG-YvR5PM	2023-08-30 07:57:31.130189+00
uh5ffeykbe2mdwe3v5hd2wqfxwv75a04	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qWMct:GpVE_ybt1FEkDCMlS7prj8Zz4QMi0PtbBqiHI8srKz0	2023-08-30 19:56:19.901109+00
3mxouem00hi6cm4iitneeal4iiwa6t8n	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qWtmu:7K2RP4kqsYhoFopR3JezUyYp2vLin-5qW2Jg9AVtx2c	2023-09-01 07:20:52.125169+00
37oimifdvnbrmno6z4c0lf2tcqju5hw0	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qaWKM:CpBAFdc12oRIybweRh3cCJ75eFnQ10scxOSewmKZ0jk	2023-09-11 07:06:22.238563+00
z2ncvwip6iz9zkwh74vgxvusdks7e4py	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qs4pH:L6o3ilVDBbpQSxUo1HHUW0yc5zC691g9PufWqH8twi0	2023-10-29 17:22:51.031797+00
sstw5qs4k3is7d8xneju6qfvpwt72zpd	.eJxVjDsOwjAQBe_iGlm21lnblPScIdqPQwLIlvKpEHeHSCmgfTPzXqanbR37bSlzP6k5G5-jOf2uTPIodUd6p3prVlpd54ntrtiDLvbatDwvh_t3MNIyfmt2nMSpJiLgDjR4SJFDEGSk7BVJcZDAwXXAIII5dg4yJsxY4uDN-wNFszhE:1qcYOF:zM5ZwW1hV8DPm0Q5atF1ze_pqJKtfD1Y-nX-j-kEMgk	2023-09-16 21:42:47.093072+00
726sveyrrnx6s9d8uee7xdvcvor7vxfk	.eJxVjDsOwjAQBe_iGlm21lnblPScIdqPQwLIlvKpEHeHSCmgfTPzXqanbR37bSlzP6k5G5-jOf2uTPIodUd6p3prVlpd54ntrtiDLvbatDwvh_t3MNIyfmt2nMSpJiLgDjR4SJFDEGSk7BVJcZDAwXXAIII5dg4yJsxY4uDN-wNFszhE:1qcYsr:FEO-CkaRA5N6a_LwM8gh-OFfkQcMnvFV6A1vaOMH1eA	2023-09-16 22:14:25.47976+00
zgo3kfov1ppqus60o5p35x9pb11w3fka	.eJxVjDsOwjAQBe_iGlm21lnblPScIdqPQwLIlvKpEHeHSCmgfTPzXqanbR37bSlzP6k5G5-jOf2uTPIodUd6p3prVlpd54ntrtiDLvbatDwvh_t3MNIyfmt2nMSpJiLgDjR4SJFDEGSk7BVJcZDAwXXAIII5dg4yJsxY4uDN-wNFszhE:1qctsC:8JQkcn0hpE-ut_40hq1jCkWUMW8__q1yxvTnKTxG7Is	2023-09-17 20:39:08.314502+00
ni56vra4zvdtfqd0fxi7ei19hiufqw5c	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qcvWf:PTGUuqivRVm243Zn692f9j6OlzUQp3gIRshNKEdZ1Hk	2023-09-17 22:25:01.030223+00
8x8wlahcmnglvglu9c9xc0obgk15mdsf	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qfihL:brSnHC6rerVb2d3k_GW_nohdHiVzCwbho6vF2pdBNyg	2023-09-25 15:19:35.179211+00
6hiu35yev4n6908cdarylz1tpjhnyr0a	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qd6x0:IK2hvy81-rfWsCs6cOIal63P0uuR_14vZSmJLi6levM	2023-09-18 10:36:58.873999+00
03xn3n10l7by1f6jhrq6fnevax2e0eg8	.eJxVjDsOwjAQBe_iGllx1p-Fkj5nsNbrNQ6gRIqTCnF3iJQC2jcz76UibWuNW5Mljlld1LlXp98xET9k2km-03SbNc_TuoxJ74o-aNPDnOV5Pdy_g0qtfmtHIWEJneWSOVkoGZwRsBY8EmCxLOwAjRXCzgCHvi_Gl4BiHKIX9f4AFds36g:1qd87G:xy76c2qUyU_w6iwixf53ptrEOXVyjbw9S5g4MJ8h-aQ	2023-09-18 11:51:38.539064+00
3soow4rvcib3yglo2d4nnxmhbznvcwyu	.eJxVjDsOwjAQBe_iGllx1p-Fkj5nsNbrNQ6gRIqTCnF3iJQC2jcz76UibWuNW5Mljlld1LlXp98xET9k2km-03SbNc_TuoxJ74o-aNPDnOV5Pdy_g0qtfmtHIWEJneWSOVkoGZwRsBY8EmCxLOwAjRXCzgCHvi_Gl4BiHKIX9f4AFds36g:1qd8B9:70H1UWv8c2Vi0X9egyP5qIfLAeOLVsXg1-Jn9gdt01A	2023-09-18 11:55:39.977526+00
z0bpi37bfqsl8wgjbv6mef2f79771qmz	.eJxVjDsOwjAQBe_iGllx1p-Fkj5nsNbrNQ6gRIqTCnF3iJQC2jcz76UibWuNW5Mljlld1LlXp98xET9k2km-03SbNc_TuoxJ74o-aNPDnOV5Pdy_g0qtfmtHIWEJneWSOVkoGZwRsBY8EmCxLOwAjRXCzgCHvi_Gl4BiHKIX9f4AFds36g:1qd8v5:v-JLZmYH8wNYz3klHa9sQTDlyJ0CKyTLqsVyDuKz7V0	2023-09-18 12:43:07.034894+00
1jq77vtef06ntzz8n4d2e4f0vr6pqsvc	.eJxVjDsOwjAQBe_iGllx1p-Fkj5nsNbrNQ6gRIqTCnF3iJQC2jcz76UibWuNW5Mljlld1LlXp98xET9k2km-03SbNc_TuoxJ74o-aNPDnOV5Pdy_g0qtfmtHIWEJneWSOVkoGZwRsBY8EmCxLOwAjRXCzgCHvi_Gl4BiHKIX9f4AFds36g:1qfxnR:L0BIUGkUUObtqLGY1r2WtlQoSiXUZo11Ro4Wx3Z97fY	2023-09-26 07:26:53.764123+00
t9u7uczlsfp6474ufrmqfvo32139qzjs	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qdF84:G6I3xJteb68o7roAFuoBhNdDIYOcoQKZclAjmUt1Rdk	2023-09-18 19:20:56.350642+00
f4gottrzvvgu49a44dncau2e0keb2z5p	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qfzRN:DoTzNuvmAQ3iLYjL3xOPqIUNkGGxHsXgbGyNYnomFrc	2023-09-26 09:12:13.637778+00
u1gu5asb46raxx4jrf1f8xcyd2ui2wyj	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qfzcG:ym3xrjzK33j0Phk034wa0EhgQvax-YGcaaoUvR5cjJ8	2023-09-26 09:23:28.052173+00
v6d8pgao0m64y8p26vmqb7w2eml1rce1	.eJxVjDsOwjAQBe_iGllx1p-Fkj5nsNbrNQ6gRIqTCnF3iJQC2jcz76UibWuNW5Mljlld1LlXp98xET9k2km-03SbNc_TuoxJ74o-aNPDnOV5Pdy_g0qtfmtHIWEJneWSOVkoGZwRsBY8EmCxLOwAjRXCzgCHvi_Gl4BiHKIX9f4AFds36g:1qgAHo:17kLo3qZOhTB2Lbyt-znfDYlLXCuqn7GqRADR_qu6EM	2023-09-26 20:47:04.100323+00
orqd64bej5a752mo0rggog3g443v1oxe	.eJxVjDsOwjAQBe_iGllx1p-Fkj5nsNbrNQ6gRIqTCnF3iJQC2jcz76UibWuNW5Mljlld1LlXp98xET9k2km-03SbNc_TuoxJ74o-aNPDnOV5Pdy_g0qtfmtHIWEJneWSOVkoGZwRsBY8EmCxLOwAjRXCzgCHvi_Gl4BiHKIX9f4AFds36g:1qdYcf:tGZLVA9LAxHR_jrfxPw_5XJWCat-qhjWZCN9CunZuHA	2023-09-19 16:09:49.880063+00
o7by5mqse02x77vubppu7la585effgfy	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qdYeq:r5PGaEAfXcGp_Z-FyTJSGmuRroGZIc8BVYp2dWbyUGI	2023-09-19 16:12:04.641355+00
wm31ofhjcfeu87hrin27crp3atap3x6e	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qdxFQ:afIfHYQFJ_02TLs8Mpca4zXbSOFNKfxgKi6t5yIECeQ	2023-09-20 18:27:28.251426+00
pqai4overmw9ajnyc26ll0ggspdk2vm7	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qeKzL:cEZsiuSyYkBCTmN-_sowA6_XHhePICsI-4_L1zwcVKc	2023-09-21 19:48:27.876999+00
pm1qkajuvgt9ckeai18stt04ahv3vt25	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qeZML:ES110DybksFD5DX8fNJuujo92UdGZeJpaF7YlO1agi4	2023-09-22 11:09:09.757643+00
07aa8c2k0u7c6bh2tojzfqfrehissdus	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qgAKe:ZYsNosgges6N6E80ZyJwEqUYTsmhL-OLZQoLMp5jfUU	2023-09-26 20:50:00.075725+00
wj5rekvmphwlmwypymfoxj02wt1k5ird	.eJxVjDsOwjAQBe_iGllx1p-Fkj5nsNbrNQ6gRIqTCnF3iJQC2jcz76UibWuNW5Mljlld1LlXp98xET9k2km-03SbNc_TuoxJ74o-aNPDnOV5Pdy_g0qtfmtHIWEJneWSOVkoGZwRsBY8EmCxLOwAjRXCzgCHvi_Gl4BiHKIX9f4AFds36g:1qhwPH:OHaKuusI8Htx6n96i_x9oSCni0vhBLFvzVf67eVZg3E	2023-10-01 18:22:07.298169+00
eklqxsia8mnhp7pbb5s382kgjk0kyft1	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qiZRd:XV1dvfnBoihZv78fzeP_ho3wCMgIYkFXkbMdaC7t3ZA	2023-10-03 12:03:09.946005+00
lhbpeskarn7cmhmuazi5zi1vozcrnx50	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qt4rM:jDecY22LAyVtXmMVtGVOvrZN-RIsbqO1c_8n_Y5E_Ac	2023-11-01 11:37:08.315979+00
evf4j3efheswfbj69tlr701n2cy3jwix	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qt5ac:3LLlZFq5pu6imHgaSTKPTKCxMCw5ux02IhWjAJ6aTVg	2023-11-01 12:23:54.943523+00
jvgb894k3k5w6hwu2xihihis9f810y0h	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qjGsb:ACL01S3y05m492Wve7yRqlhQ0xX2XGeqo9gQvM7wPE8	2023-10-05 10:25:53.019035+00
8lwalingxxidw5rsnbahqycdur92iv35	.eJxVjDsOwjAQBe_iGllx1p-Fkj5nsNbrNQ6gRIqTCnF3iJQC2jcz76UibWuNW5Mljlld1LlXp98xET9k2km-03SbNc_TuoxJ74o-aNPDnOV5Pdy_g0qtfmtHIWEJneWSOVkoGZwRsBY8EmCxLOwAjRXCzgCHvi_Gl4BiHKIX9f4AFds36g:1qtF5D:5HGWLtz9Z4qCmZ6gkOD5pNx3YoCVXG9C-88iqjn6oqM	2023-11-01 22:32:07.603524+00
4qosr7j7y4lyx6avjy4i6i9nuk6lto2h	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qlSYp:NuR4HKTvdAsPgFmdBkuA1bkBi007lu93ViMGP9oJY30	2023-10-11 11:18:31.669182+00
x4pkrsazpj9ftcbfo64pgtz5ni32u0m2	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qtYGY:oL_5da2UB3MnxGCR2gd2ghjrSJQcA1nN6LB_LUzwjzo	2023-11-02 19:01:06.77056+00
cagzptcppxu8gr1u28euukl2haufyzef	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1quUS2:iCrWomVav-g2lrd9Hg13FZFvzJOdi70OtgvvYKSspvo	2023-11-05 09:08:50.662247+00
qubrlqp32z8mdx06bjlkryu66mj22daq	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qux0y:rrq5sjHh30iJsG0pfGshj2lGfKgkVJaJsIXFBD0jXNk	2023-11-06 15:38:48.943687+00
a6ndehuq2k6hxr8gaqyjk86m5j2j4hs6	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qlYeY:WyqZJPs-kjmuFgr5q8lLhkgO7-HMp_-LDa-sfd71Vxc	2023-10-11 17:48:50.198722+00
mq5w8et0a2vpy9j4flfxyresd83a48n0	.eJxVjDsOwjAQBe_iGllx1p-Fkj5nsNbrNQ6gRIqTCnF3iJQC2jcz76UibWuNW5Mljlld1LlXp98xET9k2km-03SbNc_TuoxJ74o-aNPDnOV5Pdy_g0qtfmtHIWEJneWSOVkoGZwRsBY8EmCxLOwAjRXCzgCHvi_Gl4BiHKIX9f4AFds36g:1qlp3M:sQzEoh0WZV-tN_aGcoNhR7bubhlxqs3THRDllxN6WDs	2023-10-12 11:19:32.014582+00
gl2kna14fqpf0t0fdejl77a2jy8lve73	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qmFdb:AJkRW-WUMzr960ddUW7YChAGxRj7tv9OCKQeaZqjeMM	2023-10-13 15:42:43.477794+00
acs6x7kte12qji1s9jtftv1mpuwka5qr	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qmMiT:XUNRLxq4gp6H02hHbc316skgJQVxxKcqxI_cOGgbvjE	2023-10-13 23:16:13.027202+00
yrwi8iw5s5s6j0qabb0j5yb6pi4sdx4t	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qvDwg:yeODD9QAoGwbPr0kA-r0wL_xWyA6pDiGXlelLbZBFdA	2023-11-07 09:43:30.875832+00
jwzrv7vbgb5q461j4ourf8a6bazcbyv6	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qmWRt:-DZYw5xCOM_Br7ZbWWKfVN_gFqDAtcXffdjlAEK94po	2023-10-14 09:39:45.976068+00
94jj8vk1mpupa70tx9tanrijl9cmehlg	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qmWRu:U-a-nwOjfMVVJsZ6EIOnD1tJQ_jti9ch_9fFv_8gYig	2023-10-14 09:39:46.264682+00
8arjli24oc8hw56cw5ckz1ld7oqusj24	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qvJfW:SZm4109GfjLuJ1LM20725qxsfqTJRVpM3OKQGgLPGOA	2023-11-07 15:50:10.136168+00
1uzpe7ajg45ulr4qbyzo1acx66gmqvsr	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qqdKa:7Ae7DXN4leP4xm5HWwY2SJ41NcdrHNcPs6U2VCd-NQY	2023-10-25 17:49:12.254802+00
lemm65peh2vpt8fy2jgpxxm9k1e36tgv	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qvlRB:IFAnkdJx9_ibTqipCJC7hJKU3d3Y5qjdRbu55vcWMtc	2023-11-08 21:29:13.533959+00
th3mpfxrcs2knus13kd0f4qplxpubl5m	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qw6hK:sNe7IRw2OsMWRlhEn4SqJmYW0Xm4LwjltRXrhmTV1q8	2023-11-09 20:11:18.028203+00
dlmkfharfmj3qrbiimmojbcykh9i7ycp	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qwJm7:b3_Ryaka9DbOsHYLHGPFz_CZIV27mcEhO1HsRXOY0L4	2023-11-10 10:09:07.476521+00
nblzvnamre3voxrz4dptix67x2p7n3i6	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qwTbJ:735XztUuVgkspYHzMYSBX1EUu2kqBJXWbYz6Uz0sfqM	2023-11-10 20:38:37.300915+00
8jlnu93w5e1qs80uvnou4ysxsk5yq0xm	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qxOeg:cRIIEmqY2rEnQHBgH-QOE5Tv7s3Z72fGQfbRgAdVe5o	2023-11-13 09:33:54.768276+00
zep7p9redesang4idartzmzaby5v52ej	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qyFbI:j8g3zh6smlNrnEQGQDdlQ0hb_h3TVGGV96WKhtzczuI	2023-11-15 18:05:56.124643+00
20rkavvunt3vp11xr4hhyur7sre788nn	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1qypnO:CbNX2nEi5SW4LUbo5alm_G_4TFDORMNOwUjedoAOc6A	2023-11-17 08:44:50.424832+00
d3mjohbshn1bxb12wkrlges0pmnzi5oz	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1r0ksD:3ALYxgkGtpor5Uan7BE6CtyU6zUgRDYN75srt0861U8	2023-11-22 15:53:45.250792+00
tpp8egcfj791skfhxl4d98842d63vutr	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1r1kCC:xDAl4UW1FfR15jYW2SLFOjzNnk5rS7HR5bsKysl8N8Q	2023-11-25 09:22:28.814949+00
t898a3kbqkzv5fyuo8e9ccepdsbss6um	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1r310y:KDMJBKRk_wwAAdrNLrJieOIRLqWMj05-bhPVDCG7T1k	2023-11-28 21:32:08.783569+00
sqwtcoc8kcb8xbodh4glpggimz1u9ag5	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1r3HA5:O9Qy4VZz7KDQqtKVKNSzFTPAdD59LR1MNSGDRT8bZ24	2023-11-29 14:46:37.617353+00
qzxwl15mb9oqta1h41qli7x3xeb17sip	.eJxVjMsOwiAQRf-FtSEMEB4u3fsNZGAGqRqalHZl_Hdt0oVu7znnvkTCbW1pG7ykicRZgDj9bhnLg_sO6I79Nssy93WZstwVedAhrzPx83K4fwcNR_vWBpzxMevApKwuSKBCcRRLtpixmqycrx7ZcixKg2EGG7QGixx9CFW8P-buN_s:1r3um3:EGQIygwvEi4LUMqiBIdgNVbJ4DdzYUu--JOfwYVAlVc	2023-12-01 09:04:27.848104+00
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_site (id, domain, name) FROM stdin;
1	stocken-capital	stocken
\.


--
-- Data for Name: documents_document; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.documents_document (id, created, modified, name, description, file, visibility, company_id, creator_id, file_hash, stellar_transaction_hash, related_meeting_id, related_operation_id, type, blockchain_link, blockchain_transaction_id, cod, transaction_hash) FROM stdin;
97	2023-11-09 20:46:29.504316+00	2023-11-09 20:46:29.255108+00	09/11/2023_Contrato de Compraventa_CLADDING AND FLOORS SL		documents/8ad20a0b2952676c7f25a6368aec2bd2a7fc61bd7929525882a944a23e0f8c6e.pdf	related	3	9	5eda9ee93fc9b401e97992d75417	\N	\N	91	operation	\N	\N	\N	\N
31	2023-09-17 22:25:11.637605+00	2023-09-17 22:23:18.671553+00	Escrituras	Escrituras de Block Impulse	documents/c579306cd0d374048d1071bdc4d329ea3bde0ded92e8224581d6452d2bd69c17.pdf	private	4	23	faa1a895e11bd527eee5b76d6b99	\N	\N	\N	\N	https://mumbai.polygonscan.com/tx/0x09c90f7af30cca29d6624ed6d54c100d460499e4b8706bbbba2e4cf51a7c14f2	0x09c90f7af30cca29d6624ed6d54c100d460499e4b8706bbbba2e4cf51a7c14f2	\N	faa1a895e11bd527eee5b76d6b99
30	2023-09-17 22:23:18.910061+00	2023-09-17 22:23:18.671553+00	Portfolio 2023	Portfolio de los proyectos en 2023 desde Block Impulse	documents/705b8464f65416cff93adf3472d24aa065b05b89f4df226a145975410acd99a2.pdf	public	4	23	d1b35d99ec55835edf00a7bb5edc	\N	\N	\N	\N	https://mumbai.polygonscan.com/tx/0x973e68a0db5e509c75eee5c433d413aa42456d358a2d325412cdd6ffdc70d39d	0x973e68a0db5e509c75eee5c433d413aa42456d358a2d325412cdd6ffdc70d39d	\N	d1b35d99ec55835edf00a7bb5edc
32	2023-09-17 22:25:50.783075+00	2023-09-17 22:23:18.671553+00	ROI Block Impulse	ROI de Block Impulse	documents/df907c7e0e4841196370f6378166b482fdfd72163c75ea313625bf99eedc67b0.pdf	private	4	23	ebe0c2a46fb105d0860a95e94ae0	\N	\N	\N	\N	https://mumbai.polygonscan.com/tx/0x4dd19e77f39f81c3afded773aa67dd86757f0d3bd5b0502a026e1aef2680395f	0x4dd19e77f39f81c3afded773aa67dd86757f0d3bd5b0502a026e1aef2680395f	\N	ebe0c2a46fb105d0860a95e94ae0
33	2023-09-17 22:27:30.691952+00	2023-09-17 22:23:18.671553+00	Contrato Bitnovo	Contrato firmado con Bitnovo para integrar sus servicios.	documents/e978a361c85ce303ca63193bf88c3fa064d7390bc7e51d899f89467f13eca801.pdf	partners	4	23	0f3302fbcc7454429e898392ebe2	\N	\N	\N	\N	https://mumbai.polygonscan.com/tx/0x8674f9311622f0078f3569883ec5f8b1f97986af3e266c9d3e77f9cf5ac8995e	0x8674f9311622f0078f3569883ec5f8b1f97986af3e266c9d3e77f9cf5ac8995e	\N	0f3302fbcc7454429e898392ebe2
44	2023-11-01 17:38:37.844989+00	2023-11-01 17:38:37.728689+00	01/11/2023_Contrato de Compraventa_Block Impulse SL		documents/c9d7e9e1200bcd9460b9bfffd9d951650659c3ce29a471d139ecdeb17f52a477.pdf	related	4	23	9422c9b759672d946907c925f98a	\N	\N	25	operation	https://polygonscan.com/tx/0x1510d4b5141f3caa9658c59769fd81fe7ea41b79114f218a976695ec29e6d253	0x1510d4b5141f3caa9658c59769fd81fe7ea41b79114f218a976695ec29e6d253	\N	9422c9b759672d946907c925f98a
35	2023-09-19 06:10:16.893586+00	2023-09-19 06:10:16.726515+00	Arrendamiento Oficina	Contrato de arrendamiento oficina Valladolid	documents/f26b3183a495064dbe9bdd9822d094368af93a7f248073d89ed942a3385ac91c.pdf	partners	4	23	7614231c2d0fd4da029c5cbfc1d0	\N	\N	\N	\N	https://mumbai.polygonscan.com/tx/0x8aa629f4ef61586e15eb3ecfdfd6b7e621123c5f73c04c89fcf913abed9d4d86	0x8aa629f4ef61586e15eb3ecfdfd6b7e621123c5f73c04c89fcf913abed9d4d86	\N	7614231c2d0fd4da029c5cbfc1d0
37	2023-10-31 23:41:42.28154+00	2023-10-31 23:41:42.175968+00	31/10/2023_Contrato de Compraventa_CLADDING AND FLOORS SL		documents/3f1a69ad16fa51657c4cdfcc05b16f4cd9763e8b70ec1f385862bc4d97095d9d.pdf	related	3	9	fede4de6b6696e47039f7db38e03	\N	\N	21	operation	\N	\N	\N	\N
38	2023-11-01 09:34:31.197158+00	2023-11-01 09:34:31.026674+00	01/11/2023_Contrato de Compraventa_Block Impulse SL		documents/46a7f4f3bc09ff0d64937b2dee9fb6a08bd9bdeb787862f11bcda4bc629342b4.pdf	related	4	23	f6a390d38c104967847ccd31e95d	\N	\N	22	operation	https://mumbai.polygonscan.com/tx/0xc962f104c482f7411e0ce8fbcf0b561e3ccd98e725d759e80bf4ee1721401044	0xc962f104c482f7411e0ce8fbcf0b561e3ccd98e725d759e80bf4ee1721401044	\N	f6a390d38c104967847ccd31e95d
39	2023-11-01 15:36:59.662034+00	2023-11-01 15:36:59.470919+00	Test	test	documents/7eb7fb8e9a1dbf0fecd9317f4c9e01985b32cc9c72e3cb7e50f0ab27942be658.jpeg	private	4	23	c2cf6be7802eb1d3d0abbf0727f1	\N	\N	\N	\N	\N	\N	\N	\N
40	2023-11-01 15:41:58.730401+00	2023-11-01 15:41:58.598112+00	test 2	test	documents/274ce65dd059434bb38f51b9ee80e14f663d8b578109f2a1929b0b5b01116fb3.jpeg	private	4	23	c2cf6be7802eb1d3d0abbf0727f1	\N	\N	\N	\N	\N	\N	\N	\N
41	2023-11-01 15:47:07.438225+00	2023-11-01 15:47:07.289457+00	test 3	test	documents/88cc70486c537e6b798e1560999f0dd3f23da31dd2106b3448847c076376d172.jpeg	private	4	23	c2cf6be7802eb1d3d0abbf0727f1	\N	\N	\N	\N	https://polygonscan.com/tx/0xd270cadcddbf524566e70310aca59a5e3634dcffadf7048031e44ebfdc06c998	0xd270cadcddbf524566e70310aca59a5e3634dcffadf7048031e44ebfdc06c998	\N	c2cf6be7802eb1d3d0abbf0727f1
42	2023-11-01 17:25:43.820575+00	2023-11-01 17:25:43.686682+00	01/11/2023_Contrato de Compraventa_Block Impulse SL		documents/f9e707c8ebfe6ea14522c5d36d88d5cc45a4ab13706920c2b5519fbf4c727f12.pdf	related	4	23	c19f20dfa23eec3584ef5384f213	\N	\N	23	operation	https://polygonscan.com/tx/0x20c1a805bc665907d7eced4d6b99ead0e8db5d61b7e9325c4b9d32d3d0513287	0x20c1a805bc665907d7eced4d6b99ead0e8db5d61b7e9325c4b9d32d3d0513287	\N	c19f20dfa23eec3584ef5384f213
48	2023-11-01 18:08:38.522947+00	2023-11-01 17:48:38.790554+00	01/11/2023_Contrato de Compraventa_CLADDING AND FLOORS SL		documents/fc0b7bd769733d3cfcbe0ef18f48b61dabc0449e70f36e206e081bff8ddaeec8.pdf	related	3	9	1c67108c0b1b70c555dbe2808db1	\N	\N	32	operation	https://polygonscan.com/tx/0xdbbd4a616f602f62dd18513255eaeab8f4271d64058cbff53e5ca33f4c8000d2	0xdbbd4a616f602f62dd18513255eaeab8f4271d64058cbff53e5ca33f4c8000d2	\N	1c67108c0b1b70c555dbe2808db1
47	2023-11-01 17:48:39.241606+00	2023-11-01 17:48:38.790554+00	01/11/2023_Contrato de Compraventa_Block Impulse SL		documents/31913860243a328f2a8e1a451849ad96864c404c2a5fe91d98e3b38932358bb4.pdf	related	4	23	ab6d4e8e6b40cc7da645f41252ac	\N	\N	28	operation	https://polygonscan.com/tx/0xf22f42dbc92b787462fa7aa34abab7a5659d4457403de9e751f0e7f228d0763c	0xf22f42dbc92b787462fa7aa34abab7a5659d4457403de9e751f0e7f228d0763c	\N	ab6d4e8e6b40cc7da645f41252ac
49	2023-11-01 18:13:38.9384+00	2023-11-01 17:48:38.790554+00	01/11/2023_Contrato de Compraventa_CLADDING AND FLOORS SL		documents/b5f2ae64d7fc956106085ed845d0e635dea4d1259bfd2d6e5ed3032f34fe0d4b.pdf	related	3	9	82d3071f500db044d554b12661a4	\N	\N	33	operation	https://polygonscan.com/tx/0xf9a1b1d6c51f5ac7060979ddaf969a0414d8a75db90e05a30025b0beeb41fa9a	0xf9a1b1d6c51f5ac7060979ddaf969a0414d8a75db90e05a30025b0beeb41fa9a	\N	82d3071f500db044d554b12661a4
50	2023-11-01 18:20:56.717165+00	2023-11-01 17:48:38.790554+00	01/11/2023_Contrato de Compraventa_CLADDING AND FLOORS SL		documents/e6552b540175f4a4821b34d0bea7b942de1ea12b3555610d173beb7631a2a9bd.pdf	related	3	9	2508c3a9452e373ce4104d6f4900	\N	\N	34	operation	https://polygonscan.com/tx/0xb093cfa08e443876bb2401751e59e95c5421a28028a898efcf343a0e87fa01c9	0xb093cfa08e443876bb2401751e59e95c5421a28028a898efcf343a0e87fa01c9	\N	2508c3a9452e373ce4104d6f4900
52	2023-11-01 20:49:31.017499+00	2023-11-01 20:49:30.815006+00	01/11/2023_Contrato de Compraventa_CLADDING AND FLOORS SL		documents/d4ac4ad794430385ffdfbffa1d14ab6f0b8ad72ccbdf1ae929cb753b264c243a.pdf	related	3	9	c6461499a4c843e741307e1ac28c	\N	\N	36	operation	\N	\N	\N	\N
53	2023-11-02 09:46:39.811748+00	2023-11-02 09:46:39.699078+00	02/11/2023_Contrato de Compraventa_CLADDING AND FLOORS SL		documents/105cc80c95f798aac3ec057d75e7a443c0ebad2cea2829eb51b1c19ada82ed80.pdf	related	3	9	81821abb609d4759cfbc4bbe0c5e	\N	\N	37	operation	https://polygonscan.com/tx/0x258c40283a9994caea0096e29b1f0ae51ea00c98710fafb875d0b9cc8eb11842	0x258c40283a9994caea0096e29b1f0ae51ea00c98710fafb875d0b9cc8eb11842	\N	81821abb609d4759cfbc4bbe0c5e
70	2023-11-04 00:46:30.561256+00	2023-11-04 00:46:30.395692+00	04/11/2023_Contrato de Compraventa_CLADDING AND FLOORS SL		documents/12a0008bdaa5af4fa8a3a44ca01349d72eb275ee719b11c2a3bca8a19a7533f7.pdf	related	3	9	983b576555e4fb3e72e3af2fa7f0	\N	\N	57	operation	https://polygonscan.com/tx/0x6c729be4eb4b0c1347e29ef5d5e52d367ebef39311818e50d55f65d9fb9897dd	0x6c729be4eb4b0c1347e29ef5d5e52d367ebef39311818e50d55f65d9fb9897dd	\N	983b576555e4fb3e72e3af2fa7f0
62	2023-11-02 09:57:44.965984+00	2023-11-02 09:57:44.602081+00	02/11/2023_Contrato de Compraventa_Block Impulse SL		documents/5107f2faccb95e842dbe389789b9bc34b6f045f454f197df21c6b17672e9f59f.pdf	related	4	23	e8ec7a6654f082f1d7541972d085	\N	\N	46	operation	https://polygonscan.com/tx/0x8a63e979edd5e76a05c2cb7b6df18f857951c2ee802414beda5e174821b6fc18	0x8a63e979edd5e76a05c2cb7b6df18f857951c2ee802414beda5e174821b6fc18	\N	e8ec7a6654f082f1d7541972d085
63	2023-11-02 10:03:34.764567+00	2023-11-02 09:57:44.602081+00	02/11/2023_Contrato de Compraventa_CLADDING AND FLOORS SL		documents/4eea383b87bc927a6b098c6e9a5d692059e6ffb4d430ac2b9bc4144be5811e13.pdf	related	3	9	e95f6a65c7f7ee6ac3370ce4f386	\N	\N	47	operation	https://polygonscan.com/tx/0xeb6335714cfea8378ca4915289e05f6871267241a25ce092c190bf7af4d3361b	0xeb6335714cfea8378ca4915289e05f6871267241a25ce092c190bf7af4d3361b	\N	e95f6a65c7f7ee6ac3370ce4f386
71	2023-11-04 01:12:33.106572+00	2023-11-04 01:12:32.983783+00	04/11/2023_Contrato de Compraventa_CLADDING AND FLOORS SL		documents/469d75982a5e3493be4bd637c36d90c8be6743229387718b37b40a128846d33f.pdf	related	3	9	3ee1f977df16c3005d2f6020ee3d	\N	\N	58	operation	https://polygonscan.com/tx/0xafca9340b47aedc25cea141090cdfcea0c680767af114e5e741e8340469e0d86	0xafca9340b47aedc25cea141090cdfcea0c680767af114e5e741e8340469e0d86	\N	3ee1f977df16c3005d2f6020ee3d
66	2023-11-02 21:24:27.968799+00	2023-11-02 21:24:27.633271+00	02/11/2023_Contrato de Compraventa_CLADDING AND FLOORS SL		documents/925b355b9fb420ff4a997161a9dbdd0fdf6d20105802cdf2f93ac3c233fad458.pdf	related	3	9	b8ede68ff872f4a7319df47a088c	\N	\N	53	operation	\N	\N	\N	\N
67	2023-11-02 21:25:31.476675+00	2023-11-02 21:24:27.633271+00	02/11/2023_Contrato de Compraventa_CLADDING AND FLOORS SL		documents/96135c4f501dfd7f769c07b591aaec5d3d0d0ff07614ab7719e2ac1d09deb46b.pdf	related	3	9	f12d3e6d870354ed0f5fa268d0e0	\N	\N	54	operation	\N	\N	\N	\N
72	2023-11-04 01:21:54.066021+00	2023-11-04 01:21:53.952352+00	04/11/2023_Contrato de Compraventa_CLADDING AND FLOORS SL		documents/778be54416d02b754177e440d78d3e9fc4f405ad923b080ba90aa51b6970f8e0.pdf	related	3	9	cc363e0a24910af33909dccd443c	\N	\N	59	operation	https://polygonscan.com/tx/0x393d344ea71663bfea02f4e5904ca25f65c817fb28a2f259e318dda3530facf6	0x393d344ea71663bfea02f4e5904ca25f65c817fb28a2f259e318dda3530facf6	\N	cc363e0a24910af33909dccd443c
73	2023-11-04 01:38:11.959523+00	2023-11-04 01:38:11.879045+00	04/11/2023_Contrato de Compraventa_CLADDING AND FLOORS SL		documents/b848788747f8d683eea3614986715739d21cccd245bfd5265ee8fde0be2e6d5a.pdf	related	3	9	436d3b4f2a1b1b1f55615c47c4b5	\N	\N	60	operation	https://polygonscan.com/tx/0x47e5cdae11f479c68a3d46f0d4643c0ea7580b980e00e4e86816279143fe15c1	0x47e5cdae11f479c68a3d46f0d4643c0ea7580b980e00e4e86816279143fe15c1	\N	436d3b4f2a1b1b1f55615c47c4b5
74	2023-11-04 01:42:09.15199+00	2023-11-04 01:42:09.039041+00	04/11/2023_Contrato de Compraventa_CLADDING AND FLOORS SL		documents/051888235cf2e2b57c83224a96a22741d4cf0079b6a3ab8a5454b8d1c44a3dc4.pdf	related	3	9	0fcb5d405e62dcb7e991cc3ac7d2	\N	\N	61	operation	https://polygonscan.com/tx/0xa70c668812e8abc7e299900aa422a9e2e50a34f4f86ac174fa60f7eeeb31699c	0xa70c668812e8abc7e299900aa422a9e2e50a34f4f86ac174fa60f7eeeb31699c	\N	0fcb5d405e62dcb7e991cc3ac7d2
75	2023-11-04 01:46:56.265982+00	2023-11-04 01:46:56.173176+00	04/11/2023_Contrato de Compraventa_CLADDING AND FLOORS SL		documents/d21def20dd7dc0c69b6f2204a4cff33554076c3bb5f94f097e4372dc3588a434.pdf	related	3	9	69232a6af4b76d4147e92e502d6b	\N	\N	62	operation	https://polygonscan.com/tx/0xf26adef65d9fa806fbaa6bb357851c038b7e186249cf1649dc0522842f831cd2	0xf26adef65d9fa806fbaa6bb357851c038b7e186249cf1649dc0522842f831cd2	\N	69232a6af4b76d4147e92e502d6b
77	2023-11-04 02:03:38.976157+00	2023-11-04 02:03:38.757443+00	04/11/2023_Contrato de Compraventa_CLADDING AND FLOORS SL		documents/ab177770ba7c653e59d97a5d2b1975e53498486c99b17099fb257bcc80ec458c.pdf	related	3	9	2288ec40379f401df42e526ca0d6	\N	\N	64	operation	\N	\N	\N	\N
78	2023-11-04 02:05:18.042734+00	2023-11-04 02:03:38.757443+00	04/11/2023_Contrato de Compraventa_CLADDING AND FLOORS SL		documents/aeb4093cd1b0ed6af5035d6c2611c90110aa8826fce8e540bef02085337ea27a.pdf	related	3	9	33739b8b72c6ea9e3be90337114c	\N	\N	65	operation	https://polygonscan.com/tx/0xa450a408043a302bf95b698e17b474f85869601ba379fa7ea4dd9f2635f01fba	0xa450a408043a302bf95b698e17b474f85869601ba379fa7ea4dd9f2635f01fba	\N	33739b8b72c6ea9e3be90337114c
79	2023-11-04 02:13:06.557667+00	2023-11-04 02:13:06.432121+00	04/11/2023_Contrato de Compraventa_CLADDING AND FLOORS SL		documents/0e79b5a0abd93280c01798841700d660160cfc37de94e17b11500c400611068f.pdf	related	3	9	99f36a43b67929b5da7deaea52cd	\N	\N	66	operation	https://polygonscan.com/tx/0xa69dcb9b64c646c7e59f039b2734be391be3b0aa47f0eef6684549be9807dcf4	0xa69dcb9b64c646c7e59f039b2734be391be3b0aa47f0eef6684549be9807dcf4	\N	99f36a43b67929b5da7deaea52cd
81	2023-11-04 02:32:52.751112+00	2023-11-04 02:32:52.655589+00	04/11/2023_Contrato de Compraventa_CLADDING AND FLOORS SL		documents/28eaffb6a2f02a2fd3519bbd4f82d59cdac3585ff1254ec1263d09e8b8d05f5e.pdf	related	3	9	02fc0b1af748f103146fe91c8503	\N	\N	68	operation	\N	\N	\N	\N
82	2023-11-04 02:39:29.710504+00	2023-11-04 02:32:52.655589+00	04/11/2023_Contrato de Compraventa_CLADDING AND FLOORS SL		documents/2e30f715ba6783dc3001c72fc4b597db8ce6d94b03cc03caebb7b00f693548f7.pdf	related	3	9	99f86346cc808024e6dd3c68cf02	\N	\N	69	operation	https://polygonscan.com/tx/0x3792c461be963ec33b44b942e958d5ba9e6b3db2ad5d617e88656a7ab84fb762	0x3792c461be963ec33b44b942e958d5ba9e6b3db2ad5d617e88656a7ab84fb762	\N	99f86346cc808024e6dd3c68cf02
84	2023-11-04 23:22:09.04951+00	2023-11-04 23:22:08.941062+00	04/11/2023_Contrato de Compraventa_CLADDING AND FLOORS SL		documents/facb530671e9cb3422a0a72a361f226bc041114845c0fff122ef1930b9002a9e.pdf	related	3	9	d511045eaa621cd9bb09ae7c17ba	\N	\N	72	operation	https://polygonscan.com/tx/0x506e0f38bc9aa255dcc8adafa0de77d5a178181e830603277448c5b834dce030	0x506e0f38bc9aa255dcc8adafa0de77d5a178181e830603277448c5b834dce030	\N	d511045eaa621cd9bb09ae7c17ba
87	2023-11-05 00:16:54.824923+00	2023-11-05 00:16:54.484715+00	05/11/2023_Contrato de Compraventa_CLADDING AND FLOORS SL		documents/e91af28b4cf1761916896e92cc38745640481b7f347b5961e2be1e1b1945d06e.pdf	related	3	9	a585d6323e9a8267084425b18dfd	\N	\N	75	operation	https://polygonscan.com/tx/0x1f32d204e854182fa686c17f62bcf27100ebaa2da744971c664e919a6947b8b5	0x1f32d204e854182fa686c17f62bcf27100ebaa2da744971c664e919a6947b8b5	\N	a585d6323e9a8267084425b18dfd
88	2023-11-05 00:19:25.882607+00	2023-11-05 00:16:54.484715+00	05/11/2023_Contrato de Compraventa_CLADDING AND FLOORS SL		documents/64e2316c3c2f1751089c0f1b31ee03dff9387253d62203a721463ed91e689de3.pdf	related	3	9	4aedc3984e5e69304291cc0bc090	\N	\N	76	operation	https://polygonscan.com/tx/0xc02ce344a758f58952574e95ae4dffed7fef8dc6a110123702879d9e649066e0	0xc02ce344a758f58952574e95ae4dffed7fef8dc6a110123702879d9e649066e0	\N	4aedc3984e5e69304291cc0bc090
89	2023-11-08 15:55:34.206507+00	2023-11-08 15:55:34.087265+00	08/11/2023_Contrato de Compraventa_CLADDING AND FLOORS SL		documents/72b88619d6775370b5a497122805693fede9f4470e2cc8f3f186f058cc22634b.pdf	related	3	9	e15aeba72a6faf55c4d8c4a25e05	\N	\N	77	operation	https://polygonscan.com/tx/0x0cff752ec38f183f5879a898f850514a52bc72dadd1a5a6648aaf99b111e8215	0x0cff752ec38f183f5879a898f850514a52bc72dadd1a5a6648aaf99b111e8215	\N	e15aeba72a6faf55c4d8c4a25e05
90	2023-11-09 16:47:00.165748+00	2023-11-09 16:46:59.747877+00	09/11/2023_Contrato de Compraventa_CLADDING AND FLOORS SL		documents/0831308e41ed4abb145acc1b254ec019eae472435a19266a1e1dd55094819007.pdf	related	3	9	7cc417cadee028bec1bf434caebd	\N	\N	78	operation	https://polygonscan.com/tx/0x4e151eba61061bfd6ce43d4a2f6336dd287334a618f5bf3bf13ce9899d6cc6c2	0x4e151eba61061bfd6ce43d4a2f6336dd287334a618f5bf3bf13ce9899d6cc6c2	\N	7cc417cadee028bec1bf434caebd
91	2023-11-09 17:33:16.795+00	2023-11-09 16:46:59.747877+00	09/11/2023_Contrato de Compraventa_Big Election SL		documents/85f058f06e3b3af7e1ad9a06a966a0d80b536b90187cacca7754913377ac17d9.pdf	related	5	12	8d3578cc8f806c68964b6b458657	\N	\N	84	operation	https://polygonscan.com/tx/0x911c2cdeba4f1b3feef5c276e0e73942fdc118ca176e27e95f1243aa5e07f640	0x911c2cdeba4f1b3feef5c276e0e73942fdc118ca176e27e95f1243aa5e07f640	\N	8d3578cc8f806c68964b6b458657
92	2023-11-09 19:26:03.080686+00	2023-11-09 16:46:59.747877+00	09/11/2023_Contrato de Compraventa_Big Election SL		documents/68a7f7b75b58a0931a5b7bb24e5b89cfcaa36bf73c0a39a1980380bd4c9baa6b.pdf	related	5	12	952615a91f17eab52a8bf84f2749	\N	\N	86	operation	https://polygonscan.com/tx/0x5d4957288d2b3a710c29d56e7c239e3d453a5de6e3aba97d1fe605aba8f77929	0x5d4957288d2b3a710c29d56e7c239e3d453a5de6e3aba97d1fe605aba8f77929	\N	952615a91f17eab52a8bf84f2749
93	2023-11-09 19:32:38.419975+00	2023-11-09 16:46:59.747877+00	09/11/2023_Contrato de Compraventa_Big Election SL		documents/c19bea3bcbad8c2ea6d223615b79ce678a3fe1c95c6ea18a68b7075f9e517c70.pdf	related	5	12	3744c493df23f72168feca8409e6	\N	\N	87	operation	https://polygonscan.com/tx/0x5b9eaa7e9ef936fb27927792dea6536bde0bb4525520723da0399a68fc5dc9c7	0x5b9eaa7e9ef936fb27927792dea6536bde0bb4525520723da0399a68fc5dc9c7	\N	3744c493df23f72168feca8409e6
98	2023-11-09 20:51:55.998144+00	2023-11-09 20:46:29.255108+00	09/11/2023_Contrato de Compraventa_Big Election SL		documents/41c48eec8a452a5e8367461721c973ee37ee8ae11541cdc02e0b22580b74e651.pdf	related	5	12	f74e74edf31060f0441437762d1f	\N	\N	92	operation	https://polygonscan.com/tx/0xa8d3b521a76d79c2c50bf5289d86cbb055f2f847a86dcece339797d94e516d9a	0xa8d3b521a76d79c2c50bf5289d86cbb055f2f847a86dcece339797d94e516d9a	\N	f74e74edf31060f0441437762d1f
99	2023-11-10 17:31:53.631858+00	2023-11-10 17:31:53.505014+00	10/11/2023_Contrato de Compraventa_CLADDING AND FLOORS SL		documents/8e7faebf274879d7baa7f7fbd42cda62008400c33c8b3f78528b69b32cf0213d.pdf	related	3	9	2319daa23a0d2d84b6f5c7311dd0	\N	\N	93	operation	https://polygonscan.com/tx/0xc4811fb23e42e0c0e407a937f8f7f4c9e38d604a2c4430077a7af4af15b0b99e	0xc4811fb23e42e0c0e407a937f8f7f4c9e38d604a2c4430077a7af4af15b0b99e	\N	2319daa23a0d2d84b6f5c7311dd0
95	2023-11-09 19:41:26.686028+00	2023-11-09 19:33:39.80732+00	09/11/2023_Contrato de Compraventa_Big Election SL		documents/adb346dcd73fc53ff996afc57c566f202c99ccdf041591435983b81f5ac49e05.pdf	related	5	12	f19f67de993d1fa2777ab542f9b4	\N	\N	89	operation	https://polygonscan.com/tx/0x8b48da083aa0c61752e7c2ffc25099d38988730e0ecd6cf8026678f06424e6ab	0x8b48da083aa0c61752e7c2ffc25099d38988730e0ecd6cf8026678f06424e6ab	\N	f19f67de993d1fa2777ab542f9b4
103	2023-11-10 18:10:10.00213+00	2023-11-10 18:02:22.26492+00	10/11/2023_Contrato de Compraventa_CLADDING AND FLOORS SL		documents/4a7f0d81f4ba76888f451ece69d1d5e70ce8435d15d50258c499a3792ed94ca4.pdf	related	3	9	c35b380b14e5ce84d28d94d9df74	\N	\N	100	operation	https://polygonscan.com/tx/0xb2bbf9d76cea6d6870bcfc16200d22ea94b54c110ab8986c1bbd5f994ef26462	0xb2bbf9d76cea6d6870bcfc16200d22ea94b54c110ab8986c1bbd5f994ef26462	\N	c35b380b14e5ce84d28d94d9df74
102	2023-11-10 18:02:22.637826+00	2023-11-10 18:02:22.26492+00	10/11/2023_Contrato de Compraventa_White Bear Trading SL		documents/29e6740288d9dffe11701036f7242d15832581614a42177a2269ca1965c0fcb1.pdf	related	1	10	7cb262e95f13a91f13452ed0b51a	\N	\N	\N	operation	https://polygonscan.com/tx/0x88462394d03b411d588053e084f5b71696cb38b0fc2e4540518a839d007a74c5	0x88462394d03b411d588053e084f5b71696cb38b0fc2e4540518a839d007a74c5	\N	7cb262e95f13a91f13452ed0b51a
104	2023-11-10 18:18:39.494097+00	2023-11-10 18:02:22.26492+00	10/11/2023_Contrato de Compraventa_White Bear Trading SL		documents/fdc4108cde87b7a375444e5f1974e67839c4072476ba940236808034b55f427a.pdf	related	1	10	ea958070360ec3ef876e1d9c7b5e	\N	\N	\N	operation	https://polygonscan.com/tx/0xedd5658069522b58a7fbe5c938776e40f44501cb3296043598175dca54ba5e55	0xedd5658069522b58a7fbe5c938776e40f44501cb3296043598175dca54ba5e55	\N	ea958070360ec3ef876e1d9c7b5e
105	2023-11-11 09:27:18.241134+00	2023-11-11 09:27:18.107532+00	11/11/2023_Contrato de Compraventa_White Bear Trading SL		documents/457e323f0854f3e7fbf27c4bb2af1a9522183b5549ae94c928a04f53f13647ff.pdf	related	1	10	586ea885d75e6b7b2b6e004631e5	\N	\N	\N	operation	https://polygonscan.com/tx/0xd853190541bc1124e950d4600bda7f8d6bd0a58823f69ce6ddfd52c6319441d6	0xd853190541bc1124e950d4600bda7f8d6bd0a58823f69ce6ddfd52c6319441d6	\N	586ea885d75e6b7b2b6e004631e5
106	2023-11-11 10:23:32.262572+00	2023-11-11 10:23:32.157346+00	11/11/2023_Contrato de Compraventa_White Bear Trading SL		documents/fa0a4f211c8299f253189058801bbd2c655d27e41d82a88c6b7504d2797ab56e.pdf	related	1	10	21118885d113e8a7c1bfefd4479b	\N	\N	\N	operation	https://polygonscan.com/tx/0xc0a53d348271cf0e14614ac2e3d4d40ea2bf6aeedf1914767e44087de95a0f44	0xc0a53d348271cf0e14614ac2e3d4d40ea2bf6aeedf1914767e44087de95a0f44	\N	21118885d113e8a7c1bfefd4479b
107	2023-11-11 10:29:16.232558+00	2023-11-11 10:23:32.157346+00	11/11/2023_Contrato de Compraventa_CLADDING AND FLOORS SL		documents/0fdc8356c4da425228b25aa4808b1c4b2e772fc036f224efd805443adc0e22fe.pdf	related	3	9	2c561e8d8a9ed455e51ad9b04040	\N	\N	104	operation	https://polygonscan.com/tx/0x37c9c0bc50c5b021e4a539a2bb177add7789c0ea95644a860471482579a53ac8	0x37c9c0bc50c5b021e4a539a2bb177add7789c0ea95644a860471482579a53ac8	\N	2c561e8d8a9ed455e51ad9b04040
108	2023-11-11 10:31:25.699904+00	2023-11-11 10:23:32.157346+00	11/11/2023_Contrato de Compraventa_White Bear Trading SL		documents/468491f134a743e458494758a26c1417f4039a75c155db40b699cc975db8a905.pdf	related	1	10	9f7d6f8eec66b6294d4ebcfe7741	\N	\N	\N	operation	https://polygonscan.com/tx/0x956d44731531839d85343ef1e335b44af0da78606aaf6d101ad6dc859e18f1bf	0x956d44731531839d85343ef1e335b44af0da78606aaf6d101ad6dc859e18f1bf	\N	9f7d6f8eec66b6294d4ebcfe7741
110	2023-11-12 00:02:30.417062+00	2023-11-12 00:02:30.322264+00	12/11/2023_Contrato de Compraventa_White Bear Trading SL		documents/aa6b1997668a5999831c68bbc36df9ad47271563b4433cdc2820e132b1a82015.pdf	related	1	10	9d63cd79abb0fc45d4797ff86134	\N	\N	\N	operation	https://polygonscan.com/tx/0x2ff06d4280fa1e5d5a1b72ff5e550c1a93259725b8e197419ed693d7b0b0c2bf	0x2ff06d4280fa1e5d5a1b72ff5e550c1a93259725b8e197419ed693d7b0b0c2bf	\N	9d63cd79abb0fc45d4797ff86134
112	2023-11-12 00:28:04.584065+00	2023-11-12 00:28:04.428295+00	12/11/2023_Contrato de Compraventa_White Bear Trading SL		documents/97fe649bc573b53a5878c56c5ce68e0d9451711cb0c43db3ee01ecac8856d9b5.pdf	related	1	10	fdc02caf42ec7236ac1406c2f85a	\N	\N	\N	operation	https://polygonscan.com/tx/0xc1179c69bcd5c4a9255253c7be6bda42e0dc208e374aa25bdcbe10220f071f45	0xc1179c69bcd5c4a9255253c7be6bda42e0dc208e374aa25bdcbe10220f071f45	\N	fdc02caf42ec7236ac1406c2f85a
114	2023-11-13 21:41:10.483973+00	2023-11-13 21:41:10.347986+00	13/11/2023_Contrato de Compraventa_White Bear Trading SL		documents/3629b06c66590181f3d5bf5e03c8bb873d3306088da36b35b1c29029aa9b8495.pdf	related	1	10	9375827788cef7fb21340f3cfe28	\N	\N	\N	operation	https://polygonscan.com/tx/0x9b43700893d67d047b8462698f1c4b4f8a2f05f05d0ad208e487b4a6d25de3de	0x9b43700893d67d047b8462698f1c4b4f8a2f05f05d0ad208e487b4a6d25de3de	\N	9375827788cef7fb21340f3cfe28
115	2023-11-14 22:26:54.784341+00	2023-11-14 22:26:54.682738+00	14/11/2023_Contrato de Compraventa_White Bear Trading SL		documents/870a17ecc688c36bf91a21f759ccd0318b4a874ac63e8053fd7a48d40df9edf9.pdf	related	1	10	2467873d03c5c49b5641e5504383	\N	\N	113	operation	https://polygonscan.com/tx/0x2da0360371e080e26f6bd747ce1a76243824e9badcea26773a2c32eb030272b6	0x2da0360371e080e26f6bd747ce1a76243824e9badcea26773a2c32eb030272b6	\N	2467873d03c5c49b5641e5504383
116	2023-11-17 16:07:26.499328+00	2023-11-17 16:07:26.3789+00	17/11/2023_Contrato de Compraventa_White Bear Trading SL		documents/16b2364643b3aff8065280a15d9d7a287340f239d0a6df769bc837ab0fa03a8e.pdf	related	1	10	7ee5e9fb7e291ac5f3d769908512	\N	\N	114	operation	https://polygonscan.com/tx/0x695eb0c2298cab52c74a7c3828cf4a4aaadb9eb47c00db80a6c72e57d6535d92	0x695eb0c2298cab52c74a7c3828cf4a4aaadb9eb47c00db80a6c72e57d6535d92	\N	7ee5e9fb7e291ac5f3d769908512
117	2023-11-17 17:05:16.805543+00	2023-11-17 17:05:16.708927+00	17/11/2023_Contrato de Compraventa_White Bear Trading SL		documents/fb3e42cf2664178272711d50a5fd45e65ea91695239aba4547a39299fbca1081.pdf	related	1	10	44f966afff6defca5065e53094e0	\N	\N	115	operation	https://polygonscan.com/tx/0xd2e747785751c4c5e34c4e82232bc083a9a81307d22b7581ee5960b6eb3ec0cd	0xd2e747785751c4c5e34c4e82232bc083a9a81307d22b7581ee5960b6eb3ec0cd	\N	44f966afff6defca5065e53094e0
\.


--
-- Data for Name: documents_document_related_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.documents_document_related_users (id, document_id, user_id) FROM stdin;
16	37	196
17	37	28
20	38	82
21	38	23
24	42	82
25	42	28
28	44	82
29	44	28
36	47	82
37	47	28
40	48	324
41	48	28
44	49	324
45	49	196
48	50	324
49	50	196
54	52	196
55	52	28
58	53	324
59	53	28
72	62	82
73	62	28
76	63	196
77	63	28
84	66	324
85	66	82
88	67	324
89	67	82
94	70	324
95	70	82
98	71	324
99	71	82
102	72	324
103	72	82
106	73	324
107	73	82
110	74	324
111	74	82
114	75	324
115	75	82
118	77	324
119	77	82
122	78	324
123	78	82
126	79	324
127	79	82
132	81	324
133	81	82
136	82	324
137	82	82
140	84	324
141	84	82
146	87	324
147	87	196
150	88	324
151	88	196
154	89	196
155	89	28
158	90	324
159	90	82
162	91	82
163	91	196
166	92	28
167	92	196
170	93	28
171	93	196
176	95	28
177	95	196
182	97	196
183	97	324
186	98	28
187	98	324
190	99	324
191	99	196
196	102	324
197	102	196
200	103	196
201	103	324
204	104	324
205	104	196
208	105	324
209	105	196
212	106	324
213	106	196
216	107	196
217	107	324
220	108	324
221	108	196
226	110	324
227	110	196
232	112	324
233	112	196
236	114	324
237	114	196
240	115	324
241	115	196
244	116	324
245	116	9
248	117	324
249	117	9
\.


--
-- Data for Name: documents_historydocument; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.documents_historydocument (id, created, modified, transaction_hash, creator_id, document_id, blockchain_link, blockchain_transaction_id, cod) FROM stdin;
\.


--
-- Data for Name: documents_useractiondetail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.documents_useractiondetail (id, action, "timestamp", details, company_id, session_id) FROM stdin;
\.


--
-- Data for Name: documents_usersessionlog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.documents_usersessionlog (id, start_time, end_time, user_id) FROM stdin;
\.


--
-- Data for Name: mangopay_basemangopaytransaction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mangopay_basemangopaytransaction (id, created, modified, transaction_id, status, amount, currency, fees, cod) FROM stdin;
32	2023-06-14 19:56:20.256272+00	2023-06-15 07:58:55.036201+00	3727273748	SUCCEEDED	500.00	EUR	0.00	
22	2023-06-07 10:09:28.409304+00	2023-09-03 18:31:47.236307+00	3695904573	SUCCEEDED	700.00	EUR	0.00	pf_90
20	2023-06-06 20:50:00.290281+00	2023-09-03 18:32:26.218689+00	3694545845	FAILED	100.00	EUR	0.00	pj_4
78	2023-09-08 09:29:31.757932+00	2023-10-08 10:10:19.021758+00	4034550451	FAILED	10.00	EUR	0.00	pj_24
18	2023-06-05 09:44:18.194716+00	2023-09-03 18:33:02.243205+00	3687129218	FAILED	100.00	EUR	0.00	pf_23
17	2023-06-01 12:08:21.560042+00	2023-09-03 18:33:38.470345+00	3671642200	FAILED	300.00	EUR	0.00	pf_90
8	2023-05-04 06:07:22.671852+00	2023-05-04 06:07:22.671852+00	3561261884	SUCCEEDED	150.00		0.00	
15	2023-05-29 09:01:20.776772+00	2023-09-03 18:34:57.254491+00	3658667611	FAILED	100.00	EUR	0.00	pf_23
14	2023-05-29 09:01:00.056749+00	2023-09-03 18:35:12.687288+00	3658666204	FAILED	100.00	EUR	0.00	pf_23
89	2023-09-15 15:50:28.492821+00	2023-10-15 16:10:06.987393+00	4065045106	FAILED	1.00	EUR	0.00	pj_4
12	2023-05-18 13:19:49.029039+00	2023-09-03 18:35:17.160993+00	3618234861	FAILED	1000.00	EUR	0.00	pf_23
90	2023-09-15 22:11:17.258828+00	2023-10-15 22:40:06.499245+00	4066608414	FAILED	100.00	EUR	0.00	pj_4
105	2023-09-18 13:30:09.325714+00	2023-10-18 13:40:09.21526+00	4076454017	FAILED	3.00	EUR	0.00	pf_23
11	2023-05-18 13:19:45.679107+00	2023-09-03 18:35:20.863888+00	3618234816	FAILED	1000.00	EUR	0.00	pf_23
3	2022-09-30 07:55:45.770373+00	2023-09-03 18:35:25.316845+00	2814547054	SUCCEEDED	100.00	EUR	0.00	pf_23
10	2023-05-09 12:53:22.289118+00	2023-09-03 18:36:45.537882+00	3581888333	FAILED	100.00	EUR	0.00	pj_13
5	2022-12-06 09:35:29.348537+00	2023-09-03 18:37:38.194402+00	3061152824	SUCCEEDED	20.00	EUR	0.00	pf_28
2	2022-09-29 16:26:59.594444+00	2023-09-03 18:38:51.928569+00	2812352023	FAILED	10.00	EUR	0.00	pj_4
1	2022-09-29 16:26:57.029373+00	2023-09-03 18:39:27.406065+00	2812351766	FAILED	10.00	EUR	0.00	pj_4
70	2023-07-05 17:27:05.450454+00	2023-09-06 08:53:06.92011+00	3804350858	SUCCEEDED	1.00	EUR	0.03	pf_28
69	2023-07-05 17:23:01.990216+00	2023-09-06 08:54:16.663614+00	3804333501	SUCCEEDED	1.00	EUR	0.03	pf_28
39	2023-06-20 18:37:00.317835+00	2023-07-20 18:40:06.101586+00	3749999984	FAILED	500.00	EUR	0.00	
79	2023-09-08 10:48:24.370154+00	2023-09-08 11:04:15.126532+00	4034891846	FAILED	100.00	EUR	0.00	pf_79
80	2023-09-11 11:47:14.360532+00	2023-09-11 11:47:14.360532+00	4046325734	FAILED	2.00	EUR	0.00	
81	2023-09-12 07:23:54.614928+00	2023-09-12 07:23:54.614928+00	4049457443	FAILED	2.00	EUR	0.00	
82	2023-09-12 07:39:32.731782+00	2023-09-12 07:39:32.731782+00	4049500474	FAILED	2.00	EUR	0.00	
45	2023-06-22 10:28:57.690285+00	2023-06-22 10:28:57.690285+00	3755685221	SUCCEEDED	200.00		0.00	
66	2023-07-04 09:50:15.398886+00	2023-09-03 16:38:16.471176+00	3798585636	FAILED	200.00	EUR	0.00	pj_4
65	2023-07-04 09:49:38.026045+00	2023-09-03 16:38:54.681126+00	3798583378	FAILED	200.00	EUR	0.00	pj_4
64	2023-07-04 09:49:37.859447+00	2023-09-03 16:39:33.500185+00	3798583367	FAILED	200.00	EUR	0.00	pj_4
63	2023-07-04 09:49:34.987259+00	2023-09-03 16:40:20.751808+00	3798583347	FAILED	200.00	EUR	0.00	pj_4
62	2023-07-04 05:57:30.715424+00	2023-09-03 16:41:47.568384+00	3797937823	FAILED	100.00	EUR	0.00	pj_4
60	2023-06-29 21:12:08.900386+00	2023-09-03 16:42:56.643088+00	3783366787	SUCCEEDED	415.00	EUR	0.00	pf_126
59	2023-06-28 10:50:17.453113+00	2023-09-03 16:43:44.499861+00	3776880835	FAILED	200.00	EUR	0.00	pf_28
55	2023-06-27 14:26:47.188349+00	2023-09-03 16:44:36.493952+00	3773996086	FAILED	101.00	EUR	0.00	pf_133
44	2023-06-22 10:22:36.886471+00	2023-09-03 16:47:48.199767+00	3755670819	SUCCEEDED	200.00	EUR	0.00	pf_135
40	2023-06-21 07:12:52.718463+00	2023-09-03 16:48:41.3218+00	3751197379	FAILED	500.00	EUR	0.00	pf_122
38	2023-06-20 15:33:40.753706+00	2023-09-03 17:02:24.487378+00	3749195043	FAILED	500.00	EUR	0.00	pf_122
37	2023-06-20 06:04:02.340822+00	2023-09-03 17:02:28.608242+00	3747135701	SUCCEEDED	500.00	EUR	0.00	pf_122
35	2023-06-19 06:25:48.538321+00	2023-09-03 17:02:33.104993+00	3742988091	FAILED	500.00	EUR	0.00	pf_122
31	2023-06-14 19:54:33.146387+00	2023-09-03 17:04:08.025353+00	3727264994	FAILED	500.00	EUR	0.00	pf_120
30	2023-06-14 17:43:36.807022+00	2023-09-03 17:04:11.933997+00	3726645905	FAILED	500.00	EUR	0.00	pf_120
29	2023-06-14 17:43:33.993959+00	2023-09-03 17:04:16.399423+00	3726645888	FAILED	500.00	EUR	0.00	pf_120
28	2023-06-14 13:55:28.711313+00	2023-09-03 17:05:23.741734+00	3725495983	FAILED	1000.00	EUR	0.00	pj_4
21	2023-06-06 20:50:16.253837+00	2023-09-03 17:12:20.622693+00	3694546944	FAILED	100.00	EUR	0.00	pj_4
19	2023-06-05 09:44:37.166925+00	2023-09-03 17:13:22.957416+00	3687130392	FAILED	1000.00	EUR	0.00	pf_23
16	2023-05-29 09:02:23.865204+00	2023-09-03 17:13:42.600595+00	3658674151	FAILED	100.00	EUR	0.00	pf_23
13	2023-05-18 13:20:10.870662+00	2023-09-03 17:14:01.515086+00	3618236339	FAILED	10000.00	EUR	0.00	pf_23
26	2023-06-12 08:33:30.52555+00	2023-09-03 17:14:19.235508+00	3715860116	FAILED	1.00	EUR	0.00	pf_23
9	2023-05-09 12:53:01.350543+00	2023-09-03 17:15:07.01295+00	3581887072	FAILED	2000.00	EUR	0.00	pj_13
7	2023-02-15 10:47:18.343543+00	2023-09-03 17:15:45.315832+00	3285379854	FAILED	20.00	EUR	0.00	pf_28
6	2023-02-15 10:46:08.658379+00	2023-09-03 17:16:10.79186+00	3285374371	FAILED	100.00	EUR	0.00	pf_28
4	2022-09-30 08:02:18.647561+00	2023-09-03 17:16:52.187195+00	2814567354	SUCCEEDED	50.00	EUR	0.00	pf_23
77	2023-08-18 16:45:21.688331+00	2023-09-03 17:20:37.173092+00	3955296029	SUCCEEDED	3.00	EUR	0.00	pf_133
76	2023-08-04 20:24:14.374938+00	2023-09-03 17:22:14.927326+00	3907626695	SUCCEEDED	100.00	EUR	0.00	pf_191
75	2023-08-02 16:13:22.816163+00	2023-09-03 17:22:47.824309+00	3898660624	SUCCEEDED	500.00	EUR	0.00	pf_125
74	2023-08-02 16:08:34.556544+00	2023-09-03 17:23:55.930067+00	3898639850	FAILED	500.00	EUR	0.00	pf_125
73	2023-07-18 12:01:48.929512+00	2023-09-03 17:24:41.202076+00	3847456527	SUCCEEDED	100.00	EUR	0.00	pf_152
72	2023-07-15 07:22:45.083215+00	2023-09-03 17:25:35.625573+00	3837504970	SUCCEEDED	100.00	EUR	0.00	pf_144
71	2023-07-06 14:49:59.623223+00	2023-09-03 17:26:15.511173+00	3807713965	SUCCEEDED	180.00	EUR	0.00	pf_134
68	2023-07-05 09:00:53.282181+00	2023-09-03 17:26:59.602024+00	3802180269	FAILED	500.00	EUR	0.00	pf_125
67	2023-07-05 08:43:41.851117+00	2023-09-03 17:27:21.227012+00	3802118146	FAILED	500.00	EUR	0.00	pf_125
61	2023-06-30 09:39:25.78845+00	2023-09-03 17:28:50.338042+00	3784457169	SUCCEEDED	100.00	EUR	0.00	pf_134
58	2023-06-28 10:50:01.555882+00	2023-09-03 18:17:23.284056+00	3776879945	FAILED	20.00	EUR	0.00	pf_28
57	2023-06-27 14:48:45.529506+00	2023-09-03 18:18:25.164288+00	3774082526	FAILED	400.00	EUR	0.00	pf_126
56	2023-06-27 14:37:19.881554+00	2023-09-03 18:18:57.235207+00	3774036080	FAILED	400.00	EUR	0.00	pf_126
54	2023-06-27 07:51:27.317186+00	2023-09-03 18:19:56.643009+00	3772614337	FAILED	100.00	EUR	0.00	pf_23
53	2023-06-27 07:50:37.113294+00	2023-09-03 18:20:34.421202+00	3772612047	FAILED	100.00	EUR	0.00	pf_23
52	2023-06-27 07:49:43.180947+00	2023-09-03 18:20:40.48699+00	3772609617	FAILED	100.00	EUR	0.00	pf_23
51	2023-06-26 06:41:36.808373+00	2023-09-03 18:21:24.789017+00	3768783143	SUCCEEDED	100.00	EUR	0.00	pf_136
50	2023-06-26 06:03:48.91791+00	2023-09-03 18:22:02.033213+00	3768720147	SUCCEEDED	20.00	EUR	0.00	pf_82
49	2023-06-26 06:01:21.020552+00	2023-09-03 18:22:38.796723+00	3768716527	FAILED	20.00	EUR	0.00	pf_23
48	2023-06-26 06:01:19.878327+00	2023-09-03 18:23:00.806243+00	3768716508	FAILED	20.00	EUR	0.00	pf_23
47	2023-06-23 21:32:16.947649+00	2023-09-03 18:23:40.848452+00	3762437534	FAILED	300.00	EUR	0.00	pf_126
46	2023-06-23 11:48:06.782226+00	2023-09-03 18:24:28.99088+00	3760142665	SUCCEEDED	20.00	EUR	0.00	pf_134
43	2023-06-22 10:18:56.6202+00	2023-09-03 18:25:17.300492+00	3755662378	FAILED	200.00	EUR	0.00	pf_135
42	2023-06-22 09:29:07.21523+00	2023-09-03 18:26:18.544367+00	3755546546	SUCCEEDED	200.00	EUR	0.00	pf_134
41	2023-06-22 09:26:52.257984+00	2023-09-03 18:26:40.856885+00	3755541322	SUCCEEDED	200.00	EUR	0.00	pf_134
36	2023-06-19 08:15:33.781352+00	2023-09-03 18:27:23.477507+00	3743264295	SUCCEEDED	505.00	EUR	0.00	pf_87
34	2023-06-19 06:25:18.703678+00	2023-09-03 18:28:08.951387+00	3742987178	FAILED	500.00	EUR	0.00	pf_122
33	2023-06-19 06:25:13.722577+00	2023-09-03 18:28:43.458267+00	3742987018	FAILED	500.00	EUR	0.00	pf_122
27	2023-06-12 09:04:02.961576+00	2023-09-03 18:29:25.531913+00	3715971614	SUCCEEDED	500.00	EUR	0.00	pf_89
25	2023-06-12 08:18:03.049225+00	2023-09-03 18:30:10.507329+00	3715802905	FAILED	1.00	EUR	0.00	pf_23
24	2023-06-12 08:16:52.250289+00	2023-09-03 18:30:39.603412+00	3715799016	FAILED	200.00	EUR	0.00	pf_23
23	2023-06-12 07:54:28.45861+00	2023-09-03 18:30:59.562657+00	3715718696	FAILED	100.00	EUR	0.00	pf_23
86	2023-09-15 13:39:45.751266+00	2023-09-15 13:55:17.163158+00	4064331888	FAILED	100.00	EUR	0.00	pf_86
106	2023-09-18 13:42:57.555109+00	2023-09-18 13:58:43.756428+00	4076512526	FAILED	1.00	EUR	0.00	pf_106
91	2023-09-17 22:33:38.275351+00	2023-09-17 22:49:18.283563+00	4074519148	FAILED	100.00	EUR	0.00	pf_91
108	2023-09-18 14:38:53.724335+00	2023-10-18 14:40:09.971832+00	4076760891	FAILED	1.00	EUR	0.00	pf_23
165	2023-10-31 22:25:10.979047+00	2023-10-31 22:25:12.060304+00	4274505680	SUCCEEDED	1.00	EUR	0.03	pf_165
123	2023-10-22 22:32:46.485246+00	2023-10-22 22:32:47.26861+00	4233846803	CREATED	100.00	EUR	0.00	pf_332
266	2023-11-04 02:03:33.102315+00	2023-11-04 02:03:40.620317+00	4289180313	SUCCEEDED	1.00	EUR	0.03	pf_266
326	2023-11-14 22:26:49.349477+00	2023-11-14 22:27:03.907057+00	4343273478	SUCCEEDED	1.00	EUR	0.03	pf_326
239	2023-11-02 21:24:13.262706+00	2023-11-02 21:24:13.262706+00			1.00		0.03	
141	2023-10-24 18:39:18.78446+00	2023-10-24 18:39:20.428248+00	4241951105	CREATED	100.00	EUR	0.00	pf_332
240	2023-11-02 21:24:13.649614+00	2023-11-02 21:24:13.649614+00			1.00	EUR	0.03	
150	2023-10-25 07:51:23.348173+00	2023-10-25 07:51:25.19058+00	4243399491	CREATED	120.00	EUR	0.00	pf_332
177	2023-11-01 09:34:24.073105+00	2023-11-01 09:34:24.073105+00			1.00		0.03	
155	2023-10-27 10:05:41.227459+00	2023-10-27 10:05:42.09432+00	4253875942	CREATED	10.00	EUR	0.00	pf_196
178	2023-11-01 09:34:24.46865+00	2023-11-01 09:34:24.46865+00			1.00	EUR	0.03	
159	2023-10-29 21:30:50.614987+00	2023-10-30 22:30:54.687703+00	4265635652	SUCCEEDED	1.00	EUR	0.03	pf_159
268	2023-11-04 02:12:59.528553+00	2023-11-04 02:23:15.760218+00	4289183337	SUCCEEDED	1.00	EUR	0.03	pf_268
161	2023-10-30 22:35:38.633118+00	2023-10-30 22:35:39.603794+00	4270323032	SUCCEEDED	1.00	EUR	0.03	pf_161
191	2023-11-01 17:48:29.728987+00	2023-11-01 17:48:29.728987+00			1.00		0.03	
163	2023-10-30 23:05:45.776178+00	2023-10-30 23:05:46.788254+00	4270378030	SUCCEEDED	1.00	EUR	0.03	pf_163
192	2023-11-01 17:48:30.18285+00	2023-11-01 17:48:30.18285+00			1.00	EUR	0.03	
157	2023-10-29 20:15:06.671887+00	2023-10-31 05:15:11.419386+00	4265352304	FAILED	1.00	EUR	0.03	pf_157
195	2023-11-01 18:13:27.324894+00	2023-11-01 18:13:27.324894+00			1.00		0.03	
196	2023-11-01 18:13:27.610438+00	2023-11-01 18:13:27.610438+00			1.00	EUR	0.03	
321	2023-11-14 21:54:15.382908+00	2023-11-14 21:54:15.382908+00	4343160617	CREATED	10.00	EUR	0.00	pj_5
203	2023-11-02 09:46:32.061285+00	2023-11-02 09:46:32.061285+00			1.00		0.03	
204	2023-11-02 09:46:32.472832+00	2023-11-02 09:46:32.472832+00			1.00	EUR	0.03	
254	2023-11-03 22:53:58.537889+00	2023-11-03 22:53:59.701156+00	4289006355	SUCCEEDED	1.00	EUR	0.03	pf_254
270	2023-11-04 02:32:43.912593+00	2023-11-04 02:32:55.722561+00	4289189558	SUCCEEDED	1.00	EUR	0.03	pf_270
243	2023-11-02 21:43:42.481409+00	2023-11-02 21:56:04.646939+00	4283849230	FAILED	1.00	EUR	0.03	pf_243
256	2023-11-04 00:07:42.445736+00	2023-11-04 00:07:43.459353+00	4289113747	SUCCEEDED	1.00	EUR	0.03	pf_256
221	2023-11-02 09:57:37.29182+00	2023-11-02 09:57:37.29182+00			1.00		0.03	
222	2023-11-02 09:57:37.65467+00	2023-11-02 09:57:37.65467+00			1.00	EUR	0.03	
227	2023-11-02 20:20:31.310812+00	2023-11-02 20:20:31.995705+00	4283447894	CREATED	100.00	EUR	0.00	pf_332
302	2023-11-10 18:02:10.494023+00	2023-11-10 18:12:27.664196+00	4323087675	FAILED	4.00	EUR	0.12	pf_302
328	2023-11-17 16:07:15.06311+00	2023-11-17 16:17:31.881568+00	4356837776	SUCCEEDED	1.00	EUR	0.03	pf_328
323	2023-11-14 21:58:05.094552+00	2023-11-14 21:58:05.094552+00	4343175523	CREATED	12.00	EUR	0.00	pj_5
260	2023-11-04 01:12:26.90678+00	2023-11-04 01:22:43.385884+00	4289161509	SUCCEEDED	1.00	EUR	0.03	pf_260
310	2023-11-12 00:02:23.102838+00	2023-11-12 00:12:39.102146+00	4329109181	SUCCEEDED	1.00	EUR	0.03	pf_310
304	2023-11-10 18:18:32.432921+00	2023-11-10 18:28:48.304092+00	4323191798	SUCCEEDED	4.00	EUR	0.12	pf_304
278	2023-11-05 00:16:46.529957+00	2023-11-05 00:27:03.228064+00	4293904389	SUCCEEDED	1.00	EUR	0.03	pf_278
286	2023-11-09 16:46:51.887982+00	2023-11-09 16:57:10.083458+00	4316892374	SUCCEEDED	1.00	EUR	0.03	pf_286
262	2023-11-04 01:38:01.472528+00	2023-11-04 01:48:17.49092+00	4289171854	SUCCEEDED	1.00	EUR	0.03	pf_262
264	2023-11-04 01:46:46.818928+00	2023-11-04 01:57:02.950855+00	4289174782	SUCCEEDED	1.00	EUR	0.03	pf_264
317	2023-11-14 20:59:07.868775+00	2023-11-14 20:59:07.868775+00	4342908812	CREATED	5.00	EUR	0.00	
280	2023-11-08 15:55:28.817841+00	2023-11-08 16:06:19.151049+00	4311080003	SUCCEEDED	1.00	EUR	0.03	pf_280
284	2023-11-08 21:54:41.911087+00	2023-11-08 21:54:41.911087+00	4313307569	CREATED	1.00	EUR	0.00	pf_82
245	2023-11-02 21:56:49.89416+00	2023-11-02 21:57:04.691825+00	4283889464	FAILED	1.00	EUR	0.03	pf_245
288	2023-11-09 19:25:56.082676+00	2023-11-09 19:36:11.934588+00	4317950064	SUCCEEDED	1.00	EUR	0.03	pf_288
248	2023-11-02 22:06:17.383294+00	2023-11-02 22:06:18.2874+00	4283920381	SUCCEEDED	1.00	EUR	0.03	pf_248
250	2023-11-02 22:29:36.334854+00	2023-11-02 22:29:37.637788+00	4283988243	SUCCEEDED	1.00	EUR	0.03	pf_250
294	2023-11-09 20:51:38.958392+00	2023-11-09 21:01:54.866388+00	4318476809	SUCCEEDED	4.00	EUR	0.12	pf_294
341	2023-11-20 13:05:46.59903+00	2023-11-20 13:05:46.59903+00	4369635401	CREATED	10.00	EUR	0.00	pf_28
342	2023-11-20 13:06:05.834826+00	2023-11-20 13:06:05.990867+00	4369637162	CREATED	10.00	EUR	0.00	pf_28
306	2023-11-11 10:23:26.546717+00	2023-11-11 10:33:42.525017+00	4325478891	SUCCEEDED	4.00	EUR	0.12	pf_306
308	2023-11-11 10:31:14.328754+00	2023-11-11 10:41:30.128782+00	4325518619	SUCCEEDED	4.00	EUR	0.12	pf_308
319	2023-11-14 21:21:50.709451+00	2023-11-14 21:21:50.709451+00	4343021982	CREATED	3.00	EUR	0.00	pj_5
325	2023-11-14 22:06:12.751428+00	2023-11-14 22:06:12.751428+00	4343205581	CREATED	1.00	EUR	0.00	pj_5
344	2023-11-20 13:55:59.016047+00	2023-11-20 13:55:59.016047+00	4369880421	CREATED	23.00	EUR	0.00	pf_196
101	2023-09-18 12:40:10.179337+00	2023-09-18 12:56:04.077017+00	4076228201	FAILED	1.00	EUR	0.00	pf_101
103	2023-09-18 12:45:02.466282+00	2023-09-18 13:00:48.261597+00	4076248583	FAILED	1.00	EUR	0.00	pf_103
104	2023-09-18 12:45:42.165773+00	2023-09-18 13:01:30.65263+00	4076251943	FAILED	2.00	EUR	0.00	pf_104
96	2023-09-17 22:36:58.683601+00	2023-09-17 22:37:38.660729+00	4074522436	SUCCEEDED	10.00	EUR	0.00	pf_96
241	2023-11-02 21:25:25.30449+00	2023-11-02 21:25:25.30449+00			1.00		0.03	
97	2023-09-17 22:41:43.119677+00	2023-09-17 22:42:19.069876+00	4074526779	SUCCEEDED	10.00	EUR	0.00	pf_97
107	2023-09-18 13:44:15.662106+00	2023-09-18 14:00:06.871459+00	4076518225	FAILED	2.00	EUR	0.00	pf_107
98	2023-09-18 11:14:19.251814+00	2023-09-18 18:08:27.099977+00	4075843096	SUCCEEDED	5.00	EUR	0.00	pf_23
242	2023-11-02 21:25:25.509986+00	2023-11-02 21:25:25.509986+00			1.00	EUR	0.03	
267	2023-11-04 02:05:12.36302+00	2023-11-04 02:15:28.199046+00	4289180835	SUCCEEDED	1.00	EUR	0.03	pf_267
94	2023-09-17 22:34:46.523918+00	2023-10-17 22:40:09.229651+00	4074520183	FAILED	100.00	EUR	0.00	pf_82
99	2023-09-18 11:41:51.920544+00	2023-09-18 12:36:14.458662+00	4075967499	SUCCEEDED	5.00	EUR	0.00	pf_23
102	2023-09-18 12:44:19.736675+00	2023-10-18 13:11:29.536539+00	4076245496	FAILED	1.00	EUR	0.00	pf_23
132	2023-10-23 17:19:57.665409+00	2023-10-23 17:19:58.605426+00	4237102007	CREATED	100.00	EUR	0.00	pf_332
340	2023-11-20 13:05:13.683184+00	2023-11-20 13:05:13.683184+00	4369632164	CREATED	10.00	EUR	0.00	pf_23
244	2023-11-02 21:47:52.456151+00	2023-11-02 21:47:53.334961+00	4283856258	FAILED	1.00	EUR	0.03	pf_244
257	2023-11-04 00:14:50.799877+00	2023-11-04 00:14:51.893611+00	4289121153	SUCCEEDED	1.00	EUR	0.03	pf_257
166	2023-10-31 22:30:04.508578+00	2023-10-31 22:30:05.546355+00	4274516207	SUCCEEDED	1.00	EUR	0.03	pf_166
100	2023-09-18 12:38:22.847186+00	2023-09-18 12:54:01.087602+00	4076220935	FAILED	1.00	EUR	0.00	pf_100
140	2023-10-24 18:33:07.68352+00	2023-10-24 18:33:09.210645+00	4241917823	CREATED	100.00	EUR	0.00	pf_332
287	2023-11-09 17:33:02.461516+00	2023-11-09 17:43:19.04439+00	4317221134	SUCCEEDED	1.00	EUR	0.03	pf_287
144	2023-10-25 07:40:59.725596+00	2023-10-25 07:41:00.321639+00	4243365401	CREATED	100.00	EUR	0.00	pf_332
151	2023-10-25 08:04:14.040484+00	2023-10-25 08:04:15.739146+00	4243445153	CREATED	120.00	EUR	0.00	pf_332
156	2023-10-27 20:55:33.861743+00	2023-10-27 20:55:33.861743+00	4257373260	FAILED	1.00	EUR	0.03	
175	2023-10-31 23:41:26.995056+00	2023-10-31 23:41:26.995056+00			1.00		0.03	
176	2023-10-31 23:41:27.459126+00	2023-10-31 23:41:27.459126+00			1.00	EUR	0.03	
160	2023-10-30 22:21:24.783365+00	2023-10-30 22:21:25.87827+00	4270289831	SUCCEEDED	1.00	EUR	0.03	pf_160
345	2023-11-20 21:20:25.087796+00	2023-11-20 21:20:25.087796+00	4372455191	CREATED	2.00	EUR	0.00	pf_196
162	2023-10-30 23:00:55.678764+00	2023-10-30 23:00:56.579298+00	4270370468	SUCCEEDED	1.00	EUR	0.03	pf_162
181	2023-11-01 17:25:31.005529+00	2023-11-01 17:25:31.005529+00			1.00		0.03	
158	2023-10-29 21:08:15.243422+00	2023-10-31 06:08:19.771758+00	4265561666	SUCCEEDED	1.00	EUR	0.03	pf_158
164	2023-10-31 19:22:39.432902+00	2023-10-31 19:22:40.150875+00	4273861718	CREATED	20.00	EUR	0.00	pf_196
182	2023-11-01 17:25:31.396856+00	2023-11-01 17:25:31.396856+00			1.00	EUR	0.03	
185	2023-11-01 17:38:29.779534+00	2023-11-01 17:38:29.779534+00			1.00		0.03	
186	2023-11-01 17:38:30.161314+00	2023-11-01 17:38:30.161314+00			1.00	EUR	0.03	
249	2023-11-02 22:18:01.012831+00	2023-11-02 22:18:02.041723+00	4283956849	SUCCEEDED	1.00	EUR	0.03	pf_249
193	2023-11-01 18:08:30.575388+00	2023-11-01 18:08:30.575388+00			1.00		0.03	
194	2023-11-01 18:08:30.781325+00	2023-11-01 18:08:30.781325+00			1.00	EUR	0.03	
197	2023-11-01 18:20:44.993087+00	2023-11-01 18:20:44.993087+00			1.00		0.03	
198	2023-11-01 18:20:45.197066+00	2023-11-01 18:20:45.197066+00			1.00	EUR	0.03	
271	2023-11-04 02:39:22.269089+00	2023-11-04 02:49:38.215744+00	4289191420	SUCCEEDED	1.00	EUR	0.03	pf_271
201	2023-11-01 20:49:19.574119+00	2023-11-01 20:49:19.574119+00			1.00		0.03	
202	2023-11-01 20:49:19.915647+00	2023-11-01 20:49:19.915647+00			1.00	EUR	0.03	
327	2023-11-15 14:50:42.188071+00	2023-11-15 14:50:42.188071+00	4345872661	CREATED	3.00	EUR	0.00	pj_3
259	2023-11-04 00:46:20.1824+00	2023-11-04 00:56:36.027427+00	4289147470	SUCCEEDED	1.00	EUR	0.03	pf_259
223	2023-11-02 10:03:28.685849+00	2023-11-02 10:03:28.685849+00			1.00		0.03	
224	2023-11-02 10:03:28.914154+00	2023-11-02 10:03:28.914154+00			1.00	EUR	0.03	
261	2023-11-04 01:21:41.937336+00	2023-11-04 01:31:57.999437+00	4289165504	SUCCEEDED	1.00	EUR	0.03	pf_261
289	2023-11-09 19:32:28.205994+00	2023-11-09 19:42:44.050263+00	4317991078	SUCCEEDED	3.00	EUR	0.09	pf_289
291	2023-11-09 19:41:18.730378+00	2023-11-09 19:51:35.341833+00	4318046066	SUCCEEDED	2.00	EUR	0.06	pf_291
253	2023-11-03 15:29:59.658249+00	2023-11-03 15:30:00.327148+00	4286828549	CREATED	100.00	EUR	0.00	pf_332
275	2023-11-04 23:21:59.37115+00	2023-11-04 23:32:15.378804+00	4293835543	SUCCEEDED	1.00	EUR	0.03	pf_275
263	2023-11-04 01:41:57.057524+00	2023-11-04 01:52:13.081229+00	4289173196	SUCCEEDED	1.00	EUR	0.03	pf_263
293	2023-11-09 20:46:19.806136+00	2023-11-09 20:46:31.225779+00	4318446428	SUCCEEDED	8.00	EUR	0.24	pf_293
320	2023-11-14 21:41:33.02169+00	2023-11-14 21:41:33.02169+00	4343110067	CREATED	1.00	EUR	0.00	pj_5
279	2023-11-05 00:19:17.654724+00	2023-11-05 00:29:33.524539+00	4293907001	SUCCEEDED	1.00	EUR	0.03	pf_279
255	2023-11-04 00:01:57.056442+00	2023-11-04 00:01:58.227204+00	4289107364	SUCCEEDED	1.00	EUR	0.03	pf_255
295	2023-11-10 17:31:43.026096+00	2023-11-10 17:41:59.116513+00	4322885013	SUCCEEDED	4.00	EUR	0.12	pf_295
283	2023-11-08 21:53:32.784759+00	2023-11-08 21:53:32.784759+00	4313303259	CREATED	1.00	EUR	0.00	pf_82
329	2023-11-17 17:05:07.976921+00	2023-11-17 17:15:24.718219+00	4357246623	SUCCEEDED	1.00	EUR	0.03	pf_329
285	2023-11-08 21:56:24.807927+00	2023-11-08 21:56:24.807927+00	4313314445	CREATED	1.00	EUR	0.00	pf_82
339	2023-11-20 13:04:58.771537+00	2023-11-20 13:04:58.771537+00	4369631231	CREATED	10.00	EUR	0.00	pf_23
343	2023-11-20 13:51:28.995485+00	2023-11-20 13:51:28.995485+00	4369859390	CREATED	4.00	EUR	0.00	pf_196
305	2023-11-11 09:27:09.160309+00	2023-11-11 09:37:25.323703+00	4325203330	SUCCEEDED	1.00	EUR	0.03	pf_305
303	2023-11-10 18:10:02.33248+00	2023-11-10 18:20:18.252079+00	4323137674	SUCCEEDED	8.00	EUR	0.24	pf_303
313	2023-11-12 00:27:58.111003+00	2023-11-12 00:38:13.917157+00	4329136791	SUCCEEDED	1.00	EUR	0.03	pf_313
307	2023-11-11 10:29:08.733582+00	2023-11-11 10:39:24.666046+00	4325507353	SUCCEEDED	8.00	EUR	0.24	pf_307
315	2023-11-13 21:40:59.043702+00	2023-11-13 21:51:14.938911+00	4338203359	SUCCEEDED	1.00	EUR	0.03	pf_315
318	2023-11-14 21:10:59.680494+00	2023-11-14 21:10:59.680494+00	4342970251	CREATED	1.00	EUR	0.00	pf_196
322	2023-11-14 21:55:53.26731+00	2023-11-14 21:55:53.26731+00	4343167175	CREATED	23.00	EUR	0.00	pj_5
324	2023-11-14 22:04:02.345631+00	2023-11-14 22:04:02.345631+00	4343197374	CREATED	5.00	EUR	0.00	pj_5
\.


--
-- Data for Name: mangopay_mangopaybankaccount; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mangopay_mangopaybankaccount (id, created, modified, bank_account_id, iban, is_active, owner_name, owner_street_address, owner_city, owner_postal_code, owner_state, owner_country, user_id, cod) FROM stdin;
4	2023-07-04 11:00:42.228065+00	2023-09-06 08:56:59.05691+00	3798835726	ES83 0081 4257 8100 0109 5110	t	Harkaitz Balzategui	Ego-gain n20	eibar	20600	Gipuzkoa	ES	120	pf_120
3	2023-06-27 14:48:32.089768+00	2023-09-06 08:58:50.368254+00	3774081680	BE09967604028157	t	BUSINESS CONSULTING & TRAINING LLC	Avenue Louise 54	Brussels	1050	Brussels	BE	126	pf_126
2	2023-06-22 09:33:55.869177+00	2023-09-06 09:00:07.436882+00	3755557986	ES9221001169610200125306	t	PILAR TOBARIAS AVELLANEDA	PL MERCAT, 1	STA CRISTINA D'ARO	17246	GIRONA	NL	134	pf_134
1	2023-02-02 11:07:18.980913+00	2023-09-06 09:03:09.820879+00	3242576833	ES5614650100921724350028	t	CARLOS CALLEJO GONZALEZ	Cooperativa Caucia 3	Coca	40480	Segovia	ES	23	pf_23
\.


--
-- Data for Name: mangopay_mangopaybankwiredeposit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mangopay_mangopaybankwiredeposit (basemangopaytransaction_ptr_id, wire_reference, bank_account, to_user_id) FROM stdin;
32	MGkyca24z8	FR7618829754160284210614460	120
39	MGf0x8axt7	FR7618829754160284210614460	122
66	MG7bvhdip5	FR7618829754160284210614460	13
65	MG3n6p9k15	FR7618829754160284210614460	13
64	MGi02np8bs	FR7618829754160284210614460	13
63	MGg2zklmyr	FR7618829754160284210614460	13
62	MGghcl8cp1	FR7618829754160284210614460	13
60	MGv7luk010	FR7618829754160284210614460	126
59	MGg6xp3pyt	FR7618829754160284210614460	28
55	MGzgyw1n16	FR7618829754160284210614460	133
44	MGcpr6p2n6	FR7618829754160284210614460	135
40	MG9pf2ys3j	FR7618829754160284210614460	122
38	MGalqcspa2	FR7618829754160284210614460	122
37	MGsywcamx9	FR7618829754160284210614460	122
35	MGp0ohxnat	FR7618829754160284210614460	122
31	MG7llvzwwf	FR7618829754160284210614460	120
30	MGuhjur7mg	FR7618829754160284210614460	120
29	MG6ml45gon	FR7618829754160284210614460	120
28	MGm7xyrhci	FR7618829754160284210614460	13
90	MGf4o8d9os	FR7618829754160284210614460	13
21	MGm0hb9quh	FR7618829754160284210614460	13
19	MG9mtpu4g4	FR7618829754160284210614460	23
16	MGummtwwkd	FR7618829754160284210614460	23
13	MGa3vbqw7i	FR7618829754160284210614460	23
26	MGsqwhz5hj	FR7618829754160284210614460	23
9	MGa0wz318g	FR7618829754160284210614460	74
7	MGr3lohm1d	FR7618829754160284210614460	28
6	MGcciat5mb	FR7618829754160284210614460	28
4	MGfamvs8gp	FR7618829754160284210614460	23
94	MG0w45k611	FR7618829754160284210614460	82
102	MGr5lf36zq	FR7618829754160284210614460	23
105	MG0obrtcu4	FR7618829754160284210614460	23
108	MGllgzcxaq	FR7618829754160284210614460	23
123	MGjnbuxfb3	FR7618829754160284210614460	332
132	MGmj6u6pbs	FR7618829754160284210614460	332
78	MGkd7mogz6	FR7618829754160284210614460	266
89	MGa8smtkg9	FR7618829754160284210614460	13
140	MGtvruw9n7	FR7618829754160284210614460	332
141	MGoxko7ora	FR7618829754160284210614460	332
144	MGibfaubcx	FR7618829754160284210614460	332
150	MG6jjla8sp	FR7618829754160284210614460	332
151	MGjyikn4vd	FR7618829754160284210614460	332
155	MGljqtfpr4	FR7618829754160284210614460	196
164	MGdh6pyh3n	FR7618829754160284210614460	196
253	MGphr2poz5	FR7618829754160284210614460	332
342	MGwih71mrx	FR7618829754160284210614460	28
227	MG7hi2bor0	FR7618829754160284210614460	332
\.


--
-- Data for Name: mangopay_mangopaydeposit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mangopay_mangopaydeposit (language, redirect_url, return_url, to_user_id, basemangopaytransaction_ptr_id) FROM stdin;
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=92b7efb63ccb4a8aa3130fdba2651558&transactionId=3768720147&token=2mKjghLmmarKcnRU12101687759429392	https://app.stockencapital.com/mangopay/process/?transactionId=3768720147	82	50
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=8b8027805abf4d0d88eca5fe9b0b28af&transactionId=3768716527&token=2pJt7sBfoUEIu3p6h2091687759281431	https://app.stockencapital.com/mangopay/process/?transactionId=3768716527	23	49
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=a709fea2461f4803b905c37aa89eadb1&transactionId=3768716508&token=2o7CBQs1uQ5nlVuPB2101687759280503	https://app.stockencapital.com/mangopay/process/?transactionId=3768716508	23	48
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=dceb68fbd5774bd99bb3f8f92b1279dc&transactionId=3762437534&token=1GptUN9sVG3QL38067451687555937192	https://app.stockencapital.com/mangopay/process/?transactionId=3762437534	126	47
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=3bf19cdfdb5a4e37a9c098cdb6e73e0a&transactionId=3760142665&token=1Qu27gKfLVdbn37808401687520887349	https://app.stockencapital.com/mangopay/process/?transactionId=3760142665	134	46
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=f0f2b620787e4313919bcae49eff5fdc&transactionId=3755662378&token=1IDSKwmOOkRI180441051687429136917	https://app.stockencapital.com/mangopay/process/?transactionId=3755662378	135	43
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=6f099e626c444f8d9673153af71c4427&transactionId=3755546546&token=1VS0rs5h3t8nz38051861687426147685	https://app.stockencapital.com/mangopay/process/?transactionId=3755546546	134	42
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=88eead7f3f3a40cdba4d68d414339c60&transactionId=3755541322&token=1kwx5YvcPaGgY38051621687426012627	https://app.stockencapital.com/mangopay/process/?transactionId=3755541322	134	41
EN	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=b305bc17547542419cd30d7036f0093e&transactionId=3743264295&token=1GH7BVrZfBdQO59254671687162534281	https://app.stockencapital.com/mangopay/process/?transactionId=3743264295	87	36
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=293f6b082d1841d588078752a300b5e5&transactionId=3742987178&token=1WxSqKZaKSctf38257691687155919008	https://app.stockencapital.com/mangopay/process/?transactionId=3742987178	122	34
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=c4d5a74b888b40c5b21be9db220f2ab1&transactionId=3742987018&token=1wxhMlJ0RiNyh12963901687155915743	https://app.stockencapital.com/mangopay/process/?transactionId=3742987018	122	33
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=893e2c9f4a3d4807a5445244ade98aa0&transactionId=3715971614&token=1j6lwDQaXrQaJ38004431686560643341	https://app.stockencapital.com/mangopay/process/?transactionId=3715971614	89	27
EN	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=45ef24e0f6ff4ce9bd83391d65565a67&transactionId=3715802905&token=1b9lpUfJV9YLT12992941686557883458	https://app.stockencapital.com/mangopay/process/?transactionId=3715802905	23	25
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=7bd541955b574075bde4ce7f1c490b49&transactionId=3715799016&token=1NgRwlDBwROWo40264221686557812982	https://app.stockencapital.com/mangopay/process/?transactionId=3715799016	23	24
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=61a29838f4114330938c450b275ab7c9&transactionId=3715718696&token=1VYwtEYTnH5HX35631001686556469053	https://app.stockencapital.com/mangopay/process/?transactionId=3715718696	23	23
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=c0f5f5486eab4c679407a0809a3cf933&transactionId=3695904573&token=1CbOcXIrYunOwC2913871686132569679	https://app.stockencapital.com/mangopay/process/?transactionId=3695904573	90	22
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=0f2add46022d47d7b51000f85f49cc34&transactionId=3694545845&token=1n0CFNNVoyqGDP2913911686084600837	https://app.stockencapital.com/mangopay/process/?transactionId=3694545845	13	20
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=0a82cd0d34d0473e8dc335940006ba47&transactionId=3687129218&token=1cE0o5sdTHcxYeKL12231685958258832	https://app.stockencapital.com/mangopay/process/?transactionId=3687129218	23	18
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=bc7f87ac4be44bddb104b32ada04e725&transactionId=3671642200&token=1cTsT8fGFLjQPJ2979691685621304305	https://app.stockencapital.com/mangopay/process/?transactionId=3671642200	90	17
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=e8c3babe003e4c5cb6adc5cad3be3803&transactionId=3658667611&token=2HfI8OU3jjpAniX659611685350886835	https://app.stockencapital.com/mangopay/process/?transactionId=3658667611	23	15
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=a88b5948fb264f65b0145e846bcf3d9a&transactionId=3658666204&token=2kjZB02SMFJQJd7734971685350866279	https://app.stockencapital.com/mangopay/process/?transactionId=3658666204	23	14
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=d14d3da44869420db03b1fd95af49425&transactionId=3618234861&token=1juoP3rXIrVV09xy22201684415989386	https://app.stockencapital.com/mangopay/process/?transactionId=3618234861	23	12
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=c0c3e2987fb545989d024f97c983f52f&transactionId=3618234816&token=1HnoWSpZGMSKtMhXz1961684415988791	https://app.stockencapital.com/mangopay/process/?transactionId=3618234816	23	11
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=5ed270ac82aa4c709bee253041327ea1&transactionId=2814547054&token=2CoV2MlLza306iHfg2201664524546122	https://app.stockencapital.com/mangopay/process/?transactionId=2814547054	23	3
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=d31a5f202f3540da9232724852cfae26&transactionId=3581888333&token=1nEk99hK85fS5ZEg61931683636802861	https://app.stockencapital.com/mangopay/process/?transactionId=3581888333	74	10
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=d4df0fadfa044937ad9a0e6df4f2ddf0&transactionId=3061152824&token=1obYHYMJrpuPWkT648341670319329850	https://app.stockencapital.com/mangopay/process/?transactionId=3061152824	28	5
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=5f2ad9964f3542ec8ddcc1edfe3de7a0&transactionId=2812352023&token=2pMB6n1QjPb8n01NJ2241664468819952	https://app.stockencapital.com/mangopay/process/?transactionId=2812352023	13	2
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=1db0f4851be44040a195b575f47e500c&transactionId=2812351766&token=2PibQbBtoZ0f6m2375681664468817521	https://app.stockencapital.com/mangopay/process/?transactionId=2812351766	13	1
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=678b005f2e814be88ef6b644c7f55981&transactionId=3955296029&token=1YY2EGbjJJr1I25539391692377122183	https://app.stockencapital.com/mangopay/process/?transactionId=3955296029	133	77
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=310d5e89454945079650744cd6eb2d13&transactionId=3907626695&token=1sFOcNIfCkdvzA1Fl2071691180654973	https://app.stockencapital.com/mangopay/process/?transactionId=3907626695	191	76
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=7fe4097f42474f00aedfae436dda015d&transactionId=3898660624&token=2r1moStDKGgqv6V0u2071690992803283	https://app.stockencapital.com/mangopay/process/?transactionId=3898660624	125	75
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=270cb87c8d71422fb602a77b8167b2ad&transactionId=3898639850&token=2DjIC2OGLRaZWV9137191690992515072	https://app.stockencapital.com/mangopay/process/?transactionId=3898639850	125	74
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=623ed4f05f5842be8aa4e6d37d90ad3c&transactionId=3847456527&token=1Kr7D308YpH5zGZK45481689681709462	https://app.stockencapital.com/mangopay/process/?transactionId=3847456527	152	73
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=0177dbc4343a4dae92dc3839359ca530&transactionId=3837504970&token=1qlZdlDIWA6PmkX746471689405765433	https://app.stockencapital.com/mangopay/process/?transactionId=3837504970	144	72
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=8c03429f11224bd5b7742ff4242e3d6e&transactionId=3807713965&token=1CNXAGPvhDEK430506891688655000132	https://app.stockencapital.com/mangopay/process/?transactionId=3807713965	134	71
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=913c3b4f268e4a5389446c850904d79d&transactionId=3802180269&token=15yWB9ZcZ9i8sj5707961688547653752	https://app.stockencapital.com/mangopay/process/?transactionId=3802180269	125	68
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=81f4f8d384b748ad9c892792e693f9b9&transactionId=3802118146&token=1cHOIfL5nPTkBsiz72601688546622518	https://app.stockencapital.com/mangopay/process/?transactionId=3802118146	125	67
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=03e4ba48f21e4e4883cb2224fdd86651&transactionId=3784457169&token=1kyKwlcx1lJVIt1830471688117966125	https://app.stockencapital.com/mangopay/process/?transactionId=3784457169	134	61
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=dfe4b850b67747d8a5ab9e2aa3818cd5&transactionId=3776879945&token=2e8ftioouUdBOu0665431687949403701	https://app.stockencapital.com/mangopay/process/?transactionId=3776879945	28	58
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=d2332fc060e8473aba5f102136a008e1&transactionId=3774082526&token=1ImInEN8G6ijo40540981687877325858	https://app.stockencapital.com/mangopay/process/?transactionId=3774082526	126	57
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=5bfaf5e012ba44e29356df91eb04982f&transactionId=3774036080&token=19M3ITya8JEr559137761687876640417	https://app.stockencapital.com/mangopay/process/?transactionId=3774036080	126	56
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=e6aab958d6bc48029c9c21ccced7f583&transactionId=3772614337&token=1lWqK5F4oLkzH38257631687852288968	https://app.stockencapital.com/mangopay/process/?transactionId=3772614337	23	54
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=34950d5c5c7043f6a90a12a26d727625&transactionId=3772612047&token=16DVxSu7gvLjx80442621687852237410	https://app.stockencapital.com/mangopay/process/?transactionId=3772612047	23	53
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=88967b11f7c044498af0d9c55863208d&transactionId=3772609617&token=1Lsv9f9g2pQcP80442501687852183704	https://app.stockencapital.com/mangopay/process/?transactionId=3772609617	23	52
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=2bc44d092609408c86e526f1a1d4f203&transactionId=3768783143&token=24vU29dFZC4QRwVsd2201687761697210	https://app.stockencapital.com/mangopay/process/?transactionId=3768783143	136	51
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=726331daf59e49c099fcf5f4fd172ff4&transactionId=4074526779&token=2nyExDVsxZjUsL6940321694990503547	https://pro.stockencapital.com/mangopay/process/?transactionId=4074526779	82	97
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=86f3315cf2e34e65a09a06d719edf31d&transactionId=4034891846&token=1dWlXFppg1zET72262611694170105214	https://pro.stockencapital.com/mangopay/process/?transactionId=4034891846	196	79
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=3ff25e61d2bb42c1bbab3ad29ab48491&transactionId=4074522436&token=2svV6T1QmpeCXZ6963101694990219921	https://pro.stockencapital.com/mangopay/process/?transactionId=4074522436	13	96
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=7cac1b006c9441049bc1f536df4c5244&transactionId=4064331888&token=2gjB7K5k0PMDCNEyb1971694785187047	https://pro.stockencapital.com/mangopay/process/?transactionId=4064331888	13	86
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=c9a58be4253e4991b578af436104a78f&transactionId=4075967499&token=1oGPpxLw6AMYl97423201695037312376	https://pro.stockencapital.com/mangopay/process/?transactionId=4075967499	23	99
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=ab56abd4b93a441098d8b3b08b52f166&transactionId=4074519148&token=2vjivyxAZ25I86bbM2091694990019082	https://pro.stockencapital.com/mangopay/process/?transactionId=4074519148	23	91
EN	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=b31411ea5ed14636a7e187c75af7ec7b&transactionId=4076228201&token=1RQqCw8c645Mh97525191695040810586	https://pro.stockencapital.com/mangopay/process/?transactionId=4076228201	23	101
EN	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=78dc825c19054da2940123b54a7f41a7&transactionId=4076248583&token=1BwSwVdY7UasM97642051695041102865	https://pro.stockencapital.com/mangopay/process/?transactionId=4076248583	23	103
EN	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=56460371e20d41b895e0992b220e574d&transactionId=4076220935&token=1w3DyLUmQ5TZN97877861695040703264	https://pro.stockencapital.com/mangopay/process/?transactionId=4076220935	23	100
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=fcec07ba544d42a1b374fc2aefe787c4&transactionId=4075843096&token=1RXSS1f9gSLjK97575501695035659912	https://pro.stockencapital.com/mangopay/process/?transactionId=4075843096	23	98
EN	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=c6dc20d0330e47c6bfb1b4a7c01cbc58&transactionId=4076251943&token=1lhPPnaOVBP8397492181695041142584	https://pro.stockencapital.com/mangopay/process/?transactionId=4076251943	23	104
EN	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=fe6bf63ec01843eab48594ab641e3a3c&transactionId=4343175523&token=1I7KaWx5YmC1x10906811699999085900	https://pro.stockencapital.com/mangopay/process/?transactionId=4343175523	196	323
EN	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=d173b60727d04d2989d9df738fedd93f&transactionId=4343110067&token=1lDOQjibE6FZKQRtz2111699998094762	https://pro.stockencapital.com/mangopay/process/?transactionId=4343110067	196	320
EN	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=69058ccdf78e42dea5d2c625e35e9e70&transactionId=4342970251&token=1RDaftKV2fPkSkQIm4941699996260559	https://pro.stockencapital.com/mangopay/process/?transactionId=4342970251	196	318
EN	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=1af9c9a28fc54c44a563330dd4c6d20c&transactionId=4076512526&token=1dZhpz5NDj6MX97583681695044578204	https://pro.stockencapital.com/mangopay/process/?transactionId=4076512526	23	106
EN	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=825ef2f8481d4f30bb95334b06ca68a7&transactionId=4076518225&token=1HVyxCcsZXMxW97757581695044656094	https://pro.stockencapital.com/mangopay/process/?transactionId=4076518225	23	107
EN	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=4e04ba6d358d429abf71ae87a916cff1&transactionId=4313303259&token=1AImIyzroBAHvAWyI2151699480414085	https://pro.stockencapital.com/mangopay/process/?transactionId=4313303259	82	283
EN	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=be63fb151e844d0b84de94f544042c61&transactionId=4369880421&token=1QGY8v5jWuSHkzB434571700488559959	https://pro.stockencapital.com/mangopay/process/?transactionId=4369880421	196	344
EN	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=d85e186f6e7c4e8c8dd1d240c04ac8a2&transactionId=4313307569&token=1YwciVm0h4FjHyCzE3811699480482755	https://pro.stockencapital.com/mangopay/process/?transactionId=4313307569	82	284
EN	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=bb9329b3fee34ed1bd764db062870fd7&transactionId=4372455191&token=1lOgqitXmqEQYXf6A2331700515226283	https://pro.stockencapital.com/mangopay/process/?transactionId=4372455191	196	345
EN	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=2f07f2488ade47d7ac3cb00bb37d5a8e&transactionId=4313314445&token=1C3DcTayEToD7g1379141699480586305	https://pro.stockencapital.com/mangopay/process/?transactionId=4313314445	82	285
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=2208208e9461433592279753480b3622&transactionId=4369631231&token=1osHCUWqoAnjR10577561700485499827	https://pro.stockencapital.com/mangopay/process/?transactionId=4369631231	23	339
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=da229479de13441fb2b226fb77d7c502&transactionId=4369632164&token=1rw7sLDvX2qQmCWJ32141700485514592	https://pro.stockencapital.com/mangopay/process/?transactionId=4369632164	23	340
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=8948967e455d4e43888a0ccd1e2e3969&transactionId=4343021982&token=1atQukXGJahtivyfx3591699996911429	https://pro.stockencapital.com/mangopay/process/?transactionId=4343021982	196	319
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=d947772ba1fd4b21bbc5281b6ba6caf5&transactionId=4369635401&token=1xWhb2bQZPG6i11065741700485547445	https://pro.stockencapital.com/mangopay/process/?transactionId=4369635401	28	341
EN	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=64d2ef85bd6842b48e28ca9a6ec210ed&transactionId=4343197374&token=1060N6LUF6XtyI1Z74491699999443241	https://pro.stockencapital.com/mangopay/process/?transactionId=4343197374	196	324
EN	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=023e4fa1516d4abd8c0a691da529034d&transactionId=4369859390&token=1es4hUU1JZbySRzJs5691700488290017	https://pro.stockencapital.com/mangopay/process/?transactionId=4369859390	196	343
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=4a90e63c1fb248a385b40df9c3d09191&transactionId=4345872661&token=1hOZRTk11dDXE10562431700059843771	https://pro.stockencapital.com/mangopay/process/?transactionId=4345872661	9	327
EN	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=abf6173342ac432d8a4823541840ef1f&transactionId=4343160617&token=1EqeL84WYBdQf10667361699998856189	https://pro.stockencapital.com/mangopay/process/?transactionId=4343160617	196	321
EN	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=6af265e88f8c46518cb594c08a1a7593&transactionId=4343167175&token=1iwE6V2zJbyTG10909561699998954079	https://pro.stockencapital.com/mangopay/process/?transactionId=4343167175	196	322
EN	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=a921c33c4e84441f879f4b8f150e43aa&transactionId=4343205581&token=14sCRrjmIMDFT3rXK4281699999573519	https://pro.stockencapital.com/mangopay/process/?transactionId=4343205581	196	325
ES	https://api.mangopay.com/Content/PaylineTemplateWidget?rp=e824e26c2f8a477ea985c024db381112&transactionId=4342908812&token=19G8mB7WoXCObeQnc4211699995548972	https://pro.stockencapital.com/mangopay/process/?transactionId=4342908812	196	317
\.


--
-- Data for Name: mangopay_mangopaykycdocument; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mangopay_mangopaykycdocument (id, created, modified, status, type, document_id, user_id, processed_date, refused_reason_message, refused_reason_type, cod) FROM stdin;
70	2023-07-28 17:38:16.633479+00	2023-09-06 08:13:06.63862+00	VALIDATED	IDENTITY_PROOF	3882197316	165	2023-07-28 17:39:07+00	\N	\N	pf_165
69	2023-07-28 13:16:35.087948+00	2023-09-06 08:15:07.639653+00	VALIDATED	IDENTITY_PROOF	3881066291	190	2023-07-28 13:18:05+00	\N	\N	pf_190
68	2023-07-28 04:41:34.667514+00	2023-09-06 08:15:41.553172+00	VALIDATED	IDENTITY_PROOF	3879458384	186	2023-07-28 04:43:00+00	\N	\N	pf_186
67	2023-07-28 04:40:06.145831+00	2023-09-06 08:16:15.664522+00	VALIDATED	IDENTITY_PROOF	3879457574	168	2023-07-28 04:41:00+00	\N	\N	pf_168
65	2023-07-21 10:23:46.888259+00	2023-09-06 08:17:42.787969+00	VALIDATED	IDENTITY_PROOF	3857610375	189	2023-07-21 10:25:01+00	\N	\N	pf_189
64	2023-07-20 22:12:32.623904+00	2023-09-06 08:18:19.172584+00	REFUSED	IDENTITY_PROOF	3856609781	158	2023-07-20 22:17:00+00	\N	DOCUMENT_UNREADABLE	pf_158
63	2023-07-20 22:11:47.138903+00	2023-09-06 08:18:58.380212+00	VALIDATED	IDENTITY_PROOF	3856608744	188	2023-07-20 22:16:01+00	\N	\N	pf_188
62	2023-07-20 22:11:21.870201+00	2023-09-06 08:19:42.104236+00	VALIDATED	IDENTITY_PROOF	3856608178	160	2023-07-20 22:12:00+00	\N	\N	pf_160
6	2022-09-29 15:42:58.061475+00	2022-09-29 15:44:07.222841+00	VALIDATED	IDENTITY_PROOF	2812129695	23	2022-09-29 15:44:06+00	\N	\N	
61	2023-07-20 22:10:46.588191+00	2023-09-06 08:20:48.511841+00	VALIDATED	IDENTITY_PROOF	3856607366	185	2023-07-20 22:12:00+00	\N	\N	pf_185
46	2023-06-27 09:34:28.499756+00	2023-06-27 09:40:08.196597+00	REFUSED	IDENTITY_PROOF	3772956287	139	2023-06-27 09:40:07+00	\N	DOCUMENT_UNREADABLE	
60	2023-07-20 07:45:03.667872+00	2023-09-06 08:21:37.482389+00	VALIDATED	IDENTITY_PROOF	3853541934	183	2023-07-20 07:47:02+00	\N	\N	pf_183
59	2023-07-19 13:39:17.28884+00	2023-09-06 08:22:37.888783+00	VALIDATED	IDENTITY_PROOF	3851138907	167	2023-07-19 13:40:04+00	\N	\N	pf_167
58	2023-07-19 05:17:05.198248+00	2023-09-06 08:25:10.931001+00	VALIDATED	IDENTITY_PROOF	3849682115	154	2023-07-19 05:18:00+00	\N	\N	pf_154
57	2023-07-19 05:16:53.573145+00	2023-09-06 08:25:59.353218+00	VALIDATED	IDENTITY_PROOF	3849681968	179	2023-07-19 05:18:01+00	\N	\N	pf_179
56	2023-07-19 05:16:27.033061+00	2023-09-06 08:26:35.895484+00	VALIDATED	IDENTITY_PROOF	3849681619	175	2023-07-19 05:17:00+00	\N	\N	pf_175
55	2023-07-18 13:53:40.193748+00	2023-09-06 08:27:32.771872+00	VALIDATED	IDENTITY_PROOF	3847828292	171	2023-07-18 13:55:02+00	\N	\N	pf_171
54	2023-07-18 13:53:27.206989+00	2023-09-06 08:28:16.350237+00	VALIDATED	IDENTITY_PROOF	3847827581	173	2023-07-18 13:55:02+00	\N	\N	pf_173
53	2023-07-18 09:29:26.435563+00	2023-09-06 08:28:52.734735+00	VALIDATED	IDENTITY_PROOF	3846946873	152	2023-07-18 09:30:00+00	\N	\N	pf_152
51	2023-07-17 10:22:41.80978+00	2023-09-06 08:30:27.303467+00	VALIDATED	IDENTITY_PROOF	3843708921	112	2023-07-17 10:26:04+00	\N	\N	pf_112
50	2023-07-17 06:48:37.144885+00	2023-09-06 08:31:04.955761+00	VALIDATED	IDENTITY_PROOF	3843110667	147	2023-07-17 06:50:02+00	\N	\N	pf_147
49	2023-07-17 06:48:24.246682+00	2023-09-06 08:32:00.047153+00	VALIDATED	IDENTITY_PROOF	3843110323	150	2023-07-17 06:49:00+00	\N	\N	pf_150
48	2023-07-14 16:44:08.366144+00	2023-09-06 08:32:31.175736+00	VALIDATED	IDENTITY_PROOF	3836262919	111	2023-07-14 16:45:02+00	\N	\N	pf_111
47	2023-07-14 06:16:56.124284+00	2023-09-06 08:33:11.570121+00	VALIDATED	IDENTITY_PROOF	3834139379	144	2023-07-14 06:18:00+00	\N	\N	pf_144
43	2023-06-23 09:38:00.41366+00	2023-09-06 08:37:24.177346+00	REFUSED	IDENTITY_PROOF	3759606633	136	2023-06-23 10:00:03+00	\N	DOCUMENT_UNREADABLE	pf_136
42	2023-06-23 08:12:15.395459+00	2023-09-06 08:38:10.934309+00	VALIDATED	IDENTITY_PROOF	3759278617	126	2023-06-23 08:13:04+00	\N	\N	pf_126
41	2023-06-22 10:15:41.218632+00	2023-09-06 08:39:04.067771+00	VALIDATED	IDENTITY_PROOF	3755655221	135	2023-06-22 10:17:01+00	\N	\N	pf_135
40	2023-06-22 08:11:34.980279+00	2023-09-06 08:40:09.721134+00	VALIDATED	IDENTITY_PROOF	3755346455	133	2023-06-22 08:24:01+00	\N	\N	pf_133
39	2023-06-22 08:11:13.566345+00	2023-09-06 08:41:57.409179+00	VALIDATED	IDENTITY_PROOF	3755345461	134	2023-06-22 08:12:00+00	\N	\N	pf_134
38	2023-06-21 14:49:31.161679+00	2023-09-06 08:42:52.247804+00	VALIDATED	IDENTITY_PROOF	3752983268	125	2023-06-21 14:51:04+00	\N	\N	pf_125
37	2023-06-21 11:09:18.03484+00	2023-06-21 11:13:00.706278+00	REFUSED	IDENTITY_PROOF	3752048961	132	2023-06-21 11:13:00+00	\N	DOCUMENT_UNREADABLE	
44	2023-06-26 21:19:38.952084+00	2023-06-26 21:21:00.427222+00	REFUSED	IDENTITY_PROOF	3771996072	137	2023-06-26 21:21:00+00	\N	DOCUMENT_NOT_ACCEPTED	
45	2023-06-26 21:45:13.772135+00	2023-06-26 21:46:00.381022+00	REFUSED	IDENTITY_PROOF	3772055298	138	2023-06-26 21:46:00+00	\N	DOCUMENT_NOT_ACCEPTED	
30	2023-06-15 09:14:51.319287+00	2023-09-06 08:46:06.352885+00	VALIDATED	IDENTITY_PROOF	3728672432	118	2023-06-15 09:22:01+00	\N	\N	pf_118
31	2023-06-15 09:20:10.8246+00	2023-09-06 08:47:10.264099+00	VALIDATED	IDENTITY_PROOF	3728696125	98	2023-06-15 09:26:04+00	\N	\N	pf_98
2	2022-09-27 09:50:18.926559+00	2023-09-03 20:13:04.632513+00	REFUSED	IDENTITY_PROOF	2802738541	25	2022-09-27 09:55:01+00	\N	DOCUMENT_HAS_EXPIRED	pf_25
3	2022-09-27 10:41:38.158534+00	2023-09-03 20:14:03.704004+00	VALIDATED	IDENTITY_PROOF	2802916066	24	2022-09-27 10:42:02+00	\N	\N	pf_25
4	2022-09-27 11:42:41.282856+00	2023-09-03 20:14:57.524906+00	VALIDATED	IDENTITY_PROOF	2803131908	26	2022-09-27 11:46:04+00	\N	\N	pf_26
5	2022-09-29 10:15:38.984416+00	2023-09-03 20:15:48.670712+00	VALIDATED	IDENTITY_PROOF	2810660051	28	2022-09-29 10:16:02+00	\N	\N	pf_28
7	2022-10-17 10:45:48.884407+00	2023-09-03 20:16:38.979902+00	VALIDATED	IDENTITY_PROOF	2880189640	39	2022-10-17 10:49:02+00	\N	\N	pj_10
8	2022-10-19 06:56:19.068811+00	2023-09-03 20:17:31.471073+00	VALIDATED	IDENTITY_PROOF	2886689265	29	2022-10-19 06:59:01+00	\N	\N	pj_9
9	2023-01-04 00:15:48.587326+00	2023-09-03 20:18:27.388461+00	VALIDATED	IDENTITY_PROOF	3148198905	65	2023-01-04 00:17:00+00	\N	\N	pf_65
10	2023-01-30 17:22:07.631551+00	2023-09-03 20:19:05.670801+00	VALIDATED	IDENTITY_PROOF	3233355831	69	2023-01-30 17:23:02+00	\N	\N	pf_69
11	2023-02-28 00:23:10.383066+00	2023-09-03 20:19:42.904615+00	VALIDATED	IDENTITY_PROOF	3326433999	74	2023-02-28 00:28:00+00	\N	\N	pj_13
12	2023-03-30 10:19:03.779766+00	2023-09-03 20:20:23.923509+00	VALIDATED	IDENTITY_PROOF	3434457279	65	2023-03-30 10:20:04+00	\N	\N	pf_65
14	2023-03-31 15:13:14.350915+00	2023-09-03 20:21:58.933371+00	VALIDATED	IDENTITY_PROOF	3439760780	79	2023-03-31 15:14:03+00	\N	\N	pf_79
15	2023-04-11 16:22:50.003971+00	2023-09-03 20:22:49.532053+00	VALIDATED	IDENTITY_PROOF	3477951021	80	2023-04-11 16:24:04+00	\N	\N	pf_80
16	2023-04-16 01:14:49.249619+00	2023-09-03 20:23:32.309034+00	VALIDATED	IDENTITY_PROOF	3495266248	82	2023-04-16 01:23:00+00	\N	\N	pf_82
17	2023-04-21 10:26:40.80514+00	2023-09-03 20:24:40.483495+00	VALIDATED	IDENTITY_PROOF	3514858757	4	2023-04-21 10:28:01+00	\N	\N	pf_4
18	2023-04-26 17:27:03.04805+00	2023-09-03 20:25:18.928229+00	VALIDATED	IDENTITY_PROOF	3534551521	84	2023-04-26 17:28:01+00	\N	\N	pj_14
19	2023-05-03 13:27:49.141737+00	2023-09-03 20:26:04.149463+00	VALIDATED	IDENTITY_PROOF	3558814248	85	2023-05-03 13:29:06+00	\N	\N	pf_85
20	2023-05-09 10:20:05.249367+00	2023-09-03 20:26:43.755801+00	VALIDATED	IDENTITY_PROOF	3581305334	86	2023-05-09 10:21:01+00	\N	\N	pf_86
21	2023-05-26 10:17:59.337163+00	2023-09-03 20:27:18.962005+00	VALIDATED	IDENTITY_PROOF	3648345112	89	2023-05-26 10:23:04+00	\N	\N	pf_89
22	2023-05-31 06:22:05.497774+00	2023-09-03 20:27:57.957277+00	VALIDATED	IDENTITY_PROOF	3665931012	90	2023-05-31 06:23:02+00	\N	\N	pf_90
23	2023-06-09 15:29:38.021078+00	2023-09-03 20:28:32.274179+00	VALIDATED	IDENTITY_PROOF	3706315826	87	2023-06-09 15:31:05+00	\N	\N	pf_87
24	2023-06-14 08:25:48.258879+00	2023-09-03 20:29:13.930501+00	VALIDATED	IDENTITY_PROOF	3724080704	99	2023-06-14 08:28:01+00	\N	\N	pf_99
26	2023-06-14 08:27:44.833996+00	2023-09-03 20:31:35.8558+00	VALIDATED	IDENTITY_PROOF	3724088003	101	2023-06-14 08:30:01+00	\N	\N	pf_101
27	2023-06-14 08:28:28.984602+00	2023-09-03 20:32:15.141227+00	VALIDATED	IDENTITY_PROOF	3724090670	96	2023-06-14 08:29:02+00	\N	\N	pf_96
28	2023-06-14 12:46:08.270504+00	2023-09-03 20:35:07.561913+00	VALIDATED	IDENTITY_PROOF	3725185274	120	2023-06-14 12:48:01+00	\N	\N	pf_120
29	2023-06-15 05:56:38.318966+00	2023-09-03 20:38:35.562132+00	VALIDATED	IDENTITY_PROOF	3728077042	109	2023-06-15 05:58:01+00	\N	\N	pf_109
72	2023-07-31 06:20:00.099618+00	2023-09-06 08:11:49.483726+00	VALIDATED	IDENTITY_PROOF	3889166486	163	2023-07-31 06:21:00+00	\N	\N	pf_163
71	2023-07-31 06:19:27.862592+00	2023-09-06 08:12:21.313724+00	VALIDATED	IDENTITY_PROOF	3889165770	164	2023-07-31 06:20:01+00	\N	\N	pf_164
32	2023-06-18 15:26:47.504403+00	2023-09-06 08:47:38.591566+00	VALIDATED	IDENTITY_PROOF	3741355359	121	2023-06-18 15:28:04+00	\N	\N	pf_121
33	2023-06-19 06:02:00.180479+00	2023-09-06 08:48:15.96137+00	VALIDATED	IDENTITY_PROOF	3742947787	122	2023-06-19 06:04:02+00	\N	\N	pf_122
35	2023-06-20 13:16:47.699166+00	2023-09-06 08:49:45.463295+00	VALIDATED	IDENTITY_PROOF	3748629130	100	2023-06-20 13:18:04+00	\N	\N	pf_100
36	2023-06-21 11:08:44.134225+00	2023-09-06 08:50:40.293447+00	REFUSED	IDENTITY_PROOF	3752046793	131	2023-06-21 11:12:02+00	\N	DOCUMENT_UNREADABLE	pf_131
66	2023-07-28 04:39:43.305094+00	2023-09-06 08:16:57.21646+00	VALIDATED	IDENTITY_PROOF	3879457395	116	2023-07-28 04:41:00+00	\N	\N	pf_116
52	2023-07-17 10:22:53.061584+00	2023-09-06 08:29:48.998072+00	REFUSED	IDENTITY_PROOF	3843709503	107	2023-07-17 10:25:02+00	\N	DOCUMENT_UNREADABLE	pf_107
91	2023-09-27 23:11:34.664527+00	2023-09-27 23:12:00.480874+00	VALIDATED	IDENTITY_PROOF	4119654414	277	2023-09-27 23:12:00+00	\N	\N	pf_277
84	2023-09-06 08:47:29.034239+00	2023-09-06 08:48:05.811999+00	VALIDATED	IDENTITY_PROOF	4025710331	267	2023-09-06 08:48:05+00	\N	\N	pf_267
34	2023-06-19 12:06:43.220791+00	2023-09-06 08:49:04.746744+00	REFUSED	IDENTITY_PROOF	3744139897	124	2023-06-19 12:15:03+00	\N	DOCUMENT_NOT_ACCEPTED	pf_124
1	2022-09-19 10:11:49.372785+00	2023-09-03 20:12:12.369668+00	REFUSED	IDENTITY_PROOF	2774186728	20	2022-09-19 10:17:01+00	\N	DOCUMENT_NOT_ACCEPTED	pf_20
13	2023-03-30 10:21:20.194303+00	2023-09-03 20:21:10.315301+00	REFUSED	IDENTITY_PROOF	3434465550	78	2023-03-30 10:27:03+00	\N	DOCUMENT_HAS_EXPIRED	pf_78
25	2023-06-14 08:27:27.395436+00	2023-09-03 20:30:29.620436+00	VALIDATED	IDENTITY_PROOF	3724086888	113	2023-06-14 08:28:01+00	\N	\N	pf_113
92	2023-09-28 07:03:22.077567+00	2023-09-28 07:06:03.183855+00	REFUSED	IDENTITY_PROOF	4120085490	279	2023-09-28 07:06:02+00	\N	DOCUMENT_HAS_EXPIRED	pf_279
85	2023-09-06 11:00:43.239168+00	2023-09-06 11:03:05.913428+00	VALIDATED	IDENTITY_PROOF	4026240194	268	2023-09-06 11:03:03+00	\N	\N	pf_268
106	2023-10-18 10:23:10.554383+00	2023-10-18 10:25:11.897476+00	VALIDATED	IDENTITY_PROOF	4211694630	318	2023-10-18 10:25:07+00	\N	\N	pf_318
86	2023-09-16 07:06:31.636914+00	2023-09-16 07:07:00.491964+00	VALIDATED	IDENTITY_PROOF	4067021172	28	2023-09-16 07:07:00+00	\N	\N	pj_25
107	2023-10-18 10:24:36.221925+00	2023-10-18 10:25:12.974816+00	VALIDATED	IDENTITY_PROOF	4211700275	316	2023-10-18 10:25:07+00	\N	\N	pf_316
93	2023-09-28 09:02:09.200696+00	2023-09-28 09:03:01.59284+00	VALIDATED	IDENTITY_PROOF	4120534313	156	2023-09-28 09:03:01+00	\N	\N	pf_156
87	2023-09-21 15:14:09.233586+00	2023-09-21 15:16:01.321554+00	VALIDATED	IDENTITY_PROOF	4090700731	273	2023-09-21 15:16:00+00	\N	\N	pf_273
81	2023-09-05 21:37:00.61033+00	2023-09-05 21:39:02.353474+00	REFUSED	IDENTITY_PROOF	4024904944	263	2023-09-05 21:39:02+00	\N	DOCUMENT_NOT_ACCEPTED	pf_263
80	2023-09-04 20:33:11.039073+00	2023-09-05 22:45:16.289803+00	REFUSED	IDENTITY_PROOF	4020721420	230	2023-09-04 21:43:00+00	\N	DOCUMENT_HAS_EXPIRED	pf_230
101	2023-09-30 18:57:41.146362+00	2023-09-30 18:58:02.165995+00	VALIDATED	IDENTITY_PROOF	4133145152	290	2023-09-30 18:58:01+00	\N	\N	pf_290
82	2023-09-06 07:32:38.257239+00	2023-09-06 07:35:04.135864+00	VALIDATED	IDENTITY_PROOF	4025473452	266	2023-09-06 07:35:03+00	\N	\N	pf_266
88	2023-09-27 14:54:21.151935+00	2023-09-27 15:00:03.363408+00	VALIDATED	IDENTITY_PROOF	4117319884	106	2023-09-27 15:00:01+00	\N	\N	pf_106
83	2023-09-06 07:48:42.222439+00	2023-09-06 07:52:01.955961+00	VALIDATED	IDENTITY_PROOF	4025518921	266	2023-09-06 07:52:01+00	\N	\N	pj_24
79	2023-08-28 07:06:26.902881+00	2023-09-06 08:04:06.713094+00	VALIDATED	IDENTITY_PROOF	3988264346	196	2023-08-28 07:07:00+00	\N	\N	pf_196
78	2023-08-18 07:21:52.390923+00	2023-09-06 08:04:44.786807+00	VALIDATED	IDENTITY_PROOF	3952930825	193	2023-08-18 07:23:00+00	\N	\N	pf_193
77	2023-08-18 07:21:19.037231+00	2023-09-06 08:08:13.342041+00	VALIDATED	IDENTITY_PROOF	3952929660	184	2023-08-18 07:22:01+00	\N	\N	pf_184
76	2023-08-09 17:23:07.261123+00	2023-09-06 08:08:53.54274+00	REFUSED	IDENTITY_PROOF	3924326482	174	2023-08-09 17:27:00+00	\N	DOCUMENT_NOT_ACCEPTED	pf_174
75	2023-08-04 11:12:17.019078+00	2023-09-06 08:09:31.140506+00	VALIDATED	IDENTITY_PROOF	3905226232	191	2023-08-04 11:13:01+00	\N	\N	pf_191
74	2023-08-01 08:36:38.349149+00	2023-09-06 08:10:14.010406+00	VALIDATED	IDENTITY_PROOF	3893097913	178	2023-08-01 08:38:03+00	\N	\N	pf_178
73	2023-07-31 06:20:33.715544+00	2023-09-06 08:11:03.364538+00	VALIDATED	IDENTITY_PROOF	3889167474	157	2023-07-31 06:25:00+00	\N	\N	pf_157
94	2023-09-28 12:59:36.223277+00	2023-09-28 13:00:03.909216+00	VALIDATED	IDENTITY_PROOF	4121710089	159	2023-09-28 13:00:03+00	\N	\N	pf_159
89	2023-09-27 22:51:34.23527+00	2023-09-27 22:54:01.678632+00	REFUSED	IDENTITY_PROOF	4119635974	166	2023-09-27 22:54:01+00	\N	DOCUMENT_NOT_ACCEPTED	pf_166
90	2023-09-27 23:08:20.575037+00	2023-09-27 23:10:00.882149+00	REFUSED	IDENTITY_PROOF	4119651867	182	2023-09-27 23:10:00+00	\N	DOCUMENT_NOT_ACCEPTED	pf_182
102	2023-10-02 09:45:55.426427+00	2023-10-02 09:57:24.285501+00	VALIDATED	IDENTITY_PROOF	4138817951	291	2023-10-02 09:47:05+00	\N	\N	pf_291
95	2023-09-28 15:35:44.049239+00	2023-09-28 15:37:03.504613+00	VALIDATED	IDENTITY_PROOF	4122595094	276	2023-09-28 15:37:01+00	\N	\N	pf_276
112	2023-10-23 11:22:47.26727+00	2023-10-23 11:26:02.851385+00	VALIDATED	IDENTITY_PROOF	4235236697	333	2023-10-23 11:26:02+00	\N	\N	pf_333
96	2023-09-28 17:09:35.865763+00	2023-09-28 17:10:02.364396+00	VALIDATED	IDENTITY_PROOF	4123173369	278	2023-09-28 17:10:02+00	\N	\N	pf_278
108	2023-10-18 13:52:46.046209+00	2023-10-18 13:55:05.625175+00	VALIDATED	IDENTITY_PROOF	4212771150	313	2023-10-18 13:55:04+00	\N	\N	pf_313
103	2023-10-02 19:08:50.35255+00	2023-10-02 19:11:06.560039+00	VALIDATED	IDENTITY_PROOF	4141589472	153	2023-10-02 19:11:03+00	\N	\N	pf_153
97	2023-09-28 22:51:03.26961+00	2023-09-28 22:52:00.774307+00	VALIDATED	IDENTITY_PROOF	4124659310	282	2023-09-28 22:52:00+00	\N	\N	pf_282
98	2023-09-29 11:54:26.833868+00	2023-09-29 11:55:03.65263+00	VALIDATED	IDENTITY_PROOF	4126465461	289	2023-09-29 11:55:03+00	\N	\N	pf_289
104	2023-10-07 08:07:30.847244+00	2023-10-07 08:10:01.585031+00	VALIDATED	IDENTITY_PROOF	4162085319	192	2023-10-07 08:10:00+00	\N	\N	pf_192
99	2023-09-29 14:58:35.650273+00	2023-09-29 14:59:00.922071+00	VALIDATED	IDENTITY_PROOF	4127426146	148	2023-09-29 14:59:00+00	\N	\N	pf_148
118	2023-10-24 19:19:21.621461+00	2023-10-24 19:20:03.091112+00	VALIDATED	IDENTITY_PROOF	4242165514	177	2023-10-24 19:20:02+00	\N	\N	pf_177
100	2023-09-30 09:40:04.88889+00	2023-09-30 09:41:05.298975+00	VALIDATED	IDENTITY_PROOF	4130445063	108	2023-09-30 09:41:01+00	\N	\N	pf_108
109	2023-10-18 22:34:35.729044+00	2023-10-18 22:47:01.319236+00	REFUSED	IDENTITY_PROOF	4215376650	324	2023-10-18 22:47:00+00	\N	DOCUMENT_HAS_EXPIRED	pf_324
105	2023-10-17 20:41:38.508821+00	2023-10-17 20:53:16.393491+00	VALIDATED	IDENTITY_PROOF	4210182892	82	2023-10-17 20:43:00+00	\N	\N	pj_27
113	2023-10-23 14:33:28.966176+00	2023-10-23 14:34:00.474883+00	VALIDATED	IDENTITY_PROOF	4236138492	170	2023-10-23 14:34:00+00	\N	\N	pf_170
116	2023-10-24 09:35:01.349501+00	2023-10-24 09:37:18.347486+00	VALIDATED	IDENTITY_PROOF	4239306715	115	2023-10-24 09:37:02+00	\N	\N	pf_115
110	2023-10-19 10:42:48.696743+00	2023-10-19 10:44:01.541321+00	VALIDATED	IDENTITY_PROOF	4216682106	326	2023-10-19 10:44:00+00	\N	\N	pf_326
114	2023-10-23 16:20:59.967906+00	2023-10-23 16:22:05.819943+00	VALIDATED	IDENTITY_PROOF	4236751302	334	2023-10-23 16:22:05+00	\N	\N	pf_334
111	2023-10-22 22:12:01.390745+00	2023-10-22 22:13:02.153611+00	VALIDATED	IDENTITY_PROOF	4233819405	332	2023-10-22 22:13:01+00	\N	\N	pf_332
120	2023-10-27 22:35:03.513294+00	2023-10-27 22:36:00.585444+00	VALIDATED	IDENTITY_PROOF	4257603742	321	2023-10-27 22:36:00+00	\N	\N	pf_321
117	2023-10-24 10:20:23.071347+00	2023-10-24 10:26:26.073559+00	REFUSED	IDENTITY_PROOF	4239504119	310	2023-10-24 10:23:02+00	\N	DOCUMENT_UNREADABLE	pf_310
115	2023-10-23 16:31:22.330841+00	2023-10-23 16:32:12.355042+00	VALIDATED	IDENTITY_PROOF	4236810972	145	2023-10-23 16:32:01+00	\N	\N	pf_145
119	2023-10-27 16:20:23.316646+00	2023-10-27 16:21:03.750695+00	VALIDATED	IDENTITY_PROOF	4256027987	331	2023-10-27 16:21:03+00	\N	\N	pf_331
124	2023-10-30 11:01:19.503611+00	2023-10-30 11:02:14.823409+00	VALIDATED	IDENTITY_PROOF	4266953526	328	2023-10-30 11:02:14+00	\N	\N	pf_328
122	2023-10-29 11:33:35.891507+00	2023-10-29 11:35:04.076639+00	VALIDATED	IDENTITY_PROOF	4263060966	337	2023-10-29 11:35:03+00	\N	\N	pf_337
121	2023-10-28 16:58:19.572177+00	2023-10-28 17:00:01.411608+00	REFUSED	IDENTITY_PROOF	4260735051	336	2023-10-28 17:00:00+00	\N	DOCUMENT_HAS_EXPIRED	pf_336
123	2023-10-29 23:37:03.643152+00	2023-10-29 23:38:01.500233+00	VALIDATED	IDENTITY_PROOF	4265866412	330	2023-10-29 23:38:00+00	\N	\N	pf_330
125	2023-10-31 10:19:00.656331+00	2023-10-31 10:20:03.973557+00	VALIDATED	IDENTITY_PROOF	4271359362	172	2023-10-31 10:20:03+00	\N	\N	pf_172
126	2023-10-31 12:13:39.618601+00	2023-10-31 12:15:00.689675+00	REFUSED	IDENTITY_PROOF	4271874265	110	2023-10-31 12:15:00+00	\N	DOCUMENT_UNREADABLE	pf_110
127	2023-10-31 17:31:05.264486+00	2023-10-31 17:37:00.45038+00	REFUSED	IDENTITY_PROOF	4273378217	339	2023-10-31 17:37:00+00	Sorry, we are unable to process your document due to a technical issue. Please try again later on	SPECIFIC_CASE	pf_339
128	2023-11-01 14:09:03.616047+00	2023-11-01 14:12:04.648275+00	VALIDATED	IDENTITY_PROOF	4276586891	119	2023-11-01 14:12:03+00	\N	\N	pf_119
129	2023-11-02 10:12:53.413397+00	2023-11-02 10:14:03.152744+00	VALIDATED	IDENTITY_PROOF	4280016974	275	2023-11-02 10:14:02+00	\N	\N	pf_275
130	2023-11-03 10:46:48.828965+00	2023-11-03 10:48:03.847994+00	VALIDATED	IDENTITY_PROOF	4285265358	105	2023-11-03 10:48:03+00	\N	\N	pf_105
131	2023-11-03 15:59:48.601992+00	2023-11-03 16:01:12.309096+00	VALIDATED	IDENTITY_PROOF	4287009297	297	2023-11-03 16:01:09+00	\N	\N	pf_297
132	2023-11-04 09:29:14.102162+00	2023-11-04 09:32:02.111117+00	REFUSED	IDENTITY_PROOF	4289756433	342	2023-11-04 09:32:01+00	\N	DOCUMENT_NOT_ACCEPTED	pf_342
133	2023-11-09 06:47:17.007118+00	2023-11-09 06:48:01.239578+00	VALIDATED	IDENTITY_PROOF	4313916654	114	2023-11-09 06:48:00+00	\N	\N	pf_114
134	2023-11-10 19:29:28.265218+00	2023-11-10 19:31:05.416606+00	REFUSED	IDENTITY_PROOF	4323592374	307	2023-11-10 19:31:05+00	\N	DOCUMENT_NOT_ACCEPTED	pf_307
135	2023-11-11 10:55:14.010758+00	2023-11-11 10:56:01.780102+00	VALIDATED	IDENTITY_PROOF	4325649794	23	2023-11-11 10:56:01+00	\N	\N	pj_29
136	2023-11-15 14:40:57.372592+00	2023-11-15 14:43:04.231868+00	REFUSED	IDENTITY_PROOF	4345817050	342	2023-11-15 14:43:03+00	\N	DOCUMENT_UNREADABLE	pj_30
137	2023-11-20 19:13:50.470067+00	2023-11-20 19:15:10.123496+00	VALIDATED	IDENTITY_PROOF	4371678283	345	2023-11-20 19:15:09+00	\N	\N	pf_345
\.


--
-- Data for Name: mangopay_mangopaytransfer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mangopay_mangopaytransfer (from_user_id, to_user_id, basemangopaytransaction_ptr_id, from_cod, to_cod, total_amount) FROM stdin;
28	23	70	pf_28	pf_23	\N
28	23	69	pf_28	pf_23	\N
92	92	80	pf_28	pf_28	\N
92	92	81	pf_28	pf_28	\N
92	92	82	pf_28	pf_28	\N
28	28	156	pf_28	pf_28	\N
28	196	160	pf_28	pf_196	\N
82	324	244	pf_82	pf_324	\N
28	196	159	pf_28	pf_196	\N
82	324	271	\N	\N	\N
82	324	243	pf_82	pf_324	\N
28	196	161	pf_28	pf_196	\N
82	324	257	pf_82	pf_324	\N
28	196	162	pf_28	pf_196	\N
28	82	221	pf_28	pf_82	\N
28	82	222	\N	\N	\N
28	196	163	pf_28	pf_196	\N
28	196	223	pf_28	pf_196	\N
28	196	224	\N	\N	\N
28	28	157	pf_28	pf_28	\N
324	28	294	\N	\N	\N
28	196	158	pf_28	pf_196	\N
28	196	165	pf_28	pf_196	\N
28	196	166	pf_28	pf_196	\N
82	324	259	\N	\N	\N
196	324	313	\N	\N	\N
82	324	239	pf_82	pf_324	\N
82	324	240	\N	\N	\N
82	324	241	pf_82	pf_324	\N
82	324	242	\N	\N	\N
28	196	175	pf_28	pf_196	\N
28	196	176	\N	\N	\N
23	82	177	pf_23	pf_82	\N
23	82	178	\N	\N	\N
28	82	181	pf_28	pf_82	\N
28	82	182	\N	\N	\N
82	324	275	\N	\N	\N
28	82	185	pf_28	pf_82	\N
28	82	186	\N	\N	\N
196	324	295	\N	\N	\N
28	82	191	pf_28	pf_82	\N
28	82	192	\N	\N	\N
28	324	193	pf_28	pf_324	\N
28	324	194	\N	\N	\N
196	324	195	pf_196	pf_324	\N
196	324	196	\N	\N	\N
196	324	197	pf_196	pf_324	\N
196	324	198	\N	\N	\N
82	324	260	\N	\N	\N
28	196	201	pf_28	pf_196	\N
28	196	202	\N	\N	\N
28	324	203	pf_28	pf_324	\N
28	324	204	\N	\N	\N
82	324	261	\N	\N	\N
196	324	315	\N	\N	\N
196	324	278	\N	\N	\N
324	82	245	pf_324	pf_82	\N
196	324	279	\N	\N	\N
82	324	248	pf_82	pf_324	\N
82	324	249	pf_82	pf_324	\N
82	324	262	\N	\N	\N
196	324	326	\N	\N	\N
82	324	250	pf_82	pf_324	\N
28	196	280	\N	\N	\N
82	324	263	\N	\N	\N
82	324	254	pf_82	pf_324	\N
82	324	264	\N	\N	\N
82	324	255	pf_82	pf_324	\N
82	324	256	pf_82	pf_324	\N
196	324	302	\N	\N	\N
82	324	266	\N	\N	\N
82	324	286	\N	\N	\N
9	324	328	pj_3	pf_324	\N
82	324	267	\N	\N	\N
196	82	287	\N	\N	\N
324	82	268	\N	\N	\N
324	196	303	\N	\N	\N
82	324	270	\N	\N	\N
196	324	304	\N	\N	\N
196	324	305	\N	\N	\N
196	28	288	\N	\N	\N
9	324	329	pj_3	pf_324	\N
196	28	289	\N	\N	\N
196	28	291	\N	\N	\N
324	196	293	\N	\N	\N
196	324	306	\N	\N	\N
324	196	307	\N	\N	\N
196	324	308	\N	\N	\N
196	324	310	\N	\N	\N
\.


--
-- Data for Name: mangopay_mangopayuser; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mangopay_mangopayuser (id, created, modified, mangopay_id, user_id, kyc_level, cod) FROM stdin;
20	2023-04-11 16:22:49.810162+00	2023-09-07 09:04:55.087643+00	3477951019	80	REGULAR	pf_80
19	2023-03-31 15:13:14.135227+00	2023-09-07 09:06:08.521342+00	3439760776	79	REGULAR	pf_79
18	2023-03-30 10:21:20.027635+00	2023-09-07 09:06:44.374951+00	3434465537	78	LIGHT	pf_78
17	2023-02-28 00:23:10.172475+00	2023-09-07 09:07:25.420124+00	3326433997	74	REGULAR	pj_13
16	2023-01-30 17:22:07.395492+00	2023-09-07 09:07:55.964539+00	3233355829	69	REGULAR	pf_69
14	2022-10-19 06:56:18.17761+00	2023-09-07 09:08:33.750349+00	2886689260	29	REGULAR	pf_65
13	2022-10-17 10:45:48.572416+00	2023-09-07 09:09:15.949181+00	2880189639	39	REGULAR	pj_10
15	2023-01-04 00:15:48.338979+00	2023-09-07 09:09:39.012686+00	3148198904	65	REGULAR	pf_65
12	2022-10-07 16:34:10.119762+00	2023-09-07 09:10:14.22265+00	2355375249	32	REGULAR	pf_32
11	2022-09-29 15:42:57.734351+00	2023-09-07 09:10:48.326056+00	2812129678	23	REGULAR	pf_23
10	2022-09-29 10:15:38.695752+00	2023-09-07 09:11:21.556986+00	2810660046	28	REGULAR	pf_28
9	2022-09-27 11:42:40.677022+00	2023-09-07 09:11:52.527071+00	2803131902	26	REGULAR	pj_8
8	2022-09-27 10:41:38.029738+00	2023-09-07 09:12:36.740313+00	2802916064	24	REGULAR	pf_25
7	2022-09-27 09:50:18.441782+00	2023-09-07 09:13:13.443271+00	2802738531	25	LIGHT	pf_25
6	2022-09-19 10:11:49.062866+00	2023-09-07 09:13:55.539096+00	2774186715	20	LIGHT	pf_20
5	2022-08-09 18:06:29.282931+00	2023-09-07 09:14:35.766476+00	2257260119	14	REGULAR	pf_14
4	2022-08-09 17:51:00.169447+00	2023-09-07 09:15:18.469235+00	2090465211	13	REGULAR	pf_13
1	2022-08-09 14:53:26.245105+00	2023-09-07 09:18:46.182806+00	2171475481	10	REGULAR	pj_1
2	2022-08-09 14:57:49.709267+00	2023-09-07 09:19:18.407613+00	2259419535	11	REGULAR	pj_2
3	2022-08-09 17:46:05.385141+00	2023-09-07 09:19:41.992827+00	2136007832	9	REGULAR	pj_3
97	2023-09-15 14:38:40.155429+00	2023-09-15 14:38:40.155429+00	4064623744	13	LIGHT	pj_4
44	2023-06-21 11:09:17.863107+00	2023-06-21 11:09:17.863107+00	3752048940	132	LIGHT	
98	2023-09-16 07:06:31.293458+00	2023-09-16 07:06:31.293458+00	4067021164	28	LIGHT	pj_25
99	2023-09-21 15:14:08.871807+00	2023-09-21 15:16:01.413447+00	4090700713	273	REGULAR	pf_273
73	2023-07-20 22:12:32.54186+00	2023-10-27 14:03:04.350066+00	3856609779	158	REGULAR	pf_158
86	2023-08-09 17:23:07.041675+00	2023-11-15 14:46:05.154197+00	3924326480	174	REGULAR	pf_174
52	2023-06-26 21:19:38.719482+00	2023-06-26 21:19:38.719482+00	3771996067	137	LIGHT	
53	2023-06-26 21:45:13.669751+00	2023-06-26 21:45:13.669751+00	3772055296	138	LIGHT	
54	2023-06-27 09:34:28.380098+00	2023-06-27 09:34:28.380098+00	3772956281	139	LIGHT	
22	2023-04-21 10:26:40.600779+00	2023-09-03 15:18:40.81032+00	3514858754	4	REGULAR	pf_4
91	2023-09-04 20:33:10.764381+00	2023-09-04 20:33:10.764381+00	4020721385	230	LIGHT	pf_230
92	2023-09-05 21:37:00.262944+00	2023-09-05 21:37:00.262944+00	4024904940	263	LIGHT	pf_263
93	2023-09-06 07:32:37.646815+00	2023-09-06 07:35:08.558794+00	4025473421	266	REGULAR	pf_266
94	2023-09-06 07:48:42.029913+00	2023-09-06 07:48:42.029913+00	4025518919	266	LIGHT	pj_24
95	2023-09-06 08:47:28.67739+00	2023-09-06 08:48:06.153697+00	4025710314	267	REGULAR	pf_267
96	2023-09-06 11:00:42.970344+00	2023-09-06 11:03:11.053102+00	4026240187	268	REGULAR	pf_268
90	2023-08-28 07:06:26.646418+00	2023-09-07 07:38:33.890385+00	3988264340	196	REGULAR	pf_196
89	2023-08-18 07:21:52.282042+00	2023-09-07 07:39:03.827222+00	3952930820	193	REGULAR	pf_193
88	2023-08-18 07:21:18.935445+00	2023-09-07 07:40:06.307345+00	3952929656	184	REGULAR	pf_184
85	2023-08-04 11:12:16.760225+00	2023-09-07 07:41:28.95555+00	3905226221	191	REGULAR	pf_191
84	2023-08-01 08:36:37.755271+00	2023-09-07 07:42:11.059095+00	3893097908	178	REGULAR	pf_178
83	2023-07-31 06:20:33.526311+00	2023-09-07 07:42:45.968524+00	3889167471	157	REGULAR	pf_157
82	2023-07-31 06:19:59.994201+00	2023-09-07 07:43:24.278409+00	3889166481	163	REGULAR	pf_163
81	2023-07-31 06:19:27.325139+00	2023-09-07 07:43:58.750567+00	3889165762	164	REGULAR	pf_164
80	2023-07-28 17:38:16.352872+00	2023-09-07 07:44:37.588991+00	3882197307	165	REGULAR	pf_165
79	2023-07-28 13:16:35.005662+00	2023-09-07 07:45:58.790941+00	3881066280	190	REGULAR	pf_190
77	2023-07-28 04:41:34.581458+00	2023-09-07 07:46:32.083595+00	3879458379	186	REGULAR	pf_186
76	2023-07-28 04:40:06.054844+00	2023-09-07 07:47:07.645424+00	3879457572	168	REGULAR	pf_168
75	2023-07-28 04:39:43.051651+00	2023-09-07 07:51:58.620397+00	3879457393	116	REGULAR	pf_116
74	2023-07-21 10:23:46.664275+00	2023-09-07 07:52:24.374386+00	3857610374	189	REGULAR	pf_189
71	2023-07-20 22:11:47.04822+00	2023-09-07 07:54:09.194964+00	3856608741	188	REGULAR	pf_188
70	2023-07-20 22:11:21.77887+00	2023-09-07 07:54:44.823204+00	3856608174	160	REGULAR	pf_160
69	2023-07-20 22:10:46.342529+00	2023-09-07 07:55:55.988858+00	3856607364	185	REGULAR	pf_185
68	2023-07-20 07:45:03.324376+00	2023-09-07 07:56:26.730802+00	3853541922	183	REGULAR	pf_183
67	2023-07-19 13:39:16.774827+00	2023-09-07 07:57:06.215374+00	3851138905	167	REGULAR	pf_167
66	2023-07-19 05:17:05.116132+00	2023-09-07 07:57:54.606526+00	3849682113	154	REGULAR	pf_154
65	2023-07-19 05:16:53.495987+00	2023-09-07 07:58:34.004355+00	3849681967	179	REGULAR	pf_179
64	2023-07-19 05:16:26.793016+00	2023-09-07 07:59:06.420087+00	3849681618	175	REGULAR	pf_175
63	2023-07-18 13:53:40.105718+00	2023-09-07 07:59:44.692288+00	3847828283	171	REGULAR	pf_171
62	2023-07-18 13:53:23.692471+00	2023-09-07 08:00:17.518395+00	3847827568	173	REGULAR	pf_173
61	2023-07-18 09:29:26.181166+00	2023-09-07 08:00:59.026783+00	3846946868	152	REGULAR	pf_152
60	2023-07-17 10:22:52.956804+00	2023-09-07 08:01:28.819212+00	3843709498	107	LIGHT	pf_107
59	2023-07-17 10:22:41.544997+00	2023-09-07 08:03:21.708967+00	3843708915	112	REGULAR	pf_112
58	2023-07-17 06:48:37.066446+00	2023-09-07 08:04:00.364711+00	3843110666	147	REGULAR	pf_147
57	2023-07-17 06:48:24.007027+00	2023-09-07 08:05:12.391972+00	3843110320	150	REGULAR	pf_150
56	2023-07-14 16:44:03.483736+00	2023-09-07 08:05:45.364281+00	3836262915	111	REGULAR	pf_111
55	2023-07-14 06:16:55.90724+00	2023-09-07 08:06:22.925582+00	3834139373	144	REGULAR	pf_144
51	2023-06-23 09:38:00.189124+00	2023-09-07 08:13:21.166909+00	3759606629	136	REGULAR	pf_136
50	2023-06-23 08:12:15.165712+00	2023-09-07 08:13:55.620772+00	3759278608	126	REGULAR	pf_126
49	2023-06-22 10:15:41.121562+00	2023-09-07 08:14:39.394061+00	3755655214	135	REGULAR	pf_135
48	2023-06-22 08:11:34.895188+00	2023-09-07 08:15:39.899532+00	3755346446	133	REGULAR	pf_133
47	2023-06-22 08:11:13.381844+00	2023-09-07 08:18:39.77673+00	3755345456	134	REGULAR	pf_134
45	2023-06-21 14:49:30.851383+00	2023-09-07 08:19:26.664389+00	3752983257	125	REGULAR	pf_125
43	2023-06-21 11:08:43.87935+00	2023-09-07 08:40:53.414524+00	3752046788	131	LIGHT	pf_131
42	2023-06-20 13:16:46.694371+00	2023-09-07 08:41:36.927566+00	3748629125	100	REGULAR	pf_100
41	2023-06-19 12:06:43.11623+00	2023-09-07 08:42:16.846522+00	3744139894	124	LIGHT	pf_124
40	2023-06-19 06:01:59.644706+00	2023-09-07 08:43:27.035316+00	3742947774	122	REGULAR	pf_122
39	2023-06-18 15:26:47.262603+00	2023-09-07 08:44:23.597625+00	3741355354	121	REGULAR	pf_121
38	2023-06-15 09:20:10.740143+00	2023-09-07 08:44:56.019406+00	3728696121	98	REGULAR	pf_98
37	2023-06-15 09:14:51.056919+00	2023-09-07 08:47:40.384024+00	3728672415	118	REGULAR	pf_118
36	2023-06-15 05:56:38.035238+00	2023-09-07 08:48:10.704302+00	3728077038	109	REGULAR	pf_109
33	2023-06-14 08:28:28.895364+00	2023-09-07 08:48:44.536126+00	3724090664	96	REGULAR	pf_120
32	2023-06-14 08:27:44.514581+00	2023-09-07 08:49:44.390812+00	3724088000	101	REGULAR	pf_101
35	2023-06-14 12:46:08.186991+00	2023-09-07 08:51:04.919431+00	3725185266	120	REGULAR	pf_120
31	2023-06-14 08:27:27.30258+00	2023-09-07 08:51:37.638926+00	3724086883	113	REGULAR	pf_113
30	2023-06-14 08:25:47.940887+00	2023-09-07 08:52:16.534812+00	3724080696	99	REGULAR	pf_99
29	2023-06-09 15:29:34.617098+00	2023-09-07 08:53:54.587288+00	3706315808	87	REGULAR	pf_87
28	2023-05-31 06:22:05.117444+00	2023-09-07 08:55:48.845263+00	3665930963	90	REGULAR	pf_90
27	2023-05-26 10:17:59.078575+00	2023-09-07 08:56:55.026979+00	3648345107	89	REGULAR	pf_89
26	2023-05-09 10:20:03.541795+00	2023-09-07 09:01:53.739191+00	3581305195	86	REGULAR	pf_86
25	2023-05-03 13:27:49.047211+00	2023-09-07 09:02:33.160689+00	3558814212	85	REGULAR	pf_85
23	2023-04-26 17:27:02.809045+00	2023-09-07 09:03:05.817544+00	3534551508	84	REGULAR	pf_84
21	2023-04-16 01:14:49.037017+00	2023-09-07 09:04:18.224383+00	3495266247	82	REGULAR	pf_82
100	2023-09-27 14:54:20.968595+00	2023-09-27 15:00:02.988687+00	4117319817	106	REGULAR	pf_106
101	2023-09-27 22:51:33.808166+00	2023-09-27 22:51:33.808166+00	4119635972	166	LIGHT	pf_166
102	2023-09-27 23:08:20.425336+00	2023-09-27 23:08:20.425336+00	4119651866	182	LIGHT	pf_182
103	2023-09-27 23:11:34.518972+00	2023-09-27 23:12:00.563812+00	4119654411	277	REGULAR	pf_277
105	2023-09-28 09:02:08.846711+00	2023-09-28 09:03:01.284344+00	4120534307	156	REGULAR	pf_156
106	2023-09-28 12:59:35.860072+00	2023-09-28 13:00:04.081242+00	4121710079	159	REGULAR	pf_159
107	2023-09-28 15:35:43.677279+00	2023-09-28 15:37:03.802676+00	4122595065	276	REGULAR	pf_276
108	2023-09-28 17:09:35.322669+00	2023-09-28 17:10:02.467804+00	4123173351	278	REGULAR	pf_278
109	2023-09-28 22:51:02.888931+00	2023-09-28 22:52:00.507144+00	4124659309	282	REGULAR	pf_282
110	2023-09-29 11:54:26.331841+00	2023-09-29 11:55:03.739658+00	4126465445	289	REGULAR	pf_289
111	2023-09-29 14:58:35.263361+00	2023-09-29 14:59:00.584911+00	4127426138	148	REGULAR	pf_148
112	2023-09-30 09:40:04.484534+00	2023-09-30 09:41:05.38498+00	4130445036	108	REGULAR	pf_108
113	2023-09-30 18:57:40.811581+00	2023-09-30 18:58:02.275413+00	4133145133	290	REGULAR	pf_290
114	2023-10-02 09:45:55.05646+00	2023-10-02 09:57:27.268108+00	4138817945	291	REGULAR	pf_291
115	2023-10-02 19:08:50.010788+00	2023-10-02 19:11:07.898948+00	4141589405	153	REGULAR	pf_153
116	2023-10-07 08:07:30.457039+00	2023-10-07 08:10:01.229064+00	4162085299	192	REGULAR	pf_192
117	2023-10-17 20:41:38.119079+00	2023-10-17 20:41:38.119079+00	4210182885	82	LIGHT	pj_27
118	2023-10-18 10:23:10.137449+00	2023-10-18 10:25:12.49045+00	4211694626	318	LIGHT	pf_318
119	2023-10-18 10:24:36.02989+00	2023-10-18 10:25:13.290961+00	4211700269	316	LIGHT	pf_316
120	2023-10-18 13:52:45.8465+00	2023-10-18 13:55:05.344844+00	4212771144	313	REGULAR	pf_313
121	2023-10-18 22:34:35.352872+00	2023-10-18 22:34:35.352872+00	4215376646	324	LIGHT	pf_324
122	2023-10-19 10:42:48.308482+00	2023-10-19 10:44:01.099119+00	4216682086	326	REGULAR	pf_326
123	2023-10-22 22:12:01.020103+00	2023-10-22 22:13:02.275632+00	4233819399	332	REGULAR	pf_332
124	2023-10-23 11:22:46.86589+00	2023-10-23 11:26:02.924503+00	4235236692	333	REGULAR	pf_333
125	2023-10-23 14:33:28.570034+00	2023-10-23 14:34:00.561811+00	4236138488	170	REGULAR	pf_170
126	2023-10-23 16:20:59.787989+00	2023-10-23 16:22:05.911712+00	4236751296	334	REGULAR	pf_334
127	2023-10-23 16:31:22.137543+00	2023-10-23 16:32:12.063649+00	4236810965	145	REGULAR	pf_145
128	2023-10-24 09:35:00.938984+00	2023-10-24 09:37:18.469621+00	4239306701	115	REGULAR	pf_115
130	2023-10-24 19:19:21.405375+00	2023-10-24 19:20:03.164258+00	4242165512	177	REGULAR	pf_177
131	2023-10-26 20:20:32.329042+00	2023-10-26 20:20:32.329042+00	4211694626	318	LIGHT	pf_318
132	2023-10-27 16:20:22.905218+00	2023-10-27 16:21:03.852041+00	4256027971	331	REGULAR	pf_331
133	2023-10-27 22:35:03.113622+00	2023-10-27 22:36:00.657231+00	4257603739	321	REGULAR	pf_321
134	2023-10-28 16:58:19.199444+00	2023-10-28 16:58:19.199444+00	4260735048	336	LIGHT	pf_336
135	2023-10-29 11:33:35.555333+00	2023-10-29 11:35:03.816591+00	4263060954	337	REGULAR	pf_337
104	2023-09-28 07:03:19.68185+00	2023-10-29 16:42:01.555002+00	4120085458	279	REGULAR	pf_279
136	2023-10-29 23:37:03.258926+00	2023-10-29 23:38:01.151181+00	4265866409	330	REGULAR	pf_330
137	2023-10-30 11:01:19.143997+00	2023-10-30 11:02:14.922973+00	4266953509	328	REGULAR	pf_328
138	2023-10-31 10:19:00.261036+00	2023-10-31 10:20:04.050573+00	4271359354	172	REGULAR	pf_172
140	2023-10-31 17:31:04.868353+00	2023-10-31 17:31:04.868353+00	4273378163	339	LIGHT	pf_339
141	2023-11-01 14:09:03.244702+00	2023-11-01 14:12:04.371821+00	4276586884	119	REGULAR	pf_119
129	2023-10-24 10:20:22.863185+00	2023-11-02 10:06:06.777879+00	4239504107	310	REGULAR	pf_310
142	2023-11-02 10:12:53.083012+00	2023-11-02 10:14:03.232998+00	4280016959	275	REGULAR	pf_275
143	2023-11-03 10:46:48.608067+00	2023-11-03 10:48:04.039024+00	4285265349	105	REGULAR	pf_105
144	2023-11-03 15:59:48.403983+00	2023-11-03 16:01:12.65968+00	4287009286	297	REGULAR	pf_297
139	2023-10-31 12:13:39.39918+00	2023-11-08 21:01:04.413437+00	4271874258	110	REGULAR	pf_110
146	2023-11-09 06:47:16.600036+00	2023-11-09 06:48:01.338588+00	4313916653	114	REGULAR	pf_114
147	2023-11-10 19:29:27.865452+00	2023-11-10 19:29:27.865452+00	4323592369	307	LIGHT	pf_307
145	2023-11-04 09:29:13.919904+00	2023-11-10 23:20:01.18736+00	4289756428	342	REGULAR	pf_342
148	2023-11-11 10:55:13.824737+00	2023-11-11 10:55:13.824737+00	4325649786	23	LIGHT	pj_29
149	2023-11-15 14:40:57.172186+00	2023-11-15 14:40:57.172186+00	4345817037	342	LIGHT	pj_30
150	2023-11-20 19:13:50.048124+00	2023-11-20 19:15:10.211002+00	4371678270	345	REGULAR	pf_345
\.


--
-- Data for Name: mangopay_mangopaywallet; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mangopay_mangopaywallet (id, created, modified, wallet_id, user_id, amount, cod) FROM stdin;
72	2023-09-04 20:33:13.349624+00	2023-09-04 20:33:13.349624+00	4020721509	230	0.00	pf_230
73	2023-09-05 21:37:02.99227+00	2023-09-05 21:37:02.99227+00	4024905002	263	0.00	pf_263
74	2023-09-06 07:32:39.742129+00	2023-09-06 07:32:39.742129+00	4025473894	266	0.00	pf_266
76	2023-09-06 08:47:30.374216+00	2023-09-06 08:47:30.374216+00	4025710398	267	0.00	pf_267
77	2023-09-06 11:00:54.762045+00	2023-09-06 11:00:54.762045+00	4026241169	268	0.00	pf_268
1	2022-08-09 14:53:55.039949+00	2023-09-07 12:56:09.818957+00	2183524761	10	0.00	pj_1
15	2023-04-04 12:48:58.087999+00	2023-09-07 12:57:04.153149+00	3453248801	74	0.00	pj_13
66	2023-07-31 06:25:01.240437+00	2023-09-07 12:57:50.145204+00	3889173343	157	0.00	pf_157
2	2022-08-09 14:58:13.43809+00	2023-09-07 19:55:08.331574+00	2272299627	11	0.00	pj_2
34	2023-06-19 06:04:02.817113+00	2023-11-16 07:45:46.573716+00	3742950998	122	500.00	pf_122
83	2023-09-27 23:08:21.995808+00	2023-09-27 23:08:21.995808+00	4119651882	182	0.00	pf_182
5	2022-09-27 10:42:02.434225+00	2023-09-07 19:57:34.547029+00	2802917624	24	0.00	pf_25
27	2023-06-14 08:29:02.553994+00	2023-09-17 22:37:38.741913+00	3724092582	96	0.00	pf_96
71	2023-08-28 07:07:00.403479+00	2023-11-14 22:27:03.973299+00	3988265489	196	8.14	pf_196
8	2022-10-07 16:39:06.153244+00	2023-09-07 19:59:16.297514+00	2355378571	32	42.00	pf_32
9	2023-01-04 00:17:01.106207+00	2023-09-07 19:59:38.94938+00	3148199663	65	0.00	pf_65
10	2023-01-24 14:02:43.685484+00	2023-09-07 20:00:16.779185+00	3212653195	29	0.00	pj_9
11	2023-01-24 14:03:31.17947+00	2023-09-07 20:01:07.846597+00	3212655632	39	0.00	pj_10
12	2023-01-30 17:23:02.449695+00	2023-09-07 20:01:37.579271+00	3233359022	69	0.00	pf_69
25	2023-06-14 08:28:01.964895+00	2023-09-18 11:57:27.014878+00	3724088989	99	0.00	pf_99
14	2023-04-04 12:48:19.106386+00	2023-09-07 20:02:38.127035+00	3453246620	26	0.00	pj_8
16	2023-04-11 16:24:04.678882+00	2023-09-07 20:03:08.413119+00	3477956084	80	0.00	pf_80
13	2023-03-31 15:14:06.321624+00	2023-09-17 22:58:15.777918+00	2129022975	79	10.00	pf_79
18	2023-04-21 10:28:01.701469+00	2023-09-07 20:03:57.540162+00	3514863625	4	0.00	pf_4
19	2023-05-03 13:29:06.608125+00	2023-09-07 20:04:28.74253+00	3558818802	85	0.00	pf_85
79	2023-09-21 15:14:10.458522+00	2023-09-21 15:14:10.458522+00	4090700912	273	0.00	pf_273
21	2023-05-10 14:26:36.716251+00	2023-09-07 20:06:00.105951+00	3586385208	84	0.00	pj_14
22	2023-05-26 10:23:04.606763+00	2023-09-07 20:06:25.564799+00	3648366712	89	500.00	pf_89
23	2023-05-31 06:23:02.316055+00	2023-09-07 20:07:01.108322+00	3665933042	90	700.00	pf_90
24	2023-06-09 15:31:08.595737+00	2023-09-07 20:07:23.222476+00	3706324342	87	505.00	pf_87
35	2023-06-20 13:18:05.042108+00	2023-09-18 12:54:01.176885+00	3748634000	100	0.00	pf_100
26	2023-06-14 08:28:02.879863+00	2023-09-07 20:08:20.140724+00	3724089072	113	0.00	pf_113
28	2023-06-14 08:30:01.453122+00	2023-09-18 12:56:04.17663+00	3724095741	101	0.00	pf_101
75	2023-09-06 07:48:43.522525+00	2023-10-08 10:10:19.110136+00	4025518988	266	0.00	pj_24
29	2023-06-14 12:48:01.887248+00	2023-09-07 20:09:41.130628+00	3725196015	120	500.00	pf_120
30	2023-06-15 05:58:01.744771+00	2023-09-07 20:10:09.798196+00	3728079749	109	0.00	pf_109
31	2023-06-15 09:22:01.489563+00	2023-09-07 20:11:52.615622+00	3728703638	118	0.00	pf_118
32	2023-06-15 09:26:04.693114+00	2023-09-18 12:23:09.979195+00	3728719820	98	0.00	pf_98
33	2023-06-18 15:28:08.013908+00	2023-09-07 20:12:48.859027+00	3741359730	121	0.00	pf_121
80	2023-09-27 14:49:02.205559+00	2023-09-27 14:49:02.205559+00	4117285839	174	0.00	pf_174
36	2023-06-21 14:51:04.45943+00	2023-09-07 20:13:57.544373+00	3752991257	125	500.00	pf_125
37	2023-06-22 08:12:00.365089+00	2023-09-07 20:14:26.488735+00	3755347935	134	500.00	pf_134
38	2023-06-22 08:24:04.18679+00	2023-09-07 20:14:57.272421+00	3755387848	133	3.00	pf_133
39	2023-06-22 10:17:01.852804+00	2023-09-07 20:15:23.411203+00	3755658273	135	200.00	pf_135
40	2023-06-23 08:13:04.57931+00	2023-09-07 20:15:56.34352+00	3759281293	126	415.00	pf_126
41	2023-06-26 05:34:01.389064+00	2023-09-07 20:16:30.562291+00	3768679305	136	100.00	pf_136
42	2023-07-14 06:18:01.056937+00	2023-09-07 20:16:51.489318+00	3834141016	144	100.00	pf_144
43	2023-07-14 16:45:03.256816+00	2023-09-07 20:17:14.304505+00	3836265931	111	0.00	pf_111
44	2023-07-17 06:49:00.425506+00	2023-09-07 20:17:41.793634+00	3843111328	150	0.00	pf_150
45	2023-07-17 06:50:04.328664+00	2023-09-07 20:18:18.59564+00	3843113151	147	0.00	pf_147
46	2023-07-17 10:26:04.358728+00	2023-09-07 20:18:44.991821+00	3843719299	112	0.00	pf_112
47	2023-07-18 09:30:01.179649+00	2023-09-07 20:19:07.188415+00	3846948925	152	100.00	pf_152
48	2023-07-18 13:55:02.498085+00	2023-09-07 20:19:32.798125+00	3847832430	171	0.00	pf_171
49	2023-07-18 13:55:03.058753+00	2023-09-07 20:19:55.815932+00	3847832454	173	0.00	pf_173
50	2023-07-19 05:17:01.051302+00	2023-09-07 20:20:17.551963+00	3849682058	175	0.00	pf_175
51	2023-07-19 05:18:01.059856+00	2023-09-07 20:20:57.26916+00	3849682888	154	0.00	pf_154
52	2023-07-19 05:18:01.85407+00	2023-09-07 20:21:21.659737+00	3849682895	179	0.00	pf_179
53	2023-07-19 13:40:04.483638+00	2023-09-07 20:21:43.637949+00	3851141295	167	0.00	pf_167
54	2023-07-20 07:47:15.748168+00	2023-09-07 20:22:20.937356+00	3853547583	183	0.00	pf_183
55	2023-07-20 22:12:02.834716+00	2023-09-07 20:22:45.306744+00	3856609126	185	0.00	pf_185
56	2023-07-20 22:12:03.247017+00	2023-10-30 22:21:25.943231+00	3856609135	160	0.00	pf_160
57	2023-07-20 22:16:03.414777+00	2023-09-07 20:23:28.567943+00	3856614582	188	0.00	pf_188
58	2023-07-21 10:25:01.257783+00	2023-09-07 20:23:53.458287+00	3857614813	189	0.00	pf_189
59	2023-07-28 04:41:00.977729+00	2023-09-07 20:24:13.214451+00	3879458128	168	0.00	pf_168
60	2023-07-28 04:41:01.392252+00	2023-09-07 20:24:34.499695+00	3879458130	116	0.00	pf_116
61	2023-07-28 04:43:00.569609+00	2023-09-07 20:25:10.328853+00	3879459185	186	0.00	pf_186
62	2023-07-28 13:18:08.028593+00	2023-09-07 20:25:34.178309+00	3881073976	190	0.00	pf_190
63	2023-07-28 17:39:07.996537+00	2023-09-07 20:25:54.603615+00	3882200397	165	0.00	pf_165
64	2023-07-31 06:20:12.238396+00	2023-09-07 20:26:13.815574+00	3889166841	164	0.00	pf_164
65	2023-07-31 06:21:00.549329+00	2023-09-07 20:26:33.134362+00	3889168076	163	0.00	pf_163
67	2023-08-01 08:38:05.908879+00	2023-09-07 20:27:32.641922+00	3893102801	178	0.00	pf_178
68	2023-08-04 11:13:19.551994+00	2023-09-07 20:27:55.250645+00	3905230899	191	100.00	pf_191
69	2023-08-18 07:22:05.524524+00	2023-09-07 20:28:16.563317+00	3952931371	184	0.00	pf_184
70	2023-08-18 07:23:00.582273+00	2023-09-07 20:28:37.681228+00	3952933348	193	0.00	pf_193
94	2023-09-30 18:57:42.486982+00	2023-10-31 12:02:54.219139+00	4133145219	290	0.00	pf_290
4	2022-08-09 17:51:26.826064+00	2023-10-15 22:40:06.614463+00	2129022975	13	10.00	pj_4
81	2023-09-27 14:54:22.790801+00	2023-09-27 14:54:22.790801+00	4117320059	106	0.00	pf_106
84	2023-09-27 23:11:35.958618+00	2023-09-27 23:11:35.958618+00	4119654425	277	0.00	pf_277
20	2023-05-09 10:21:03.51444+00	2023-09-15 13:55:17.290143+00	3581308779	86	0.00	pf_86
3	2022-08-09 17:46:31.458843+00	2023-11-15 14:53:01.446792+00	2183520461	9	3.00	pj_3
82	2023-09-27 22:51:35.533189+00	2023-09-27 22:51:35.533189+00	4119635987	166	0.00	pf_166
78	2023-09-16 07:06:33.324448+00	2023-09-16 07:06:33.324448+00	4067021326	28	0.00	pj_25
85	2023-09-28 07:03:24.336833+00	2023-09-28 07:03:24.336833+00	4120085687	279	0.00	pf_279
87	2023-09-28 12:59:37.713984+00	2023-10-30 22:30:54.807203+00	4121710244	159	0.00	pf_159
86	2023-09-28 09:02:10.748203+00	2023-09-28 09:02:10.748203+00	4120534409	156	0.00	pf_156
88	2023-09-28 15:35:45.657414+00	2023-09-28 15:35:45.657414+00	4122595297	276	0.00	pf_276
89	2023-09-28 17:09:37.081397+00	2023-09-28 17:09:37.081397+00	4123173427	278	0.00	pf_278
90	2023-09-28 22:51:04.583292+00	2023-09-28 22:51:04.583292+00	4124659323	282	0.00	pf_282
91	2023-09-29 11:54:28.384609+00	2023-09-29 11:54:28.384609+00	4126465541	289	0.00	pf_289
92	2023-09-29 14:58:36.643451+00	2023-09-29 14:58:36.643451+00	4127426220	148	0.00	pf_148
93	2023-09-30 09:40:06.362794+00	2023-09-30 09:40:06.362794+00	4130445181	108	0.00	pf_108
17	2023-04-16 01:23:00.956887+00	2023-11-09 17:33:03.060428+00	3495268476	82	5.35	pf_82
95	2023-10-02 09:45:57.325642+00	2023-10-02 09:45:57.325642+00	4138818103	291	0.00	pf_291
96	2023-10-02 19:08:51.653961+00	2023-10-02 19:08:51.653961+00	4141589576	153	0.00	pf_153
97	2023-10-07 08:07:32.139556+00	2023-10-07 08:07:32.139556+00	4162085395	192	0.00	pf_192
98	2023-10-17 20:41:39.545128+00	2023-10-17 20:41:39.545128+00	4210182997	82	0.00	pj_27
126	2023-11-03 15:59:49.57573+00	2023-11-03 15:59:49.57573+00	4287009396	297	0.00	pf_297
99	2023-10-18 10:23:11.611691+00	2023-10-18 10:23:11.611691+00	4211694697	318	0.00	pf_318
100	2023-10-18 10:24:37.393735+00	2023-10-18 10:24:37.393735+00	4211700477	316	0.00	pf_316
101	2023-10-18 13:52:47.8765+00	2023-10-18 13:52:47.8765+00	4212771360	313	0.00	pf_313
103	2023-10-19 10:42:50.477715+00	2023-10-19 10:42:50.477715+00	4216682308	326	0.00	pf_326
105	2023-10-23 11:22:48.369263+00	2023-10-23 11:22:48.369263+00	4235236766	333	0.00	pf_333
106	2023-10-23 14:33:30.938772+00	2023-10-23 14:33:30.938772+00	4236138592	170	0.00	pf_170
107	2023-10-23 15:53:50.899264+00	2023-10-23 15:53:50.899264+00	4236590207	158	0.00	pf_158
108	2023-10-23 16:21:01.658132+00	2023-10-23 16:21:01.658132+00	4236751426	334	0.00	pf_334
109	2023-10-23 16:31:23.59391+00	2023-10-23 16:31:23.59391+00	4236811054	145	0.00	pf_145
7	2022-09-30 07:35:03.594242+00	2023-11-09 20:51:39.469772+00	2814484726	28	20.61	pf_28
133	2023-11-20 19:13:51.405162+00	2023-11-20 19:13:51.405162+00	4371678360	345	0.00	pf_345
110	2023-10-24 09:35:02.569346+00	2023-10-24 09:35:02.569346+00	4239306778	115	0.00	pf_115
111	2023-10-24 10:20:23.967789+00	2023-10-24 10:20:23.967789+00	4239504187	310	0.00	pf_310
112	2023-10-24 19:19:23.250792+00	2023-10-24 19:19:23.250792+00	4242165612	177	0.00	pf_177
113	2023-10-26 20:19:28.020955+00	2023-10-26 20:19:28.020955+00	4211694697	318	0.00	pf_318
114	2023-10-27 16:20:24.62961+00	2023-10-27 16:20:24.62961+00	4256028064	331	0.00	pf_331
116	2023-10-28 16:58:20.632692+00	2023-10-28 16:58:20.632692+00	4260735097	336	0.00	pf_336
117	2023-10-29 11:33:37.191642+00	2023-10-29 11:33:37.191642+00	4263061025	337	0.00	pf_337
118	2023-10-29 23:37:04.918686+00	2023-10-29 23:37:04.918686+00	4265866429	330	0.00	pf_330
119	2023-10-30 11:01:21.057601+00	2023-10-30 11:01:21.057601+00	4266953787	328	0.00	pf_328
129	2023-11-10 19:29:29.313992+00	2023-11-10 19:29:29.313992+00	4323592406	307	0.00	pf_307
120	2023-10-31 10:19:02.032798+00	2023-10-31 10:19:02.032798+00	4271359433	172	0.00	pf_172
121	2023-10-31 12:13:41.17916+00	2023-10-31 12:13:41.17916+00	4271874345	110	0.00	pf_110
122	2023-10-31 17:31:07.070169+00	2023-10-31 17:31:07.070169+00	4273378374	339	0.00	pf_339
127	2023-11-04 09:29:15.657537+00	2023-11-04 09:29:15.657537+00	4289756661	342	0.00	pf_342
124	2023-11-02 10:12:54.828354+00	2023-11-02 10:12:54.828354+00	4280017046	275	0.00	pf_275
115	2023-10-27 22:35:05.392742+00	2023-11-02 17:37:44.308709+00	4257603826	321	0.00	pf_321
130	2023-11-11 10:55:15.054216+00	2023-11-11 10:55:15.054216+00	4325649861	23	0.00	pj_29
6	2022-09-29 15:44:07.301588+00	2023-11-01 09:34:24.53199+00	2812135153	23	11.97	pf_23
123	2023-11-01 14:09:05.283631+00	2023-11-01 14:09:05.283631+00	4276586977	119	0.00	pf_119
131	2023-11-12 02:11:00.883873+00	2023-11-14 21:24:32.028859+00	2173487944	12	5.00	pj_5
128	2023-11-09 06:47:18.859389+00	2023-11-09 06:47:18.859389+00	4313916702	114	0.00	pf_114
132	2023-11-15 14:40:58.990878+00	2023-11-15 14:40:58.990878+00	4345817200	342	0.00	pj_30
104	2023-10-22 22:12:02.876472+00	2023-11-15 18:54:48.625384+00	4233819464	332	100.00	pf_332
125	2023-11-03 10:46:50.666476+00	2023-11-03 10:46:50.666476+00	4285265658	105	0.00	pf_105
102	2023-10-18 22:34:36.743916+00	2023-11-17 17:05:08.681124+00	4215376663	324	41.02	pf_324
\.


--
-- Data for Name: meetings_agendaitem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.meetings_agendaitem (id, created, proposal, meeting_id, proposal_agreement, approved) FROM stdin;
49	2023-09-19 06:13:43.65407+00	NOMBRAMIENTO Y CESE DE ADMINISTRADORES	34	Orden del día\n\nCesar y nombrar administradores, adoptando los acuerdos complementarios.\nFacultar, en su caso, para la ejecución y elevación a público de los acuerdos adoptados.\n\nAcuerdos\nPRIMERO\nCesar al administrador (único/solidario) XXXXXX, cuyas circunstancias son las que constan en el Registro Mercantil sin que hayan sufrido variación alguna, agradeciéndole los servicios prestados a la sociedad, aprobando su gestión hasta la fecha de su cese.\n\nSEGUNDO \nNombrar como administrador único/solidari, por tiempo indefinido, a XXXXXXX, mayor de edad, (estado civil), con domicilio en (municipio/provincia), Calle XXXXXX, con D.N.I. / N.I.F. número XXXXX.\n\nEl nombrado, presente en el acto, acepta el nombramiento y declara que no se halla incurso en ninguna de las prohibiciones o incompatibilidades establecidas legalmente.\n\nTERCERO\n Facultar expresamente al Administrador Único/Solidario de la Sociedad nombrado, para que comparezca ante el Notario de su elección y eleve a público los anteriores acuerdos, firmando al efecto cuantos documentos públicos y privados se precisen sin limitación alguna.	\N
50	2023-09-19 09:32:28.076183+00	AUMENTO DE CAPITAL CON PRIMA	35	Orden del día\n\nAumentar el capital social por creación de nuevas participaciones sociales y con cargo a aportaciones dinerarias, adoptando los acuerdos complementarios, en especial modificando los Estatutos sociales\n\nAcuerdos a adoptar\n\nAcuerdo PRIMERO\n\n1)\tAumentar el capital social de la entidad en la cifra de XXX euros mediante la creación de XXX nuevas participaciones sociales de igual valor nominal y contenido de derechos que las anteriores, y numeradas correlativamente del XXX-XXX, ambos inclusive.\n\nLas nuevas participaciones sociales se crean por su valor nominal, y con una prima global de XXX euros, equivalente a XXX por participación social.\n\n2)\tSe reconoce a los socios el derecho a asumir un número de las nuevas participaciones sociales proporcional al valor nominal de las que poseen, no obstante lo cual y ante la propia Junta se realiza la empresa renuncia al ejercicio del derecho de asunción preferente, por todos y cada uno de los asistentes, lo que acepta la Junta, absteniéndose por tanto, de establecer las condiciones de ejercicio de tal derecho. Haciendo constar el órgano de administración, de conformidad con el art. 308 de la Ley de Sociedades de Capital:\n\na)\tque el órgano de gobierno ha elaborado un informe especificando el valor de las participaciones y justificando detalladamente la propuesta y la contraprestación a satisfacer por las nuevas participaciones a las personas a las que hayan de atribuirse.\n\nb)\tQue en la convocatoria de la junta se ha hecho constar la propuesta de supresión del derecho de preferencia, el tipo de creación de las nuevas participaciones y el derecho de los socios a examinar en el domicilio social el informe de los administradores así como pedir entrega o envío gratuito de estos documentos.\n\nc)\tQue el valor nominal de las nuevas participaciones, más, en su caso, el importe de la prima, se corresponde con el valor real atribuido a las participaciones en el informe de los administradores.\n\n3)\tAprobar la asunción y desembolso que de las nuevas participaciones sociales se realiza en el mismo acto en los términos siguientes:\n\n-\t(Nombre Apellidos), mayor de edad, (estado civil), vecino de (municipio), con domicilio en la (calle número), y con DNI/NIF número (número), asume XXX nuevas participaciones sociales, números “XX” a “XX”, ambas inclusive, por su valor nominal conjunto de XX euros. En unión de XXX euros correspondientes a la prima de asunción de las participaciones sociales asumidas.\n\nAcuerdo Segundo\nModificar, como consecuencia del aumento de capital, el artículo número XXX de los estatutos sociales, el cual quedará con la siguiente redacción:\n\nArtículo XX\n(Texto de del artículo)\n\nAcuerdo Tercero\nFacultar a todos y cada uno de los miembros del órgano de administración para que, indistintamente, puedan comparecer ante Notario y elevar a público los presentes acuerdos, otorgando para ello las escrituras públicas correspondientes (incluso de subsanación, aclaración o rectificación), así como para realizar cuantas actuaciones sean precisas o conveniente para la plena eficacia de los acuerdos.	\N
51	2023-09-20 10:17:48.973533+00	AUMENTO DE CAPITAL CON PRIMA	36	Orden del día\n\nAumentar el capital social por creación de nuevas participaciones sociales y con cargo a aportaciones dinerarias, adoptando los acuerdos complementarios, en especial modificando los Estatutos sociales\n\nAcuerdos a adoptar\n\nAcuerdo PRIMERO\n\n1)\tAumentar el capital social de la entidad en la cifra de XXX euros mediante la creación de XXX nuevas participaciones sociales de igual valor nominal y contenido de derechos que las anteriores, y numeradas correlativamente del XXX-XXX, ambos inclusive.\n\nLas nuevas participaciones sociales se crean por su valor nominal, y con una prima global de XXX euros, equivalente a XXX por participación social.\n\n2)\tSe reconoce a los socios el derecho a asumir un número de las nuevas participaciones sociales proporcional al valor nominal de las que poseen, no obstante lo cual y ante la propia Junta se realiza la empresa renuncia al ejercicio del derecho de asunción preferente, por todos y cada uno de los asistentes, lo que acepta la Junta, absteniéndose por tanto, de establecer las condiciones de ejercicio de tal derecho. Haciendo constar el órgano de administración, de conformidad con el art. 308 de la Ley de Sociedades de Capital:\n\na)\tque el órgano de gobierno ha elaborado un informe especificando el valor de las participaciones y justificando detalladamente la propuesta y la contraprestación a satisfacer por las nuevas participaciones a las personas a las que hayan de atribuirse.\n\nb)\tQue en la convocatoria de la junta se ha hecho constar la propuesta de supresión del derecho de preferencia, el tipo de creación de las nuevas participaciones y el derecho de los socios a examinar en el domicilio social el informe de los administradores así como pedir entrega o envío gratuito de estos documentos.\n\nc)\tQue el valor nominal de las nuevas participaciones, más, en su caso, el importe de la prima, se corresponde con el valor real atribuido a las participaciones en el informe de los administradores.\n\n3)\tAprobar la asunción y desembolso que de las nuevas participaciones sociales se realiza en el mismo acto en los términos siguientes:\n\n-\t(Nombre Apellidos), mayor de edad, (estado civil), vecino de (municipio), con domicilio en la (calle número), y con DNI/NIF número (número), asume XXX nuevas participaciones sociales, números “XX” a “XX”, ambas inclusive, por su valor nominal conjunto de XX euros. En unión de XXX euros correspondientes a la prima de asunción de las participaciones sociales asumidas.\n\nAcuerdo Segundo\nModificar, como consecuencia del aumento de capital, el artículo número XXX de los estatutos sociales, el cual quedará con la siguiente redacción:\n\nArtículo XX\n(Texto de del artículo)\n\nAcuerdo Tercero\nFacultar a todos y cada uno de los miembros del órgano de administración para que, indistintamente, puedan comparecer ante Notario y elevar a público los presentes acuerdos, otorgando para ello las escrituras públicas correspondientes (incluso de subsanación, aclaración o rectificación), así como para realizar cuantas actuaciones sean precisas o conveniente para la plena eficacia de los acuerdos.	\N
52	2023-09-20 11:28:41.461018+00	AUMENTO DE CAPITAL CON PRIMA	37	Orden del día\n\nAumentar el capital social por creación de nuevas participaciones sociales y con cargo a aportaciones dinerarias, adoptando los acuerdos complementarios, en especial modificando los Estatutos sociales\n\nAcuerdos a adoptar\n\nAcuerdo PRIMERO\n\n1)\tAumentar el capital social de la entidad en la cifra de XXX euros mediante la creación de XXX nuevas participaciones sociales de igual valor nominal y contenido de derechos que las anteriores, y numeradas correlativamente del XXX-XXX, ambos inclusive.\n\nLas nuevas participaciones sociales se crean por su valor nominal, y con una prima global de XXX euros, equivalente a XXX por participación social.\n\n2)\tSe reconoce a los socios el derecho a asumir un número de las nuevas participaciones sociales proporcional al valor nominal de las que poseen, no obstante lo cual y ante la propia Junta se realiza la empresa renuncia al ejercicio del derecho de asunción preferente, por todos y cada uno de los asistentes, lo que acepta la Junta, absteniéndose por tanto, de establecer las condiciones de ejercicio de tal derecho. Haciendo constar el órgano de administración, de conformidad con el art. 308 de la Ley de Sociedades de Capital:\n\na)\tque el órgano de gobierno ha elaborado un informe especificando el valor de las participaciones y justificando detalladamente la propuesta y la contraprestación a satisfacer por las nuevas participaciones a las personas a las que hayan de atribuirse.\n\nb)\tQue en la convocatoria de la junta se ha hecho constar la propuesta de supresión del derecho de preferencia, el tipo de creación de las nuevas participaciones y el derecho de los socios a examinar en el domicilio social el informe de los administradores así como pedir entrega o envío gratuito de estos documentos.\n\nc)\tQue el valor nominal de las nuevas participaciones, más, en su caso, el importe de la prima, se corresponde con el valor real atribuido a las participaciones en el informe de los administradores.\n\n3)\tAprobar la asunción y desembolso que de las nuevas participaciones sociales se realiza en el mismo acto en los términos siguientes:\n\n-\t(Nombre Apellidos), mayor de edad, (estado civil), vecino de (municipio), con domicilio en la (calle número), y con DNI/NIF número (número), asume XXX nuevas participaciones sociales, números “XX” a “XX”, ambas inclusive, por su valor nominal conjunto de XX euros. En unión de XXX euros correspondientes a la prima de asunción de las participaciones sociales asumidas.\n\nAcuerdo Segundo\nModificar, como consecuencia del aumento de capital, el artículo número XXX de los estatutos sociales, el cual quedará con la siguiente redacción:\n\nArtículo XX\n(Texto de del artículo)\n\nAcuerdo Tercero\nFacultar a todos y cada uno de los miembros del órgano de administración para que, indistintamente, puedan comparecer ante Notario y elevar a público los presentes acuerdos, otorgando para ello las escrituras públicas correspondientes (incluso de subsanación, aclaración o rectificación), así como para realizar cuantas actuaciones sean precisas o conveniente para la plena eficacia de los acuerdos.	\N
53	2023-09-20 12:18:47.471221+00	NOMBRAMIENTO Y CESE DE ADMINISTRADORES	38	Orden del día\n\nCesar y nombrar administradores, adoptando los acuerdos complementarios.\nFacultar, en su caso, para la ejecución y elevación a público de los acuerdos adoptados.\n\nAcuerdos\nPRIMERO\nCesar al administrador (único/solidario) XXXXXX, cuyas circunstancias son las que constan en el Registro Mercantil sin que hayan sufrido variación alguna, agradeciéndole los servicios prestados a la sociedad, aprobando su gestión hasta la fecha de su cese.\n\nSEGUNDO \nNombrar como administrador único/solidari, por tiempo indefinido, a XXXXXXX, mayor de edad, (estado civil), con domicilio en (municipio/provincia), Calle XXXXXX, con D.N.I. / N.I.F. número XXXXX.\n\nEl nombrado, presente en el acto, acepta el nombramiento y declara que no se halla incurso en ninguna de las prohibiciones o incompatibilidades establecidas legalmente.\n\nTERCERO\n Facultar expresamente al Administrador Único/Solidario de la Sociedad nombrado, para que comparezca ante el Notario de su elección y eleve a público los anteriores acuerdos, firmando al efecto cuantos documentos públicos y privados se precisen sin limitación alguna.	\N
54	2023-09-22 06:27:29.991913+00	APROBACIÓN CUENTAS ANUALES (CUENTAS ABREVIADAS)	39	Examen y aprobación, si procede, de las cuentas anuales comprensivas de balance, cuenta de pérdidas y ganancias, memoria y , de la gestión social del órgano de administración y de la aplicación del resultado, todo ello referido al ejercicio cerrado el 31 de diciembre de XXXX.\n\nSe acuerda aprobar por unanimidad la gestión social durante el ejercicio cerrado a 31 de diciembre de XXX, ratificando la confianza depositada en el actual órgano de administración.\n\nAsimismo se acuerda aprobar las cuentas anuales de la sociedad comprensivas del Balance, la Cuenta de Pérdidas y Ganancias y la Memoria, correspondientes al ejercicio cerrado a 31 de diciembre de XXXX, que fueron formuladas y firmadas por los administradores de la sociedad con cargo vigente.\n\nLa sociedad formula cuentas abreviadas y no está obligada a someter las mismas a verificación ni a elaborar Informe de Gestión, Estado de Cambios en el Patrimonio Neto ni Estado de Flujos de Efectivo, de conformidad con los arts. 257, 258, 261, 262.3 y 263.2 de la Ley de Sociedades de Capital.	\N
55	2023-09-26 08:40:25.880585+00	NOMBRAMIENTO Y CESE DE ADMINISTRADORES	40	Orden del día\n\nCesar y nombrar administradores, adoptando los acuerdos complementarios.\nFacultar, en su caso, para la ejecución y elevación a público de los acuerdos adoptados.\n\nAcuerdos\nPRIMERO\nCesar al administrador (único/solidario) XXXXXX, cuyas circunstancias son las que constan en el Registro Mercantil sin que hayan sufrido variación alguna, agradeciéndole los servicios prestados a la sociedad, aprobando su gestión hasta la fecha de su cese.\n\nSEGUNDO \nNombrar como administrador único/solidari, por tiempo indefinido, a XXXXXXX, mayor de edad, (estado civil), con domicilio en (municipio/provincia), Calle XXXXXX, con D.N.I. / N.I.F. número XXXXX.\n\nEl nombrado, presente en el acto, acepta el nombramiento y declara que no se halla incurso en ninguna de las prohibiciones o incompatibilidades establecidas legalmente.\n\nTERCERO\n Facultar expresamente al Administrador Único/Solidario de la Sociedad nombrado, para que comparezca ante el Notario de su elección y eleve a público los anteriores acuerdos, firmando al efecto cuantos documentos públicos y privados se precisen sin limitación alguna.	\N
56	2023-10-06 10:44:15.483142+00	APROBACIÓN CUENTAS ANUALES (CUENTAS ABREVIADAS)	41	Examen y aprobación, si procede, de las cuentas anuales comprensivas de balance, cuenta de pérdidas y ganancias, memoria y , de la gestión social del órgano de administración y de la aplicación del resultado, todo ello referido al ejercicio cerrado el 31 de diciembre de XXXX.\n\nSe acuerda aprobar por unanimidad la gestión social durante el ejercicio cerrado a 31 de diciembre de XXX, ratificando la confianza depositada en el actual órgano de administración.\n\nAsimismo se acuerda aprobar las cuentas anuales de la sociedad comprensivas del Balance, la Cuenta de Pérdidas y Ganancias y la Memoria, correspondientes al ejercicio cerrado a 31 de diciembre de XXXX, que fueron formuladas y firmadas por los administradores de la sociedad con cargo vigente.\n\nLa sociedad formula cuentas abreviadas y no está obligada a someter las mismas a verificación ni a elaborar Informe de Gestión, Estado de Cambios en el Patrimonio Neto ni Estado de Flujos de Efectivo, de conformidad con los arts. 257, 258, 261, 262.3 y 263.2 de la Ley de Sociedades de Capital.	\N
57	2023-10-13 08:40:40.613494+00	NOMBRAMIENTO Y CESE DE ADMINISTRADORES	42	Orden del día\n\nCesar y nombrar administradores, adoptando los acuerdos complementarios.\nFacultar, en su caso, para la ejecución y elevación a público de los acuerdos adoptados.\n\nAcuerdos\nPRIMERO\nCesar al administrador (único/solidario) XXXXXX, cuyas circunstancias son las que constan en el Registro Mercantil sin que hayan sufrido variación alguna, agradeciéndole los servicios prestados a la sociedad, aprobando su gestión hasta la fecha de su cese.\n\nSEGUNDO \nNombrar como administrador único/solidari, por tiempo indefinido, a XXXXXXX, mayor de edad, (estado civil), con domicilio en (municipio/provincia), Calle XXXXXX, con D.N.I. / N.I.F. número XXXXX.\n\nEl nombrado, presente en el acto, acepta el nombramiento y declara que no se halla incurso en ninguna de las prohibiciones o incompatibilidades establecidas legalmente.\n\nTERCERO\n Facultar expresamente al Administrador Único/Solidario de la Sociedad nombrado, para que comparezca ante el Notario de su elección y eleve a público los anteriores acuerdos, firmando al efecto cuantos documentos públicos y privados se precisen sin limitación alguna.	\N
\.


--
-- Data for Name: meetings_document; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.meetings_document (id, created, file, hash, agenda_item_id, creator_id, stellar_transaction_hash, blockchain_link, blockchain_transaction_id) FROM stdin;
68	2023-09-19 09:32:43.111443+00	meeting_documents/19f0b1c6260a159021835392fd8ac8d7b7a57abd6b25f212e83c7684ff997cc5.pdf	4e39345ca6279ae77239c042d01d	\N	23	\N	https://mumbai.polygonscan.com/tx/0x9bab296414b9b8548923594560c63bb103f53f4f4e48c0a4e930f0805ad96580	0x9bab296414b9b8548923594560c63bb103f53f4f4e48c0a4e930f0805ad96580
69	2023-09-20 12:19:03.609511+00	meeting_documents/98ef7e5638ba774ac2a0239bedece3b441f6fe3de139f21ff575dca878278ea5.pdf	5fcb396d14901661165149affc85	\N	23	\N	https://mumbai.polygonscan.com/tx/0x74e2633b62a2cac4911738edb94e4a39751ac37495870484f814bf271fd6537f	0x74e2633b62a2cac4911738edb94e4a39751ac37495870484f814bf271fd6537f
70	2023-09-22 06:28:53.939325+00	meeting_documents/71a04ee312011ec4e7d5f54062776bb530e39d1e031ae764377c3f44cdcbe676.pdf	f73eae9a268b65917d1ffbe0a6d1	\N	10	\N	https://mumbai.polygonscan.com/tx/0x1c77616ab5b77a2c4f74b54ba33b4b003b53ca21519974266d484aa7ae3b0462	0x1c77616ab5b77a2c4f74b54ba33b4b003b53ca21519974266d484aa7ae3b0462
71	2023-09-26 08:40:40.998486+00	meeting_documents/cde5396c4f7fc0f2a973bc4eb50841cf76ac1b3db2d8700286cdff7148b1a24e.pdf	e20cd3a7635aad6cf799e8d02771	\N	23	\N	https://mumbai.polygonscan.com/tx/0x01a27881b3238b07ed0bb93b656eebb9787dc8dfde2417d8ce8e7f984a9129e6	0x01a27881b3238b07ed0bb93b656eebb9787dc8dfde2417d8ce8e7f984a9129e6
63	2023-09-18 17:13:56.135854+00	meeting_documents/77460dd3d025195654b2a4c2956b619ba17d3c7b15bb0b6abe4ed9a30b314e33.pdf	e089edcdc11b185e0ec57c77ae27	\N	23	\N	https://mumbai.polygonscan.com/tx/0x1faf8d15f8ef20b523dbae87d31a9ba267eb40bd8f8d4debdaa175c62cd7aaef	0x1faf8d15f8ef20b523dbae87d31a9ba267eb40bd8f8d4debdaa175c62cd7aaef
65	2023-09-18 17:29:24.140047+00	meeting_documents/eb7acc4edb593dc9c222f3a74d1920d26c0cd3988889795c49564dc2c6cdc08b.pdf	f8d2f797b9423ea60d55a0a8f1f7	\N	23	\N	https://mumbai.polygonscan.com/tx/0xaecb1323cbd5b61b7de8df1de060f1f5a17574ddd19b7e6cd03c6573356fcef4	0xaecb1323cbd5b61b7de8df1de060f1f5a17574ddd19b7e6cd03c6573356fcef4
66	2023-09-19 06:13:39.874607+00	meeting_documents/48c2504303a1531ba714521a56f915dcf806de0912ed6ed0b3a701190245ff0e.pdf	51f05e952f863b9d4d10572187ae	49	23	\N	https://mumbai.polygonscan.com/tx/0x3254037126237ae3ca05f33af396d97096e17ef737c80107409f59658135b068	0x3254037126237ae3ca05f33af396d97096e17ef737c80107409f59658135b068
67	2023-09-19 06:13:59.593324+00	meeting_documents/a44ef5cfe7e6adc301b1c3f6fd7473446fb82d9e32de8ad332d366a8dcd0d91c.pdf	8fbccc6718dbe2ea08be70689ecd	\N	23	\N	https://mumbai.polygonscan.com/tx/0x9a954098be2a247c558cd887b128e47ed765881ef911c1b793e0dbc7461f0b02	0x9a954098be2a247c558cd887b128e47ed765881ef911c1b793e0dbc7461f0b02
\.


--
-- Data for Name: meetings_historymeetingsdocument; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.meetings_historymeetingsdocument (id, created, modified, transaction_hash, blockchain_transaction_id, blockchain_link, creator_id, document_id) FROM stdin;
1	2023-09-12 10:22:17.584161+00	2023-09-12 10:22:17.584161+00	b7758a5330b61e5c41adb464fa9a	0xacc92714e9d112c9d15b349ae05f39f43f7bd6903453cbabfca8424b072c3e7f	https://mumbai.polygonscan.com/tx/0xacc92714e9d112c9d15b349ae05f39f43f7bd6903453cbabfca8424b072c3e7f	266	\N
2	2023-09-12 10:35:25.561427+00	2023-09-12 10:35:25.561427+00	b7758a5330b61e5c41adb464fa9a	0xcc4c642a94ece43ebdb9a70a89a513513f46e781fdf76066c2fe1096654e7701	https://mumbai.polygonscan.com/tx/0xcc4c642a94ece43ebdb9a70a89a513513f46e781fdf76066c2fe1096654e7701	1	\N
14	2023-09-14 10:28:55.564491+00	2023-09-14 10:28:55.564491+00	1ed4f76b5bf41bad527600f15161	\N	\N	13	\N
15	2023-09-14 10:29:03.316862+00	2023-09-14 10:29:03.316862+00	2420d10392adbdd3ba2c86d1a372	\N	\N	13	\N
16	2023-09-14 10:29:11.355203+00	2023-09-14 10:29:11.355203+00	34cde21cca6da4ec0610b580d32e	\N	\N	13	\N
3	2023-09-13 08:26:19.990609+00	2023-09-13 08:26:19.990609+00	2420d10392adbdd3ba2c86d1a372	\N	\N	266	\N
4	2023-09-13 08:33:22.191097+00	2023-09-13 08:33:22.191097+00	2420d10392adbdd3ba2c86d1a372	\N	\N	266	\N
5	2023-09-13 08:37:53.387455+00	2023-09-13 08:37:53.387455+00	\N	\N	\N	266	\N
6	2023-09-13 08:46:55.201096+00	2023-09-13 08:46:55.201096+00	2420d10392adbdd3ba2c86d1a372	\N	\N	266	\N
7	2023-09-13 12:31:51.5297+00	2023-09-13 12:31:51.5297+00	2420d10392adbdd3ba2c86d1a372	0xe410957d994beeaaeaf74e0595eb4f1704c84c80b45421f5fc863a6a521345ca	https://mumbai.polygonscan.com/tx/0xe410957d994beeaaeaf74e0595eb4f1704c84c80b45421f5fc863a6a521345ca	266	\N
8	2023-09-13 12:31:51.531563+00	2023-09-13 12:31:51.531563+00	2420d10392adbdd3ba2c86d1a372	0xe410957d994beeaaeaf74e0595eb4f1704c84c80b45421f5fc863a6a521345ca	https://mumbai.polygonscan.com/tx/0xe410957d994beeaaeaf74e0595eb4f1704c84c80b45421f5fc863a6a521345ca	266	\N
9	2023-09-13 13:36:26.362704+00	2023-09-13 13:36:26.362704+00	2420d10392adbdd3ba2c86d1a372	\N	\N	266	\N
13	2023-09-14 10:20:49.519534+00	2023-09-14 10:20:49.519534+00	2420d10392adbdd3ba2c86d1a372	\N	\N	266	\N
21	2023-09-14 13:14:17.243602+00	2023-09-14 13:14:17.243602+00	2420d10392adbdd3ba2c86d1a372	\N	\N	266	\N
23	2023-09-17 08:50:12.171385+00	2023-09-17 08:50:12.171385+00	631e031a42acae14daecbed40f3c	\N	\N	13	\N
10	2023-09-13 14:47:52.512414+00	2023-09-13 14:47:52.512414+00	bc55ba466d572839c93d9bd2aacc	\N	\N	13	\N
11	2023-09-13 14:55:38.427191+00	2023-09-13 14:55:38.427191+00	acd78dfc6ef8de94c8dc36584259	\N	\N	13	\N
12	2023-09-14 10:19:21.540234+00	2023-09-14 10:19:21.540234+00	acd78dfc6ef8de94c8dc36584259	0x63a0a14abc2fd3f6729a20c788edadfa883d546d0561203e75cbea82a0576a83	https://mumbai.polygonscan.com/tx/0x63a0a14abc2fd3f6729a20c788edadfa883d546d0561203e75cbea82a0576a83	13	\N
17	2023-09-14 10:50:01.304789+00	2023-09-14 10:50:01.304789+00	92900794395f3a4669bc50e24852	\N	\N	13	\N
18	2023-09-14 11:14:19.293167+00	2023-09-14 11:14:19.293167+00	2420d10392adbdd3ba2c86d1a372	\N	\N	92	\N
19	2023-09-14 11:21:33.254732+00	2023-09-14 11:21:33.254732+00	2420d10392adbdd3ba2c86d1a372	\N	\N	13	\N
20	2023-09-14 12:51:35.313464+00	2023-09-14 12:51:35.313464+00	db1679cc3cd64d82f121896f3393	\N	\N	13	\N
22	2023-09-15 21:12:26.368777+00	2023-09-15 21:12:26.368777+00	8f80a11acc7c2014ff41d88e994f	\N	\N	13	\N
24	2023-09-17 08:50:20.252242+00	2023-09-17 08:50:20.252242+00	4bc9cd78a7c19522fc26bbcf733d	\N	\N	13	\N
25	2023-09-17 21:59:59.124852+00	2023-09-17 21:59:59.124852+00	d15bdc2ce605a0f96b1f32c5378e	\N	\N	23	\N
27	2023-09-18 17:13:59.383416+00	2023-09-18 17:13:59.383416+00	e089edcdc11b185e0ec57c77ae27	\N	\N	23	63
29	2023-09-18 17:29:31.268892+00	2023-09-18 17:29:31.268892+00	f8d2f797b9423ea60d55a0a8f1f7	\N	\N	23	65
30	2023-09-19 06:13:43.239487+00	2023-09-19 06:13:43.239487+00	51f05e952f863b9d4d10572187ae	\N	\N	23	66
31	2023-09-19 06:14:03.22131+00	2023-09-19 06:14:03.22131+00	8fbccc6718dbe2ea08be70689ecd	\N	\N	23	67
26	2023-09-18 17:13:49.182512+00	2023-09-18 17:13:49.182512+00	3ffbf59ba62edf9b663cf7e71252	\N	\N	23	\N
28	2023-09-18 17:28:53.252052+00	2023-09-18 17:28:53.252052+00	0a0b47c3c6fa0c714e8add66365a	\N	\N	23	\N
32	2023-09-19 09:32:47.291568+00	2023-09-19 09:32:47.291568+00	4e39345ca6279ae77239c042d01d	\N	\N	23	68
33	2023-09-20 12:19:08.261009+00	2023-09-20 12:19:08.261009+00	5fcb396d14901661165149affc85	\N	\N	23	69
34	2023-09-22 06:29:02.394951+00	2023-09-22 06:29:02.394951+00	f73eae9a268b65917d1ffbe0a6d1	\N	\N	10	70
35	2023-09-26 08:40:44.21499+00	2023-09-26 08:40:44.21499+00	e20cd3a7635aad6cf799e8d02771	\N	\N	23	71
\.


--
-- Data for Name: meetings_meeting; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.meetings_meeting (id, planned_date, celebration_date, "time", finish, date_of_call, state, type, place, company_id, creator_id, minutes_id, footer, header, review_date, call_id) FROM stdin;
38	2024-01-01	\N	10:00:00	\N	2023-09-20	in_progress	extraordinary	C/ Francisco Valles 8 - Parque Tecnologico De Boecillo Boecillo 47151 Valladolid España	4	23	\N	<p class="mt-6 pt-6">\n    Fdo. D. Carlos Callejo\n</p>	<h1 class="has-text-centered">\n  Convocatoria De La Junta General Extraordinary\n  De Block Impulse Sl\n</h1>\n\n<p>\n  En Boecillo (Valladolid), a 20 de\n  Septiembre de 2023\n</p>\n\n<p>\n  El Representante Legal De Block Impulse Sl, Carlos Callejo, ha decidido convocar\n  junta general Extraordinary de socios, que se celebrará en el domicilio social de la Sociedad,\n  C/ Francisco Valles 8 - Parque Tecnologico De Boecillo Boecillo 47151 Valladolid España, el 1 de Enero\n  de 2024, a las\n  10:00, con el siguiente:\n</p>	\N	69
41	2023-10-10	\N	09:00:00	\N	\N	preparation	ordinary	C/ Francisco Valles 8 - Parque Tecnologico De Boecillo Boecillo 47151 Valladolid España	4	23	\N	\N	\N	\N	\N
36	2023-10-10	\N	12:00:00	\N	\N	preparation	extraordinary	C/ Francisco Valles 8 - Parque Tecnologico De Boecillo Boecillo 47151 Valladolid España	4	23	\N	\N	\N	\N	\N
37	2023-10-10	\N	20:20:00	\N	\N	preparation	extraordinary	C/ Francisco Valles 8 - Parque Tecnologico De Boecillo Boecillo 47151 Valladolid España	4	23	\N	\N	\N	\N	\N
42	2023-10-15	\N	10:00:00	\N	\N	preparation	extraordinary	C/ Francisco Valles 8 - Parque Tecnologico De Boecillo Boecillo 47151 Valladolid España	4	23	\N	\N	\N	\N	\N
39	2023-09-23	\N	11:30:00	\N	2023-09-22	review	ordinary	Calle Gascones, 13 Madrid 28035 Madrid España	1	10	\N	<p class="mt-6 pt-6">\n    Fdo. D. Rafael Del Castillo Ionov\n</p>	<h2>Convocatoria De La Junta General ordinaria de MiEmpresa SL</h2><p>En Madrid (Madrid), a 22 de Septiembre de 2023</p><p>El Representante Legal de MiEmpresa SL, Rafael Del Castillo Ionov, ha decidido convocar junta general ordinaria de socios, que se celebrará en el domicilio social de la Sociedad, Calle Gascones, 13 Madrid 28035 Madrid España, el 23 de Septiembre de 2023, a las 11:30, con el siguiente:</p>	\N	70
35	2023-10-10	\N	12:00:00	\N	2023-09-19	review	extraordinary	C/ Francisco Valles 8 - Parque Tecnologico De Boecillo Boecillo 47151 Valladolid España	4	23	\N	<p class="mt-6 pt-6">\n    Fdo. D. Carlos Callejo\n</p>	<h1 class="has-text-centered">\n  Convocatoria De La Junta General Extraordinary\n  De Block Impulse Sl\n</h1>\n\n<p>\n  En Boecillo (Valladolid), a 19 de\n  Septiembre de 2023\n</p>\n\n<p>\n  El Representante Legal De Block Impulse Sl, Carlos Callejo, ha decidido convocar\n  junta general Extraordinary de socios, que se celebrará en el domicilio social de la Sociedad,\n  C/ Francisco Valles 8 - Parque Tecnologico De Boecillo Boecillo 47151 Valladolid España, el 10 de Octubre\n  de 2023, a las\n  12:00, con el siguiente:\n</p>	\N	68
40	2024-01-01	\N	10:00:00	\N	2023-09-26	in_progress	extraordinary	C/ Francisco Valles 8 - Parque Tecnologico De Boecillo Boecillo 47151 Valladolid España	4	23	\N	<p class="mt-6 pt-6">\n    Fdo. D. Carlos Callejo\n</p>	<h1 class="has-text-centered">\n  Convocatoria De La Junta General Extraordinary\n  De Block Impulse Sl\n</h1>\n\n<p>\n  En Boecillo (Valladolid), a 26 de\n  Septiembre de 2023\n</p>\n\n<p>\n  El Representante Legal De Block Impulse Sl, Carlos Callejo, ha decidido convocar\n  junta general Extraordinary de socios, que se celebrará en el domicilio social de la Sociedad,\n  C/ Francisco Valles 8 - Parque Tecnologico De Boecillo Boecillo 47151 Valladolid España, el 1 de Enero\n  de 2024, a las\n  10:00, con el siguiente:\n</p>	\N	71
34	2023-10-01	\N	10:00:00	\N	2023-09-19	review	extraordinary	C/ Francisco Valles 8 - Parque Tecnologico De Boecillo Boecillo 47151 Valladolid España	4	23	\N	<p class="mt-6 pt-6">\n    Fdo. D. Carlos Callejo\n</p>	<h1 class="has-text-centered">\n  Convocatoria De La Junta General Extraordinary\n  De Block Impulse Sl\n</h1>\n\n<p>\n  En Boecillo (Valladolid), a 19 de\n  Septiembre de 2023\n</p>\n\n<p>\n  El Representante Legal De Block Impulse Sl, Carlos Callejo, ha decidido convocar\n  junta general Extraordinary de socios, que se celebrará en el domicilio social de la Sociedad,\n  C/ Francisco Valles 8 - Parque Tecnologico De Boecillo Boecillo 47151 Valladolid España, el 1 de Octubre\n  de 2023, a las\n  10:00, con el siguiente:\n</p>	\N	67
\.


--
-- Data for Name: meetings_participant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.meetings_participant (id, shares, attendant, vote_datetime, meeting_id, user_id, read_call, read_minutes, cod) FROM stdin;
26	1500	f	\N	34	13	\N	\N	\N
27	1500	f	\N	34	82	\N	\N	\N
28	1500	f	\N	35	13	\N	\N	\N
29	1500	f	\N	35	82	\N	\N	\N
30	1500	f	\N	38	13	\N	\N	\N
31	1500	f	\N	38	82	\N	\N	\N
32	1500	f	\N	40	13	\N	\N	\N
33	1500	f	\N	40	82	\N	\N	\N
\.


--
-- Data for Name: oauth2_provider_accesstoken; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oauth2_provider_accesstoken (id, token, expires, scope, application_id, user_id, created, updated, source_refresh_token_id, id_token_id) FROM stdin;
1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IjNMS3Jtc2dZRVR4VzNkaVl3bWJlbk5pS205akdlRCJ9.572inqN9HvcYWmw475cqRU_K0_Vp-6a43WFxDUIno4I	2023-09-04 01:25:47.574922+00	read write	1	198	2023-09-03 15:25:47.575424+00	2023-09-03 15:25:47.575434+00	\N	\N
2	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IlB3RHA3UXN3aFhuZ3N3Tk4zSEdFQ0ZOdFZpMGQzRSJ9.qmBPKai54VmNZjpPBh5vx8yVSllppH-ZXjH1RDvb7aA	2023-09-06 06:51:33.295595+00	read write	3	228	2023-09-05 20:51:33.296409+00	2023-09-05 20:51:33.296425+00	\N	\N
3	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImgzZXY2WVBobUNCaHd4QU5BZW8xcVVXMFJHR0hveiJ9.AqETYh6faZfKR4GHpQ5mpVg37VwznboeixhCiZFEaHg	2023-09-06 07:34:21.73418+00	read write	3	198	2023-09-05 21:34:21.734626+00	2023-09-05 21:34:21.734637+00	\N	\N
4	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImlKNExVS3RQNkJaWEdmd2hwMExTSGJ5dHRLQzBxNCJ9.jwmx8utalbrCQf_ZzGDVFPPWQPY4RQEvz_EGhYRB6n0	2023-09-06 07:47:11.655251+00	read write	3	23	2023-09-05 21:47:11.655625+00	2023-09-05 21:47:11.655634+00	\N	\N
5	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Im9EVG9JZEVIREpsQ1JSeG9Dc3ltSEdBaW9LdDU3eiJ9.WNWzsNrMSPzn-rN6FOXvqHOi0Iqui8GkpHlFIohzTtQ	2023-09-07 03:45:53.189016+00	read write	3	269	2023-09-06 17:45:53.189396+00	2023-09-06 17:45:53.189405+00	\N	\N
6	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InRBZ3hzVWx1OFhURDc1TzdwVFkwRWx4TXhsQTNLdyJ9.E6qTKswJFeDMzUgP2hz2JxrQXAE7nWGpN08bKuzYzuI	2023-09-07 03:46:44.042967+00	read write	3	28	2023-09-06 17:46:44.043411+00	2023-09-06 17:46:44.043421+00	\N	\N
7	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Ik85cmJjREwySkwyMXpWbzEyT1cxUTRuWld2d2ZZbCJ9.EmlGV5nl2NQnc0xzgSX0PZkYW-764n-d0nydcAf5_AM	2023-09-11 19:54:17.722745+00	read write	3	269	2023-09-11 09:54:17.723325+00	2023-09-11 09:54:17.723336+00	\N	\N
8	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkRrdDd6cjgxdHExbExJQUhlbjJJY20xdEFTMjVpSCJ9.ip-iz2IHolIs-jEdUw9uxvvJFCW8wyAgNU_7msYqAAI	2023-09-12 18:28:47.634599+00	read write	3	271	2023-09-12 08:28:47.638926+00	2023-09-12 08:28:47.638939+00	\N	\N
9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImJQRDRKdDUwRWhMR01oaFh1elNrbFBVbUM0S1RFZyJ9.yFKkDMiCxWUmQIPo4OOMQJ-41J_PKYM_DmVOwqLJclg	2023-09-12 19:14:52.777977+00	read write	3	269	2023-09-12 09:14:52.778421+00	2023-09-12 09:14:52.778432+00	\N	\N
10	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Ik4wWXlqWm9Od1RHMmFpTnE3dnI1cVNqaG5yZFpJWSJ9.-QB-kpKoTcC8aN984C80BprSKFH-ZfIWhy4G_W2eLN0	2023-09-16 02:28:43.532134+00	read write	3	198	2023-09-15 16:28:43.532802+00	2023-09-15 16:28:43.532814+00	\N	\N
11	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Im9VekpaTFZvWlNSQzdwNHgzMnM0OFBGQWdweE11eiJ9.bZE7uRiiEF-NcnMBysfN682DKyBZIfaO_RpW5dwsNWc	2023-09-19 14:38:57.167378+00	read write	3	28	2023-09-19 04:38:57.167927+00	2023-09-19 04:38:57.16794+00	\N	\N
12	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Im1OT0pJcEljdERvU1ZpdDZuQzhnSEZoeGdZdk9XbiJ9.jg4ZA2lqaCLFWmgaTI3_-AeFL_KuSV96ktcxFs6WkrI	2023-09-22 00:32:19.500565+00	read write	3	273	2023-09-21 14:32:19.501061+00	2023-09-21 14:32:19.501072+00	\N	\N
13	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IlJKWlR1SUJheGNsT05LaURUWHhteEZmSXRDaTdBYyJ9.0SNBNXvYR20qusqkiaNeA79ole-Zbr9d4ZVz7VS1EyQ	2023-09-25 06:28:03.721627+00	read write	3	273	2023-09-24 20:28:03.722662+00	2023-09-24 20:28:03.722674+00	\N	\N
14	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InlHZGVnNVJ2aENxS01INndaNkhGcVNmamhuUVJmQiJ9.Bb4KBIIi7sGZ4WErxxrT7-qCDv2ppXZHQDhtQWcjsTw	2023-09-28 06:31:49.39175+00	read write	3	278	2023-09-27 20:31:49.392189+00	2023-09-27 20:31:49.392199+00	\N	\N
15	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Im02SHZUakVhRHh3anZEOGpRbHlXOHNZYVlYdTFJOSJ9.DP1zl07mskLY2PQjoa7S0OFevQ73Yu2eUwj_iFXgsRg	2023-09-28 09:02:25.040681+00	read write	3	277	2023-09-27 23:02:25.04131+00	2023-09-27 23:02:25.04132+00	\N	\N
16	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImM1WEFxdFRFeEp4bDBpampiYmViZnVYbWx6Q1YxNCJ9.JaXXp_cN208btZSt5_PM0qls-rrqaG_5jQiIUHFcrJo	2023-09-28 18:56:04.646177+00	read write	3	156	2023-09-28 08:56:04.646638+00	2023-09-28 08:56:04.64665+00	\N	\N
17	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkpDY05CeE5vcFJ3MlgyQXNtRE1SRVROT1hSbWdLSSJ9.p_ybpka2oXNt-QspOofP_yS67gAlIaIzr3pVrFbQPh8	2023-09-28 23:49:53.360018+00	read write	3	284	2023-09-28 13:49:53.360474+00	2023-09-28 13:49:53.360484+00	\N	\N
18	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InBKYTJVSUtyMU9pV2UyYmxnMFJicTlVTUFOWGxYYSJ9.7_s7Ez9a28lByua6qGJy2pS5FElkzHyWuTQSrpfhVdI	2023-09-29 02:48:15.291513+00	read write	3	278	2023-09-28 16:48:15.291925+00	2023-09-28 16:48:15.291935+00	\N	\N
19	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IlRVN013eE14c1ozZ2xvWFVTb3JQdjV3VWV2QWgyYiJ9.-Dk9zoXAtloWmlStjbknppMYl9TMgSFfBOUTnQV5A24	2023-09-29 16:45:10.73259+00	read write	3	285	2023-09-29 06:45:10.733153+00	2023-09-29 06:45:10.733164+00	\N	\N
20	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InVNaG1jaHE1MHZhRUtoTXA2TVNTaTZXWlNGYk16aiJ9.es6NAPA90fWFN91ejKTQwyerSBzOUe_uGgoq1mAOz10	2023-09-29 19:55:32.867503+00	read write	3	287	2023-09-29 09:55:32.868144+00	2023-09-29 09:55:32.868156+00	\N	\N
21	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IlFOQ1I5cmlVcE00ZHNSNVRCa0ZjYnBTVWdzcDk3dCJ9.sC9_F7n-QmaDnRcpkSfVadIyV5hAUTXhHQ8WJwKBi-I	2023-09-29 21:40:49.13572+00	read write	3	288	2023-09-29 11:40:49.136359+00	2023-09-29 11:40:49.136372+00	\N	\N
22	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InVHZjVKaUtwcU1sWXQ3cVBRdkxNVWpWdWJnUm9JQSJ9.CiaaueStvXaJEuSWnbnlkueupeM6AcdrA-kYN1nWqx4	2023-09-29 21:42:09.631533+00	read write	3	289	2023-09-29 11:42:09.632791+00	2023-09-29 11:42:09.632804+00	\N	\N
23	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IjRuNTJWS0tHaklPanRmZHo1OXFPZmdSNlAzT29iZiJ9.k80Ee2KMZuHCqDta6zS6LpziBceka9L8Oc8pfMMaZYg	2023-09-30 03:18:57.330864+00	read write	3	278	2023-09-29 17:18:57.331428+00	2023-09-29 17:18:57.331439+00	\N	\N
24	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkttY3laektyQnpaZUFtdDIxc240ZVhyV1lFbjhWMCJ9.tqPvn3RYyuIvx2ng0MA4MZCCt8U9ZAHqe532B6dW0W4	2023-10-02 20:47:15.558927+00	read write	3	156	2023-10-02 10:47:15.559635+00	2023-10-02 10:47:15.559648+00	\N	\N
25	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImRpMmVid29BejBOVGtSdWw3cWJGZ3h0Q1NXTEFrSyJ9.X9SC85LXW9imzkm1h-GDIwaMKeWwkFDEbcnWhlMaS9Y	2023-10-02 21:39:34.638978+00	read write	3	69	2023-10-02 11:39:34.639543+00	2023-10-02 11:39:34.639555+00	\N	\N
26	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Ik9SaFlHM2FsQ1ZTTDREZVpkTW9zYXo1MDUzTkljWCJ9.u2SU_wd2-AYonsoRB677hrsTNKfel31fh-fH2aWoHC8	2023-10-03 19:13:13.06822+00	read write	3	293	2023-10-03 09:13:13.068871+00	2023-10-03 09:13:13.068882+00	\N	\N
27	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Im82Z3FHdlNSVWgxSWhjWUthMllFcWlTc2xDeTh2VyJ9.bCQB32HMF2GUNTG9wDqEEoA3r2iEJkDfi40ubPsECNE	2023-10-04 18:04:46.700557+00	read write	3	294	2023-10-04 08:04:46.700987+00	2023-10-04 08:04:46.700997+00	\N	\N
28	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IjhXSzNnYnBIUk1MZFZxbVU5ekNxSHBVV1E3cDJpSyJ9.8vPmHuQjgy1N0yDmLYKSmdURAjYF0_k_s5ZDSZYhrXU	2023-10-04 18:05:12.167644+00	read write	3	295	2023-10-04 08:05:12.168262+00	2023-10-04 08:05:12.16828+00	\N	\N
29	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImJyUmhZcE1BbGhsbEpTMkJZa2VqVkI4T2l2SHM5aiJ9.ma2syjDARaev4LdbULgG9IVTT68zSP9KAlbR3Z_K-Ps	2023-10-04 18:08:29.038396+00	read write	3	269	2023-10-04 08:08:29.038896+00	2023-10-04 08:08:29.038907+00	\N	\N
30	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkFYbktFVW9aM3lyVnRRcjR4OWF6NmVXRUV2elBFdyJ9.3nUskfm6jBZ3RvohWq-CF66pyMSP0i9vFg1TTJf1ODw	2023-10-05 03:49:46.278585+00	read write	3	156	2023-10-04 17:49:46.279199+00	2023-10-04 17:49:46.27921+00	\N	\N
31	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IjBkYXAxRVQ2bUtkVmdTbEdrZG11OGlZM3VDUHVpVCJ9.XG8-kOXXxT2OnISvNsP_Dt-rkkmgH4dtfl1iJligbUA	2023-10-05 05:29:18.639992+00	read write	3	273	2023-10-04 19:29:18.640428+00	2023-10-04 19:29:18.640439+00	\N	\N
32	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImZWZTRtQlI4TWk5V05uRUxiWlhad0lSaHppa3paeSJ9.TwDiLK35LWWxGIQbV5qbD7jZ4kzzSpyrgeMTkSySQSI	2023-10-05 15:59:35.357201+00	read write	3	156	2023-10-05 05:59:35.357619+00	2023-10-05 05:59:35.357629+00	\N	\N
33	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IllLWnFmQklXTGI5ZzU4Q1hqc3FGMjB0TjBsQVNrMyJ9.zU_tOvvE7gqi9dgVFgKpudIJy_6y-MBb2Fs1mF1-87o	2023-10-05 16:55:54.935748+00	read write	3	278	2023-10-05 06:55:54.936167+00	2023-10-05 06:55:54.936177+00	\N	\N
34	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IlNmRmJicW9YVGxuakNNY3R6NDZWR2pHaEFzYk1kTyJ9.xATiEM5svvMvecNxVHz0b1SSOLh2RG03unkZOLch4sw	2023-10-05 21:21:15.622148+00	read write	3	273	2023-10-05 11:21:15.62263+00	2023-10-05 11:21:15.622641+00	\N	\N
35	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IldISUswMmYwOVVTZThWM0lxUEN3Z0l6cElXY1pIUiJ9.YtYhtj4kc6GOIIHrT4WS4lVHrOb-DCeN6XAwkw7SCyE	2023-10-06 01:41:46.889455+00	read write	3	297	2023-10-05 15:41:46.890511+00	2023-10-05 15:41:46.890522+00	\N	\N
36	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkJoRXFJbjVJUmgzcEZQQkRaeG5TdDd4RUpjU3RudSJ9.Hhewh9hkPGY8mZRQ_kMDOUMv5HzWsHJT9y5ke77suB4	2023-10-06 02:42:18.091433+00	read write	3	156	2023-10-05 16:42:18.091852+00	2023-10-05 16:42:18.091862+00	\N	\N
37	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Ilp4c1lnNjExN0JuVzFuRjkzdjQwWUhmNzB2ckV2MiJ9.eOqOfqNs3DuB5HQ-WTR0aA5_Fb_JiYMtZnrE6S5D5FY	2023-10-06 13:43:17.16851+00	read write	3	156	2023-10-06 03:43:17.168921+00	2023-10-06 03:43:17.168931+00	\N	\N
38	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImtZd1ZNUzFKVVVWcVp3NU5hYU8wVW11T2JjbnlKdyJ9.p61tXQKhKDo_apSSOaKsHbxX6pJ3jbnmMj2WPT9glkc	2023-10-06 21:06:27.36361+00	read write	3	273	2023-10-06 11:06:27.364021+00	2023-10-06 11:06:27.364031+00	\N	\N
39	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkZMaDh6c2FpQTlUYklSTlNTV0pneG9HaGl4bDhmYyJ9.NGh_dI0k0gaoi8B_4CIe2fhzSCgkb_zx6s-489pn8_g	2023-10-06 23:56:50.537684+00	read write	3	156	2023-10-06 13:56:50.538163+00	2023-10-06 13:56:50.538174+00	\N	\N
40	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Im1xMmw3WXNuVTFickxnSXdQMnEyWUFNSWRRT0VUWSJ9.omGvi6xK5r8AQ6M1N0Nub2SLTBznBCiys_9NGbHUOU0	2023-10-07 16:50:51.923539+00	read write	3	156	2023-10-07 06:50:51.923965+00	2023-10-07 06:50:51.923976+00	\N	\N
41	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InZvM2VIajhKT0w0anY3V1lIN2dTWVVvcFozeVBSYyJ9.cdAqFFUrZPIneMqV6ObvGL4hQnU-DawXAvX6HwK5AtY	2023-10-09 00:07:06.825645+00	read write	3	273	2023-10-08 14:07:06.826294+00	2023-10-08 14:07:06.826306+00	\N	\N
42	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InlhaFA1QmhxbVBHMmtQd1NBSEVTQ1U0Z01SaTA5TiJ9.1UIpy8kB_ptA1epMYGPIsPjFHUsoytanrLitzz5z71A	2023-10-09 20:10:58.731886+00	read write	3	273	2023-10-09 10:10:58.732303+00	2023-10-09 10:10:58.732317+00	\N	\N
43	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IlgzaHVqdFBYc0E4OHJvNjlGbU1oVW1wd3kwV2M0WiJ9.Ogt3TwRH_XJpxzzWkIGB1wEtt8-7-gF5rFL1l8-tylM	2023-10-09 20:29:16.518486+00	read write	3	300	2023-10-09 10:29:16.51943+00	2023-10-09 10:29:16.519444+00	\N	\N
44	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IjBvTFhOcmM3VWx2SEdNcmlidHhCM0ZVSnBJck5xTSJ9.vLPRPsm34WbLjps2ZpuX99j-JqHUm-2C0c4yV0kZni4	2023-10-10 18:19:12.490846+00	read write	3	271	2023-10-10 08:19:12.491265+00	2023-10-10 08:19:12.491275+00	\N	\N
45	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkZiVmRBaWc1RjdiaFZ6YnlRTWFteVZ2VXNmdnUxUCJ9.YxOZoWbGxONxlJdONVHYjkj_k0PAgRhwvFEZ3jGIclg	2023-10-10 18:40:16.178011+00	read write	3	156	2023-10-10 08:40:16.178423+00	2023-10-10 08:40:16.178434+00	\N	\N
46	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Ijl3akh5ZEVIWkl5WFFLclFUV2VtcXFDY29kamNrZyJ9.4_tcIKTpXpZZwSQrnRFNgmvpA3PjkUQm4lUDUyB20Gs	2023-10-10 23:02:02.163956+00	read write	3	186	2023-10-10 13:02:02.16575+00	2023-10-10 13:02:02.165763+00	\N	\N
47	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IldFclpIMTdOWVM1cVZzWXV2NFlSM3hkU1J6TWxCbCJ9.pqh-vylfSYfeZxP8hBWnB6psCJiHom1TXsucqqKdRzI	2023-10-11 00:49:30.437397+00	read write	3	167	2023-10-10 14:49:30.438038+00	2023-10-10 14:49:30.43805+00	\N	\N
48	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InFxRkdBTG5LY2ZEbWZrUUhvYUxvdWRMYjB0bjhFZiJ9.ELKws8xk2duXzEpPDkF0bwL4JyOq_Odb6Z6AJm4j_mg	2023-10-11 06:10:01.823195+00	read write	3	278	2023-10-10 20:10:01.823697+00	2023-10-10 20:10:01.823706+00	\N	\N
49	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Imt5alNhWFdzeEtDQ0EwYzZzZThBMkNSS09CbEk1VyJ9.h4jzt4QLLJOoemiqVXLbJjuNjD2nSm9MF6DOhY3VqMI	2023-10-11 22:38:19.749125+00	read write	3	156	2023-10-11 12:38:19.749604+00	2023-10-11 12:38:19.749614+00	\N	\N
50	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IjdTOTRCT1NjUEdoU2VHR0xZdFgwUElDNHJhbmNUSSJ9.DXhwv0xiLBe8lLDrivYf_LYQEqn9HEJYc-d1Ai8LXgw	2023-10-12 18:43:50.439397+00	read write	3	278	2023-10-12 08:43:50.439943+00	2023-10-12 08:43:50.439954+00	\N	\N
51	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IlFUUHR0VDZpbjdXSExYQ2s0aVFLRjNXT3B0T29ZMSJ9.HfPZaOm9DgbBOqjLZuLG0yCfpHFJPz9V7mzGep4qJFk	2023-10-13 03:39:50.50898+00	read write	3	156	2023-10-12 17:39:50.509473+00	2023-10-12 17:39:50.509484+00	\N	\N
52	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkFKTkJhOElHTzE0eEo5SllER0hoMDNKWEV3N3dpVyJ9.kGuX482pKGPiLZezqYqWJwAMUYvV7D0SsEvd4Rxk_3s	2023-10-13 21:23:23.364502+00	read write	3	273	2023-10-13 11:23:23.365169+00	2023-10-13 11:23:23.365181+00	\N	\N
53	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImNDZ3JlSEJadlNwbzlDT3JQQnhZa0RiNFhFWllWbyJ9.j8DKy-MP_phcD8p5Aueuv15lil2qpodduZ3T1chvYLA	2023-10-14 05:27:25.844977+00	read write	3	156	2023-10-13 19:27:25.845461+00	2023-10-13 19:27:25.845471+00	\N	\N
54	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InB6RFNSQWtFVEJ4VTBzaEFkVmxqNGdxeHdmNkRwSSJ9.9gSpcM2CF1Rx6w-hID1nqbMY9S2OVsepJ57XwXtXHy8	2023-10-14 19:52:04.515022+00	read write	3	156	2023-10-14 09:52:04.515517+00	2023-10-14 09:52:04.515527+00	\N	\N
55	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImZTb21NbjJUYnE0ZHY4QzUwRVFDUE02eEZOc2pCSiJ9.FIV4SEU1E4lQYTPOhFkadNZQKWydLDTHdn6QEHaA-qU	2023-10-16 00:08:56.777976+00	read write	3	156	2023-10-15 14:08:56.779027+00	2023-10-15 14:08:56.77904+00	\N	\N
56	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Ik5EU0s2blJ4dVhLWmVlSUZEU09yWEs2b0lvVTRYeCJ9.f3GhUPNv3AbD4AN6nPyfyhj5fLsIz7C9hRZhhAaSYxc	2023-10-16 21:04:54.228742+00	read write	3	185	2023-10-16 11:04:54.229206+00	2023-10-16 11:04:54.229216+00	\N	\N
57	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkFSWlFFUGkxOGJPaHpnSm9pT0dEUHptS25MV2FQQSJ9.4OnxOJq2_S8eX7vpHn2BGDXPplVgq1WVrAvzBkzHODY	2023-10-16 21:58:41.454818+00	read write	3	273	2023-10-16 11:58:41.455406+00	2023-10-16 11:58:41.455417+00	\N	\N
58	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Im5SeEZOTFBLR2kxeW5sU1RETGlHcDlkT3lmem5JQSJ9.ZwGW0eUzgkchTHmKfBuzkH0hNno5CL2vpzM4qhUEDDc	2023-10-17 06:41:33.909577+00	read write	3	278	2023-10-16 20:41:33.910074+00	2023-10-16 20:41:33.910084+00	\N	\N
59	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Ik9LemtlWmd0bnc3UUJDME9lTm9nQ2dneUN2UGdwbSJ9.ohWHx9YFvpzq_VeaJrjh8QVTB4Ma0m0TA3orBNGXpBI	2023-10-17 19:19:14.341223+00	read write	3	185	2023-10-17 09:19:14.341675+00	2023-10-17 09:19:14.341684+00	\N	\N
60	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImE0VEVNTUpqd0NqQlBoVXBDMnk1aDJGcFh2MHo1RSJ9.0remWncgEShzXl-XSE_f_5liwVob6Ct-dU5KU1Lnx1Y	2023-10-17 23:00:03.425096+00	read write	3	156	2023-10-17 13:00:03.426244+00	2023-10-17 13:00:03.426259+00	\N	\N
61	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Ilh2QWVudlVMdngwQTg3Vld1M0VYb29BcXEzT0hDbiJ9.Ytwm3_8BR9FhNezuW2ydWZ4Q0k8A-45D4oS7aE5qKPI	2023-10-18 06:59:58.234586+00	read write	3	157	2023-10-17 20:59:58.234981+00	2023-10-17 20:59:58.23499+00	\N	\N
62	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IldtWWd6R0tPQ0NnRXlDZDV2Q2RndjI1bVc2R1VqcSJ9.IFsuWdvQtEOkYFIbHEenM7IvA6HL_4xj-QPiRIpl7TY	2023-10-18 07:18:44.771904+00	read write	3	309	2023-10-17 21:18:44.772274+00	2023-10-17 21:18:44.772283+00	\N	\N
63	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IndoRlk1QkFCeVZoaG44OWJVNFBCWTU0NWQyb0VOTSJ9.gZTNYrCXXS04YtHXLbHw3lnw7m4UAZq_OQJT9CWaRPY	2023-10-18 09:07:39.29918+00	read write	3	311	2023-10-17 23:07:39.299572+00	2023-10-17 23:07:39.299624+00	\N	\N
64	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Im5qWUFodGNIWTF2VnUyaTJndFh4ZktibFp3SHJLNiJ9.3weOtQ4gT0daTo-jKbx74uqYPSpq22caA5Ew4WbuycA	2023-10-18 16:11:40.595146+00	read write	3	110	2023-10-18 06:11:40.595619+00	2023-10-18 06:11:40.595628+00	\N	\N
65	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IlNFbnRMYm5kZWo2Vm43V2hCTGZ5RG1jZzhnYlRsSyJ9.XfC-xw-ERkmSlwni7JVE8UuR3ywOrq-XkAOQ03s52Ak	2023-10-18 18:45:02.887581+00	read write	3	146	2023-10-18 08:45:02.88808+00	2023-10-18 08:45:02.888092+00	\N	\N
66	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Im44UTdqbkpxek9TYW5PckhpOTFmZ0NoeG01ZjNvcCJ9.ef8ZNluQYlfUdPgJOcio28OHD0U4LyXDiRRB0Jr45cE	2023-10-18 20:15:54.208209+00	read write	3	318	2023-10-18 10:15:54.208649+00	2023-10-18 10:15:54.208659+00	\N	\N
67	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Im5jZU41aEtvSjVwc0swZkdGSGdXNEp5WjVwcW1laSJ9.RBibx_9oI62VTZzdAvg_8muUfL38-jVWFuLdufZHa3k	2023-10-18 20:16:41.09921+00	read write	3	316	2023-10-18 10:16:41.099785+00	2023-10-18 10:16:41.099795+00	\N	\N
68	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImRVU2NnN3B5cm15alRUUEtCTGowWkJXcE9FVXJhYiJ9._vzUzSahygQZZR6d4Z-NtTO0o3rcaqv3JgdriAPVqdQ	2023-10-18 23:25:10.440264+00	read write	3	157	2023-10-18 13:25:10.440814+00	2023-10-18 13:25:10.440825+00	\N	\N
69	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkVSVnBEVFdKdmpqbmk3eW01R2lCaHpxYjMxRmpOYiJ9.jqwzmw66Pe_vX0FtxTWOtBBgtgL73-cx4mNbzKcThJk	2023-10-19 00:19:16.794563+00	read write	3	156	2023-10-18 14:19:16.79495+00	2023-10-18 14:19:16.794959+00	\N	\N
70	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImVOc093MHhxdzN4MmdadXNvN3VQRHhCNVJQdlVyeiJ9.2kODwlZ3df_HofhLKiyk4--SHalLvc2FDKz4dD_mZ14	2023-10-19 20:49:36.143411+00	read write	3	318	2023-10-19 10:49:36.143981+00	2023-10-19 10:49:36.143991+00	\N	\N
71	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IlI4TlUweFVXcUxDdnJkbFlhN3FDSjJzbVBldkhSMyJ9.9JVgf4NF7NRS1a0gSGIo9BXMEmReOo4_xb3QWIIynN4	2023-10-20 20:01:05.467267+00	read write	3	105	2023-10-20 10:01:05.467639+00	2023-10-20 10:01:05.467648+00	\N	\N
72	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Inp1ZmszWktaVWJzVWdWOE1wYm5CdTJnVEVpQ3VqYiJ9.fcS-hl_JNAlsAdhpj60kkuFniL5TrTxezHnAv3RJJCA	2023-10-20 21:10:03.967437+00	read write	3	273	2023-10-20 11:10:03.96806+00	2023-10-20 11:10:03.968071+00	\N	\N
73	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InRMZkM0eGcwMWhEREo4b3ZNenFxR0x1S1VITjQzQyJ9.hBZyiilySBQKj-UB0AqTbbKrcvBf6ZFUf1MsrLAHGMw	2023-10-21 23:39:28.620354+00	read write	3	156	2023-10-21 13:39:28.62078+00	2023-10-21 13:39:28.62079+00	\N	\N
74	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkdtRFVzaDFoamxjVEpSWFBCcFA0Ukh3ckZ5aTVhSiJ9.avPl08n5PGHHisjP7ouCGIErObxfzm9WY-3Rbxo7m5M	2023-10-23 00:35:59.626651+00	read write	3	316	2023-10-22 14:35:59.62723+00	2023-10-22 14:35:59.62724+00	\N	\N
75	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Ilk1ZHlCMFJ1bGVPbFBGWkZ2ZzFKY0xIV2hwVHNISCJ9.F-vHj9ipkKoD_zwEIHmuILqnBFD1S6_tVLdZOaBEJQQ	2023-10-23 03:14:49.190968+00	read write	3	186	2023-10-22 17:14:49.191317+00	2023-10-22 17:14:49.191326+00	\N	\N
76	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Im5yYVlkWW95UUprMUlKVXh0NTlIdHU3aDREZ2JUeiJ9.DSrZUMzWMqNSXBUVVXkR3fV4WaHPyefpV0Sd0rtLKW4	2023-10-23 03:54:04.832485+00	read write	3	156	2023-10-22 17:54:04.832879+00	2023-10-22 17:54:04.832889+00	\N	\N
77	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkNBTUZMNFZhUGRIVXZQNFdiWXhBYjNNVU5XdmdsWiJ9.FhRCKfvycqpeMTPuXa3RxjWxmAo836pird-BL6ODQbA	2023-10-23 23:01:03.055726+00	read write	3	316	2023-10-23 13:01:03.056231+00	2023-10-23 13:01:03.056242+00	\N	\N
78	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImUwbjgwV0pKUE1xRmN0bDN2MFNvZXhvS0xZbmNVUCJ9.m_-TL8ZtRbvr4jGYpK1Gek_NuWtV-oE51gO6dHEl3gg	2023-10-24 03:16:12.11513+00	read write	3	273	2023-10-23 17:16:12.115744+00	2023-10-23 17:16:12.115755+00	\N	\N
79	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkdRNXNuRkxPM2haMGVINXg4d2VFUjU0UThqaW9NZiJ9.LGebdF4M01qpr3MlYtWqODubottskGlQGRigQZnrfJA	2023-10-25 01:07:59.222019+00	read write	3	105	2023-10-24 15:07:59.222497+00	2023-10-24 15:07:59.222508+00	\N	\N
80	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InZnMTJNcWU0cmVKVFJvWGRVaE5qdU1nTldzSVBaZCJ9.71KEelZTM6NipYMPHkwpoNP4fYWfWsn8Tp_-Wioee4E	2023-10-25 04:40:47.164379+00	read write	3	158	2023-10-24 18:40:47.164917+00	2023-10-24 18:40:47.164932+00	\N	\N
81	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Ik5ZUWtERHV1eTh6VmhLVThlalUyQTFmYWIzb1NjYSJ9.zqv9OaiM5Zx-Uagbt81wygu4uB1OWN7sO76xh0VQlOQ	2023-10-25 05:58:43.487369+00	read write	3	318	2023-10-24 19:58:43.487897+00	2023-10-24 19:58:43.487908+00	\N	\N
82	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InZyTXZ2YkpEV3dGRlJIZDRmSzlvOWhtZkY2NDNmcyJ9.EBveKXNSKc2uA7wPqe9zxf9VVKXXAxZXkeESk1QkjQU	2023-10-25 07:05:40.343211+00	read write	3	316	2023-10-24 21:05:40.343623+00	2023-10-24 21:05:40.343632+00	\N	\N
83	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InhZaU93elhCOFN4S2VDWlN6ZGtRVW9lNktrbk1obyJ9.EUdDk6vQhlnlBAjGdVZpkzdJnk9lVlaX3-yYnX2mnUk	2023-10-26 01:03:01.69691+00	read write	3	316	2023-10-25 15:03:01.697347+00	2023-10-25 15:03:01.697356+00	\N	\N
84	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Im5SSWFNemEyQ0dvZnFlS3JDZlRwenVaRG14UWs0VCJ9.hlZ9lXecfcynThf1ciVt-Tuv7-3y7wmljktKoLPlylg	2023-10-26 01:11:53.607338+00	read write	3	318	2023-10-25 15:11:53.607719+00	2023-10-25 15:11:53.607729+00	\N	\N
85	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InVER3dMNVc1NFJ3TzRnSVRmZldGM2g5d2hqcEgwViJ9.kIW7zyJ330Mbs11iq4Uc2LM_gptTgfetrEqWqSibass	2023-10-26 15:16:07.340168+00	read write	3	105	2023-10-26 05:16:07.340538+00	2023-10-26 05:16:07.340547+00	\N	\N
86	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IlZkU2RKY3ZlazlnRFFSalRYUHQ5bEx1Q3ZXU3dqNiJ9.GlqLRidVYTzWjrzTn2qtFiXvuPzdUvAmL2mHB9G_b7k	2023-10-27 01:58:09.636567+00	read write	3	278	2023-10-26 15:58:09.637205+00	2023-10-26 15:58:09.637241+00	\N	\N
87	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Ilk3WDBrdkN6cDM3T1hkZmthTExuTGlvMHhpcXlwQyJ9.-wR_4nKETBZL5zPTFG6iQqGWExleay8RWuVGSeIk94s	2023-10-27 02:46:55.357866+00	read write	3	156	2023-10-26 16:46:55.358238+00	2023-10-26 16:46:55.358247+00	\N	\N
88	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IjlPd1BNdVd4TnRKc2E0REpWMDMzQVpmaXp2ODNJUCJ9._sYr9ivq7d3fEBkhsgzCeEnXHoZDJU6nOTdeSpYuh8I	2023-10-27 05:19:12.616808+00	read write	3	318	2023-10-26 19:19:12.617283+00	2023-10-26 19:19:12.617293+00	\N	\N
89	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IjVaODZRalFBeUhSZ0d3ckJGTFlkSEQyYlZrbU1XUCJ9.7riNNAq8QVlwk4-_CFOjtadVwl3pDBKR9RZK9GSRNJ4	2023-10-27 19:14:45.845368+00	read write	3	316	2023-10-27 09:14:45.845891+00	2023-10-27 09:14:45.845901+00	\N	\N
90	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Iko3dTV4UU9KUXRzRkFzckRLeDJHRkhiWE5ONVE3bSJ9.qgkZa0rXGVfB2EN0tk8aDdbzZrOJXnik1TjDW9gY3NA	2023-10-28 02:48:54.165304+00	read write	3	278	2023-10-27 16:48:54.165807+00	2023-10-27 16:48:54.165817+00	\N	\N
91	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IlM4Y2loanpVNVFzdFkwcTdmYjkwOHFZMzdoTnV1RCJ9.aS8XQ_4vRL8SujyXFT5WAsSUjZC0XxfQDUxvh4Q6R1E	2023-10-29 19:37:20.734638+00	read write	3	157	2023-10-29 09:37:20.735178+00	2023-10-29 09:37:20.735188+00	\N	\N
92	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImpnUnljQlRna2VIVW5Oa3Vza1MzWnlIWTNTYW5xSSJ9.eIq7yM_e1j2rtbHwE7ja6FARNKr1LzVULjCpDt87ga0	2023-10-30 02:04:18.703566+00	read write	3	156	2023-10-29 16:04:18.703945+00	2023-10-29 16:04:18.703955+00	\N	\N
93	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IjFiUmRtVHdPTE96YnZIWVZMMnc4ZkVjcDF3RGI2SiJ9.GBk6PQsjHR0c6dFWZ4ynIsvQE3swIfXOEGZRsuEj13E	2023-10-30 03:36:34.498159+00	read write	3	328	2023-10-29 17:36:34.49856+00	2023-10-29 17:36:34.498639+00	\N	\N
94	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IjZ0aDJ4TEh4Z09NdVlmYUFpcXpjOGJHeGhVWjI4VSJ9.c8wstSdjP6KI7AuOB7k1T2QWqzCU11_2yxXgXW3ulR0	2023-10-30 06:32:05.507466+00	read write	3	278	2023-10-29 20:32:05.508052+00	2023-10-29 20:32:05.508062+00	\N	\N
95	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InRnVlZKSnVnQ1d0WjRQQnJXNTJLam5IcWh2MkZtWSJ9.HU4xGjUiSxDv5XrW2-OI2A4xTGqTSwL_cKqIpk6DQ24	2023-10-30 15:17:55.94842+00	read write	3	328	2023-10-30 05:17:55.948984+00	2023-10-30 05:17:55.948995+00	\N	\N
96	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkZoNVBwazZDUHFmU0ZmZFNCNUk0cEQ4QVdmR2MyVyJ9.TbXfrXnupl0Cn11tVlhVfCelXdojPxzWzzvyDLgDtos	2023-10-30 17:59:31.598284+00	read write	3	309	2023-10-30 07:59:31.598777+00	2023-10-30 07:59:31.598981+00	\N	\N
97	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Iml2SlJRbDVaUzhtTWJzQ1h5c09oNmx1QVh0elRJdiJ9.VvT1GbOE8QBaErNc_8lJb_sloYxFv9sN1ZiCwHlEdIQ	2023-10-30 19:09:49.018348+00	read write	3	156	2023-10-30 09:09:49.0188+00	2023-10-30 09:09:49.01881+00	\N	\N
98	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IjRpSFVKSFhjeXpkMTNxNFA2T3VSeEZVTXFocE1GUyJ9.W_zL92xb5QXmWlPtpLX54xUOnWvgBzkTY2pONv9_rxY	2023-10-31 06:00:19.186137+00	read write	3	156	2023-10-30 20:00:19.186674+00	2023-10-30 20:00:19.186685+00	\N	\N
99	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImNOOW9nQVREYVRrWEdYZ3pjRVFmWU9nRzhRRE5sbCJ9.LLh0_Hlxnt-Lq1d5-k4UqBuwLNlAMv0IqlA02db4i1c	2023-10-31 07:50:10.579829+00	read write	3	278	2023-10-30 21:50:10.580233+00	2023-10-30 21:50:10.580243+00	\N	\N
100	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IjBES2ZYRmJCUnY1R2MzMFhhb1N4WVFTa0JVbmFXOSJ9.5BiMgl5KeVrtMnUVvfd2YBuix56L_8W3RBi-gMyhzrM	2023-11-01 00:39:13.905647+00	read write	3	156	2023-10-31 14:39:13.906207+00	2023-10-31 14:39:13.906217+00	\N	\N
101	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkZmcE0wenEzTjVWOVludUR0MFI4YUw0WG5LSXg2byJ9.o0FJlateH_ZqpEBNo_OVKUzFGrzAG5bx_jsBk9ymfmM	2023-11-01 02:38:18.054888+00	read write	3	278	2023-10-31 16:38:18.055284+00	2023-10-31 16:38:18.055311+00	\N	\N
102	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Im9EWHNEWHdTV3VKRmZaSXkzNEhsaFFlMUtDWElSUSJ9.ApdhXRoMDEsF45nCKF0ZqUVp0qjzgcTQq4FtGCb_enU	2023-11-01 03:27:22.217149+00	read write	3	339	2023-10-31 17:27:22.217635+00	2023-10-31 17:27:22.217646+00	\N	\N
103	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Im1aaFdoZTZaQjA4ZHh6Mk9Pa21xeWJWVnpoRlBmNCJ9.1cfUhWpAX-Abry8nk_jyroEvMahCYdfCbn1QEvKWSnk	2023-11-02 00:08:03.490443+00	read write	3	74	2023-11-01 14:08:03.491024+00	2023-11-01 14:08:03.491034+00	\N	\N
104	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InJNSnVVWTRvNnJ5OGZwTFFIbURjd1pKYjRKT3FieSJ9.ggCmd67yNA83QagUBpRc97xT8lzIh7YFa1SX8Es0XKs	2023-11-02 01:36:10.831996+00	read write	3	328	2023-11-01 15:36:10.832639+00	2023-11-01 15:36:10.832649+00	\N	\N
105	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InBrUW9BNFYzck0yQ0ZEMmFzZHkwb3BWMmtYd01HZyJ9.UEKul6Fr9VO61cmv5J2fl8ovGGXsscpfssEIqPG0ezU	2023-11-03 03:44:21.730082+00	read write	3	341	2023-11-02 17:44:21.730741+00	2023-11-02 17:44:21.730752+00	\N	\N
106	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImZMUGpnbXhhdVA2c0trQjNOeEtpSkc0dHFYdHNNUiJ9.OdlLzAen1ARYYZ7Oh6HYdkgzTUsNoMxIzCcTNVQNTFc	2023-11-03 05:06:12.871913+00	read write	3	278	2023-11-02 19:06:12.872348+00	2023-11-02 19:06:12.872358+00	\N	\N
107	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkZsOExPZDlBemhWd1NoRkM5VFhGRVZoWlE4cjRhZyJ9.5ypPndyJPj_KeWd1CYfIuoO8MRarFADT9m7KGxfciRU	2023-11-04 19:15:16.241844+00	read write	3	74	2023-11-04 09:15:16.242716+00	2023-11-04 09:15:16.242727+00	\N	\N
108	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IlNlSks3SUljd2JzYU55cjcwMWZwNWoyd2xLY0V5RSJ9.9pSMKEhVaOuX5vn5v0ldYNOqJPBHkB3PdeUXtmt3Mzo	2023-11-05 00:08:33.907836+00	read write	3	156	2023-11-04 14:08:33.908279+00	2023-11-04 14:08:33.908288+00	\N	\N
109	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImxQZmJsSHlXUmludVR4dFJ1Z2RLUjZjZ095bERZeSJ9.mEna_7ifDLRrsCthQKQD_MVVZhuOZ1hljEFBGTe8xxY	2023-11-07 00:31:43.1141+00	read write	3	273	2023-11-06 14:31:43.114951+00	2023-11-06 14:31:43.114962+00	\N	\N
110	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImJmbXYwSEJYa3QyTDhwb1lXOGVvbkRuQmgxWUpJWSJ9.vrWT1eMMhUc10O0DuspB1rDrP5P9dcSnOPol_5r7WNM	2023-11-09 01:21:03.913112+00	read write	3	278	2023-11-08 15:21:03.91359+00	2023-11-08 15:21:03.9136+00	\N	\N
111	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkhJSWVjelBQUFVVVkhWUGpHcHJYandKT2JNTzZSUiJ9.cwnUFYWy5pHmjwyNy3EdUTFB6h2lK7N4mx8pJs0c6GM	2023-11-10 18:33:37.564118+00	read write	3	341	2023-11-10 08:33:37.564633+00	2023-11-10 08:33:37.564643+00	\N	\N
112	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Im5SRWNTTUxmczV2YUZRTk5VYXBrQjRlY0pqR1hzYyJ9.qmIbXgvpk3hyEeAGwy4O9fvTlfprFVzf2NDTURJRspc	2023-11-13 11:30:08.482625+00	read write	3	343	2023-11-13 01:30:08.483179+00	2023-11-13 01:30:08.483189+00	\N	\N
113	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IjFvZXlRVUdtMklhQTBJNXZybXh3eDJWa2ZZRFhCZSJ9.un7_sQoR4_x60SGcs4wzsz5VAtGh2TbTkBbMRalNP70	2023-11-15 01:16:37.849218+00	read write	3	66	2023-11-14 15:16:37.849824+00	2023-11-14 15:16:37.849835+00	\N	\N
114	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImR4UGh3WlFKVnZrR2NKeHE1UW1pNGhPZGdERVdUaCJ9.4--VWioWie5ZO4zxdsd15YtpVNXD3Op2cLx62-l150M	2023-11-16 03:33:22.595165+00	read write	3	278	2023-11-15 17:33:22.595725+00	2023-11-15 17:33:22.595735+00	\N	\N
115	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Ik1qZzNmdHVRMWlvNGR1QzZPSmdZUEVqMU5RcVpBaiJ9.llHb8vF6sEcVYZpN2Sv9fVHVPA9TR-8hwW_ctI3BCWo	2023-11-16 18:00:58.15961+00	read write	3	110	2023-11-16 08:00:58.160126+00	2023-11-16 08:00:58.160135+00	\N	\N
116	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IlNkeEZFRDloYTBVV3YxM3RXYVBQWGxUc1paTGtRbiJ9.VkszSbyWI23ct5rB0J3sg8FCfxwjkt_eQ8o7isdB7-E	2023-11-16 21:01:55.435306+00	read write	3	278	2023-11-16 11:01:55.43581+00	2023-11-16 11:01:55.435821+00	\N	\N
117	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InFBcHRkSFFPTmZZMnFmSGlJNTFDRnZJQUlCNDEyeiJ9.kkFBIwBA61a0rmTjc_-Pr6hUGvted6DQg-WeSMOrJ44	2023-11-19 08:40:39.101703+00	read write	3	273	2023-11-18 22:40:39.102404+00	2023-11-18 22:40:39.102417+00	\N	\N
118	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IjdrcVlobUVaZVgzVzk4SllSbzBEUDVjeW1EeEllZSJ9.QE3krbdvw2eJZ_Fr33XryT7t7AZCn78hKt98K89iGmA	2023-11-21 05:08:00.389491+00	read write	3	345	2023-11-20 19:08:00.390053+00	2023-11-20 19:08:00.390064+00	\N	\N
\.


--
-- Data for Name: oauth2_provider_application; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oauth2_provider_application (id, client_id, redirect_uris, client_type, authorization_grant_type, client_secret, name, user_id, skip_authorization, created, updated, algorithm, post_logout_redirect_uris) FROM stdin;
1	iwTBwWlxs7O0xi0WxZQEhdqfYuVOOacxMirDor7z		confidential	password	md5$MHQmTWXhN0UnTHXXFdDPZN$fc6552ea5b663bf0f60c21f0aa3329df		\N	f	2023-09-03 12:11:12.029757+00	2023-09-03 12:11:12.029779+00		
2	ZBWIJ16lyyMgtP6FlD35cKHWFT1QPD6pwYgLNkHM		confidential	password	argon2$argon2id$v=19$m=102400,t=2,p=8$dnRPWXZGYU9uRFhIeVdNdnRIQnZMNA$soUV9sVbCDqdQNIkLrfUbQ		\N	f	2023-09-03 22:35:12.050715+00	2023-09-03 22:35:12.050789+00		
3	ha0ISIDOU2nX4oZxJuas7dEgToCpIWfYLqdxFOyt		confidential	password	argon2$argon2id$v=19$m=102400,t=2,p=8$ZE8zNU4xU1hieTV0MEp1VEx0ejlqVg$UFecrk8taHFcTfdFzwobGQ	App	\N	f	2023-09-04 19:22:28.788914+00	2023-09-04 19:22:28.788947+00		
\.


--
-- Data for Name: oauth2_provider_grant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oauth2_provider_grant (id, code, expires, redirect_uri, scope, application_id, user_id, created, updated, code_challenge, code_challenge_method, nonce, claims) FROM stdin;
\.


--
-- Data for Name: oauth2_provider_idtoken; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oauth2_provider_idtoken (id, jti, expires, scope, created, updated, application_id, user_id) FROM stdin;
\.


--
-- Data for Name: oauth2_provider_refreshtoken; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oauth2_provider_refreshtoken (id, token, access_token_id, application_id, user_id, created, updated, revoked) FROM stdin;
1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Imh2ajdYTklXb0lBZjVGYmZoZ0ZmcUc0QVV5cjdleiJ9.E0kquu32JVm8aGyG4FeVh-cP0pnTEzpWY9ZhABjxKBs	1	1	198	2023-09-03 15:25:47.577522+00	2023-09-03 15:25:47.577537+00	\N
2	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImpLU09XcFBMQ25pSEdFZWJVdHd3eHNkbzBzNTVTSiJ9.eJ5wrAbnjCDs7u7zthZhKoOxTFRP5d-mmQc-oDTlZOM	2	3	228	2023-09-05 20:51:33.298559+00	2023-09-05 20:51:33.298575+00	\N
3	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IjNnZExSUFlaNmY3emF0N3hVVXd3V1hWc0M5dkRWeSJ9.Gh1u3zCQUanxAh30jgdqJC5dw8Pe9dB6oEGhlEq0siY	3	3	198	2023-09-05 21:34:21.736606+00	2023-09-05 21:34:21.736622+00	\N
4	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InZxMXdtN3JCa2hVSkRLUTNXM1BVc2J0bERMYlRtdCJ9.JLs_QpXJxxOSFBCy9FnWMvjsS1HwlIq_UtEBmgXMN6c	4	3	23	2023-09-05 21:47:11.65663+00	2023-09-05 21:47:11.656645+00	\N
5	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InJ0WXJDTjZ5UkFHdGd4MDM3WHdDWFdlbUpBMHJ4eCJ9.dH6TvyGasdUDhGGB2bWNILmHeOec0AD4MJJe2KXq-Vg	5	3	269	2023-09-06 17:45:53.190661+00	2023-09-06 17:45:53.190676+00	\N
6	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Im5idVRjWHU2OHo3Um52ME9FWVUwcEFtNXBicllScSJ9.XBlqQsxNrAnZhsSY91GeqyhWM9CygsC_ATWCplvy_go	6	3	28	2023-09-06 17:46:44.044463+00	2023-09-06 17:46:44.04448+00	\N
7	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IjdaaFJpUEFmSnh6RjdrWW1VaUtRY0Z2aVhHeEFOdSJ9.ZToYcldHQxemoy2soQ-vqECKXbfDnDiZ3q_sk3BZxUo	7	3	269	2023-09-11 09:54:17.725039+00	2023-09-11 09:54:17.725057+00	\N
8	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IlFsNXBXdEVIUDhuSHBTNFhFYlFwbHNBRjR4N0N4eCJ9.QAcvbYJpWHg3LlaV9XlYNZ5LMdjii9c7kkdRBioyYzo	8	3	271	2023-09-12 08:28:47.642763+00	2023-09-12 08:28:47.642784+00	\N
9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Ik9sVDJZc2N4VUNQakQxOHRzNTQzQmNGbVRGdmtNSyJ9.4NbmDWcnqGpwMTihFPIwQO6pEbzFbROo_zrXo1nAsbQ	9	3	269	2023-09-12 09:14:52.780003+00	2023-09-12 09:14:52.780022+00	\N
10	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IlkzZUQ4bFQ1YzFkYVpJR04yc2RJUGc1ZzEzSEJlUyJ9.oUfWBB-PaVtC9EXK4oylDtYfkBMrJDYbzTO0QZZ9u_M	10	3	198	2023-09-15 16:28:43.535068+00	2023-09-15 16:28:43.535085+00	\N
11	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkdDSXJEODYyT2FJQmRUYmJ2a2Z3ZnhaYW1NdWtsaCJ9.HBbcrul1CLwMCFXlgzmsgYOn2BHwmqG8pscWs1PyN5A	11	3	28	2023-09-19 04:38:57.169224+00	2023-09-19 04:38:57.169239+00	\N
12	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkZITmpKb2o1Zk1lWHZ1RkdHMzF5S2dpb3U0eGgydSJ9.BRRHFaz5XhtO5BZFx8RNpK5EKr3UL-ZWy0EQldUFs94	12	3	273	2023-09-21 14:32:19.502205+00	2023-09-21 14:32:19.502222+00	\N
13	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IlZFNnZ6Y1p2akNFZndqZ09CMW1vaDB6NzBKTmE4MCJ9.syuZ-_pNSCoEbQDUOPWLUssNOHQIwC1oUfdANhCImnI	13	3	273	2023-09-24 20:28:03.725906+00	2023-09-24 20:28:03.725925+00	\N
14	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Imc1RDI4Z0lVRGg0WjNWOHhUYms2YklCSzJYZ3l6SiJ9.NtINCxUHb8HBUsMT3wJxoozJOElniyP3m4hnDyOB5vA	14	3	278	2023-09-27 20:31:49.394435+00	2023-09-27 20:31:49.394454+00	\N
15	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InU4YWVzMk1tV2dBWWZyOVlCdVRrelRlMlh0RFpwMSJ9.zMS3T1jvDj1ayoC5ZuA0W0jxQUMIFm6EQtiCEWG6l2g	15	3	277	2023-09-27 23:02:25.043172+00	2023-09-27 23:02:25.043191+00	\N
16	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImI2ZkczT3VaM0dscXp6Y3dISUhoYlRRTWpjNVVNbiJ9.HRTuxo-mgKu4nKIl6JDZ6ugs1jksoaLNUFlh3TQcL2U	16	3	156	2023-09-28 08:56:04.64943+00	2023-09-28 08:56:04.649452+00	\N
17	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IjFGZzRBOHhIS1RMWDI5YUFQM0R6dGk5eGxJNWp4dyJ9.XfnFuYA0fQLqXfSh_Js6Tl_e1j2Hvn8T7ZaN0OK-TMY	17	3	284	2023-09-28 13:49:53.363133+00	2023-09-28 13:49:53.363153+00	\N
18	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IktNQmhvcXV3RzBsQWJaZFY3RklEMEZkd1R1WnhzZSJ9.uAOqPPg1J06whMVXNI6TOzdyysQ9eHL8nLUFTJ81H10	18	3	278	2023-09-28 16:48:15.293525+00	2023-09-28 16:48:15.293541+00	\N
19	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Ik9lRkV6TXJNRWN5R0trd3pYTXVYckhWc1ZUcUVSSCJ9.Rl1OywE06rtuhMKd0Kd-ajLCD13A41xrTZADELbTf18	19	3	285	2023-09-29 06:45:10.735277+00	2023-09-29 06:45:10.735296+00	\N
20	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InB4cnB2ZW01aWJ0VmdnMWNyMEEzbXFZbGJ2NlVyQiJ9.X9oaIo70C4s-V3qeo8SpL-BP1mg0QhAlA9h2991Umjc	20	3	287	2023-09-29 09:55:32.871473+00	2023-09-29 09:55:32.8715+00	\N
21	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Im1ITHUxNFlKcmxJbzlhcmN5UHBqbUpwbnVRTEthcCJ9.TMao1g8kYM1asstTJC0K0VOgVYTUG2YZcLR3gqdJ8eU	21	3	288	2023-09-29 11:40:49.142302+00	2023-09-29 11:40:49.142325+00	\N
22	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InJGZ0k5bXRwdkVrb2pDenVtWHBLMFl4T1lSUVo3SiJ9.md5DDzYbLgTc3mDFybdtn1_Y4aCXs2DA-vfxslKURSM	22	3	289	2023-09-29 11:42:09.634781+00	2023-09-29 11:42:09.634808+00	\N
23	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkxOYWdoN3owd1NVaE5VMkdpTVlaQ2pLU3dYUzhueSJ9.EhiXw-FX6HedrGRhKUxet-xxQvB8MU5aMdXC-D1HqZQ	23	3	278	2023-09-29 17:18:57.333435+00	2023-09-29 17:18:57.333456+00	\N
24	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Ijh2Z01EYzdoU0J1ZHk5OVZUbjgweFBOTW5xM2RuOSJ9.O3GJcdkMX1cLq0J-rIX3WNE2xuLECzEy8urhs0pWOo8	24	3	156	2023-10-02 10:47:15.562616+00	2023-10-02 10:47:15.562637+00	\N
25	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IlNXNWdudzRBRGlLcWNjODhITzhYUGtwaThSVnFZeiJ9.ES2kNm4MANsaWWyg7IHznTA_1uPMFu03hxdl1caKVoM	25	3	69	2023-10-02 11:39:34.641438+00	2023-10-02 11:39:34.641457+00	\N
26	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkQ4S3pOU3ozRkdzZW5DdFRUWjVSR2lDcTR2N0pTNiJ9.6ISo249wqPb26H84HWvQ7Y3CxY_DYbs3pfpnMcPRacA	26	3	293	2023-10-03 09:13:13.07591+00	2023-10-03 09:13:13.075929+00	\N
27	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkRjakI1eUoyeFJkNERSMUFpRldkZDZtV3AyYTZHMCJ9.UCqHGNwahVp54_i-g2bUs8OF3a4-VHv0nuiCcmnDCeM	27	3	294	2023-10-04 08:04:46.702775+00	2023-10-04 08:04:46.702792+00	\N
28	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Ikt4azBkQWExaDNWOUE5R3h6dENURzhhZFN0UXBZOCJ9.DwjqdKK11DlzYhURMY-Eu8HgHTGdk-Zic9vDu7G251I	28	3	295	2023-10-04 08:05:12.172275+00	2023-10-04 08:05:12.172304+00	\N
29	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IlZpcWN6aDlvSlJIZ2p5bGszaVZwdzU1M0hTZXRHbyJ9.bRrWCmaULEuJb-mc-xulDF5SNdWAy8XuJG7w3vOTauU	29	3	269	2023-10-04 08:08:29.041905+00	2023-10-04 08:08:29.041923+00	\N
30	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IngybllBUFVmaTkzdDRkT3o5Y1NFRkE0Wlc0cHpaRiJ9.5NcD_Yn-nhZRePMW_JLsjnsgfz2-QuiHcRq5Cv25fe0	30	3	156	2023-10-04 17:49:46.282637+00	2023-10-04 17:49:46.282656+00	\N
31	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IlJZbHpSM3EwYkp4bHpxNUF4aUNOMzlRWEZOZEZXUSJ9.Bl1R_JU-Bwpuu-0RAfzBiu0zYDYV91QW38tF8FgOk8I	31	3	273	2023-10-04 19:29:18.642592+00	2023-10-04 19:29:18.642609+00	\N
32	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Im1rdjNZRTRxaldITzBiYVdlN1F4MzcxcFpFY2t4diJ9.u0vxcjVyKFw1fWvJyv2VIplNHjKi1_t8Tm6sOPaI1Mo	32	3	156	2023-10-05 05:59:35.359877+00	2023-10-05 05:59:35.359894+00	\N
33	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IlhxY1BER1NNeVhJWWZRZm1CcTlEMzhZR3ZpZ3ZXWCJ9.1thRbfTUNWTRlnorda8M9y1ekOmQ9eq5c6xX97Fv2FM	33	3	278	2023-10-05 06:55:54.938311+00	2023-10-05 06:55:54.93833+00	\N
34	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImRXcUl2VzhYaFhKYlF3Vzh4R1JRUm42blRpUm96bCJ9.KcwUe_NTR9D_p4j0Bju1AmnoTV2C-vuS1d3-Pfl8fuU	34	3	273	2023-10-05 11:21:15.625164+00	2023-10-05 11:21:15.625182+00	\N
35	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InZSbXJFN3I2azZuV2lXdU4yZENBZXBRQ1Brdnk0YyJ9.sfUPU7en9eefZz35vrLpbnc8dGpkKcpTaotlbH-C2FI	35	3	297	2023-10-05 15:41:46.894552+00	2023-10-05 15:41:46.89457+00	\N
36	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Ilp0bnRHVm1ISEl4YUpkcFk1V3dsbUZ2eGJBZnBOVSJ9.yDc4oM9fOInmEOI63vHlbW3waqT4ZWT4Z8HP7Mb7oIU	36	3	156	2023-10-05 16:42:18.093833+00	2023-10-05 16:42:18.093851+00	\N
37	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IjhTTWVjTHRVbXJOVEpMRjI1VEdZUFMyYXdhN08xdiJ9.qT-bwfKH4DGV8DUZVwwb7cWvfkghvOLYofLVR8okM-s	37	3	156	2023-10-06 03:43:17.170888+00	2023-10-06 03:43:17.170967+00	\N
38	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IjNQQ1J6cUhHR1JHaG9od0RFTGF4WHNjRmhXbE8zZyJ9.ohvoxDRFRat622mjcYpbh9cUHNYqckrb6fsqnjq09mo	38	3	273	2023-10-06 11:06:27.36581+00	2023-10-06 11:06:27.365827+00	\N
39	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkV1dXJsTlh0WGpNckdXb3QyVFN0bm5NRGNTalJReSJ9.EillaBNcpNKLrcqlrE9W0ULFvygP12Ln8l7dwrBypYs	39	3	156	2023-10-06 13:56:50.540331+00	2023-10-06 13:56:50.540349+00	\N
40	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IjNRVTRjWVJGMmRwVmQ3dVRmaEl0WFFtVnRvOHdiciJ9.wjBXcO87gZQI7tOxwh9Ngkbqi67vbTOzzxnDfQJSsMw	40	3	156	2023-10-07 06:50:51.926205+00	2023-10-07 06:50:51.926222+00	\N
41	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkNsbk5vQ2FNMTF3YXRLWDZ1Tnp1M3NWOUI1REgwNyJ9.ICggQoAKVWUaGI4ZtmFMtikYsa7U-uOxA-c2omGbSAo	41	3	273	2023-10-08 14:07:06.829651+00	2023-10-08 14:07:06.82967+00	\N
42	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IlUzWWg4R2ZZT2N0NHlhcTFWa2tiZE0wY1p0NWlPSiJ9.Jegh2f5TQsHnMWvfbgOMRG64uwkPtMWqB_OP_GbqNX8	42	3	273	2023-10-09 10:10:58.734858+00	2023-10-09 10:10:58.734875+00	\N
43	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImxOeW1TcWgwNGU0eEQ4NVdWTlRJOUJVbUY5VklkdSJ9.hfblQ6w6hX7_RK2HkdWhsXWKW-NcbaGMWFFTt5ApeXU	43	3	300	2023-10-09 10:29:16.521488+00	2023-10-09 10:29:16.521505+00	\N
44	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImdrQnNBRHNSZUs3N0JRbHFOeDJKYzNlUENTNDM4eiJ9.kD8BMj16L4WpQJib54O_i4jAK-i2Bw1YSVs-UU-TCgQ	44	3	271	2023-10-10 08:19:12.493782+00	2023-10-10 08:19:12.493808+00	\N
45	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IjNCa3Y1a1NFNE1jOE1DTGlrNmlySW4xNllNSzN5cyJ9.1CtUS0nMN2dmVLrKBzZduUwO0sciD1L0rhwi37Q0e9Y	45	3	156	2023-10-10 08:40:16.180469+00	2023-10-10 08:40:16.180484+00	\N
46	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImJ6Tko2SzVKd3dNWGlYNXNqcEZqRFA3SkEzTXRzZSJ9.3in6ekKfhkxGlVRjMkWoWCc4paNqw3t_bXCnZ1CRd4c	46	3	186	2023-10-10 13:02:02.171195+00	2023-10-10 13:02:02.171229+00	\N
47	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Inp5VVV1b3kzaGNGQWlFYlJmcGwycGsySFZ2bTBFOCJ9.68d90eVTe0s3MTJTgBFbVeZDHep3VbydZYYTeY_npSU	47	3	167	2023-10-10 14:49:30.440187+00	2023-10-10 14:49:30.440203+00	\N
48	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkJiSXdxV25qUFdmU1VKZE93dXNVc0FvRElyUjVVVSJ9.bTjlSBt1bMi7iHL2UzHHlBrdI23NqO5mA5fBWMKywEQ	48	3	278	2023-10-10 20:10:01.826455+00	2023-10-10 20:10:01.826477+00	\N
49	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Im9FRmtMR2ptOExvZGdJcGVqN3g5aUR2RmJqYkR1SSJ9.ieYN9Hq_a_Feg8yyOAaAN62Y29fqiO6FeB-DFfIN7oc	49	3	156	2023-10-11 12:38:19.751881+00	2023-10-11 12:38:19.7519+00	\N
50	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImlzQTVrZVNLdmJyUTRKRTNoSzZtOVVBVnRrMGkxZiJ9.krxsTiE3o0pD-59cgC4cCN6F7WUzsxsUearELx0kA3k	50	3	278	2023-10-12 08:43:50.442121+00	2023-10-12 08:43:50.442138+00	\N
51	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IlI2SU9hMTFZcjNTTHh3M3djSkRZWXZqaVNMQlVWMSJ9.9fW5bMKQY1ZOIfHUx3Ckp1AuwTWBuZ5B58mEWSR3jvk	51	3	156	2023-10-12 17:39:50.511775+00	2023-10-12 17:39:50.511793+00	\N
52	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IjVjQjd1STRuNm1neXVwbjBKbEhmR3pQWm5wYUZRTCJ9._FPCLu-MytOqRw2Ahcq0zjX01cw98ar7FHaJhNbJr2M	52	3	273	2023-10-13 11:23:23.367857+00	2023-10-13 11:23:23.367879+00	\N
53	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkdvNHJ2cU9zeG9LQmo0ZlQyTG1SNkNWRHpucmR4ZSJ9.Pr6hwGbXDqkCPziCMlxKaoPUXnumnTET3Xw1H-uk_-w	53	3	156	2023-10-13 19:27:25.849345+00	2023-10-13 19:27:25.849365+00	\N
54	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Ik9ESEljaWhCRnphYmtLdjlOd243SnpBV05Jb0VKTCJ9.h3qFy7chMuKs9xWcs55drDxuTdERMWtj5aZBv8ws9T0	54	3	156	2023-10-14 09:52:04.52084+00	2023-10-14 09:52:04.520862+00	\N
55	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImZ5UE8wMnkwSFU4aXdmek96ZlJTd0QzNmc5RlRyaCJ9.vD1syWVXyUJ45_GIB6Yz5KcdXVbDviBCcBPbCX4sM-E	55	3	156	2023-10-15 14:08:56.787125+00	2023-10-15 14:08:56.787432+00	\N
56	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImNCSnV6dVZKd1hOa1RoMDh3d0dJQXZnR3JFUE50bSJ9.NPqDHyosk_QjCSujMkU1EFJE3OdC4FwZTeYFmJljBnM	56	3	185	2023-10-16 11:04:54.23259+00	2023-10-16 11:04:54.232609+00	\N
57	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Ijh3U2lWUnhZV1pMRDg1YW1XWWVseEh3aE42VE1oUSJ9.OJlHAhPK8BxFLePSxB83Umh-G9GmAxtYCF993dRiz4c	57	3	273	2023-10-16 11:58:41.461343+00	2023-10-16 11:58:41.461368+00	\N
58	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImJMZ0h3RXZYSFpCaFJCcXFTWFVJTUp0SU5HYm91eiJ9.3AK4rdO_1F528_UWdC6fdmzWhMWdlbBnZoBoBXJNTSI	58	3	278	2023-10-16 20:41:33.912538+00	2023-10-16 20:41:33.912557+00	\N
59	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImM1bVFhemZ6VlNLajdweXZCOFdvZEtpbEV6NHQ2cyJ9.sK7X8oQ_b9fJ_dmOb3n0ZSaKr3w3Fus7HXZIF3s1YFE	59	3	185	2023-10-17 09:19:14.344037+00	2023-10-17 09:19:14.344056+00	\N
60	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IklRbzR3YzNVWWwyYVI2cG1GemdnandUQXBqcUFWUyJ9.HrGg52hCqPSvkEmAiRsARmBaJ49EVidv5-IQxF6g_o4	60	3	156	2023-10-17 13:00:03.431188+00	2023-10-17 13:00:03.431211+00	\N
61	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Im9GdWNMNHlFMVBwWjFRbGVRSkl6MEdDdjhxcEd3QiJ9.l-wod6mGQ-83wfnwlw0-Qm23jrBtaq-3gVqHBoQTcZo	61	3	157	2023-10-17 20:59:58.237245+00	2023-10-17 20:59:58.237264+00	\N
62	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkpBTXcxOG1UMG1pYUs5SE9ETmxURmk0ZDBVc3BUbiJ9.5VuUGmClRvlmSZZfuzALDbKYtbR5eYJ6VkruNgfr5ko	62	3	309	2023-10-17 21:18:44.774467+00	2023-10-17 21:18:44.774483+00	\N
63	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkNRejVkTnZGcjd3WFhrcUNENjFUc2VkcTZxenduaSJ9.XNsPPJGrGb_W646wFXSeEra__MArXCFDwFuebIOzwBA	63	3	311	2023-10-17 23:07:39.301628+00	2023-10-17 23:07:39.301647+00	\N
64	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InFRWWVxRjAzaWVJd01nZUE3TlBmeDhRR1JqMGUwbSJ9.A_Tpzn97t_7nN4lldQm5BPR7H1cSiThJVAqRN6DRB0E	64	3	110	2023-10-18 06:11:40.598017+00	2023-10-18 06:11:40.598037+00	\N
65	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InZRVUpzTnZrQ0IxT2RNSll3dEY5dUF6UkhFcVZkMiJ9.GCmeB2u4nyXiRDW5N3KO4qVCFmcyN0Vhtg-dH-ghtK4	65	3	146	2023-10-18 08:45:02.890377+00	2023-10-18 08:45:02.890399+00	\N
66	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InJ2MHhleVROOXZNbXlsWklCdW8zOXVZNGd6QW4ycCJ9.SaLouUM6HN97iiavRtEIhislpxmfLKG5K1mlOMeHbBA	66	3	318	2023-10-18 10:15:54.212033+00	2023-10-18 10:15:54.212053+00	\N
67	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImRaUWNjcXFrdW0xUTJzQUNSajEzdER0NUZNMnU3ayJ9.CdaJbTNgeBIaCiInkoqTVMpJUNWjnpR6h85UGeqC2Uk	67	3	316	2023-10-18 10:16:41.101606+00	2023-10-18 10:16:41.10162+00	\N
68	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImRlbzRsV0RPa3RycVY5amttNjBDMXZqVHpRY3hDUCJ9.16r1GowkQMFPKO5BvxXySOJkQnc9Oxq5jSETvAqz7mE	68	3	157	2023-10-18 13:25:10.443292+00	2023-10-18 13:25:10.44331+00	\N
69	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImNvb1c1eTJYN3NhbHZDRFVKdUt1Wld4cGp3bXBrayJ9.lECNUiu4d2mdcF3ngNtGI8AXMM6rre-pnu-VK86SXTw	69	3	156	2023-10-18 14:19:16.797004+00	2023-10-18 14:19:16.797021+00	\N
70	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IlN2SFBYc0hUSXUyMDBKM2ZLdGR6WnlaSEFCbGxZUSJ9.Ql7DRTHSNAes8JtLOTfTlmjRGA1FRAb64DhloEGFn74	70	3	318	2023-10-19 10:49:36.147248+00	2023-10-19 10:49:36.147266+00	\N
71	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImdXUmR3c3lMN1JSNlhiT1NnU3g3dVVlS2FMNnhsYiJ9.WbS1r54ZG99K8qBCyAJnklhwMg6kjIuRyK1x-ew3KUE	71	3	105	2023-10-20 10:01:05.4696+00	2023-10-20 10:01:05.469616+00	\N
72	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Ijc2RkRzeGxYdlVEbTFEckt0Z3hoT1RhSnI0ZVBDaiJ9.2C11g2NSd7IOlXlfEJ8zfcaCyoNErRO3j1xIB5Gssk0	72	3	273	2023-10-20 11:10:03.970255+00	2023-10-20 11:10:03.970274+00	\N
73	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IlRkbEg5dU1nNVR2UndEYUJxNkN1U3hhY2pWUUpEYSJ9.nOxBzyB6L0dnr9oeatylCY9XV2sqoZBpYlJ9rHrwAac	73	3	156	2023-10-21 13:39:28.622678+00	2023-10-21 13:39:28.622694+00	\N
74	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Ik5yOFZHUzJ6aFZaUTZjN1dMc09BYURZcWROaHBUYyJ9.m7mHoKOhRfC9nJqOCy7FphaLzgwyx9e_yEWVpt2hmOM	74	3	316	2023-10-22 14:35:59.630281+00	2023-10-22 14:35:59.630296+00	\N
75	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImNWM3FtSk9VTkxubXpRWWE0aURKTlJieEVCRDRRTCJ9.YHuYK2LjCUMJOQp6RaOb3bDwz9512V-xPmK8aPNgcZw	75	3	186	2023-10-22 17:14:49.193718+00	2023-10-22 17:14:49.193733+00	\N
76	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InBBbDZrYURqWHBCd2dsak9UUnFwUTRPaUNmT0NIVCJ9.WAxlI2KAY2FXR0jGZ7wkPmrb8M-o_ua0lyymlgBYu8k	76	3	156	2023-10-22 17:54:04.834824+00	2023-10-22 17:54:04.83484+00	\N
77	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImNjOVd6QkZHWExzR2V5bWloOTlCcEdCSFFGNTM4TyJ9.ZoYxVs26uahEOP5ro34QbJPEY_Cryuywo9BmWfXNY2o	77	3	316	2023-10-23 13:01:03.059194+00	2023-10-23 13:01:03.059214+00	\N
78	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImpqSVU4aGxtWGN0SGJOR3FVRFBMR2JjS1JJVHc3cyJ9.dAX1VEbp0UjmcbyaXQSq_OQwSoOjJWW80RsbSXAJlXU	78	3	273	2023-10-23 17:16:12.118784+00	2023-10-23 17:16:12.118802+00	\N
79	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkMwcjVYWU81UmhDSUk0RXpaME5FemlNSDRsYWhxdCJ9.2QnLV-W1hcOEOiBkVaDAsFMG-qhQ2fTS0fwVymNcgFc	79	3	105	2023-10-24 15:07:59.224832+00	2023-10-24 15:07:59.224848+00	\N
80	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InNLUXFycTNabVp0OWtHcmNzTzhmREhrZmR4dXRuTiJ9.6RdbcBKI5pP2lf4IJMevr4u2dcoI1Esv_zUxTUJphRg	80	3	158	2023-10-24 18:40:47.166804+00	2023-10-24 18:40:47.166819+00	\N
81	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkRFUHlkT2czYnFXYnBZdzNrbVltZ3NQazFHb2VtQyJ9.9K5LOKjvFrD5SAUN1i70uSz58J2ZH44Uo2jGYxV8Wi8	81	3	318	2023-10-24 19:58:43.489968+00	2023-10-24 19:58:43.489984+00	\N
82	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Imt6bVQwQnAxZ1lLQjJienlENDh4Umdud2F5YmJIVyJ9.Gd8THSUQUpBwtr5O_5zYqbfQhzI8XsXi6cCCgDWuA5A	82	3	316	2023-10-24 21:05:40.34571+00	2023-10-24 21:05:40.345727+00	\N
83	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkJiY0tLZWVKNG1jcEhVUXZUNldPcmxsb1RiZ2x2cCJ9.AHWrCRGQVdCh5aE4vVeyds6BzBRnojTZ-wEzY0Uyw10	83	3	316	2023-10-25 15:03:01.699537+00	2023-10-25 15:03:01.699555+00	\N
84	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkJLOGhYeklkOVVFZk9tVHFQU0VIMTZrVXEyQlFzYiJ9.7D3kyMpp7jkSwP16PrkoibHJNVPH-f7izazyqGIEwSE	84	3	318	2023-10-25 15:11:53.609701+00	2023-10-25 15:11:53.609717+00	\N
85	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Im5xbFZ6cUxYdUJWakxRQlZJdkgwVUtNRTgyYmpBaCJ9.AL-U5mbxOJj777--WXDwtvxY5qtJl7UctVHBF8VLTy4	85	3	105	2023-10-26 05:16:07.342637+00	2023-10-26 05:16:07.342652+00	\N
86	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IlF3M3RFUmFqU2VqaFRkNGpXOTFoYzdzUGx2NW12MiJ9.XpRKC8egiGVPuw8yPjCj88esMrXhuNGYCFdCeL4kQ0U	86	3	278	2023-10-26 15:58:09.64049+00	2023-10-26 15:58:09.640507+00	\N
87	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IlQ5c2g0RmEzRm44WFc4d2FDZDJ2dWQ5Y3dBZWpFMCJ9.pE4AKvHstlG5z8O-E3JNaX-2Mq4ohEsePm-UJ3WqFtw	87	3	156	2023-10-26 16:46:55.360517+00	2023-10-26 16:46:55.360532+00	\N
88	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImpnOGFQd05acHFFaE9hTHZyMzd5S1VhZW9wWjFWRiJ9.0n2apAEpZkFE5L3iocflWpnY-VG5lwbI7uiw7a_MZS4	88	3	318	2023-10-26 19:19:12.620248+00	2023-10-26 19:19:12.620263+00	\N
89	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InZDclNRTTFJQU4wTGZibjZqWU1PTVNsMDNwVXJncyJ9.XVPK1n2oENyoYKiXUhH3ot7Zh7Oh4sUq69ofvkifkBo	89	3	316	2023-10-27 09:14:45.848332+00	2023-10-27 09:14:45.848346+00	\N
90	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IlpRR0t5S2FHVHp0bk1sS0hOWjFnSU9rdXdTNEJZTiJ9.CC0DlCBoqNbuTku74OWtzXSJq2qT3pFiRFbfdNDuunU	90	3	278	2023-10-27 16:48:54.168625+00	2023-10-27 16:48:54.168639+00	\N
91	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IlhPWURsTTJPUEgwSGR0MWdLaEdFcFd2MmNzR29MOCJ9.ZbENNgkMavAPNM-fzVjSpvl2QEUP8ySS7PgFk0suHKY	91	3	157	2023-10-29 09:37:20.737943+00	2023-10-29 09:37:20.73796+00	\N
92	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImFaYVk2SVluQVJBY2VtTEV4VmhMbVJGdXhhTkpOSCJ9.knFkaC0q1vgYBgvSr_uw6VnGQ-0e1iDzSaqe_t2udcs	92	3	156	2023-10-29 16:04:18.706423+00	2023-10-29 16:04:18.706439+00	\N
93	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImRONDVnbUNSMTZKc2tsOU1zZ1pnQ0FhTEVtRkNWWCJ9.Pre8pnbLFS-wft6nPraBdBzdXTIy7vWL3ncnPbfPAAM	93	3	328	2023-10-29 17:36:34.500861+00	2023-10-29 17:36:34.500875+00	\N
94	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImFZQUM0NDJIMXFVMkZTVkhXMmo0NVNMREZKcGlFUiJ9.Anx-O1ng2RvlMFCeNUuGhWmlR8-p0qpTXdIRHw23H-M	94	3	278	2023-10-29 20:32:05.511105+00	2023-10-29 20:32:05.511121+00	\N
95	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImkwYjVsOUVYNWZESHh3NFJ1NEFINDlsenFyU3V4QiJ9.KfjEuOyjHw9dO4M7xKZWWZdjq8BDDjmHZttVpofcgCY	95	3	328	2023-10-30 05:17:55.951548+00	2023-10-30 05:17:55.951564+00	\N
96	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImZ0YWdHbzF1UVFWUHR3bUhXTzFhelVqOXFiY0t6ZCJ9.W4CDSHGkTzOIz8VjhghEZ5cfiih4PUYUU0ZL6p4Gxk0	96	3	309	2023-10-30 07:59:31.601571+00	2023-10-30 07:59:31.601673+00	\N
97	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Ilc4UHBOU1BlRlo5RjZsekc2MWkyTllLeUQ4VGI2eCJ9.CtVhL2wu1dZ3D_bnyH3MvZnqYFU6rDstIN9aLVrhlqc	97	3	156	2023-10-30 09:09:49.021345+00	2023-10-30 09:09:49.021381+00	\N
98	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImltVjVPUXd2TDRkT3NFOEJkaEQwM1lYem5iQzROQSJ9.PcFqzpCoYgiUndSjNEo3iPAVWH8yZYkPoVxSfetWvmo	98	3	156	2023-10-30 20:00:19.189506+00	2023-10-30 20:00:19.189522+00	\N
99	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InpGQVFHY3llVzUxTU1qY0FMek01ZDRUdWhsTExBUSJ9.LTVGE3KGyvavbtoFSytB-b0CNKvER9X6Bk9hAoxLM10	99	3	278	2023-10-30 21:50:10.582653+00	2023-10-30 21:50:10.58267+00	\N
100	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImRPNUFMdnhHbTBSQnI1MmdHU1VJWXhBQXpFOXdFciJ9.hbZaPJXs6UyH9en_0x7uvHRJu1aGWKZqT2FSbVQrjYw	100	3	156	2023-10-31 14:39:13.909784+00	2023-10-31 14:39:13.909801+00	\N
101	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImN3NkhaTjJ3elU0ZFdmQ0prbzk3OGJZUnY1MHZVaiJ9.GPYdI_EGhjWyjnF-eIiwQn8gsWYKZESHO8SxVv8GSGU	101	3	278	2023-10-31 16:38:18.057563+00	2023-10-31 16:38:18.05758+00	\N
102	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IjE4QXU5dlZodzBrN2V2dXFVWGxoMWFuV0FUaFNkbiJ9.SqujZ1KCR3lEnn-SYUqAQpOXiBAe_-FhnBfBxWzM-FE	102	3	339	2023-10-31 17:27:22.219853+00	2023-10-31 17:27:22.219869+00	\N
103	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IkFjMHhVRWN6N1lkTm9KQmZGZExLZnhZbmNQcWRQRiJ9.srXjYQifkcqqM-CuNsZJVN_nInrPYUAO8KnZzLViSqU	103	3	74	2023-11-01 14:08:03.493541+00	2023-11-01 14:08:03.493559+00	\N
104	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Imx6dEM4VXVyOWdlR3NoU29xUXo2ZDJtd0VvazRtcyJ9.gpWBKCqzuaAY2i95BpC_vH_LrxtUBxQOOaiFv1ls6PI	104	3	328	2023-11-01 15:36:10.83498+00	2023-11-01 15:36:10.834996+00	\N
105	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InFJTmdjVnRCQThzTjFvT09wMlZDNHFCTFc3aFE1MSJ9.ncc1jmxcPZcUjFUprn95SgjpHfzykos6sB24Eh4JWkc	105	3	341	2023-11-02 17:44:21.733357+00	2023-11-02 17:44:21.733373+00	\N
106	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Ims0MFlLRXRTSmEzZXhJMnVPUFBuVDJEOUVQN3JyRyJ9.pHhQ6tZ0BymDcm_7cgj6XEyax69AyZ1TkNAfhSInnbs	106	3	278	2023-11-02 19:06:12.875442+00	2023-11-02 19:06:12.875461+00	\N
107	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Ikt3TW1tNWxZTWtFb1NnSVpFa2V6YlBrRDJtNGJOdSJ9.s1CFhW6asow3wQUYtqwDFvW2QBUWicRQM3M3lDidAwU	107	3	74	2023-11-04 09:15:16.245147+00	2023-11-04 09:15:16.245165+00	\N
108	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IjV0QjdVYXh5cE9GYlVQRXQ1bUE1QkVYZlZhM2dEMSJ9.s1e5SU5zQ_ABqAiGRhvNwJCoNq6zwMw1D1pwvf5W8bE	108	3	156	2023-11-04 14:08:33.910796+00	2023-11-04 14:08:33.910815+00	\N
109	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Ikk5dU55VTc1ZDhBWGIxMkxOM2lZMm1VQlIyQkVQeCJ9.qk_jnPrSnudKyHxyzA2y9bunN-0rkwzLfIAyNHphrx8	109	3	273	2023-11-06 14:31:43.117919+00	2023-11-06 14:31:43.117935+00	\N
110	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Ik1DUHZ5dEVIdnFsRGtKRVE2UEFJYTc4OTJlOG9heCJ9.JIkZQSjgcjz50ZEe7CmnQ1C5lb6tknU6UeZFLIMkTk0	110	3	278	2023-11-08 15:21:03.916003+00	2023-11-08 15:21:03.916019+00	\N
111	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InBTdkwxSzlscVplcFpCME8wVGI0UFpBSHlWYXBHUCJ9.buXCTrQnQfDEync0GHYCaHwMf3K6YsIeKFCmG1uQ8gA	111	3	341	2023-11-10 08:33:37.567699+00	2023-11-10 08:33:37.567715+00	\N
112	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImNzUHZETTNWcXdHOTlYMGQ4d2RLYnJENThiTUlFUyJ9.a2wr5FvNTM6_JzEG8DQg4ryZFX9jV3K1o8sLLqTewuc	112	3	343	2023-11-13 01:30:08.485592+00	2023-11-13 01:30:08.485608+00	\N
113	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InNZSzVBOUxuT0h4QmV6eE1CWlJZWEl0a01KNU1FeCJ9.LIBpIKk-eOE2S2R2NfOs_S2vla-zcFfFZbzRkGX6Tfc	113	3	66	2023-11-14 15:16:37.854707+00	2023-11-14 15:16:37.854726+00	\N
114	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6Im9LUXBSYU5tNWJyNGVNMEZwWlVEQ01VZVBzS09TdSJ9.Ds11nXp3H2reRoM2eZTZLeD7fiDOFtJmbtxzB0A_hbY	114	3	278	2023-11-15 17:33:22.598199+00	2023-11-15 17:33:22.598215+00	\N
115	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImtzcHlRbnFQUHFoWVBXTzRwOTdYMk0ySWxRQmtWZiJ9.QwsLOYDzvQc8RNtVVu2nf3k-dk7BhZTFpEVv2OcGoF4	115	3	110	2023-11-16 08:00:58.162706+00	2023-11-16 08:00:58.162721+00	\N
116	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6InBDT3NaYVYyUEpUSnZKMzNlclVUZVA0UTlDU09ZeSJ9.b6paH0Kg2UMBTHshgwSJ4HR_5JMRuwPhTTR6shwpesI	116	3	278	2023-11-16 11:01:55.438245+00	2023-11-16 11:01:55.438263+00	\N
117	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IjRaSVpoRkw2TkhQNzNSZ24yYWFoMkpveHZmYURDSiJ9.Unh68kIfcp54iZwF9ube2eJDjtnPKFGiq3LDfryxlvg	117	3	273	2023-11-18 22:40:39.105659+00	2023-11-18 22:40:39.105676+00	\N
118	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6IllvTVhSN09KcUpyQ1NuQTJSckxhdVVyaXQzRWJubSJ9.bzZHuTmCwzmkDM_Ml8AF0qnF-HlHajgUqXGIkaEAM6c	118	3	345	2023-11-20 19:08:00.393323+00	2023-11-20 19:08:00.393341+00	\N
\.


--
-- Data for Name: offers_document; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offers_document (id, created, modified, file, hash, stellar_transaction_hash, proposal_id, blockchain_link, blockchain_transaction_id) FROM stdin;
26	2023-11-02 21:25:33.374286+00	2023-11-02 21:25:36.347661+00	documents/96135c4f501dfd7f769c07b591aaec5d3d0d0ff07614ab7719e2ac1d09deb46b.pdf	f12d3e6d870354ed0f5fa268d0e0	\N	92	\N	\N
34	2023-11-04 02:03:39.514564+00	2023-11-04 02:03:39.781549+00	documents/ab177770ba7c653e59d97a5d2b1975e53498486c99b17099fb257bcc80ec458c.pdf	2288ec40379f401df42e526ca0d6	\N	113	\N	\N
28	2023-11-04 00:46:35.281515+00	2023-11-04 00:46:38.489031+00	documents/12a0008bdaa5af4fa8a3a44ca01349d72eb275ee719b11c2a3bca8a19a7533f7.pdf	983b576555e4fb3e72e3af2fa7f0	\N	107	https://polygonscan.com/tx/0x59d07914a2e78cea6d234106fcd0e15106722b9777757bb780b545312a41d698	0x59d07914a2e78cea6d234106fcd0e15106722b9777757bb780b545312a41d698
15	2023-11-02 09:46:45.846745+00	2023-11-02 09:46:50.387306+00	documents/105cc80c95f798aac3ec057d75e7a443c0ebad2cea2829eb51b1c19ada82ed80.pdf	81821abb609d4759cfbc4bbe0c5e	\N	87	https://polygonscan.com/tx/0xc72a0dda2f42acf9e1b015a9d85388c2f9be091e894ce9643371a6be8bbfd6c4	0xc72a0dda2f42acf9e1b015a9d85388c2f9be091e894ce9643371a6be8bbfd6c4
29	2023-11-04 01:12:36.594045+00	2023-11-04 01:12:54.404837+00	documents/469d75982a5e3493be4bd637c36d90c8be6743229387718b37b40a128846d33f.pdf	3ee1f977df16c3005d2f6020ee3d	\N	108	https://polygonscan.com/tx/0x9c815da7836171603db951b619dd121ec6f4e75fd0a4b5ae9b4f7518924ad16c	0x9c815da7836171603db951b619dd121ec6f4e75fd0a4b5ae9b4f7518924ad16c
30	2023-11-04 01:21:58.339894+00	2023-11-04 01:22:08.438764+00	documents/778be54416d02b754177e440d78d3e9fc4f405ad923b080ba90aa51b6970f8e0.pdf	cc363e0a24910af33909dccd443c	\N	109	https://polygonscan.com/tx/0xec11abcbdf316c968408a46b32ef295e7d65ec23978b01d8331c781d92682458	0xec11abcbdf316c968408a46b32ef295e7d65ec23978b01d8331c781d92682458
21	2023-11-02 09:57:50.065391+00	2023-11-02 09:57:56.200461+00	documents/5107f2faccb95e842dbe389789b9bc34b6f045f454f197df21c6b17672e9f59f.pdf	e8ec7a6654f082f1d7541972d085	\N	88	https://polygonscan.com/tx/0x6e5234e590a577fe7024534d409d4988b8b399378f9627f9792c318dfc8518b2	0x6e5234e590a577fe7024534d409d4988b8b399378f9627f9792c318dfc8518b2
35	2023-11-04 02:05:23.435222+00	2023-11-04 02:05:32.213171+00	documents/aeb4093cd1b0ed6af5035d6c2611c90110aa8826fce8e540bef02085337ea27a.pdf	33739b8b72c6ea9e3be90337114c	\N	114	https://polygonscan.com/tx/0x8ba8d0b59b035c1eb6bf11c6437e49fd472722b36e6cfa81099eb263ab99a292	0x8ba8d0b59b035c1eb6bf11c6437e49fd472722b36e6cfa81099eb263ab99a292
25	2023-11-02 21:24:31.148943+00	2023-11-02 21:24:33.045035+00	documents/925b355b9fb420ff4a997161a9dbdd0fdf6d20105802cdf2f93ac3c233fad458.pdf	b8ede68ff872f4a7319df47a088c	\N	91	\N	\N
31	2023-11-04 01:38:16.546702+00	2023-11-04 01:38:20.322549+00	documents/b848788747f8d683eea3614986715739d21cccd245bfd5265ee8fde0be2e6d5a.pdf	436d3b4f2a1b1b1f55615c47c4b5	\N	110	https://polygonscan.com/tx/0x39aba5fc4cf96da33f3ece81b4f31d497a932efa7f5ba40340a27b70f603eafa	0x39aba5fc4cf96da33f3ece81b4f31d497a932efa7f5ba40340a27b70f603eafa
40	2023-11-04 23:22:13.162993+00	2023-11-04 23:22:17.318408+00	documents/facb530671e9cb3422a0a72a361f226bc041114845c0fff122ef1930b9002a9e.pdf	d511045eaa621cd9bb09ae7c17ba	\N	120	https://polygonscan.com/tx/0x3b44995753e1850378bc1f05312024cc94616609c3d13a1c4bc9b25ae96ea708	0x3b44995753e1850378bc1f05312024cc94616609c3d13a1c4bc9b25ae96ea708
32	2023-11-04 01:42:17.759364+00	2023-11-04 01:42:21.499506+00	documents/051888235cf2e2b57c83224a96a22741d4cf0079b6a3ab8a5454b8d1c44a3dc4.pdf	0fcb5d405e62dcb7e991cc3ac7d2	\N	111	https://polygonscan.com/tx/0x0da3398a1785f5c617d30bcef61d5fbc46af22c164037d02cd9d9abaa5e83e2e	0x0da3398a1785f5c617d30bcef61d5fbc46af22c164037d02cd9d9abaa5e83e2e
36	2023-11-04 02:13:10.305626+00	2023-11-04 02:13:19.366536+00	documents/0e79b5a0abd93280c01798841700d660160cfc37de94e17b11500c400611068f.pdf	99f36a43b67929b5da7deaea52cd	\N	115	https://polygonscan.com/tx/0xbfc6112d3f7ff6f6b4ab0d2758143ba8d00dfd69b8cf3b83bf335543aabb3b65	0xbfc6112d3f7ff6f6b4ab0d2758143ba8d00dfd69b8cf3b83bf335543aabb3b65
33	2023-11-04 01:47:02.650546+00	2023-11-04 01:47:11.61792+00	documents/d21def20dd7dc0c69b6f2204a4cff33554076c3bb5f94f097e4372dc3588a434.pdf	69232a6af4b76d4147e92e502d6b	\N	112	https://polygonscan.com/tx/0x7e1bf273562ebf8e8df5dbc29e5bdc5e91dfc22dda7f3f90efae3339f1e25f78	0x7e1bf273562ebf8e8df5dbc29e5bdc5e91dfc22dda7f3f90efae3339f1e25f78
38	2023-11-04 02:32:54.180196+00	2023-11-04 02:32:54.746522+00	documents/28eaffb6a2f02a2fd3519bbd4f82d59cdac3585ff1254ec1263d09e8b8d05f5e.pdf	02fc0b1af748f103146fe91c8503	\N	116	\N	\N
45	2023-11-09 16:47:05.374618+00	2023-11-09 16:47:10.991436+00	documents/0831308e41ed4abb145acc1b254ec019eae472435a19266a1e1dd55094819007.pdf	7cc417cadee028bec1bf434caebd	\N	121	https://polygonscan.com/tx/0x294401120d4f650a6801ef3f69df9a0f2be6b2f9edf429f46f84d6171665152e	0x294401120d4f650a6801ef3f69df9a0f2be6b2f9edf429f46f84d6171665152e
39	2023-11-04 02:39:37.404319+00	2023-11-04 02:39:41.262416+00	documents/2e30f715ba6783dc3001c72fc4b597db8ce6d94b03cc03caebb7b00f693548f7.pdf	99f86346cc808024e6dd3c68cf02	\N	117	https://polygonscan.com/tx/0x8249c9d494269640995fc7f8ec48343ad5762f524d3aaf8abdebe69044e7c193	0x8249c9d494269640995fc7f8ec48343ad5762f524d3aaf8abdebe69044e7c193
42	2023-11-05 00:17:01.064393+00	2023-11-05 00:17:05.248191+00	documents/e91af28b4cf1761916896e92cc38745640481b7f347b5961e2be1e1b1945d06e.pdf	a585d6323e9a8267084425b18dfd	\N	122	https://polygonscan.com/tx/0x462977be02876411de5bbcbf684ea0f017836957c6c199f081a9b722aec096ea	0x462977be02876411de5bbcbf684ea0f017836957c6c199f081a9b722aec096ea
43	2023-11-05 00:19:35.656447+00	2023-11-05 00:19:43.825552+00	documents/64e2316c3c2f1751089c0f1b31ee03dff9387253d62203a721463ed91e689de3.pdf	4aedc3984e5e69304291cc0bc090	\N	123	https://polygonscan.com/tx/0x01982063ce71fbe83c705b81f8235f48a345bb4407df89093df73a034d2f8d81	0x01982063ce71fbe83c705b81f8235f48a345bb4407df89093df73a034d2f8d81
48	2023-11-09 19:32:42.315456+00	2023-11-09 19:32:58.214529+00	documents/c19bea3bcbad8c2ea6d223615b79ce678a3fe1c95c6ea18a68b7075f9e517c70.pdf	3744c493df23f72168feca8409e6	\N	130	https://polygonscan.com/tx/0xeebd28e5a5206c5a82e5bd5a92f7fee594cec3d407cf1e91db545c8bcad7eafd	0xeebd28e5a5206c5a82e5bd5a92f7fee594cec3d407cf1e91db545c8bcad7eafd
46	2023-11-09 17:33:23.36934+00	2023-11-09 17:33:27.50282+00	documents/85f058f06e3b3af7e1ad9a06a966a0d80b536b90187cacca7754913377ac17d9.pdf	8d3578cc8f806c68964b6b458657	\N	128	https://polygonscan.com/tx/0xa651e84bf8e61a247d33fb1549bb703eb79eedb29729e37f9773733fa96ea254	0xa651e84bf8e61a247d33fb1549bb703eb79eedb29729e37f9773733fa96ea254
47	2023-11-09 19:26:15.574319+00	2023-11-09 19:26:21.383117+00	documents/68a7f7b75b58a0931a5b7bb24e5b89cfcaa36bf73c0a39a1980380bd4c9baa6b.pdf	952615a91f17eab52a8bf84f2749	\N	129	https://polygonscan.com/tx/0x84caa8b999d6f4c476d47046f32baeaae90387b96391ce67190143070527071d	0x84caa8b999d6f4c476d47046f32baeaae90387b96391ce67190143070527071d
50	2023-11-09 19:41:30.208724+00	2023-11-09 19:41:34.372119+00	documents/adb346dcd73fc53ff996afc57c566f202c99ccdf041591435983b81f5ac49e05.pdf	f19f67de993d1fa2777ab542f9b4	\N	131	https://polygonscan.com/tx/0x39276b2445e64d78ecbc83dd7e776d904e595ca7bd9072490d65371b364839eb	0x39276b2445e64d78ecbc83dd7e776d904e595ca7bd9072490d65371b364839eb
52	2023-11-09 20:46:29.860772+00	2023-11-09 20:46:30.286229+00	documents/8ad20a0b2952676c7f25a6368aec2bd2a7fc61bd7929525882a944a23e0f8c6e.pdf	5eda9ee93fc9b401e97992d75417	\N	132	\N	\N
53	2023-11-09 20:52:03.991153+00	2023-11-09 20:52:07.279404+00	documents/41c48eec8a452a5e8367461721c973ee37ee8ae11541cdc02e0b22580b74e651.pdf	f74e74edf31060f0441437762d1f	\N	133	https://polygonscan.com/tx/0x2dbac07b63e6058aea22279bf07cce515a5a613644c53b4cf942741d6d4d1201	0x2dbac07b63e6058aea22279bf07cce515a5a613644c53b4cf942741d6d4d1201
54	2023-11-10 17:31:58.271489+00	2023-11-10 17:32:02.239654+00	documents/8e7faebf274879d7baa7f7fbd42cda62008400c33c8b3f78528b69b32cf0213d.pdf	2319daa23a0d2d84b6f5c7311dd0	\N	134	https://polygonscan.com/tx/0x21591c5e7d7905d3085b413460d4c941f8059d295f280668aa1acc06ece06218	0x21591c5e7d7905d3085b413460d4c941f8059d295f280668aa1acc06ece06218
57	2023-11-10 18:10:14.598101+00	2023-11-10 18:10:20.208674+00	documents/4a7f0d81f4ba76888f451ece69d1d5e70ce8435d15d50258c499a3792ed94ca4.pdf	c35b380b14e5ce84d28d94d9df74	\N	136	https://polygonscan.com/tx/0xab27cc5225198104b92077aa8b3fb9ffb5e8d3c86ed842205ec6f6adeb23544e	0xab27cc5225198104b92077aa8b3fb9ffb5e8d3c86ed842205ec6f6adeb23544e
68	2023-11-14 22:26:59.284766+00	2023-11-14 22:27:03.387015+00	documents/870a17ecc688c36bf91a21f759ccd0318b4a874ac63e8053fd7a48d40df9edf9.pdf	2467873d03c5c49b5641e5504383	\N	152	https://polygonscan.com/tx/0x477c38596b1e7b43ff42cfc454db5fbcc8fef282873eabf409e3f25f0a64ff34	0x477c38596b1e7b43ff42cfc454db5fbcc8fef282873eabf409e3f25f0a64ff34
69	2023-11-17 16:07:30.614582+00	2023-11-17 16:07:37.383781+00	documents/16b2364643b3aff8065280a15d9d7a287340f239d0a6df769bc837ab0fa03a8e.pdf	7ee5e9fb7e291ac5f3d769908512	\N	155	https://polygonscan.com/tx/0x8f8a78901c1fce04829a0c7a7dad07efb0f9cfaaf5ba3abe0292e2fe7f797b0d	0x8f8a78901c1fce04829a0c7a7dad07efb0f9cfaaf5ba3abe0292e2fe7f797b0d
70	2023-11-17 17:05:29.243701+00	2023-11-17 17:05:33.339931+00	documents/fb3e42cf2664178272711d50a5fd45e65ea91695239aba4547a39299fbca1081.pdf	44f966afff6defca5065e53094e0	\N	156	https://polygonscan.com/tx/0x945f399e7aeab008f0c21b9936e118a6afb8e757ab26cbd58f21a5e8934aa9e3	0x945f399e7aeab008f0c21b9936e118a6afb8e757ab26cbd58f21a5e8934aa9e3
61	2023-11-11 10:29:22.913214+00	2023-11-11 10:29:32.509012+00	documents/0fdc8356c4da425228b25aa4808b1c4b2e772fc036f224efd805443adc0e22fe.pdf	2c561e8d8a9ed455e51ad9b04040	\N	140	https://polygonscan.com/tx/0xcd21f41cfffc691d3969c4842e3c43aa27270c9017c0ba73cb4c11c4b2fefe90	0xcd21f41cfffc691d3969c4842e3c43aa27270c9017c0ba73cb4c11c4b2fefe90
\.


--
-- Data for Name: offers_historyoffersdocument; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offers_historyoffersdocument (id, created, modified, cod, transaction_hash, blockchain_transaction_id, blockchain_link, creator_id, document_id) FROM stdin;
2	2023-11-01 09:34:38.155703+00	2023-11-01 09:34:38.155703+00	pf_23	f6a390d38c104967847ccd31e95d	0xd7cbef7918a18fdafc65c46efb05d09d874e42a83a66d239498474dcd2cbec79	https://mumbai.polygonscan.com/tx/0xd7cbef7918a18fdafc65c46efb05d09d874e42a83a66d239498474dcd2cbec79	23	\N
8	2023-11-01 18:21:12.749372+00	2023-11-01 18:21:12.749372+00	pf_196	2508c3a9452e373ce4104d6f4900	0x11266add1675a9345d3b7856c4448d39af307ab166a97d5f5954f4a1dbdf149d	https://polygonscan.com/tx/0x11266add1675a9345d3b7856c4448d39af307ab166a97d5f5954f4a1dbdf149d	196	\N
7	2023-11-01 18:13:46.415148+00	2023-11-01 18:13:46.415148+00	pf_196	82d3071f500db044d554b12661a4	0xc5812f9292b05ab326d55c17fe1b6296f4383699a65ae34848e99ab6fc7ddde6	https://polygonscan.com/tx/0xc5812f9292b05ab326d55c17fe1b6296f4383699a65ae34848e99ab6fc7ddde6	196	\N
6	2023-11-01 18:08:48.271825+00	2023-11-01 18:08:48.271825+00	pf_28	1c67108c0b1b70c555dbe2808db1	0xc8db01930b28e61f621b7162f63ca978b7ea9527b0931b6b3646af61ae6c2a31	https://polygonscan.com/tx/0xc8db01930b28e61f621b7162f63ca978b7ea9527b0931b6b3646af61ae6c2a31	28	\N
5	2023-11-01 17:48:48.325177+00	2023-11-01 17:48:48.325177+00	pf_28	ab6d4e8e6b40cc7da645f41252ac	0xdcec243184eeb6690c670a12e3a87d71277083ffd5bf48d9c4682c26202b4454	https://polygonscan.com/tx/0xdcec243184eeb6690c670a12e3a87d71277083ffd5bf48d9c4682c26202b4454	28	\N
4	2023-11-01 17:38:46.305785+00	2023-11-01 17:38:46.305785+00	pf_28	9422c9b759672d946907c925f98a	0xe946a6a246febd7651b65e9dbfb8a28c87ad5c04824cf464db3b6538d68255fe	https://polygonscan.com/tx/0xe946a6a246febd7651b65e9dbfb8a28c87ad5c04824cf464db3b6538d68255fe	28	\N
3	2023-11-01 17:25:52.489455+00	2023-11-01 17:25:52.489455+00	pf_28	c19f20dfa23eec3584ef5384f213	0x38fd12ca157aab7a5c6d9fb34b7d5b13f376ddc1554ac35da8132a3e04d257b5	https://polygonscan.com/tx/0x38fd12ca157aab7a5c6d9fb34b7d5b13f376ddc1554ac35da8132a3e04d257b5	28	\N
10	2023-11-02 09:46:50.384931+00	2023-11-02 09:46:50.384931+00	pf_28	81821abb609d4759cfbc4bbe0c5e	0xc72a0dda2f42acf9e1b015a9d85388c2f9be091e894ce9643371a6be8bbfd6c4	https://polygonscan.com/tx/0xc72a0dda2f42acf9e1b015a9d85388c2f9be091e894ce9643371a6be8bbfd6c4	28	15
11	2023-11-02 09:57:56.198475+00	2023-11-02 09:57:56.198475+00	pf_28	e8ec7a6654f082f1d7541972d085	0x6e5234e590a577fe7024534d409d4988b8b399378f9627f9792c318dfc8518b2	https://polygonscan.com/tx/0x6e5234e590a577fe7024534d409d4988b8b399378f9627f9792c318dfc8518b2	28	21
9	2023-11-01 20:49:31.873568+00	2023-11-01 20:49:31.873568+00	pf_28	c6461499a4c843e741307e1ac28c	\N	\N	28	\N
1	2023-10-31 23:41:42.707524+00	2023-10-31 23:41:42.707524+00	pf_28	fede4de6b6696e47039f7db38e03	\N	\N	28	\N
13	2023-11-02 21:24:33.042365+00	2023-11-02 21:24:33.042365+00	pf_82	b8ede68ff872f4a7319df47a088c	\N	\N	82	25
14	2023-11-02 21:25:36.344566+00	2023-11-02 21:25:36.344566+00	pf_82	f12d3e6d870354ed0f5fa268d0e0	\N	\N	82	26
15	2023-11-04 00:46:38.48662+00	2023-11-04 00:46:38.48662+00	pf_82	983b576555e4fb3e72e3af2fa7f0	0x59d07914a2e78cea6d234106fcd0e15106722b9777757bb780b545312a41d698	https://polygonscan.com/tx/0x59d07914a2e78cea6d234106fcd0e15106722b9777757bb780b545312a41d698	82	28
16	2023-11-04 01:12:54.40197+00	2023-11-04 01:12:54.40197+00	pf_82	3ee1f977df16c3005d2f6020ee3d	0x9c815da7836171603db951b619dd121ec6f4e75fd0a4b5ae9b4f7518924ad16c	https://polygonscan.com/tx/0x9c815da7836171603db951b619dd121ec6f4e75fd0a4b5ae9b4f7518924ad16c	82	29
17	2023-11-04 01:22:08.434864+00	2023-11-04 01:22:08.434864+00	pf_82	cc363e0a24910af33909dccd443c	0xec11abcbdf316c968408a46b32ef295e7d65ec23978b01d8331c781d92682458	https://polygonscan.com/tx/0xec11abcbdf316c968408a46b32ef295e7d65ec23978b01d8331c781d92682458	82	30
18	2023-11-04 01:38:20.320111+00	2023-11-04 01:38:20.320111+00	pf_82	436d3b4f2a1b1b1f55615c47c4b5	0x39aba5fc4cf96da33f3ece81b4f31d497a932efa7f5ba40340a27b70f603eafa	https://polygonscan.com/tx/0x39aba5fc4cf96da33f3ece81b4f31d497a932efa7f5ba40340a27b70f603eafa	82	31
19	2023-11-04 01:42:21.497273+00	2023-11-04 01:42:21.497273+00	pf_82	0fcb5d405e62dcb7e991cc3ac7d2	0x0da3398a1785f5c617d30bcef61d5fbc46af22c164037d02cd9d9abaa5e83e2e	https://polygonscan.com/tx/0x0da3398a1785f5c617d30bcef61d5fbc46af22c164037d02cd9d9abaa5e83e2e	82	32
20	2023-11-04 01:47:11.612762+00	2023-11-04 01:47:11.612762+00	pf_82	69232a6af4b76d4147e92e502d6b	0x7e1bf273562ebf8e8df5dbc29e5bdc5e91dfc22dda7f3f90efae3339f1e25f78	https://polygonscan.com/tx/0x7e1bf273562ebf8e8df5dbc29e5bdc5e91dfc22dda7f3f90efae3339f1e25f78	82	33
21	2023-11-04 02:03:39.776557+00	2023-11-04 02:03:39.776557+00	pf_82	2288ec40379f401df42e526ca0d6	\N	\N	82	34
22	2023-11-04 02:05:32.201851+00	2023-11-04 02:05:32.201851+00	pf_82	33739b8b72c6ea9e3be90337114c	0x8ba8d0b59b035c1eb6bf11c6437e49fd472722b36e6cfa81099eb263ab99a292	https://polygonscan.com/tx/0x8ba8d0b59b035c1eb6bf11c6437e49fd472722b36e6cfa81099eb263ab99a292	82	35
23	2023-11-04 02:13:19.363184+00	2023-11-04 02:13:19.363184+00	pf_82	99f36a43b67929b5da7deaea52cd	0xbfc6112d3f7ff6f6b4ab0d2758143ba8d00dfd69b8cf3b83bf335543aabb3b65	https://polygonscan.com/tx/0xbfc6112d3f7ff6f6b4ab0d2758143ba8d00dfd69b8cf3b83bf335543aabb3b65	82	36
24	2023-11-04 02:32:54.743422+00	2023-11-04 02:32:54.743422+00	pf_82	02fc0b1af748f103146fe91c8503	\N	\N	82	38
25	2023-11-04 02:39:41.259793+00	2023-11-04 02:39:41.259793+00	pf_82	99f86346cc808024e6dd3c68cf02	0x8249c9d494269640995fc7f8ec48343ad5762f524d3aaf8abdebe69044e7c193	https://polygonscan.com/tx/0x8249c9d494269640995fc7f8ec48343ad5762f524d3aaf8abdebe69044e7c193	82	39
26	2023-11-04 23:22:17.31559+00	2023-11-04 23:22:17.31559+00	pf_82	d511045eaa621cd9bb09ae7c17ba	0x3b44995753e1850378bc1f05312024cc94616609c3d13a1c4bc9b25ae96ea708	https://polygonscan.com/tx/0x3b44995753e1850378bc1f05312024cc94616609c3d13a1c4bc9b25ae96ea708	82	40
27	2023-11-05 00:17:05.245361+00	2023-11-05 00:17:05.245361+00	pf_196	a585d6323e9a8267084425b18dfd	0x462977be02876411de5bbcbf684ea0f017836957c6c199f081a9b722aec096ea	https://polygonscan.com/tx/0x462977be02876411de5bbcbf684ea0f017836957c6c199f081a9b722aec096ea	196	42
12	2023-11-02 10:03:56.106883+00	2023-11-02 10:03:56.106883+00	pf_28	e95f6a65c7f7ee6ac3370ce4f386	0x0ba4839e21e2e3a098677b019ef58968d820b00219f77db74420a496b78109e4	https://polygonscan.com/tx/0x0ba4839e21e2e3a098677b019ef58968d820b00219f77db74420a496b78109e4	28	\N
28	2023-11-05 00:19:43.822506+00	2023-11-05 00:19:43.822506+00	pf_196	4aedc3984e5e69304291cc0bc090	0x01982063ce71fbe83c705b81f8235f48a345bb4407df89093df73a034d2f8d81	https://polygonscan.com/tx/0x01982063ce71fbe83c705b81f8235f48a345bb4407df89093df73a034d2f8d81	196	43
30	2023-11-09 16:47:10.989337+00	2023-11-09 16:47:10.989337+00	pf_82	7cc417cadee028bec1bf434caebd	0x294401120d4f650a6801ef3f69df9a0f2be6b2f9edf429f46f84d6171665152e	https://polygonscan.com/tx/0x294401120d4f650a6801ef3f69df9a0f2be6b2f9edf429f46f84d6171665152e	82	45
29	2023-11-08 15:55:45.373477+00	2023-11-08 15:55:45.373477+00	pf_28	e15aeba72a6faf55c4d8c4a25e05	0xcd4f5240336df3000b4ce526eda3f5085284a8216ae2e63ac7d2a4e9c9fdb734	https://polygonscan.com/tx/0xcd4f5240336df3000b4ce526eda3f5085284a8216ae2e63ac7d2a4e9c9fdb734	28	\N
31	2023-11-09 17:33:27.501069+00	2023-11-09 17:33:27.501069+00	pf_196	8d3578cc8f806c68964b6b458657	0xa651e84bf8e61a247d33fb1549bb703eb79eedb29729e37f9773733fa96ea254	https://polygonscan.com/tx/0xa651e84bf8e61a247d33fb1549bb703eb79eedb29729e37f9773733fa96ea254	196	46
32	2023-11-09 19:26:21.380995+00	2023-11-09 19:26:21.380995+00	pf_196	952615a91f17eab52a8bf84f2749	0x84caa8b999d6f4c476d47046f32baeaae90387b96391ce67190143070527071d	https://polygonscan.com/tx/0x84caa8b999d6f4c476d47046f32baeaae90387b96391ce67190143070527071d	196	47
33	2023-11-09 19:32:58.212276+00	2023-11-09 19:32:58.212276+00	pf_196	3744c493df23f72168feca8409e6	0xeebd28e5a5206c5a82e5bd5a92f7fee594cec3d407cf1e91db545c8bcad7eafd	https://polygonscan.com/tx/0xeebd28e5a5206c5a82e5bd5a92f7fee594cec3d407cf1e91db545c8bcad7eafd	196	48
34	2023-11-09 19:41:34.369997+00	2023-11-09 19:41:34.369997+00	pf_196	f19f67de993d1fa2777ab542f9b4	0x39276b2445e64d78ecbc83dd7e776d904e595ca7bd9072490d65371b364839eb	https://polygonscan.com/tx/0x39276b2445e64d78ecbc83dd7e776d904e595ca7bd9072490d65371b364839eb	196	50
35	2023-11-09 20:46:30.283806+00	2023-11-09 20:46:30.283806+00	pf_324	5eda9ee93fc9b401e97992d75417	\N	\N	324	52
36	2023-11-09 20:52:07.277153+00	2023-11-09 20:52:07.277153+00	pf_324	f74e74edf31060f0441437762d1f	0x2dbac07b63e6058aea22279bf07cce515a5a613644c53b4cf942741d6d4d1201	https://polygonscan.com/tx/0x2dbac07b63e6058aea22279bf07cce515a5a613644c53b4cf942741d6d4d1201	324	53
37	2023-11-10 17:32:02.227833+00	2023-11-10 17:32:02.227833+00	pf_196	2319daa23a0d2d84b6f5c7311dd0	0x21591c5e7d7905d3085b413460d4c941f8059d295f280668aa1acc06ece06218	https://polygonscan.com/tx/0x21591c5e7d7905d3085b413460d4c941f8059d295f280668aa1acc06ece06218	196	54
40	2023-11-10 18:10:20.206392+00	2023-11-10 18:10:20.206392+00	pf_324	c35b380b14e5ce84d28d94d9df74	0xab27cc5225198104b92077aa8b3fb9ffb5e8d3c86ed842205ec6f6adeb23544e	https://polygonscan.com/tx/0xab27cc5225198104b92077aa8b3fb9ffb5e8d3c86ed842205ec6f6adeb23544e	324	57
39	2023-11-10 18:02:36.750743+00	2023-11-10 18:02:36.750743+00	pf_196	7cb262e95f13a91f13452ed0b51a	\N	\N	196	\N
41	2023-11-10 18:18:54.194699+00	2023-11-10 18:18:54.194699+00	pf_196	ea958070360ec3ef876e1d9c7b5e	0xdd64f20b15fca7d545d4e00bc3dbd29e889c00b1f67b46c2be186948d8c1277c	https://polygonscan.com/tx/0xdd64f20b15fca7d545d4e00bc3dbd29e889c00b1f67b46c2be186948d8c1277c	196	\N
42	2023-11-11 09:27:26.619325+00	2023-11-11 09:27:26.619325+00	pf_196	586ea885d75e6b7b2b6e004631e5	\N	\N	196	\N
43	2023-11-11 10:23:42.391326+00	2023-11-11 10:23:42.391326+00	pf_196	21118885d113e8a7c1bfefd4479b	0x1d6a01e9075e1fac255154eb78d52b1bee9803942e7ecf077fd56640918def80	https://polygonscan.com/tx/0x1d6a01e9075e1fac255154eb78d52b1bee9803942e7ecf077fd56640918def80	196	\N
44	2023-11-11 10:29:32.507113+00	2023-11-11 10:29:32.507113+00	pf_324	2c561e8d8a9ed455e51ad9b04040	0xcd21f41cfffc691d3969c4842e3c43aa27270c9017c0ba73cb4c11c4b2fefe90	https://polygonscan.com/tx/0xcd21f41cfffc691d3969c4842e3c43aa27270c9017c0ba73cb4c11c4b2fefe90	324	61
45	2023-11-11 10:31:29.714287+00	2023-11-11 10:31:29.714287+00	pf_196	9f7d6f8eec66b6294d4ebcfe7741	\N	\N	196	\N
46	2023-11-12 00:02:38.220273+00	2023-11-12 00:02:38.220273+00	pf_196	9d63cd79abb0fc45d4797ff86134	0xc9fb14391f509ab3a4a7161893ce938fdbe029964e59f0df3ac3dd4594a309d3	https://polygonscan.com/tx/0xc9fb14391f509ab3a4a7161893ce938fdbe029964e59f0df3ac3dd4594a309d3	196	\N
47	2023-11-12 00:28:12.654857+00	2023-11-12 00:28:12.654857+00	pf_196	fdc02caf42ec7236ac1406c2f85a	0x1edca4d3c38c869003eab49bf13ec619b1b4dc69d00fb825a9c8dbcdc8ed8cb9	https://polygonscan.com/tx/0x1edca4d3c38c869003eab49bf13ec619b1b4dc69d00fb825a9c8dbcdc8ed8cb9	196	\N
48	2023-11-13 21:41:25.239837+00	2023-11-13 21:41:25.239837+00	pj_5	9375827788cef7fb21340f3cfe28	0xa81d6f6434f35304856bb403517ef5a4227cc2d4b44e1f64a35329d4ff2ffb2b	https://polygonscan.com/tx/0xa81d6f6434f35304856bb403517ef5a4227cc2d4b44e1f64a35329d4ff2ffb2b	196	\N
49	2023-11-14 22:27:03.384261+00	2023-11-14 22:27:03.384261+00	pj_5	2467873d03c5c49b5641e5504383	0x477c38596b1e7b43ff42cfc454db5fbcc8fef282873eabf409e3f25f0a64ff34	https://polygonscan.com/tx/0x477c38596b1e7b43ff42cfc454db5fbcc8fef282873eabf409e3f25f0a64ff34	196	68
50	2023-11-17 16:07:37.375762+00	2023-11-17 16:07:37.375762+00	pj_3	7ee5e9fb7e291ac5f3d769908512	0x8f8a78901c1fce04829a0c7a7dad07efb0f9cfaaf5ba3abe0292e2fe7f797b0d	https://polygonscan.com/tx/0x8f8a78901c1fce04829a0c7a7dad07efb0f9cfaaf5ba3abe0292e2fe7f797b0d	9	69
51	2023-11-17 17:05:33.3374+00	2023-11-17 17:05:33.3374+00	pj_3	44f966afff6defca5065e53094e0	0x945f399e7aeab008f0c21b9936e118a6afb8e757ab26cbd58f21a5e8934aa9e3	https://polygonscan.com/tx/0x945f399e7aeab008f0c21b9936e118a6afb8e757ab26cbd58f21a5e8934aa9e3	9	70
\.


--
-- Data for Name: offers_offer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offers_offer (id, created, modified, shares, amount_per_share, company_id, user_id, for_user_id, is_family, concept, capital_increase_id, is_canceled, status, cod) FROM stdin;
51	2023-10-27 10:13:38.856667+00	2023-10-27 10:13:38.856667+00	1	1.00	3	196	\N	f	sale	\N	f	pending	pf_196
52	2023-10-27 10:33:25.316382+00	2023-10-27 10:33:25.316382+00	1	1.00	3	196	\N	f	sale	\N	f	pending	pf_196
53	2023-10-27 10:33:33.294011+00	2023-10-27 10:33:33.294011+00	2	1.00	3	196	\N	f	sale	\N	f	pending	pf_196
54	2023-10-27 10:33:45.104632+00	2023-10-27 10:33:45.104632+00	1	1.00	3	196	\N	f	sale	\N	f	pending	pf_196
55	2023-10-27 10:33:51.45127+00	2023-10-27 10:33:51.45127+00	2	2.00	3	196	\N	f	sale	\N	f	pending	pf_196
56	2023-10-27 10:33:57.819354+00	2023-10-27 10:33:57.819354+00	1	1.00	3	196	\N	f	sale	\N	f	pending	pf_196
57	2023-10-27 20:35:12.497903+00	2023-10-27 20:35:12.497903+00	1	1.00	3	196	\N	f	sale	\N	f	pending	pf_196
58	2023-10-27 20:52:12.019196+00	2023-10-27 20:52:12.019196+00	1	1.00	3	196	\N	f	sale	\N	f	pending	pf_196
59	2023-10-29 20:11:27.626296+00	2023-10-29 20:11:27.626296+00	1	1.00	3	196	\N	f	sale	\N	f	pending	pf_196
3	2023-05-09 11:48:58.913391+00	2023-09-08 08:08:40.241757+00	500	1.00	13	74	\N	f	capital_increase	3	f	pending	pf_74
60	2023-10-29 20:27:20.223429+00	2023-10-29 20:27:20.223429+00	1	1.00	3	196	\N	f	sale	\N	f	pending	pf_196
61	2023-10-29 20:36:15.663091+00	2023-10-29 20:36:15.663091+00	1	1.00	3	196	\N	f	sale	\N	f	pending	pf_196
62	2023-10-29 21:29:59.601589+00	2023-10-29 21:29:59.601589+00	1	1.00	3	196	\N	f	sale	\N	f	pending	pf_196
64	2023-10-30 22:34:27.501066+00	2023-10-30 22:34:27.501066+00	1	1.00	3	196	\N	f	sale	\N	f	pending	pf_196
65	2023-10-30 23:00:01.13401+00	2023-10-30 23:00:01.13401+00	1	1.00	3	196	\N	f	sale	\N	f	pending	pf_196
66	2023-10-30 23:04:48.861598+00	2023-10-30 23:04:48.861598+00	1	1.00	3	196	\N	f	sale	\N	f	pending	pf_196
67	2023-10-31 22:23:50.234625+00	2023-10-31 22:23:50.234625+00	1	1.00	3	196	\N	f	sale	\N	f	pending	pf_196
68	2023-10-31 22:29:15.89322+00	2023-10-31 22:29:15.89322+00	1	1.00	3	196	\N	f	sale	\N	f	pending	pf_196
69	2023-10-31 22:38:22.436194+00	2023-10-31 22:38:22.436194+00	1	1.00	3	196	\N	f	sale	\N	f	pending	pf_196
70	2023-10-31 23:15:24.405435+00	2023-10-31 23:15:24.405435+00	1	1.00	3	196	\N	f	sale	\N	f	pending	pf_196
71	2023-10-31 23:26:54.114827+00	2023-10-31 23:26:54.114827+00	1	1.00	3	196	\N	f	sale	\N	f	pending	pf_196
112	2023-11-04 02:01:40.092206+00	2023-11-04 02:03:38.252826+00	1	1.00	3	324	\N	f	sale	\N	f	completed	pf_324
86	2023-11-02 21:09:24.652923+00	2023-11-02 21:24:27.268456+00	1	1.00	3	324	\N	f	sale	\N	f	completed	pf_324
87	2023-11-02 21:14:08.583257+00	2023-11-02 21:25:31.100458+00	1	1.00	3	324	\N	f	sale	\N	f	completed	pf_324
88	2023-11-02 21:42:55.206488+00	2023-11-02 21:42:55.206488+00	1	1.00	3	324	\N	f	sale	\N	f	pending	pf_324
89	2023-11-02 21:47:07.879486+00	2023-11-02 21:47:07.879486+00	1	1.00	3	324	\N	f	sale	\N	f	pending	pf_324
90	2023-11-02 21:53:35.944004+00	2023-11-02 21:53:35.944004+00	1	1.00	4	82	\N	f	sale	\N	f	pending	pf_82
91	2023-11-02 21:54:15.675429+00	2023-11-02 21:54:15.675429+00	1	1.00	4	82	\N	f	sale	\N	f	pending	pf_82
93	2023-11-02 22:00:07.322091+00	2023-11-02 22:00:07.322091+00	1	1.00	3	324	\N	f	sale	\N	f	pending	pf_324
33	2023-09-17 22:39:29.188102+00	2023-09-17 22:39:29.188102+00	1	2.00	4	13	\N	f	sale	\N	f	pending	pf_13
35	2023-09-19 07:52:30.287448+00	2023-09-19 07:52:30.287448+00	1	1.00	4	13	\N	f	sale	\N	f	pending	pf_13
113	2023-11-04 02:04:10.528355+00	2023-11-04 02:05:17.684547+00	1	1.00	3	324	\N	f	sale	\N	f	completed	pf_324
94	2023-11-02 22:05:23.166292+00	2023-11-02 22:05:23.166292+00	1	1.00	3	324	\N	f	sale	\N	f	pending	pf_324
95	2023-11-02 22:16:24.539488+00	2023-11-02 22:16:24.539488+00	1	1.00	3	324	\N	f	sale	\N	f	pending	pf_324
96	2023-11-02 22:28:44.493107+00	2023-11-02 22:28:44.493107+00	1	1.00	3	324	\N	f	sale	\N	f	pending	pf_324
97	2023-11-03 15:33:50.328678+00	2023-11-03 15:33:50.328678+00	1000	1.00	4	23	\N	f	capital_increase	12	f	pending	\N
84	2023-11-02 09:40:46.691831+00	2023-11-02 09:46:39.296677+00	1	1.00	3	324	\N	f	sale	\N	f	completed	pf_324
98	2023-11-03 15:47:03.612739+00	2023-11-03 15:47:03.612739+00	1	1.00	4	82	\N	f	sale	\N	f	pending	pf_82
99	2023-11-03 22:52:40.112175+00	2023-11-03 22:52:40.112175+00	1	1.00	3	324	\N	f	sale	\N	f	pending	pf_324
100	2023-11-04 00:01:04.824635+00	2023-11-04 00:01:04.824635+00	1	1.00	3	324	\N	f	sale	\N	f	pending	pf_324
101	2023-11-04 00:06:43.948584+00	2023-11-04 00:06:43.948584+00	1	1.00	3	324	\N	f	sale	\N	f	pending	pf_324
102	2023-11-04 00:13:40.401044+00	2023-11-04 00:13:40.401044+00	1	1.00	3	324	\N	f	sale	\N	f	pending	pf_324
103	2023-11-04 00:19:42.964779+00	2023-11-04 00:19:42.964779+00	1	1.00	3	324	\N	f	sale	\N	f	pending	pf_324
104	2023-11-04 00:32:29.582209+00	2023-11-04 00:32:29.582209+00	1	1.00	3	324	\N	f	sale	\N	f	pending	pf_324
105	2023-11-04 00:39:09.404664+00	2023-11-04 00:39:09.404664+00	1	1.00	3	324	\N	f	sale	\N	f	pending	pf_324
83	2023-11-02 09:40:19.37364+00	2023-11-02 09:57:44.27871+00	1	1.00	4	82	\N	f	sale	\N	f	completed	pf_82
114	2023-11-04 02:10:57.521338+00	2023-11-04 02:10:57.521338+00	1	1.00	3	324	\N	f	sale	\N	f	pending	pf_324
106	2023-11-04 00:44:46.701042+00	2023-11-04 00:46:29.870381+00	1	1.00	3	324	\N	f	sale	\N	f	completed	pf_324
107	2023-11-04 01:11:23.341743+00	2023-11-04 01:12:32.658115+00	1	1.00	3	324	\N	f	sale	\N	f	completed	pf_324
108	2023-11-04 01:20:17.880362+00	2023-11-04 01:21:53.646415+00	1	1.00	3	324	\N	f	sale	\N	f	completed	pf_324
109	2023-11-04 01:36:56.582942+00	2023-11-04 01:38:11.529231+00	1	1.00	3	324	\N	f	sale	\N	f	completed	pf_324
110	2023-11-04 01:41:03.689461+00	2023-11-04 01:42:08.758605+00	1	1.00	3	324	\N	f	sale	\N	f	completed	pf_324
111	2023-11-04 01:45:44.826464+00	2023-11-04 01:46:55.785055+00	1	1.00	3	324	\N	f	sale	\N	f	completed	pf_324
115	2023-11-04 02:11:59.306201+00	2023-11-04 02:13:06.026659+00	1	1.00	3	324	\N	f	sale	\N	f	completed	pf_324
116	2023-11-04 02:30:46.505864+00	2023-11-04 02:32:52.35895+00	1	1.00	3	324	\N	f	sale	\N	f	completed	pf_324
117	2023-11-04 02:38:16.271279+00	2023-11-04 02:39:29.362241+00	1	1.00	3	324	\N	f	sale	\N	f	completed	pf_324
118	2023-11-04 22:59:25.419647+00	2023-11-04 22:59:25.419647+00	1	1.00	3	324	\N	f	sale	\N	f	pending	pf_324
119	2023-11-04 23:15:11.18167+00	2023-11-04 23:15:11.18167+00	1	1.00	3	324	\N	f	sale	\N	f	pending	pf_324
120	2023-11-04 23:20:45.284009+00	2023-11-04 23:22:08.60124+00	1	1.00	3	324	\N	f	sale	\N	f	completed	pf_324
122	2023-11-05 00:13:01.770041+00	2023-11-05 00:16:54.153723+00	1	1.00	3	324	\N	f	sale	\N	f	completed	pf_324
123	2023-11-05 00:18:06.310922+00	2023-11-05 00:19:25.538428+00	1	1.00	3	324	\N	f	sale	\N	f	completed	pf_324
126	2023-11-09 16:19:52.929816+00	2023-11-09 16:19:52.929816+00	5	5.00	4	13	\N	f	sale	\N	f	pending	pf_13
128	2023-11-09 16:27:16.443379+00	2023-11-09 16:27:16.443379+00	5	1.00	4	13	\N	f	sale	\N	f	pending	pf_13
121	2023-11-05 00:07:18.152261+00	2023-11-09 16:46:59.378741+00	1	1.00	3	324	\N	f	sale	\N	f	completed	pf_324
129	2023-11-09 17:18:22.515606+00	2023-11-09 17:18:22.515606+00	1	1.00	3	196	\N	f	sale	\N	f	pending	pf_196
130	2023-11-09 17:31:29.50094+00	2023-11-09 17:33:16.385337+00	1	1.00	5	82	\N	f	sale	\N	f	completed	pf_82
131	2023-11-09 19:24:26.839584+00	2023-11-09 19:26:02.694824+00	1	1.00	5	28	\N	f	sale	\N	f	completed	pf_28
132	2023-11-09 19:30:25.924483+00	2023-11-09 19:32:38.050489+00	3	1.00	5	28	\N	f	sale	\N	f	completed	pf_28
133	2023-11-09 19:40:17.31104+00	2023-11-09 19:41:26.333204+00	2	1.00	5	28	\N	f	sale	\N	f	completed	pf_28
134	2023-11-09 20:43:53.20841+00	2023-11-09 20:46:28.917424+00	2	2.00	3	196	\N	f	sale	\N	f	completed	pf_196
135	2023-11-09 20:49:52.080792+00	2023-11-09 20:51:55.658844+00	4	1.00	5	28	\N	f	sale	\N	f	completed	pf_28
136	2023-11-10 17:29:15.061472+00	2023-11-10 17:31:53.193401+00	2	2.00	3	324	\N	f	sale	\N	f	completed	pf_324
139	2023-11-10 18:08:35.575056+00	2023-11-10 18:10:09.387303+00	4	2.00	3	196	\N	f	sale	\N	f	completed	pf_196
143	2023-11-11 10:27:28.167101+00	2023-11-11 10:29:15.903082+00	4	2.00	3	196	\N	f	sale	\N	f	completed	pf_196
152	2023-11-14 21:36:44.414408+00	2023-11-14 21:36:44.423669+00	2000	1.00	4	23	\N	f	capital_increase	13	f	pending	pj_4
153	2023-11-14 22:25:36.92251+00	2023-11-14 22:26:54.40514+00	1	1.00	1	324	\N	f	sale	\N	f	completed	pf_324
154	2023-11-15 14:55:21.139138+00	2023-11-15 14:55:21.139138+00	1	1.00	1	324	\N	f	sale	\N	f	pending	pf_324
155	2023-11-17 15:15:18.13349+00	2023-11-17 15:15:18.13349+00	1	1.00	1	324	\N	f	sale	\N	f	pending	pf_324
156	2023-11-17 16:06:09.620467+00	2023-11-17 16:07:26.023926+00	1	1.00	1	324	\N	f	sale	\N	f	completed	pf_324
157	2023-11-17 17:02:40.49597+00	2023-11-17 17:05:16.266679+00	1	1.00	1	324	\N	f	sale	\N	f	completed	pf_324
158	2023-11-17 17:52:47.917736+00	2023-11-17 17:52:47.917736+00	1	1.00	1	324	\N	f	sale	\N	f	pending	pf_324
159	2023-11-17 18:01:21.627568+00	2023-11-17 18:01:21.627568+00	1	1.00	1	324	\N	f	sale	\N	f	pending	pf_324
160	2023-11-17 18:28:11.099381+00	2023-11-17 18:28:11.099381+00	1	1.00	1	324	\N	f	sale	\N	f	pending	pf_324
\.


--
-- Data for Name: offers_proposal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offers_proposal (id, created, modified, shares, amount_per_share, state, offer_id, user_id, operation_id, payment_id, shares_range_end, shares_range_start, fees, total_amount, cod) FROM stdin;
101	2023-11-04 00:01:18.736662+00	2023-11-04 00:01:57.760461+00	1	1.00	executing	100	82	\N	\N	1	1	0.03	1.00	pf_82
92	2023-11-02 21:14:28.137668+00	2023-11-02 21:25:31.09629+00	1	1.00	executed	87	82	54	145	21	21	0.03	1.00	pf_82
87	2023-11-02 09:41:14.420031+00	2023-11-02 09:46:39.292354+00	1	1.00	executed	84	28	37	128	1	1	0.03	1.00	pf_28
107	2023-11-04 00:45:00.898175+00	2023-11-04 00:46:29.866732+00	1	1.00	executed	106	82	57	179	30	30	0.03	1.00	pf_82
93	2023-11-02 21:43:10.791064+00	2023-11-02 21:43:43.195994+00	1	1.00	executing	88	82	\N	\N	22	22	0.03	1.00	pf_82
102	2023-11-04 00:06:59.723181+00	2023-11-04 00:07:43.166572+00	1	1.00	executing	101	82	\N	\N	11	11	0.03	1.00	pf_82
94	2023-11-02 21:47:22.396848+00	2023-11-02 21:47:53.048526+00	1	1.00	executing	89	82	\N	\N	24	24	0.03	1.00	pf_82
8	2023-06-22 09:40:22.673404+00	2023-10-07 06:56:03.258633+00	2	1.00	rejected	3	134	\N	\N	\N	\N	0.00	200.00	pf_134
1	2023-06-07 10:13:13.974426+00	2023-09-09 09:12:16.051005+00	7	1.00	pending	3	90	\N	\N	\N	\N	0.00	700.00	pf_90
2	2023-06-12 09:08:55.466044+00	2023-09-09 09:12:43.293577+00	5	1.00	pending	3	89	\N	\N	\N	\N	0.00	500.00	pf_89
3	2023-06-15 08:01:56.54905+00	2023-09-09 09:13:14.623616+00	2	1.00	pending	3	120	\N	\N	\N	\N	0.00	200.00	pf_120
4	2023-06-15 09:37:49.794627+00	2023-09-09 09:13:34.523922+00	2	1.00	pending	3	120	\N	\N	\N	\N	0.00	200.00	pf_120
5	2023-06-15 12:18:57.601878+00	2023-09-09 09:13:41.298178+00	1	1.00	pending	3	120	\N	\N	\N	\N	0.00	100.00	pf_120
6	2023-06-19 08:18:21.874213+00	2023-09-09 09:14:10.989145+00	5	1.00	pending	3	87	\N	\N	\N	\N	0.00	500.00	pf_87
7	2023-06-21 09:48:47.041353+00	2023-09-09 09:14:38.207532+00	5	1.00	pending	3	122	\N	\N	\N	\N	0.00	500.00	pf_122
10	2023-06-26 06:44:22.122566+00	2023-09-09 09:15:15.129304+00	1	1.00	pending	3	136	\N	\N	\N	\N	0.00	100.00	pf_136
11	2023-06-27 08:57:54.752579+00	2023-09-09 09:15:33.071057+00	2	1.00	pending	3	135	\N	\N	\N	\N	0.00	200.00	pf_135
12	2023-06-30 09:41:51.822594+00	2023-09-09 09:15:58.371207+00	1	1.00	pending	3	134	\N	\N	\N	\N	0.00	100.00	pf_134
13	2023-07-01 09:37:56.334808+00	2023-09-09 09:16:26.981477+00	4	1.00	pending	3	126	\N	\N	\N	\N	0.00	400.00	pf_126
19	2023-07-15 07:24:33.353597+00	2023-09-09 09:16:48.423689+00	1	1.00	pending	3	144	\N	\N	\N	\N	0.00	100.00	pf_144
20	2023-07-18 12:04:47.109624+00	2023-09-09 09:17:09.453218+00	1	1.00	pending	3	152	\N	\N	\N	\N	0.00	100.00	pf_152
22	2023-08-02 16:15:02.109275+00	2023-09-09 09:17:32.566775+00	5	1.00	pending	3	125	\N	\N	\N	\N	0.00	500.00	pf_125
23	2023-08-04 20:26:50.020911+00	2023-09-09 09:17:54.520483+00	1	1.00	pending	3	191	\N	\N	\N	\N	0.00	100.00	pf_191
17	2023-07-06 14:52:00.079488+00	2023-10-07 06:57:20.427274+00	2	1.00	rejected	3	134	\N	\N	\N	\N	0.00	200.00	pf_134
88	2023-11-02 09:42:47.656512+00	2023-11-02 09:57:44.271526+00	1	1.00	executed	83	28	46	137	10	10	0.03	1.00	pf_28
110	2023-11-04 01:37:09.72728+00	2023-11-04 01:38:11.525045+00	1	1.00	executed	109	82	60	182	11	11	0.03	1.00	pf_82
96	2023-11-02 22:00:26.152487+00	2023-11-02 22:00:42.233451+00	1	1.00	accepted	93	82	\N	\N	\N	\N	0.03	1.00	pf_82
128	2023-11-09 17:31:54.403987+00	2023-11-09 17:33:16.381632+00	1	1.00	executed	130	196	84	203	1	1	0.03	1.00	pf_196
103	2023-11-04 00:13:57.475024+00	2023-11-04 00:14:51.510836+00	1	1.00	executing	102	82	\N	\N	12	12	0.03	1.00	pf_82
129	2023-11-09 19:24:53.707566+00	2023-11-09 19:26:02.683405+00	1	1.00	executed	131	196	86	204	2	2	0.03	1.00	pf_196
97	2023-11-02 22:05:37.372353+00	2023-11-02 22:06:18.011485+00	1	1.00	executing	94	82	\N	\N	26	26	0.03	1.00	pf_82
104	2023-11-04 00:19:59.97846+00	2023-11-04 00:20:44.040893+00	1	1.00	executing	103	82	\N	\N	11	11	0.03	1.00	pf_82
98	2023-11-02 22:17:19.47146+00	2023-11-02 22:18:01.729271+00	1	1.00	executing	95	82	\N	\N	26	26	0.03	1.00	pf_82
99	2023-11-02 22:28:57.716972+00	2023-11-02 22:29:37.350977+00	1	1.00	executing	96	82	\N	\N	10	10	0.03	1.00	pf_82
105	2023-11-04 00:32:46.461196+00	2023-11-04 00:33:25.248317+00	1	1.00	accepted	104	82	\N	\N	22	22	0.03	1.00	pf_82
100	2023-11-03 22:52:53.874889+00	2023-11-03 22:53:59.376621+00	1	1.00	executing	99	82	\N	\N	12	12	0.03	1.00	pf_82
108	2023-11-04 01:11:41.506528+00	2023-11-04 01:12:32.654082+00	1	1.00	executed	107	82	58	180	29	29	0.03	1.00	pf_82
130	2023-11-09 19:30:49.787805+00	2023-11-09 19:32:38.040994+00	3	1.00	executed	132	196	87	205	6	3	0.09	3.00	pf_196
106	2023-11-04 00:39:23.698835+00	2023-11-04 00:39:56.009615+00	1	1.00	executing	105	82	\N	\N	23	23	0.03	1.00	pf_82
115	2023-11-04 02:12:16.313259+00	2023-11-04 02:13:06.022876+00	1	1.00	executed	115	82	66	188	29	29	0.03	1.00	pf_82
91	2023-11-02 21:09:40.488727+00	2023-11-02 21:24:27.263857+00	1	1.00	executed	86	82	53	144	1	1	0.03	1.00	pf_82
131	2023-11-09 19:40:35.082652+00	2023-11-09 19:41:26.329523+00	2	1.00	executed	133	196	89	207	10	8	0.06	2.00	pf_196
111	2023-11-04 01:41:18.401125+00	2023-11-04 01:42:08.754596+00	1	1.00	executed	110	82	61	183	33	33	0.03	1.00	pf_82
153	2023-11-15 14:57:52.984128+00	2023-11-15 14:59:48.183984+00	1	1.00	executing	154	9	\N	\N	11	10	0.03	1.00	pj_3
109	2023-11-04 01:20:59.287884+00	2023-11-04 01:21:53.641651+00	1	1.00	executed	108	82	59	181	33	33	0.03	1.00	pf_82
157	2023-11-17 17:53:11.209097+00	2023-11-17 17:53:31.117033+00	1	1.00	accepted	158	9	\N	\N	\N	\N	0.03	1.00	pj_3
132	2023-11-09 20:44:47.654162+00	2023-11-09 20:46:28.913516+00	2	4.00	executed	134	324	91	209	10	8	0.24	8.00	pf_324
113	2023-11-04 02:02:04.214706+00	2023-11-04 02:03:38.249013+00	1	1.00	executed	112	82	64	186	14	14	0.03	1.00	pf_82
155	2023-11-17 16:06:26.956832+00	2023-11-17 16:07:26.016105+00	1	1.00	executed	156	9	114	259	3	2	0.03	1.00	pj_3
112	2023-11-04 01:46:07.82729+00	2023-11-04 01:46:55.7812+00	1	1.00	executed	111	82	62	184	34	34	0.03	1.00	pf_82
133	2023-11-09 20:50:37.461623+00	2023-11-09 20:51:55.655325+00	4	1.00	executed	135	324	92	210	1	1	0.12	4.00	pf_324
114	2023-11-04 02:04:24.312469+00	2023-11-04 02:05:17.681108+00	1	1.00	executed	113	82	65	187	15	15	0.03	1.00	pf_82
134	2023-11-10 17:29:33.003088+00	2023-11-10 17:31:53.188835+00	2	2.00	executed	136	196	93	211	10	8	0.12	4.00	pf_196
117	2023-11-04 02:38:38.902093+00	2023-11-04 02:39:29.357695+00	1	1.00	executed	117	82	69	191	55	55	0.03	1.00	pf_82
118	2023-11-04 22:59:43.246412+00	2023-11-04 23:00:02.807319+00	1	1.00	accepted	118	82	\N	\N	\N	\N	0.03	1.00	pf_82
123	2023-11-05 00:18:30.49209+00	2023-11-05 00:19:25.534458+00	1	1.00	executed	123	196	76	198	33	33	0.03	1.00	pf_196
158	2023-11-17 18:01:40.317837+00	2023-11-17 18:02:04.768335+00	1	1.00	accepted	159	9	\N	\N	\N	\N	0.03	1.00	pj_3
116	2023-11-04 02:31:06.964015+00	2023-11-04 02:32:52.354785+00	1	1.00	executed	116	82	68	190	7	7	0.03	1.00	pf_82
119	2023-11-04 23:15:27.56828+00	2023-11-04 23:15:50.991368+00	1	1.00	accepted	119	82	\N	\N	\N	\N	0.03	1.00	pf_82
120	2023-11-04 23:21:07.64394+00	2023-11-04 23:22:08.59661+00	1	1.00	executed	120	82	72	194	2	2	0.03	1.00	pf_82
124	2023-11-08 12:32:42.764967+00	2023-11-08 12:32:42.764967+00	1	1.00	pending	3	332	\N	\N	\N	\N	0.00	100.00	pf_332
136	2023-11-10 18:09:20.608364+00	2023-11-10 18:10:09.383469+00	4	2.00	executed	139	324	100	219	5	1	0.24	8.00	pf_324
122	2023-11-05 00:14:59.711325+00	2023-11-05 00:16:54.142565+00	1	1.00	executed	122	196	75	197	11	11	0.03	1.00	pf_196
127	2023-11-09 16:27:57.087295+00	2023-11-09 16:30:14.629067+00	5	1.00	executing	128	196	\N	\N	8	3	0.15	5.00	pf_196
121	2023-11-05 00:07:32.303765+00	2023-11-09 16:46:59.373943+00	1	1.00	executed	121	82	78	202	22	22	0.03	1.00	pf_82
126	2023-11-09 16:21:09.186461+00	2023-11-09 16:41:00.200632+00	1	1.00	executing	126	196	\N	\N	2	2	0.03	1.00	pf_196
159	2023-11-17 18:28:24.864832+00	2023-11-17 18:28:43.657356+00	1	1.00	accepted	160	9	\N	\N	\N	\N	0.03	1.00	pj_3
140	2023-11-11 10:28:03.961803+00	2023-11-11 10:29:15.899431+00	4	2.00	executed	143	324	104	235	6	2	0.24	8.00	pf_324
152	2023-11-14 22:25:52.327565+00	2023-11-14 22:26:54.400516+00	1	1.00	executed	153	196	113	256	2	1	0.03	1.00	pj_5
154	2023-11-17 15:19:17.306052+00	2023-11-17 15:23:38.566604+00	1	1.00	executing	155	9	\N	\N	2	1	0.03	1.00	pj_3
156	2023-11-17 17:04:30.559714+00	2023-11-17 17:05:16.262241+00	1	1.00	executed	157	9	115	260	1	1	0.03	1.00	pj_3
\.


--
-- Data for Name: operations_operation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.operations_operation (id, created, modified, type, status, shares, amount, date, concept, range_start, range_end, company_id, from_user_id, to_user_id, from_shares_after_operation, to_shares_after_operation, amount_per_share, stellar_transaction_hash, issue_premium, from_cod, to_cod) FROM stdin;
25	2023-11-01 17:38:30.354479+00	2023-11-01 17:38:37.370406+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-01	\N	103	104	4	82	28	\N	\N	1.00	8f7ff2a1f58a40eccc047c47814c2baf612033cd07a5435322fa78229a1296ed	\N	\N	\N
15	2023-10-27 10:12:51.976113+00	2023-10-27 10:13:04.313705+00	ASSIGNMENT	COMPLETED	100	100.00	2021-10-27	Asignacion Participaciones Sociales	1	100	3	\N	196	\N	\N	1.00	f4fde41d3cddefb82c81ec86de4f6dc9a77ec06ad4c09ff567efb03b0d993dcf	\N	\N	\N
32	2023-11-01 18:08:31.030171+00	2023-11-01 18:08:38.087127+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-01	\N	33	34	3	324	28	\N	\N	1.00	ea2524b8039158275aeee9ffa929e59f3385a69079ec80bac1961e623312eaec	\N	\N	\N
16	2023-10-31 19:49:52.130083+00	2023-10-31 19:50:03.155231+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-10-31	Compra Venta Participaciones Sociales	1	1	3	196	23	\N	\N	1.00	16cb14cf0bfc7aa7c99575ccebf9f0af5e2dae147e53c9a48840356e1e69e6f2	\N	\N	\N
12	2023-09-17 22:13:35.877898+00	2023-09-17 22:13:44.177105+00	ASSIGNMENT	COMPLETED	1500	1500.00	2018-07-01	Asignación Participaciones Sociales	1	1500	4	\N	13	\N	\N	1.00	39cbe41297b0f4777ff8dd7d7173ab50f06ee96bf747c586d53d4fb427570cbd	\N	\N	\N
13	2023-09-17 22:14:15.304432+00	2023-09-17 22:14:29.562035+00	ASSIGNMENT	COMPLETED	1500	1500.00	2018-07-01	Asignación Participaciones Sociales	1501	3000	4	\N	82	\N	\N	1.00	9ba2bcb2cf54841a385819af81548a45063f07206b8146c1cc30fa9332796a11	\N	\N	\N
33	2023-11-01 18:13:27.828851+00	2023-11-01 18:13:38.568266+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-01	\N	1	1	3	324	196	\N	\N	1.00	20eb574d182a5ac5db8cb7540173f02c0bd5178837a55d2a2020efb0142a2cad	\N	\N	\N
21	2023-10-31 23:41:27.676451+00	2023-10-31 23:41:41.806054+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-10-31	\N	17	17	3	196	28	\N	\N	1.00	0e5314a43492a7fa28794ceacd1c3dd2f9cfe58aaddd2caf5ade619216c7321e	\N	\N	\N
22	2023-11-01 09:34:24.658673+00	2023-11-01 09:34:30.641591+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-01	\N	44	45	4	82	23	\N	\N	1.00	429a6d840bfc4426eacef21e73b8f6d6fb558825c13137e63e7ef2dc87368043	\N	\N	\N
28	2023-11-01 17:48:30.423411+00	2023-11-01 17:48:38.370697+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-01	\N	100	101	4	82	28	\N	\N	1.00	06235b920f3417b5b0de774e58fe3422b24175a8897aad22ad0bb224e0244d86	\N	\N	\N
23	2023-11-01 17:25:31.596182+00	2023-11-01 17:25:43.317658+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-01	\N	1	1	4	82	28	\N	\N	1.00	89d0c7694949a2e4feca07b2585a2cb3def3e18129b897dcd0d2c4a13ffcbfa7	\N	\N	\N
34	2023-11-01 18:20:45.381877+00	2023-11-01 18:20:56.087034+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-01	\N	102	102	3	324	196	\N	\N	1.00	d8e613749f7caced54ca6263056f9688dcd35ce413d96c893b990895e99c573b	\N	\N	\N
57	2023-11-04 00:46:20.936869+00	2023-11-04 00:46:29.838317+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-04	\N	30	30	3	324	82	\N	\N	1.00	5c0a4c66b341ce33e2cf3c60d5c61b9dc2c5fe54874972ce03265b7ebb4afc8d	\N	\N	\N
29	2023-11-01 17:52:58.941299+00	2023-11-01 17:53:13.503859+00	ASSIGNMENT	COMPLETED	1	200.00	2022-11-01	Asignación Participaciones Sociales	1	200	3	\N	9	\N	\N	200.00	84ae5a1d08037404f6c33a2b22ad01b03114a357e183a843654c298d5ce154e3	\N	\N	\N
47	2023-11-02 10:03:29.130612+00	2023-11-02 10:03:34.316398+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-02	\N	11	11	3	196	28	\N	\N	1.00	7de1f6a3bca6f1249beae79b45f0601bf2734b2bf201e342eaba82d835472ba7	\N	\N	\N
31	2023-11-01 18:01:24.568282+00	2023-11-01 18:01:40.846721+00	ASSIGNMENT	COMPLETED	100	100.00	2021-11-01	Asignación Participaciones Sociales	200	300	3	\N	324	\N	\N	1.00	7af412dc3d8be1fe2bf14813ad52b606380bd837d4c03a42649a311de4841e9a	\N	\N	\N
36	2023-11-01 20:49:20.096468+00	2023-11-01 20:49:30.224498+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-01	\N	10	10	3	196	28	\N	\N	1.00	53897bc5b8f80286b334107222ef6b16018eb57e870dd01afe577617ef44dd70	\N	\N	\N
37	2023-11-02 09:46:32.629729+00	2023-11-02 09:46:39.253081+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-02	\N	1	1	3	324	28	\N	\N	1.00	1a4ebc2707df02878088717a542318dc31cf2f7442584aa6636aff2e0f9efdf6	\N	\N	\N
53	2023-11-02 21:24:13.816301+00	2023-11-02 21:24:27.239307+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-02	\N	1	1	3	324	82	\N	\N	1.00	29c0471eb582fa5c63e266c76ce1cec35bbb08ec061f37d088816fe5e1365094	\N	\N	\N
68	2023-11-04 02:32:44.701296+00	2023-11-04 02:32:52.330927+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-04	\N	7	7	3	324	82	\N	\N	1.00	ab6b35b74537677685e11e87a01cc1d66eab922254c9117e0d90308d09636b38	\N	\N	\N
54	2023-11-02 21:25:25.678263+00	2023-11-02 21:25:31.069592+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-02	\N	21	21	3	324	82	\N	\N	1.00	cc14d15f6d43b00bd27a3116a2b9fd88aada5c6a2bb191c9a6c1ff58bf28a1f7	\N	\N	\N
46	2023-11-02 09:57:37.804543+00	2023-11-02 09:57:44.243893+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-02	\N	10	10	4	82	28	\N	\N	1.00	673a9864ca2cf5e6ff6ba78e1bfa9c3ec54baeff8807025b63dd54c4c6d5235f	\N	\N	\N
65	2023-11-04 02:05:12.953812+00	2023-11-04 02:05:17.657827+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-04	\N	15	15	3	324	82	\N	\N	1.00	2feb30fd582d8131eded4732f428b6b89258347475be5da58526c158c596fac7	\N	\N	\N
58	2023-11-04 01:12:27.705857+00	2023-11-04 01:12:32.627703+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-04	\N	29	29	3	324	82	\N	\N	1.00	0634655658b4435dd7545f146f5a13a91bbd263721cd6521473ae5e30605131d	\N	\N	\N
61	2023-11-04 01:41:57.831668+00	2023-11-04 01:42:08.713324+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-04	\N	33	33	3	324	82	\N	\N	1.00	a11d1b6d544fd41d4e3f6a7460a2264f1293116d73f2d1a18ad6eb64d6b4efee	\N	\N	\N
59	2023-11-04 01:21:42.758745+00	2023-11-04 01:21:53.619592+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-04	\N	33	33	3	324	82	\N	\N	1.00	da7a3f2c5fbbb72b9f84ac0854e0d7e585250111bed87be4e1e74de8d35cb683	\N	\N	\N
60	2023-11-04 01:38:02.333233+00	2023-11-04 01:38:11.47954+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-04	\N	11	11	3	324	82	\N	\N	1.00	38844dfee35fc25efa1ad7d9ed9847bd9faae51c387d0d20b458871af5d01f23	\N	\N	\N
62	2023-11-04 01:46:47.654045+00	2023-11-04 01:46:55.725552+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-04	\N	34	34	3	324	82	\N	\N	1.00	267a0ac195559ac35b3f2dffd7f5a4dd37804d889d1c23f8a50abbea5f1524a9	\N	\N	\N
64	2023-11-04 02:03:34.124849+00	2023-11-04 02:03:38.219853+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-04	\N	14	14	3	324	82	\N	\N	1.00	067ec70fcae2af22b5083488b2b65009ca69ef2aa8213cd44d885ad0e1d9b0e5	\N	\N	\N
66	2023-11-04 02:13:00.410499+00	2023-11-04 02:13:05.990369+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-04	\N	29	29	3	324	82	\N	\N	1.00	91c7bf6670d66cf94fc9aa80be644550a3d9405183f9fd6c765d6e2809e7a5ff	\N	\N	\N
69	2023-11-04 02:39:22.825005+00	2023-11-04 02:39:29.329811+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-04	\N	55	55	3	324	82	\N	\N	1.00	1614e46be6921c36e56ff6d7556b3969814068f852088103f5bd69b44a2ddcc0	\N	\N	\N
72	2023-11-04 23:22:00.161925+00	2023-11-04 23:22:08.548289+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-04	\N	2	2	3	324	82	\N	\N	1.00	38d6d93e3e095ba9e6bf836dfe2c0a06c6ae4a1677803aee27fe5d4b0b82d626	\N	\N	\N
75	2023-11-05 00:16:47.436187+00	2023-11-05 00:16:54.116813+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-05	\N	11	11	3	324	196	\N	\N	1.00	9bc99d18ad797bc13821a88548cda3fdac71efe3c3c6461a1fee720729523bf2	\N	\N	\N
76	2023-11-05 00:19:18.185681+00	2023-11-05 00:19:25.507029+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-05	\N	33	33	3	324	196	\N	\N	1.00	f107798db15a4fe5c3503613edf82161bee61b6dc6af899e7a27d3c8858744b7	\N	\N	\N
77	2023-11-08 15:55:29.314904+00	2023-11-08 15:55:33.70771+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-08	\N	1	1	3	196	28	\N	\N	1.00	33f4e1a8ddb118dcf19061167cbb953d03a0161219bc34ae77d03886e19a3192	\N	\N	\N
78	2023-11-09 16:46:53.81028+00	2023-11-09 16:46:59.350514+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-09	\N	22	22	3	324	82	\N	\N	1.00	b8d6cef882bde17d81f42acf396792def186b253ebe7d86665086b2e2a961375	\N	\N	\N
86	2023-11-09 19:25:56.694914+00	2023-11-09 19:26:02.657155+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-09	\N	2	2	5	28	196	\N	\N	1.00	777ef9cd9134c41b82fa9b1646ced78241cb3b82175749e469630ce783f458a1	\N	\N	\N
113	2023-11-14 22:26:50.174406+00	2023-11-14 22:26:54.373836+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-14	\N	1	2	1	324	196	\N	\N	1.00	0b03987f1936e51ba05ca4e9bc61733a2a87a3b255673dd12a0b779ff4971081	\N	\N	\N
83	2023-11-09 17:27:13.518551+00	2023-11-09 17:27:37.374489+00	ASSIGNMENT	COMPLETED	1	1.00	2023-11-09	Asignación Participaciones Sociales	1	1	5	\N	82	\N	\N	1.00	29f0868a00a15d5ed633b88b9d898aa50c3c4b64dc5ea9ca3b63f32eee44b907	\N	\N	\N
87	2023-11-09 19:32:28.781803+00	2023-11-09 19:32:38.010357+00	BUY_AND_SELL	COMPLETED	3	3.00	2023-11-09	\N	3	6	5	28	196	\N	\N	1.00	0a953f73a4447d867b466dd11450bc4996bbec9446aa15505dc773c8b442ebf6	\N	\N	\N
84	2023-11-09 17:33:03.090179+00	2023-11-09 17:33:16.360539+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-09	\N	1	1	5	82	196	\N	\N	1.00	83b3c03d125b009da041d97ddabafcd67ad6f4b776c1b178ca21dcaea773ddb9	\N	\N	\N
85	2023-11-09 17:41:44.064682+00	2023-11-09 17:41:59.26113+00	ASSIGNMENT	COMPLETED	20	20.00	2021-11-09	Asignación Participaciones Sociales	1	20	5	\N	28	\N	\N	1.00	6bb3d65dbd781248f7775cb340eeb859829b6a7dffd1cac514bf49b43a1bb6c8	\N	\N	\N
89	2023-11-09 19:41:19.236209+00	2023-11-09 19:41:26.30581+00	BUY_AND_SELL	COMPLETED	2	2.00	2023-11-09	\N	8	10	5	28	196	\N	\N	1.00	b8a75969a83171d6959e026a853e4bd0fd0bb25a060fe4e53ff3c6b20dc2f0f8	\N	\N	\N
114	2023-11-17 16:07:15.753557+00	2023-11-17 16:07:25.986803+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-17	\N	2	3	1	324	9	\N	\N	1.00	1c72c712edad9242c652c2a95f8ccada64f5dc94b5640aab53b6a3fff61db091	\N	\N	\N
91	2023-11-09 20:46:20.466326+00	2023-11-09 20:46:28.888759+00	BUY_AND_SELL	COMPLETED	2	8.00	2023-11-09	\N	8	10	3	196	324	\N	\N	4.00	6496a6bc69db299d1fed52c63ff50d051d4ae75ab07877d8081a410bbd9ad626	\N	\N	\N
92	2023-11-09 20:51:39.497032+00	2023-11-09 20:51:55.6291+00	BUY_AND_SELL	COMPLETED	4	4.00	2023-11-09	\N	1	1	5	28	324	\N	\N	1.00	6082f02e887030a68a834b84af344284ace162d2bc86e22cd93d39681b8d165f	\N	\N	\N
93	2023-11-10 17:31:43.733743+00	2023-11-10 17:31:53.162853+00	BUY_AND_SELL	COMPLETED	2	4.00	2023-11-10	\N	8	10	3	324	196	\N	\N	2.00	165505941eaae6cf919eb0e01acb6b0cb93b0b385c91e1151e0c422404271b7d	\N	\N	\N
104	2023-11-11 10:29:09.282359+00	2023-11-11 10:29:15.87611+00	BUY_AND_SELL	COMPLETED	4	8.00	2023-11-11	\N	2	6	3	196	324	\N	\N	2.00	8b62ad96578f5109227524ffe87686affa3b9065e27f8323c8a5ce0325ddd433	\N	\N	\N
94	2023-11-10 17:49:54.266892+00	2023-11-10 17:50:09.009861+00	ASSIGNMENT	COMPLETED	100	100.00	2021-11-10	Asignacion participaciones	1	100	1	\N	324	\N	\N	1.00	ef515481af751eb09548ef657a75d9ad3cfd8859c48abcd43bd9f64e22264916	\N	\N	\N
115	2023-11-17 17:05:08.712643+00	2023-11-17 17:05:16.241131+00	BUY_AND_SELL	COMPLETED	1	1.00	2023-11-17	\N	1	1	1	324	9	\N	\N	1.00	3c269ad275f46e5a98343b4273973f285bfb51b56105149516f3ec923ff5bed6	\N	\N	\N
100	2023-11-10 18:10:02.85682+00	2023-11-10 18:10:09.358103+00	BUY_AND_SELL	COMPLETED	4	8.00	2023-11-10	\N	1	5	3	196	324	\N	\N	2.00	afa69fb51748df3ed38c7e4fef32a286d75631f1a6bdcc7ec1fa1551da6ead3f	\N	\N	\N
\.


--
-- Data for Name: options_option; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.options_option (id, name, public_name, type, value, is_list, file, is_public, help_text) FROM stdin;
2	token_issuer_starting_balance	Balance for issuing wallets	2	2.5	f		f	\N
3	token_distribution_starting_balance	Balance for distribution wallets	2	4	f		f	\N
5	capital_increase_fee_percentage	Commission in capital increase operations	0	0.0	f		t	\N
4	block_explorer_tx_url	URL for the block explorer tx page	2	https://stellarchain.io/tx	f		f	\N
1	notification_emails	Emails to receive event notifications	2	stockencapital@mecexis.com	f		f	\N
6	buy_and_sell_fee_percentage	Commission in buy and sell operations	0	3.0	f		t	\N
\.


--
-- Data for Name: options_useroption; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.options_useroption (id, public_name, type, value, is_list, name, user_id, file, is_public, help_text) FROM stdin;
\.


--
-- Data for Name: partners_partner; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.partners_partner (id, shares, company_id, user_id, unit_acquisition_value, cod, company_cod, content_type_id, object_id, user_cod) FROM stdin;
39	7	5	196	1.00	\N	\N	\N	\N	\N
41	4	5	324	1.00	\N	\N	\N	\N	\N
40	10	5	28	1.00	pf_28	\N	\N	\N	pf_28
56	1	1	196	1.00	\N	\N	\N	\N	\N
57	2	1	9	1.00	\N	\N	\N	\N	\N
15	1500	4	13	1.00	pf_13	\N	\N	\N	pf_13
42	97	1	324	1.00	pf_324	\N	\N	\N	pf_324
16	1495	4	82	1.00	pf_82	\N	\N	\N	pf_82
33	6	3	28	1.00	\N	\N	\N	\N	\N
32	15	3	82	1.00	\N	\N	\N	\N	\N
29	87	3	324	2.25	pf_324	\N	\N	\N	pf_324
26	1	3	9	200.00	pf_9	\N	\N	\N	pf_9
18	91	3	196	1.17	pf_196	\N	\N	\N	pf_196
38	0	5	82	1.00	pf_82	\N	\N	\N	pf_82
\.


--
-- Data for Name: payments_payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments_payment (id, created, modified, amount, currency, status, mangopay_transaction_id, to_user_id, type, from_user_id, fees, from_cod, to_cod) FROM stdin;
42	2023-06-27 08:07:14.220637+00	2023-06-27 08:07:14.224605+00	100.00	EUR	FAILED	54	23	DEPOSIT	\N	0.00	\N	\N
1	2022-09-29 16:42:43.153831+00	2022-09-29 16:42:43.158076+00	10.00	EUR	FAILED	1	13	DEPOSIT	\N	0.00	\N	\N
26	2023-06-19 06:40:51.361888+00	2023-06-19 06:40:51.363747+00	500.00	EUR	FAILED	34	122	DEPOSIT	\N	0.00	\N	\N
2	2022-09-29 16:42:43.319298+00	2022-09-29 16:42:43.321438+00	10.00	EUR	FAILED	2	13	DEPOSIT	\N	0.00	\N	\N
3	2022-09-30 08:01:59.414971+00	2022-09-30 08:01:59.417357+00	100.00	EUR	EXECUTED	3	23	DEPOSIT	\N	0.00	\N	\N
4	2022-10-03 08:04:50.987435+00	2022-10-03 08:04:50.990032+00	50.00	EUR	EXECUTED	4	23	DEPOSIT	\N	0.00	\N	\N
27	2023-06-19 08:17:37.923087+00	2023-06-19 08:17:37.925875+00	505.00	EUR	EXECUTED	36	87	DEPOSIT	\N	0.00	\N	\N
5	2022-12-06 09:36:42.338726+00	2022-12-06 09:36:42.341494+00	20.00	EUR	EXECUTED	5	28	DEPOSIT	\N	0.00	\N	\N
6	2023-03-15 11:10:14.020715+00	2023-03-15 11:10:14.023249+00	20.00	EUR	FAILED	7	28	DEPOSIT	\N	0.00	\N	\N
58	2023-07-14 18:10:06.242219+00	2023-07-14 18:10:06.245973+00	500.00	EUR	FAILED	30	120	DEPOSIT	\N	0.00	\N	\N
7	2023-03-15 11:10:14.349718+00	2023-03-15 11:10:14.352104+00	100.00	EUR	FAILED	6	28	DEPOSIT	\N	0.00	\N	\N
8	2023-05-04 06:07:22.675963+00	2023-05-04 06:07:22.675963+00	150.00	EUR	EXECUTED	8	\N	WITHDRAWAL	23	0.00	\N	\N
28	2023-06-21 08:18:40.747856+00	2023-06-21 08:18:40.75072+00	500.00	EUR	EXECUTED	37	122	DEPOSIT	\N	0.00	\N	\N
9	2023-05-09 13:09:17.278036+00	2023-05-09 13:09:17.286051+00	100.00	EUR	FAILED	10	74	DEPOSIT	\N	0.00	\N	\N
10	2023-05-18 13:35:14.417353+00	2023-05-18 13:35:14.420404+00	1000.00	EUR	FAILED	11	23	DEPOSIT	\N	0.00	\N	\N
43	2023-06-27 14:38:20.433946+00	2023-06-27 14:38:20.438114+00	400.00	EUR	FAILED	56	126	DEPOSIT	\N	0.00	\N	\N
11	2023-05-18 13:35:34.396487+00	2023-05-18 13:35:34.39835+00	1000.00	EUR	FAILED	12	23	DEPOSIT	\N	0.00	\N	\N
29	2023-06-22 09:28:47.740784+00	2023-06-22 09:28:47.745235+00	200.00	EUR	EXECUTED	41	134	DEPOSIT	\N	0.00	\N	\N
12	2023-05-29 09:16:27.629691+00	2023-05-29 09:16:27.633019+00	100.00	EUR	FAILED	14	23	DEPOSIT	\N	0.00	\N	\N
13	2023-05-29 09:16:49.253591+00	2023-05-29 09:16:49.255392+00	100.00	EUR	FAILED	15	23	DEPOSIT	\N	0.00	\N	\N
14	2023-06-01 12:09:36.636764+00	2023-06-01 12:09:36.640023+00	300.00	EUR	FAILED	17	90	DEPOSIT	\N	0.00	\N	\N
30	2023-06-22 09:30:16.129191+00	2023-06-22 09:30:16.131538+00	200.00	EUR	EXECUTED	42	134	DEPOSIT	\N	0.00	\N	\N
15	2023-06-05 10:00:06.173947+00	2023-06-05 10:00:06.179016+00	100.00	EUR	FAILED	18	23	DEPOSIT	\N	0.00	\N	\N
16	2023-06-06 21:05:53.722893+00	2023-06-06 21:05:53.726803+00	100.00	EUR	FAILED	20	13	DEPOSIT	\N	0.00	\N	\N
52	2023-07-05 17:23:01.987198+00	2023-07-05 17:23:02.298455+00	1.00	EUR	EXECUTED	69	23	BUY_AND_SELL	28	0.03	\N	\N
17	2023-06-07 10:10:46.717808+00	2023-06-07 10:10:46.719901+00	700.00	EUR	EXECUTED	22	90	DEPOSIT	\N	0.00	\N	\N
31	2023-06-22 10:22:08.741254+00	2023-06-22 10:22:08.744286+00	200.00	EUR	FAILED	43	135	DEPOSIT	\N	0.00	\N	\N
18	2023-06-11 06:18:58.367842+00	2023-06-11 06:18:58.370388+00	2000.00	EUR	FAILED	9	74	DEPOSIT	\N	0.00	\N	\N
32	2023-06-22 10:28:57.694922+00	2023-06-22 10:28:57.694922+00	200.00	EUR	EXECUTED	45	\N	WITHDRAWAL	134	0.00	\N	\N
19	2023-06-12 08:10:06.758528+00	2023-06-12 08:10:06.769525+00	100.00	EUR	FAILED	23	23	DEPOSIT	\N	0.00	\N	\N
20	2023-06-12 08:32:28.417662+00	2023-06-12 08:32:28.420913+00	200.00	EUR	FAILED	24	23	DEPOSIT	\N	0.00	\N	\N
44	2023-06-27 14:49:23.524812+00	2023-06-27 14:49:23.533608+00	400.00	EUR	FAILED	57	126	DEPOSIT	\N	0.00	\N	\N
21	2023-06-12 08:33:48.853409+00	2023-06-12 08:33:48.864935+00	1.00	EUR	FAILED	25	23	DEPOSIT	\N	0.00	\N	\N
33	2023-06-23 11:48:59.758754+00	2023-06-23 11:48:59.761571+00	20.00	EUR	EXECUTED	46	134	DEPOSIT	\N	0.00	\N	\N
22	2023-06-12 09:07:45.369878+00	2023-06-12 09:07:45.373225+00	500.00	EUR	EXECUTED	27	89	DEPOSIT	\N	0.00	\N	\N
23	2023-06-15 07:58:55.043482+00	2023-06-15 07:58:55.048008+00	500.00	EUR	EXECUTED	32	120	DEPOSIT	\N	0.00	\N	\N
24	2023-06-18 13:40:06.29569+00	2023-06-18 13:40:06.298705+00	10000.00	EUR	FAILED	13	23	DEPOSIT	\N	0.00	\N	\N
34	2023-06-23 21:32:55.791129+00	2023-06-23 21:32:55.795374+00	300.00	EUR	FAILED	47	126	DEPOSIT	\N	0.00	\N	\N
25	2023-06-19 06:40:51.105911+00	2023-06-19 06:40:51.108852+00	500.00	EUR	FAILED	33	122	DEPOSIT	\N	0.00	\N	\N
35	2023-06-26 06:04:31.187708+00	2023-06-26 06:04:31.191098+00	20.00	EUR	EXECUTED	50	82	DEPOSIT	\N	0.00	\N	\N
45	2023-06-28 11:05:44.673848+00	2023-06-28 11:05:44.67874+00	20.00	EUR	FAILED	58	28	DEPOSIT	\N	0.00	\N	\N
36	2023-06-26 06:16:55.535714+00	2023-06-26 06:16:55.540024+00	20.00	EUR	FAILED	49	23	DEPOSIT	\N	0.00	\N	\N
37	2023-06-26 06:16:55.843501+00	2023-06-26 06:16:55.845305+00	20.00	EUR	FAILED	48	23	DEPOSIT	\N	0.00	\N	\N
38	2023-06-26 06:43:20.352094+00	2023-06-26 06:43:20.355583+00	100.00	EUR	EXECUTED	51	136	DEPOSIT	\N	0.00	\N	\N
46	2023-06-29 09:10:09.799784+00	2023-06-29 09:10:09.803111+00	100.00	EUR	FAILED	16	23	DEPOSIT	\N	0.00	\N	\N
39	2023-06-26 08:20:27.888474+00	2023-06-26 08:20:27.891339+00	200.00	EUR	EXECUTED	44	135	DEPOSIT	\N	0.00	\N	\N
40	2023-06-27 08:06:14.838558+00	2023-06-27 08:06:14.841608+00	100.00	EUR	FAILED	52	23	DEPOSIT	\N	0.00	\N	\N
53	2023-07-05 17:27:05.444165+00	2023-07-05 17:27:06.407034+00	1.00	EUR	EXECUTED	70	23	BUY_AND_SELL	28	0.03	\N	\N
41	2023-06-27 08:06:37.79361+00	2023-06-27 08:06:37.796422+00	100.00	EUR	FAILED	53	23	DEPOSIT	\N	0.00	\N	\N
47	2023-06-30 08:50:03.225479+00	2023-06-30 08:50:03.231253+00	415.00	EUR	EXECUTED	60	126	DEPOSIT	\N	0.00	\N	\N
62	2023-07-18 12:03:47.622442+00	2023-07-18 12:03:47.625701+00	100.00	EUR	EXECUTED	73	152	DEPOSIT	\N	0.00	\N	\N
48	2023-06-30 09:40:05.633734+00	2023-06-30 09:40:05.638633+00	100.00	EUR	EXECUTED	61	134	DEPOSIT	\N	0.00	\N	\N
54	2023-07-06 14:51:27.800328+00	2023-07-06 14:51:27.803464+00	180.00	EUR	EXECUTED	71	134	DEPOSIT	\N	0.00	\N	\N
49	2023-07-05 08:45:09.578102+00	2023-07-05 08:45:09.581522+00	500.00	EUR	FAILED	67	125	DEPOSIT	\N	0.00	\N	\N
50	2023-07-05 09:05:14.97644+00	2023-07-05 09:05:14.980042+00	500.00	EUR	FAILED	68	125	DEPOSIT	\N	0.00	\N	\N
59	2023-07-14 18:10:06.382089+00	2023-07-14 18:10:06.384143+00	500.00	EUR	FAILED	29	120	DEPOSIT	\N	0.00	\N	\N
51	2023-07-05 10:10:12.009721+00	2023-07-05 10:10:12.014127+00	1000.00	EUR	FAILED	19	23	DEPOSIT	\N	0.00	\N	\N
55	2023-07-06 21:10:06.16065+00	2023-07-06 21:10:06.164622+00	100.00	EUR	FAILED	21	13	DEPOSIT	\N	0.00	\N	\N
56	2023-07-12 08:40:06.93231+00	2023-07-12 08:40:06.935867+00	1.00	EUR	FAILED	26	23	DEPOSIT	\N	0.00	\N	\N
57	2023-07-14 14:10:06.388112+00	2023-07-14 14:10:06.392392+00	1000.00	EUR	FAILED	28	13	DEPOSIT	\N	0.00	\N	\N
68	2023-07-28 11:10:06.804202+00	2023-07-28 11:10:06.807582+00	200.00	EUR	FAILED	59	28	DEPOSIT	\N	0.00	\N	\N
60	2023-07-14 20:10:09.50981+00	2023-07-14 20:10:09.517456+00	500.00	EUR	FAILED	31	120	DEPOSIT	\N	0.00	\N	\N
63	2023-07-19 06:40:06.694279+00	2023-07-19 06:40:06.697731+00	500.00	EUR	FAILED	35	122	DEPOSIT	\N	0.00	\N	\N
61	2023-07-15 07:23:49.350614+00	2023-07-15 07:23:49.35389+00	100.00	EUR	EXECUTED	72	144	DEPOSIT	\N	0.00	\N	\N
65	2023-07-20 18:40:06.106688+00	2023-07-20 18:40:06.110114+00	500.00	EUR	FAILED	39	122	DEPOSIT	\N	0.00	\N	\N
64	2023-07-20 15:40:09.332983+00	2023-07-20 15:40:09.335924+00	500.00	EUR	FAILED	38	122	DEPOSIT	\N	0.00	\N	\N
67	2023-07-27 14:40:08.638037+00	2023-07-27 14:40:08.641634+00	101.00	EUR	FAILED	55	133	DEPOSIT	\N	0.00	\N	\N
66	2023-07-21 07:40:06.916251+00	2023-07-21 07:40:06.920289+00	500.00	EUR	FAILED	40	122	DEPOSIT	\N	0.00	\N	\N
69	2023-08-02 16:11:34.935203+00	2023-08-02 16:11:34.93803+00	500.00	EUR	FAILED	74	125	DEPOSIT	\N	0.00	\N	\N
70	2023-08-02 16:17:51.949449+00	2023-08-02 16:17:51.951929+00	500.00	EUR	EXECUTED	75	125	DEPOSIT	\N	0.00	\N	\N
71	2023-08-04 06:10:06.709684+00	2023-08-04 06:10:06.713112+00	100.00	EUR	FAILED	62	13	DEPOSIT	\N	0.00	\N	\N
72	2023-08-04 10:12:26.279068+00	2023-08-04 10:12:26.282291+00	200.00	EUR	FAILED	65	13	DEPOSIT	\N	0.00	\N	\N
73	2023-08-04 10:12:27.130486+00	2023-08-04 10:12:27.132433+00	200.00	EUR	FAILED	63	13	DEPOSIT	\N	0.00	\N	\N
74	2023-08-04 10:12:27.284706+00	2023-08-04 10:12:27.286735+00	200.00	EUR	FAILED	64	13	DEPOSIT	\N	0.00	\N	\N
75	2023-08-04 10:12:27.456045+00	2023-08-04 10:12:27.458233+00	200.00	EUR	FAILED	66	13	DEPOSIT	\N	0.00	\N	\N
76	2023-08-04 20:25:22.196408+00	2023-08-04 20:25:22.199668+00	100.00	EUR	EXECUTED	76	191	DEPOSIT	\N	0.00	\N	\N
77	2023-08-18 16:48:56.779428+00	2023-08-18 16:48:56.783674+00	3.00	EUR	EXECUTED	77	133	DEPOSIT	\N	0.00	\N	\N
78	2023-09-08 11:04:15.137577+00	2023-09-08 11:04:15.145082+00	100.00	EUR	FAILED	79	196	DEPOSIT	\N	0.00	\N	\N
79	2023-09-11 11:47:15.06511+00	2023-09-11 11:47:15.07237+00	2.00	EUR	EXECUTING	\N	92	BUY_AND_SELL	92	0.00	pf_28	pf_28
80	2023-09-12 07:23:55.559308+00	2023-09-12 07:23:55.561978+00	2.00	EUR	EXECUTING	\N	92	BUY_AND_SELL	92	0.00	pf_28	pf_28
81	2023-09-12 07:39:33.121626+00	2023-09-12 07:39:33.123979+00	2.00	EUR	EXECUTING	\N	92	BUY_AND_SELL	92	0.00	pf_28	pf_28
106	2023-10-30 22:35:39.351082+00	2023-10-30 22:35:39.354226+00	1.00	EUR	EXECUTING	\N	196	BUY_AND_SELL	28	0.03	pf_28	pf_196
82	2023-09-15 13:55:17.16777+00	2023-09-15 13:55:17.177813+00	100.00	EUR	FAILED	86	13	DEPOSIT	\N	0.00	\N	\N
83	2023-09-17 22:37:38.665256+00	2023-09-17 22:37:38.668266+00	10.00	EUR	EXECUTED	96	13	DEPOSIT	\N	0.00	\N	\N
107	2023-10-30 23:00:56.353174+00	2023-10-30 23:00:56.360193+00	1.00	EUR	EXECUTING	\N	196	BUY_AND_SELL	28	0.03	pf_28	pf_196
84	2023-09-17 22:42:19.074104+00	2023-09-17 22:42:19.077007+00	10.00	EUR	EXECUTED	97	82	DEPOSIT	\N	0.00	\N	\N
85	2023-09-17 22:49:18.287907+00	2023-09-17 22:49:18.29074+00	100.00	EUR	FAILED	91	23	DEPOSIT	\N	0.00	\N	\N
108	2023-10-30 23:05:46.449353+00	2023-10-30 23:05:46.453199+00	1.00	EUR	EXECUTING	\N	196	BUY_AND_SELL	28	0.03	pf_28	pf_196
86	2023-09-18 11:29:45.864836+00	2023-09-18 11:29:45.870413+00	5.00	EUR	EXECUTED	98	23	DEPOSIT	\N	0.00	\N	\N
87	2023-09-18 11:57:26.891968+00	2023-09-18 11:57:26.898593+00	5.00	EUR	EXECUTED	99	23	DEPOSIT	\N	0.00	\N	\N
109	2023-10-31 22:25:11.713066+00	2023-10-31 22:25:11.716736+00	1.00	EUR	EXECUTING	\N	196	BUY_AND_SELL	28	0.03	pf_28	pf_196
88	2023-09-18 12:54:01.096437+00	2023-09-18 12:54:01.103+00	1.00	EUR	FAILED	100	23	DEPOSIT	\N	0.00	\N	\N
89	2023-09-18 12:56:04.083206+00	2023-09-18 12:56:04.086265+00	1.00	EUR	FAILED	101	23	DEPOSIT	\N	0.00	\N	\N
110	2023-10-31 22:30:05.200986+00	2023-10-31 22:30:05.204254+00	1.00	EUR	EXECUTING	\N	196	BUY_AND_SELL	28	0.03	pf_28	pf_196
90	2023-09-18 13:00:48.266777+00	2023-09-18 13:00:48.270053+00	1.00	EUR	FAILED	103	23	DEPOSIT	\N	0.00	\N	\N
146	2023-11-02 21:43:43.161354+00	2023-11-02 21:43:43.170566+00	1.00	EUR	EXECUTING	\N	324	BUY_AND_SELL	82	0.03	pf_82	pf_324
91	2023-09-18 13:01:30.658032+00	2023-09-18 13:01:30.661302+00	2.00	EUR	FAILED	104	23	DEPOSIT	\N	0.00	\N	\N
92	2023-09-18 13:58:43.761781+00	2023-09-18 13:58:43.76524+00	1.00	EUR	FAILED	106	23	DEPOSIT	\N	0.00	\N	\N
153	2023-11-02 22:18:01.712303+00	2023-11-02 22:18:01.71736+00	1.00	EUR	EXECUTING	\N	324	BUY_AND_SELL	82	0.03	pf_82	pf_324
93	2023-09-18 14:00:06.885604+00	2023-09-18 14:00:06.892172+00	2.00	EUR	FAILED	107	23	DEPOSIT	\N	0.00	\N	\N
147	2023-11-02 21:44:01.19124+00	2023-11-02 21:44:01.195342+00	1.00	EUR	FAILED	243	324	DEPOSIT	\N	0.00	\N	\N
94	2023-10-08 10:10:19.035856+00	2023-10-08 10:10:19.050473+00	10.00	EUR	FAILED	78	266	DEPOSIT	\N	0.00	\N	\N
95	2023-10-15 16:10:06.997249+00	2023-10-15 16:10:07.004355+00	1.00	EUR	FAILED	89	13	DEPOSIT	\N	0.00	\N	\N
148	2023-11-02 21:47:53.036068+00	2023-11-02 21:47:53.039591+00	1.00	EUR	EXECUTING	\N	324	BUY_AND_SELL	82	0.03	pf_82	pf_324
96	2023-10-15 22:40:06.511023+00	2023-10-15 22:40:06.518374+00	100.00	EUR	FAILED	90	13	DEPOSIT	\N	0.00	\N	\N
97	2023-10-17 22:40:09.237326+00	2023-10-17 22:40:09.245722+00	100.00	EUR	FAILED	94	82	DEPOSIT	\N	0.00	\N	\N
149	2023-11-02 21:56:50.411329+00	2023-11-02 21:56:50.414517+00	1.00	EUR	EXECUTING	\N	82	BUY_AND_SELL	324	0.03	pf_324	pf_82
98	2023-10-18 13:11:29.543243+00	2023-10-18 13:11:29.548387+00	1.00	EUR	FAILED	102	23	DEPOSIT	\N	0.00	\N	\N
99	2023-10-18 13:40:09.223506+00	2023-10-18 13:40:09.228157+00	3.00	EUR	FAILED	105	23	DEPOSIT	\N	0.00	\N	\N
100	2023-10-18 14:40:09.977515+00	2023-10-18 14:40:09.981917+00	1.00	EUR	FAILED	108	23	DEPOSIT	\N	0.00	\N	\N
101	2023-10-27 20:55:34.502442+00	2023-10-27 20:55:34.505554+00	1.00	EUR	EXECUTING	\N	28	BUY_AND_SELL	28	0.03	pf_28	pf_28
102	2023-10-29 20:15:07.316064+00	2023-10-29 20:15:07.320093+00	1.00	EUR	EXECUTING	\N	28	BUY_AND_SELL	28	0.03	pf_28	pf_28
103	2023-10-29 21:08:15.842989+00	2023-10-29 21:08:15.846165+00	1.00	EUR	EXECUTING	\N	196	BUY_AND_SELL	28	0.03	pf_28	pf_196
104	2023-10-29 21:30:51.322992+00	2023-10-29 21:30:51.326018+00	1.00	EUR	EXECUTING	\N	196	BUY_AND_SELL	28	0.03	pf_28	pf_196
105	2023-10-30 22:21:25.569655+00	2023-10-30 22:21:25.573679+00	1.00	EUR	EXECUTING	\N	196	BUY_AND_SELL	28	0.03	pf_28	pf_196
150	2023-11-02 21:57:04.30241+00	2023-11-02 21:57:04.307067+00	1.00	EUR	FAILED	245	82	DEPOSIT	\N	0.00	\N	\N
201	2023-11-09 16:40:59.860303+00	2023-11-09 16:40:59.866982+00	1.00	EUR	EXECUTING	\N	13	BUY_AND_SELL	196	0.03	pf_196	pf_13
154	2023-11-02 22:29:37.338484+00	2023-11-02 22:29:37.342547+00	1.00	EUR	EXECUTING	\N	324	BUY_AND_SELL	82	0.03	pf_82	pf_324
128	2023-11-02 09:46:32.46697+00	2023-11-02 09:46:32.476265+00	1.00	EUR	EXECUTED	204	324	BUY_AND_SELL	28	0.03	pf_28	pf_324
115	2023-10-31 23:41:27.453872+00	2023-10-31 23:41:27.463669+00	1.00	EUR	EXECUTED	176	196	BUY_AND_SELL	28	0.03	pf_28	pf_196
116	2023-11-01 09:34:24.458253+00	2023-11-01 09:34:24.473574+00	1.00	EUR	EXECUTED	178	82	BUY_AND_SELL	23	0.03	pf_23	pf_82
152	2023-11-02 22:06:17.994793+00	2023-11-02 22:06:18.001677+00	1.00	EUR	EXECUTING	\N	324	BUY_AND_SELL	82	0.03	pf_82	pf_324
117	2023-11-01 17:25:31.390333+00	2023-11-01 17:25:31.40272+00	1.00	EUR	EXECUTED	182	82	BUY_AND_SELL	28	0.03	pf_28	pf_82
172	2023-11-03 22:53:59.359083+00	2023-11-03 22:53:59.36486+00	1.00	EUR	EXECUTING	\N	324	BUY_AND_SELL	82	0.03	pf_82	pf_324
119	2023-11-01 17:38:30.156583+00	2023-11-01 17:38:30.164377+00	1.00	EUR	EXECUTED	186	82	BUY_AND_SELL	28	0.03	pf_28	pf_82
122	2023-11-01 17:48:30.143013+00	2023-11-01 17:48:30.193327+00	1.00	EUR	EXECUTED	192	82	BUY_AND_SELL	28	0.03	pf_28	pf_82
123	2023-11-01 18:08:30.775604+00	2023-11-01 18:08:30.784863+00	1.00	EUR	EXECUTED	194	324	BUY_AND_SELL	28	0.03	pf_28	pf_324
124	2023-11-01 18:13:27.604575+00	2023-11-01 18:13:27.613716+00	1.00	EUR	EXECUTED	196	324	BUY_AND_SELL	196	0.03	pf_196	pf_324
125	2023-11-01 18:20:45.188675+00	2023-11-01 18:20:45.20164+00	1.00	EUR	EXECUTED	198	324	BUY_AND_SELL	196	0.03	pf_196	pf_324
173	2023-11-04 00:01:57.745116+00	2023-11-04 00:01:57.749143+00	1.00	EUR	EXECUTING	\N	324	BUY_AND_SELL	82	0.03	pf_82	pf_324
127	2023-11-01 20:49:19.91175+00	2023-11-01 20:49:19.918524+00	1.00	EUR	EXECUTED	202	196	BUY_AND_SELL	28	0.03	pf_28	pf_196
174	2023-11-04 00:07:43.154389+00	2023-11-04 00:07:43.157889+00	1.00	EUR	EXECUTING	\N	324	BUY_AND_SELL	82	0.03	pf_82	pf_324
175	2023-11-04 00:14:51.496315+00	2023-11-04 00:14:51.500578+00	1.00	EUR	EXECUTING	\N	324	BUY_AND_SELL	82	0.03	pf_82	pf_324
176	2023-11-04 00:20:44.020699+00	2023-11-04 00:20:44.026687+00	1.00	EUR	EXECUTING	\N	324	BUY_AND_SELL	82	0.03	pf_82	pf_324
177	2023-11-04 00:39:55.64412+00	2023-11-04 00:39:55.64817+00	1.00	EUR	EXECUTING	\N	324	BUY_AND_SELL	82	0.03	pf_82	pf_324
137	2023-11-02 09:57:37.644111+00	2023-11-02 09:57:37.657776+00	1.00	EUR	EXECUTED	222	82	BUY_AND_SELL	28	0.03	pf_28	pf_82
138	2023-11-02 10:03:28.907765+00	2023-11-02 10:03:28.918905+00	1.00	EUR	EXECUTED	224	196	BUY_AND_SELL	28	0.03	pf_28	pf_196
179	2023-11-04 00:46:20.178393+00	2023-11-04 00:46:20.731935+00	1.00	EUR	EXECUTED	259	324	BUY_AND_SELL	82	0.03	pf_82	pf_324
180	2023-11-04 01:12:26.894779+00	2023-11-04 01:12:27.520276+00	1.00	EUR	EXECUTED	260	324	BUY_AND_SELL	82	0.03	pf_82	pf_324
181	2023-11-04 01:21:41.925992+00	2023-11-04 01:21:42.580102+00	1.00	EUR	EXECUTED	261	324	BUY_AND_SELL	82	0.03	pf_82	pf_324
182	2023-11-04 01:38:01.465873+00	2023-11-04 01:38:02.046547+00	1.00	EUR	EXECUTED	262	324	BUY_AND_SELL	82	0.03	pf_82	pf_324
183	2023-11-04 01:41:57.052281+00	2023-11-04 01:41:57.604754+00	1.00	EUR	EXECUTED	263	324	BUY_AND_SELL	82	0.03	pf_82	pf_324
144	2023-11-02 21:24:13.645019+00	2023-11-02 21:24:13.652816+00	1.00	EUR	EXECUTED	240	324	BUY_AND_SELL	82	0.03	pf_82	pf_324
184	2023-11-04 01:46:46.812412+00	2023-11-04 01:46:47.426392+00	1.00	EUR	EXECUTED	264	324	BUY_AND_SELL	82	0.03	pf_82	pf_324
145	2023-11-02 21:25:25.506028+00	2023-11-02 21:25:25.513061+00	1.00	EUR	EXECUTED	242	324	BUY_AND_SELL	82	0.03	pf_82	pf_324
233	2023-11-11 09:27:09.153511+00	2023-11-11 09:27:09.741069+00	1.00	EUR	EXECUTED	305	324	BUY_AND_SELL	196	0.03	pf_196	pf_324
202	2023-11-09 16:46:51.881557+00	2023-11-09 16:46:53.59954+00	1.00	EUR	EXECUTED	286	324	BUY_AND_SELL	82	0.03	pf_82	pf_324
203	2023-11-09 17:33:02.456171+00	2023-11-09 17:33:02.908464+00	1.00	EUR	EXECUTED	287	82	BUY_AND_SELL	196	0.03	pf_196	pf_82
186	2023-11-04 02:03:33.097927+00	2023-11-04 02:03:33.884111+00	1.00	EUR	EXECUTED	266	324	BUY_AND_SELL	82	0.03	pf_82	pf_324
234	2023-11-11 10:23:26.540328+00	2023-11-11 10:23:27.009262+00	4.00	EUR	EXECUTED	306	324	BUY_AND_SELL	196	0.12	pf_196	pf_324
187	2023-11-04 02:05:12.357399+00	2023-11-04 02:05:12.772413+00	1.00	EUR	EXECUTED	267	324	BUY_AND_SELL	82	0.03	pf_82	pf_324
204	2023-11-09 19:25:56.072137+00	2023-11-09 19:25:56.502274+00	1.00	EUR	EXECUTED	288	28	BUY_AND_SELL	196	0.03	pf_196	pf_28
188	2023-11-04 02:12:59.522166+00	2023-11-04 02:13:00.217039+00	1.00	EUR	EXECUTED	268	324	BUY_AND_SELL	82	0.03	pf_82	pf_324
219	2023-11-10 18:10:02.323769+00	2023-11-10 18:10:02.659571+00	8.00	EUR	EXECUTED	303	196	BUY_AND_SELL	324	0.24	pf_324	pf_196
205	2023-11-09 19:32:28.199713+00	2023-11-09 19:32:28.60788+00	3.00	EUR	EXECUTED	289	28	BUY_AND_SELL	196	0.09	pf_196	pf_28
235	2023-11-11 10:29:08.723337+00	2023-11-11 10:29:09.134179+00	8.00	EUR	EXECUTED	307	196	BUY_AND_SELL	324	0.24	pf_324	pf_196
190	2023-11-04 02:32:43.903877+00	2023-11-04 02:32:44.481327+00	1.00	EUR	EXECUTED	270	324	BUY_AND_SELL	82	0.03	pf_82	pf_324
236	2023-11-11 10:31:14.320974+00	2023-11-11 10:31:14.665517+00	4.00	EUR	EXECUTED	308	324	BUY_AND_SELL	196	0.12	pf_196	pf_324
191	2023-11-04 02:39:22.263765+00	2023-11-04 02:39:22.612666+00	1.00	EUR	EXECUTED	271	324	BUY_AND_SELL	82	0.03	pf_82	pf_324
207	2023-11-09 19:41:18.72497+00	2023-11-09 19:41:19.054683+00	2.00	EUR	EXECUTED	291	28	BUY_AND_SELL	196	0.06	pf_196	pf_28
220	2023-11-10 18:18:32.424337+00	2023-11-10 18:18:32.822572+00	4.00	EUR	EXECUTED	304	324	BUY_AND_SELL	196	0.12	pf_196	pf_324
260	2023-11-17 17:05:07.969823+00	2023-11-17 17:05:08.616898+00	1.00	EUR	EXECUTED	329	324	BUY_AND_SELL	9	0.03	pj_3	pf_324
209	2023-11-09 20:46:19.802151+00	2023-11-09 20:46:20.319287+00	8.00	EUR	EXECUTED	293	196	BUY_AND_SELL	324	0.24	pf_324	pf_196
250	2023-11-12 00:02:23.09778+00	2023-11-12 00:02:23.577021+00	1.00	EUR	EXECUTED	310	324	BUY_AND_SELL	196	0.03	pf_196	pf_324
194	2023-11-04 23:21:59.366271+00	2023-11-04 23:21:59.919435+00	1.00	EUR	EXECUTED	275	324	BUY_AND_SELL	82	0.03	pf_82	pf_324
210	2023-11-09 20:51:38.949052+00	2023-11-09 20:51:39.344792+00	4.00	EUR	EXECUTED	294	28	BUY_AND_SELL	324	0.12	pf_324	pf_28
211	2023-11-10 17:31:43.017322+00	2023-11-10 17:31:43.569821+00	4.00	EUR	EXECUTED	295	324	BUY_AND_SELL	196	0.12	pf_196	pf_324
197	2023-11-05 00:16:46.524822+00	2023-11-05 00:16:47.263507+00	1.00	EUR	EXECUTED	278	324	BUY_AND_SELL	196	0.03	pf_196	pf_324
198	2023-11-05 00:19:17.647576+00	2023-11-05 00:19:18.012051+00	1.00	EUR	EXECUTED	279	324	BUY_AND_SELL	196	0.03	pf_196	pf_324
199	2023-11-08 15:55:28.812533+00	2023-11-08 15:55:29.163087+00	1.00	EUR	EXECUTED	280	196	BUY_AND_SELL	28	0.03	pf_28	pf_196
200	2023-11-09 16:30:14.477343+00	2023-11-09 16:30:14.481011+00	5.00	EUR	EXECUTING	\N	13	BUY_AND_SELL	196	0.15	pf_196	pf_13
253	2023-11-12 00:27:58.107131+00	2023-11-12 00:27:58.639827+00	1.00	EUR	EXECUTED	313	324	BUY_AND_SELL	196	0.03	pf_196	pf_324
255	2023-11-13 21:40:59.038132+00	2023-11-13 21:40:59.596075+00	1.00	EUR	EXECUTED	315	324	BUY_AND_SELL	196	0.03	pj_5	pf_324
218	2023-11-10 18:02:10.487712+00	2023-11-10 18:02:10.976485+00	4.00	EUR	EXECUTED	302	324	BUY_AND_SELL	196	0.12	pf_196	pf_324
256	2023-11-14 22:26:49.34015+00	2023-11-14 22:26:50.021227+00	1.00	EUR	EXECUTED	326	324	BUY_AND_SELL	196	0.03	pj_5	pf_324
257	2023-11-15 14:59:48.171265+00	2023-11-15 14:59:48.175276+00	1.00	EUR	EXECUTING	\N	324	BUY_AND_SELL	9	0.03	pj_3	pf_324
258	2023-11-17 15:23:38.549927+00	2023-11-17 15:23:38.554576+00	1.00	EUR	EXECUTING	\N	324	BUY_AND_SELL	9	0.03	pj_3	pf_324
259	2023-11-17 16:07:15.054405+00	2023-11-17 16:07:15.657958+00	1.00	EUR	EXECUTED	328	324	BUY_AND_SELL	9	0.03	pj_3	pf_324
\.


--
-- Data for Name: snitch_event; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.snitch_event (id, created, modified, actor_object_id, verb, trigger_object_id, target_object_id, notified, actor_content_type_id, target_content_type_id, trigger_content_type_id) FROM stdin;
\.


--
-- Data for Name: snitch_eventtype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.snitch_eventtype (id, verb, enabled) FROM stdin;
\.


--
-- Data for Name: snitch_notification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.snitch_notification (id, created, modified, sent, received, read, event_id, user_id) FROM stdin;
\.


--
-- Data for Name: social_auth_association; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.social_auth_association (id, server_url, handle, secret, issued, lifetime, assoc_type) FROM stdin;
\.


--
-- Data for Name: social_auth_code; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.social_auth_code (id, email, code, verified, "timestamp") FROM stdin;
\.


--
-- Data for Name: social_auth_nonce; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.social_auth_nonce (id, server_url, "timestamp", salt) FROM stdin;
\.


--
-- Data for Name: social_auth_partial; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.social_auth_partial (id, token, next_step, backend, "timestamp", data) FROM stdin;
\.


--
-- Data for Name: social_auth_usersocialauth; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.social_auth_usersocialauth (id, provider, uid, user_id, created, modified, extra_data) FROM stdin;
10	google-oauth2	mrascongarcia@gmail.com	156	2023-09-28 08:56:04.329372+00	2023-11-04 14:08:33.608522+00	{"expires": null, "auth_time": 1699106913, "token_type": null, "access_token": "ya29.a0AfB_byAo-fJ0zd9ECbnm5TvFhA_-ZP0MVO_cSXdC-MoDJ2CwBiP3C52-vTUufybrX-aEl3U0YrqCeA6E7Va_J-3HwXV4YYULfu5gKdAwi3ciMr2lON2nYV5GQB3gIYHZTlkgJ3IzMmXtB0OcrBq_MzwtHVAbX69-KVCIaCgYKAV0SARASFQGOcNnCMfuGBZ1fg1lP1NZGmuV_9A0171"}
1	google-oauth2	rodrigoloco.595@gmail.com	198	2023-09-03 15:25:47.475182+00	2023-09-15 16:28:43.309518+00	{"expires": null, "auth_time": 1694795323, "token_type": null, "access_token": "ya29.a0AfB_byDtw-TgVryOdm3SmF_VQV5hIT0zHFCcULmUH7GxJfdV3jUlzXVeWp__kz2Nj8agA36Fxdn8ICg3fvN_YWJjEWO2C3FgskH7E3ft42Ax-zkmMLM8gD7xhXNhylKdCDtsdSBcMm4P_sF6WrK_IXcT2Vz3x_ufemIaCgYKARISARISFQGOcNnCHX_CrFcjKbYE3tlhZYXK6A0170"}
2	google-oauth2	strcod@gmail.com	228	2023-09-05 20:51:32.987268+00	2023-09-05 21:13:05.397583+00	{"expires": null, "auth_time": 1693948385, "token_type": null, "access_token": "ya29.a0AfB_byBCTuIH9aJDgpiPVDxnlj4W02W4rxkcEymOH_-3vfoIbkjpywOEiMC7QBKs4Lo90JmG4qsaBERaH--drO27RhjCRPrL4WK7SqlYSkzpv-k7WOijFa6f4LE2oBvDqsLAVSMgw05bV2c8kd3hK5eYLb439LQdthh0ZQaCgYKAaQSARISFQHsvYlsCD6-ZQTbTWh4QM2Ew3U88g0173"}
9	google-oauth2	elisamoncayo08@gmail.com	277	2023-09-27 23:02:24.442318+00	2023-09-27 23:02:24.444284+00	{"expires": null, "auth_time": 1695855744, "token_type": null, "access_token": "ya29.a0AfB_byCMsKngMlw4-OuL6Y0X8QGBV6DSniJcDSFq10jNn-k8LLhzkEq_onMVGVq0LF8jdwPC0U_QNRln3K8yvd0Bf3GewxfYWNYqrS0FUZk8QbaQaMMtbosOlLNahGSylTW9Rr_KbJKqi3-5VPHr_A8sHgOwbz9YPwaCgYKAacSARESFQGOcNnCSEwin1h6tPl1Dj4FepSy_Q0169"}
5	google-oauth2	ccallejo@stockencapital.com	28	2023-09-06 17:46:43.819416+00	2023-09-19 04:38:57.15893+00	{"expires": null, "auth_time": 1695098337, "token_type": null, "access_token": "ya29.a0AfB_byCNv7FDlc5fWIO3qGoPUs2QkB_XYR1ImIG4e6_G76dV8yUbkD22SRWRhZsODwiJKk7_TrWHaSgWyD3jV2ByIN5pe3081-K9npPdyhuXRWHCQi-hYo530i8PTfLJYAJ_X8RscuVs7bKMH8ZqVyl7vBPMeddSBZ4aCgYKAWoSARISFQGOcNnCl3snNlpzCPrXHoqCbr9lVQ0170"}
3	google-oauth2	kallejo@gmail.com	23	2023-09-05 21:47:11.452359+00	2023-09-05 22:02:03.900911+00	{"expires": null, "auth_time": 1693951323, "token_type": null, "access_token": "ya29.a0AfB_byAWMvmN1VHRSjUisg--_m-g2alA10p9HLzHw2AhK8SyH59SCoWbUDcn21cSUKl48CyAnbC-xgWFv2dtb80_TCYSBVGalwGwtYi1CzXSZAF5WylVPQHgOqTpwj0RgJ7pO-PT2cfW5MipCYHeC4vQijqbUJJwECsh1uwaCgYKARgSARMSFQHsvYlsvIpwRYVi7jRaXblFvJ53Wg0174"}
8	google-oauth2	gsynedl@hotmail.com	278	2023-09-27 20:31:49.111848+00	2023-11-16 11:01:55.106882+00	{"expires": null, "auth_time": 1700132515, "token_type": null, "access_token": "ya29.a0AfB_byCEXifrIYnMEVQlwzmv4a4fz-2T3ru3jrH22FYl46huj7yBizGIHA9SKq967ub_yNUtn81JS207WP-bZsfKsd3buP2XMQdlZjKBb9gZ9viZE2vrTmaEoj26P27nWKevEN73_W39OzrhYPXtnJ73XqHDgpLkRsnxaCgYKAeASARESFQHGX2Mifu5vE3XD29aq1j1y7WHSyQ0171"}
11	google-oauth2	cristiandelsaz@gmail.com	284	2023-09-28 13:49:53.064874+00	2023-09-28 13:49:53.068703+00	{"expires": null, "auth_time": 1695908993, "token_type": null, "access_token": "ya29.a0AfB_byAZLPCY1AlF0kFZLm78Z7H0YhqWUcTnzJN9bmdaIu246lt_oOdImCOu8vQPIAaM-qVNxTk5ziXIDFMTJwbYnWeYcEZ8V1CUITjkl4DxIkDPrEI8yuV1i_254M-yuIPG9v8x1o5eq7dgThSyZNxSoYpS12DIWwaCgYKAW8SARASFQGOcNnCgzXbZ6jbxux55qMCPuaeBQ0169"}
12	google-oauth2	info@portage.es	285	2023-09-29 06:45:10.419849+00	2023-09-29 06:45:31.285113+00	{"expires": null, "auth_time": 1695969931, "token_type": null, "access_token": "ya29.a0AfB_byAUCPwhHM-mVjgP7ugWp3osXDsvNNfw6n2VvTST14BOL43ceJERrYEpWPyPi2AZq1_8T0val8HC1u2d8qcEoVuVD6ekq-qPPuzW0e3hG_oJNa_RVuTynAycG2kSyzjRwN622RNn8_LTvXgexAYvmHqcnaa4JQaCgYKAZcSARMSFQGOcNnCm13fLtuQJ3X4KPJ75LokCQ0169"}
6	google-oauth2	vcallejo@stockencapital.com	271	2023-09-12 08:28:47.383457+00	2023-10-10 08:21:30.897207+00	{"expires": null, "auth_time": 1696926090, "token_type": null, "access_token": "ya29.a0AfB_byCmNB5YtpLaTvyKYwPxreodnROmiKykuicWPUyCL8iAlgswLCZ90TnbehD7A5xI3pNJeM-f2XpShBsqG8pdSJ-QiBFaBVwzsWhx3RRhWMuQkQu_hNQe3uDCbxyUq_0EWaqEIHgv6bBl6M9LXyeyyy7dQBnePRc9aCgYKAYQSARMSFQGOcNnCivfUjpSyN6Udu80Io6rEXg0171"}
13	google-oauth2	leolower@gmail.com	287	2023-09-29 09:55:32.513934+00	2023-09-29 09:55:32.517852+00	{"expires": null, "auth_time": 1695981332, "token_type": null, "access_token": "ya29.a0AfB_byA3jyfBC8K2FXN3aNXe0UtwX80G-zbLgB99JKBErhgFGNeCL2NsvU9X-dT0BHMwpIeP_YNqqN8fAHPMH5SB_NyvmwYncNPnYXu78UJ8okNliQhhUDaa1XlNxYwPtkPqDflKsCIdrUucc_vqO2F2VB_9ATBC1waCgYKAfcSARMSFQGOcNnCm7lAHa2C3SRkElVj8tTRCg0169"}
15	google-oauth2	vzamorano@hispalabs.com	289	2023-09-29 11:42:09.317755+00	2023-09-29 11:54:52.79818+00	{"expires": null, "auth_time": 1695988492, "token_type": null, "access_token": "ya29.a0AfB_byAqDxgbjcXEHlpoJWKJxF6TaIOp2tkFTN-2tb6p0bNZ5V2N0NUXT5_J9IIEk5EGNJKPtkskpaDQ9KVtoUexRKYeMncIqdAw79cOSqhI2mqblUZ1xvfXac1v8urL-iehlcGqENdvhxPxjM5yFZ0AIQNoez-UYQaCgYKAWISARMSFQGOcNnCcm_M4stIx2D5epSiMAJLmg0169"}
14	google-oauth2	vzamorano1@gmail.com	288	2023-09-29 11:40:48.735017+00	2023-09-29 11:40:49.127473+00	{"expires": null, "auth_time": 1695987649, "token_type": null, "access_token": "ya29.a0AfB_byCSgvNiNEt34xIjbE3qCz-uXUQoj2Eef2jpzYZ5PiTnt-zthIazdMXzIhmsu8hIwZsobhSROntlYPkKySQ9FZP_eiXBGAuYUyUkxiQQEbpuVhvT8TmS1PRif7VObm6QPV7Vs_ysvuKUgGYpmvf2oE5VuOl2FQaCgYKAd0SARMSFQGOcNnCW1bEue2yi7FuBuTRei8jtw0169"}
16	google-oauth2	xperiend@gmail.com	69	2023-10-02 11:39:34.391287+00	2023-10-02 11:39:44.967383+00	{"expires": null, "auth_time": 1696246784, "token_type": null, "access_token": "ya29.a0AfB_byCmifuVX6OfRHCZXGLdi74Nj5INGo-msYc-eHwthXDjz4_RAtarAM1SUkE_yv_kdYlg7xd5W1HVWecK-8gIlF2zQLn_LOPr0wyKyAbytQbcsDDQYmGnhvZQJ02welsI-PQSeWYgvNTBEzVE4QdLz1iYOk4M9QaCgYKAXkSARMSFQGOcNnCHl-X7XpjkH7gC7B5dBD8ig0169"}
17	google-oauth2	nasvolador@gmail.com	293	2023-10-03 09:13:12.694445+00	2023-10-03 11:24:24.436633+00	{"expires": null, "auth_time": 1696332264, "token_type": null, "access_token": "ya29.a0AfB_byCr0FI0hkN49FJNzOMEiVVKqdTNM9tqmV77MwMhNAn_wkfJVxHHWO6dsKB0vFFoTuzBVCG0OpLBnaPnJKeaU7TeUXOLSVK0c3vpEzxhMj7RYSRezWYnNz1EOmoLszetkoORclLltKGh8uljbqwVPcnYtOUK0AaCgYKAWsSARMSFQGOcNnCJJKgnPgd2hlLSl_TItEAJg0169"}
18	google-oauth2	dcodina@verus.es	294	2023-10-04 08:04:46.425642+00	2023-10-04 08:04:46.430174+00	{"expires": null, "auth_time": 1696406686, "token_type": null, "access_token": "ya29.a0AfB_byDyhi2RNryP482MpHOxwbtU4vb94a8Gzw210kL2b2uYpTGMndE4ynNR3GlGmn39MB22kPi6wv3MAr_vuR9-k3gr4um9BBRW0HPPb-r4w8nSb1PS8LFE9Xa7-FHiLzG6ujSeq0M6AifotI_prEkmMzhZ3Kdu5gaCgYKATkSARISFQGOcNnCFfaoLLtuvR3p7yT6asMOOw0169"}
7	google-oauth2	ramoncorujo1970@gmail.com	273	2023-09-21 14:32:19.186149+00	2023-11-18 22:40:39.087736+00	{"expires": null, "auth_time": 1700347239, "token_type": null, "access_token": "ya29.a0AfB_byCr_YDB1wjht2xrtxMnO7PCyZjx4TqISfY5Ph3g8ZdL59z-QDF1FA_q2EYcYa5j4LDBQ6A3XoxuRpstJmm1QERCrn9W25jeosz7ir0a7KQDcG4BwBbkZWYdL442At3qROFA1CAeCnc5uXg__sDpQonJ7WkKqK9kaCgYKATkSARESFQHGX2Mih0wXb6RSBoe5IZ4EV2rmIQ0171"}
19	google-oauth2	gegantspedrera@gmail.com	295	2023-10-04 08:05:11.83492+00	2023-10-04 08:05:12.163925+00	{"expires": null, "auth_time": 1696406712, "token_type": null, "access_token": "ya29.a0AfB_byCtAt6tIQmnN2jMnyvFj15boYPUyKHXewiZBHT859Kra6g3V0Qdc93VYXa2TYZkWLjAWAPj6OdfHgJeo--StVbIm4BgnOhGy9q4M4F6EdsbNlLEc-a8tA8i9riM3eeBowsE0jMeacrcfNdRByc314TIhTIsIgaCgYKASISARISFQGOcNnCjFB-K6FtKsqG_TUc5qltig0169"}
4	google-oauth2	info@stockencapital.com	269	2023-09-06 17:45:52.939298+00	2023-10-04 08:08:29.034555+00	{"expires": null, "auth_time": 1696406909, "token_type": null, "access_token": "ya29.a0AfB_byA43I3qdStG8FaHD1FSir8CAYgTQcon-MWmkQ1jVvpArikfq13IrINa1oRNkv6riKqtLaHam_nfIVURuC-tBIwl-LV7q3H6Jt5MwZ_Lcs6da9xQMiDt6_bkUZoJ6-feiFGuqPK96ZqSbelW-hKqGLYDLjaWtJjraCgYKAdISARISFQGOcNnC20N4Z1aejeUS_W33j6xuog0171"}
20	google-oauth2	pilar.esteban.herrera@gmail.com	297	2023-10-05 15:41:46.605761+00	2023-10-05 15:41:46.616272+00	{"expires": null, "auth_time": 1696520506, "token_type": null, "access_token": "ya29.a0AfB_byCi_Xug6fZGV06mflz4l6CctKgCmp2s_OMbkopD9RObB1rgHqQVjq4tCLd7dL8pN_5FmmeSLiCRb8zietPnh38Nm8UGXw_JKrMc9GzvxBxW8M9EwyYi4H6PkvuQbv02g6quaSXfRZfsBSUjRTmJqyIKTbhGhwaCgYKAZoSARISFQGOcNnCJSJdsaSDzIAHICCAa2updA0169"}
21	google-oauth2	oxummanagement@gmail.com	300	2023-10-09 10:29:16.215847+00	2023-10-09 10:29:16.220446+00	{"expires": null, "auth_time": 1696847356, "token_type": null, "access_token": "ya29.a0AfB_byAkVEXR0eScyXMrD8spRzb4WYzGu03zii9KaLad6-ez63_F5J8qxV4kwCcZlNKUWXzX84HSYKg1iaooTJC-Dr8GKK5Dl1Sy5lEYzTU_yhAJzWxdKLMIQbG-n18VK9z1odKCbqMnm-ApIFUTqpLqZ2GL5TR-vAaCgYKAcUSARESFQGOcNnCPcPz1hHJWfckBsTiAxo1HQ0169"}
30	google-oauth2	mdiazollero@gmail.com	318	2023-10-18 10:15:53.902235+00	2023-10-26 21:26:47.04998+00	{"expires": null, "auth_time": 1698355607, "token_type": null, "access_token": "ya29.a0AfB_byAz3jF4PfNvzWhnVp55qUknQ_l1P6Mab3EkllCuHVbPYw6Sxo4ktZW5iG3v7NvqdMhDMP_Oj7iFGvejIDvdER6KeS_wWoeugptUy7If_Ucz4s2d7n-IOurhIMYQ2_Rc6moYsYFCLsXQHHQHLRLz9UGkvgyAv44aCgYKAY8SARMSFQGOcNnCeRnDEBUWxnVWmj4jKDGjMg0170"}
23	google-oauth2	joitturri@gmail.com	167	2023-10-10 14:49:30.135562+00	2023-10-10 14:49:30.137901+00	{"expires": null, "auth_time": 1696949370, "token_type": null, "access_token": "ya29.a0AfB_byCCSgqTUM_Ve0iBadoGG5Ql5j51K3A-4L9isediR1H4n8iQwZT1Kkz4T91AfEaOBJ_N0i2zKD3XLoefKJb25u4cyCyubQJvqTyCymoCu9gUcf65v0iADkMu2C8LiIL-w9UxOnAyUNud6WNAXtCQ_8rtRbPBOAaCgYKAb0SARESFQGOcNnC7qhxmP0y57r7GuVGreMn-w0169"}
27	google-oauth2	aquiyosoy71@gmail.com	311	2023-10-17 23:07:39.009809+00	2023-10-17 23:07:39.014453+00	{"expires": null, "auth_time": 1697584059, "token_type": null, "access_token": "ya29.a0AfB_byDZYxlMj-YhWrZ6aq0I5zEV0Fo-fqDbFpiUUBssdD2S_v_9tNAp3W3RuXk5--lyaWnbikOmyen_lTR5BIMsqu3Guor3geWHZKzRufBGKikZUI-wmvJ3WNaFJ8a66F26YgWEBJMeev2I1yKkCa-IzB8TydlIBAaCgYKAV8SARISFQGOcNnCJ1Ptg1VxjKQHFB7RMNYvvg0169"}
28	google-oauth2	angelmmt70@gmail.com	110	2023-10-18 06:11:40.233975+00	2023-11-16 08:04:48.226577+00	{"expires": null, "auth_time": 1700121888, "token_type": null, "access_token": "ya29.a0AfB_byAkpObHnFn8IiJxGfI6ZoX3QrSsytTgXx2v-qc1PtnWblBLTiQ8CrfZUtOe8eRxBbVV07AwxkBSWmjW6cstwrIaaz3kG6WvCL5iqzo8EeJiZlL-RemSD1cWQ87XdTkxwau4QMn8RehTrWu7fLPs-DKCipAYxd80aCgYKASgSARMSFQHGX2Mi-yaqYXvctBv7KxTdA6-qlw0171"}
24	google-oauth2	carmenhr2006@hotmail.es	185	2023-10-16 11:04:53.913593+00	2023-10-17 09:19:14.047292+00	{"expires": null, "auth_time": 1697534354, "token_type": null, "access_token": "ya29.a0AfB_byCchThgpW0xrTHUuq1--X3uT4sykn0jBoZAQYqJzk2NAqQvhxoCd1QuLUpjsOohJU-hMRoPAXac3fbB5Z5IQsNE_DPKYFcfJYAJzA7trHG601ATdHGE29BcOXir_mzGIOE9yKVYtqfpDDSknEM7JwccBR9wdFUaCgYKAekSARASFQGOcNnCNzpg56f08NU35fXL5ImG7Q0170"}
29	google-oauth2	martagarciahc@gmail.com	146	2023-10-18 08:45:02.5325+00	2023-10-18 08:45:02.535379+00	{"expires": null, "auth_time": 1697618702, "token_type": null, "access_token": "ya29.a0AfB_byCYItoXzee27wfg5y8n1-wDI8sXT2Ni-g1mzLZDXfwYtkkZYw0sZjThdpbzOUEeikjuPbnGcarPp3Mql2y1_p7tE0T-6RpJTI9jXP3ujtgbHGd2VZsIMrwoGSOr3E5NszhtKnNeWE_Jx7y3nKDuiKhFvIlXGAaCgYKAdESARASFQGOcNnC8YEsLmC1IKuktk3civF7oQ0169"}
25	google-oauth2	augustocp.coutinho@gmail.com	157	2023-10-17 20:59:57.900872+00	2023-10-29 09:37:20.40797+00	{"expires": null, "auth_time": 1698572240, "token_type": null, "access_token": "ya29.a0AfB_byAu6Wpg77xaRVolsRwZABFyvNeIkAT49poJUeayinSxqfrW5rD1AGrmWJTReBnNqG8UxiPfgsxeNHkXfIXEuDLGEHo9dHGMgFTULx3HTYcwhGVJbgYhDbTCgY0THsz9Ir1vXmXrl7CsJ92lQtRpWM1W1EWYn04aCgYKAW4SARESFQGOcNnCEQVekNKP7QKHBJbamktddA0170"}
31	google-oauth2	manuelmongarcia@gmail.com	316	2023-10-18 10:16:40.800516+00	2023-10-27 16:33:26.639621+00	{"expires": null, "auth_time": 1698424406, "token_type": null, "access_token": "ya29.a0AfB_byDalvHRPpF4_Mn2tYoIhGtEJIQByXq2vMXA9TKUQW-2JgskAzPWhrK-vWseCphIbfUxHuzxukMLdtVvV1FLtvjxwgdYUeXlSQRZf2MSE_fStkeVmhZmFS0ovjnzx_wwJcg-m2Cs_a_guVdmzYgJvLTLtGFoenAaCgYKAZcSARESFQGOcNnCr0hT9wAzVUATsm1ZA1DMHw0170"}
33	google-oauth2	rascongarciavictoria@gmail.com	158	2023-10-24 18:40:46.89017+00	2023-10-24 18:40:47.161027+00	{"expires": null, "auth_time": 1698172847, "token_type": null, "access_token": "ya29.a0AfB_byAFkhxuNuYVd2kWUT5uZNwIVrQbYhmYIQngA5EfNzIRqkPsgTMktNlFPAPqghxm9pv6WFhBbqc_3u1Rss738lwz9FEuzLMf2RdxzcfSiHqozceiTd-tkQmShds59thW8i4pEeOfmCBstncAMkDQD9tQGbtuOwaCgYKATwSARESFQGOcNnCxgpbSD-TJ1ejgdUMH8uP0A0169"}
22	google-oauth2	nuskita555@gmail.com	186	2023-10-10 13:02:01.801579+00	2023-10-22 17:14:49.187294+00	{"expires": null, "auth_time": 1697994889, "token_type": null, "access_token": "ya29.a0AfB_byAF3b5jTA6HPsr8qA3IOZWYLPptSy-sCeNuXN0ZENwAlqFQhmek30hsulSOCxWA-v9iCo7HEqNDKXMP-RBWvnGavsG74UyyLQILDXlDHfm2IYfziWCIUT4sOrFvYFhGcr9R7o0adldubkZY2HxjyAN4iSkjyS0aCgYKAWESARASFQGOcNnCtTl2ASfK72d82KnAbqrxWw0170"}
32	google-oauth2	lorena.merchan81@gmail.com	105	2023-10-20 10:01:05.146792+00	2023-10-26 05:16:07.019242+00	{"expires": null, "auth_time": 1698297367, "token_type": null, "access_token": "ya29.a0AfB_byAMoRvN9MvhzTVGvdZTFi1H2VZjsQNldZ6J9leY-8lMAgz2bEQmOja1JjgVKZr4zakkeDrYAujWVr0916Ksmwuv967t6Bf3UwfHjr0IEs11_0o0r_7fKWKnuLG-7e0j5XVaurI7k7mSolQTr3V_XfdE3Hq6N-YaCgYKAZoSARISFQGOcNnCNgNQ5K_Ju-4CkIK1epA3eg0170"}
26	google-oauth2	rosidigu55@gmail.com	309	2023-10-17 21:18:44.499694+00	2023-10-30 07:59:31.317327+00	{"expires": null, "auth_time": 1698652771, "token_type": null, "access_token": "ya29.a0AfB_byD7gPUaWIc4I-baP4Uj5cc13E8pxKIyOEzbpPmfN-OOd2opQO63JvH8EAhbEmNaUp4uxNgjN7RK5hbV5ars3FMzKexzrb_xw7LLBwqNBhpkGsh15px5TKaoKrxjg1VDuD0eYk5yQEiaCa6FVsf9QDfSA3ndQdQaCgYKAXQSARMSFQGOcNnCBRAMY1TZ-M2KvuCij3I4CQ0170"}
35	google-oauth2	joseluis@hernandezagustin.com	339	2023-10-31 17:27:21.902111+00	2023-10-31 17:31:25.296255+00	{"expires": null, "auth_time": 1698773485, "token_type": null, "access_token": "ya29.a0AfB_byBA-gyJruiqKlRpDmOZHyvgo0z0VKJLMxX6E4XJGbU2txNnJoRI45xX69XlPqKlQfTwFqoDRgznJIrCGJUkr_nJEbOmD2qFO5Skm0NDQGjJ3L4FR3MSlR2ysJ5LeMSu6AxVzfPFsWo1LAI03d6rdKYi-apucwaCgYKAQQSARASFQGOcNnCR9YWRF20gILw6rMUIpdEag0169"}
34	google-oauth2	diezmariarosa9@gmail.com	328	2023-10-29 17:36:34.235542+00	2023-11-01 15:40:06.286755+00	{"expires": null, "auth_time": 1698853206, "token_type": null, "access_token": "ya29.a0AfB_byBRAKlUktf9xZ9gYf1yb6jRNDw-5XMOGy_vt7_kMtcxU_LibjBwI0uxEEqSI1a_O1SiVq1rEq7OxVZ8Ks9J1XOHV0Jfl_0RV7yESRGd1WChUybialQUfSVYwdxGfrCTc16OgZAphcf8xsoRt2wy1q-fKd1MQ9oaCgYKASYSARESFQGOcNnCu1wT_dKXpB8xYi2mkLwr5Q0170"}
36	google-oauth2	riccardo@braccaioli.com	74	2023-11-01 14:08:03.156522+00	2023-11-04 09:15:16.20515+00	{"expires": null, "auth_time": 1699089316, "token_type": null, "access_token": "ya29.a0AfB_byCOPRlKu5qa8fHFYaGlxkYHel57eBMv729UA29Xr3fBjRAgcyYfLsBh8kNgXQW-60piNPLjBIS6uNKQqebdd3HtdUhuAEVIKwt-Xb7GN76fN5G1Swf28g1bAtHvRBHavG5r_pY19FENU3tUPHbSzIPWrlPfVl0aCgYKAcMSARMSFQGOcNnCA6H3ElkJCBRJ7kRvTBmkmQ0170"}
37	google-oauth2	immabalasch1967@gmail.com	341	2023-11-02 17:44:21.401279+00	2023-11-10 08:33:37.272096+00	{"expires": null, "auth_time": 1699605217, "token_type": null, "access_token": "ya29.a0AfB_byBLAIWHQXWOg6hSZuCUPAmYqrrrRpO23OzXXg8jG41eqD1Qrm2WS2iR4d5lqVEB9QOkSWGvmDZ23Hl26AEYPlY2GDYc_yLsvephZdhR7O6-gDCGmv1Bd4uxVPfSsxYyVBud4fnlsU2_U7va8WhlTTV5hsHP0MkaCgYKAWsSARESFQHGX2MixGkZkcr2mPNxzaaQ1aUnFA0170"}
38	google-oauth2	cripto.broh@gmail.com	343	2023-11-13 01:30:08.19484+00	2023-11-13 01:30:08.197858+00	{"expires": null, "auth_time": 1699839008, "token_type": null, "access_token": "ya29.a0AfB_byBkYuAFyd742KSl4PGitBjN5ZDCU1Ca4nNLJw--YZ-Nm5hC3Vd2LmNiLZEYsO8R4irGw1ncYIX8luQvx39ESTQFTmPhQxkZNO3ujj7ne9vS_sIgJSsptpslu7vBsWmfs_c8Y8k_AOIbFvjH93DS69RwGNqMtgaCgYKAQISARESFQHGX2MiSa9OOlTyuxP-rv200QB_Lg0169"}
39	google-oauth2	braccaioli.riccardo@gmail.com	66	2023-11-14 15:16:37.543605+00	2023-11-14 15:16:37.545918+00	{"expires": null, "auth_time": 1699974997, "token_type": null, "access_token": "ya29.a0AfB_byCb_Hn6kOVBk45PZMoljWJJMjoNsEHUQUNFycs6VmrM40ryrVDeunsq38Rv8RUQB1lS3-4Ax2UwB3OGJsupVAsS1XmLHYoX0FlRFz_V53-Dzn0owDoq5kX8Z4WmG7gWlnQg3MAu0LC60e4KBFC9gomVEx3LTAaCgYKAWsSARESFQHGX2MitDBw_5cNdASKpXkdMGoFsQ0169"}
40	google-oauth2	mjhuertas@thelighthouse.team	345	2023-11-20 19:07:59.936225+00	2023-11-20 19:41:26.902517+00	{"expires": null, "auth_time": 1700509286, "token_type": null, "access_token": "ya29.a0AfB_byBtWcSNuJiA1gPDOC3zsmb1-AliIV_Somuba6fH7DWp9vc2du0fbc5W0GA7iJV_oNG9iYbkiGhNw_V5-fQTR2VwVSvd4CpGXHzF6fqtbfcox01DdfCfCk_qwtk_p0nKhpaW_K4AJ3lSNaKgRpj0vBt3A-n6bQaCgYKASMSARISFQHGX2MiMs6vHahpsYEKxYEbGxmToA0169"}
\.


--
-- Data for Name: stellar_asset; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stellar_asset (id, created, modified, code, issuer_public_key, issuer_secret, distribution_public_key, distribution_secret, company_id) FROM stdin;
1	2022-10-17 09:37:35.544871+00	2022-10-17 09:37:35.544871+00	WBT1	GCRBSJWZ3SQZSZF2GN6AU3E3ZJH4BYUV7IZWRHRZHDGHU6S2BTQWAKMP	mDwOwOqDBEqnLRJsoAfjloAAAAAAY00ieX4fWAM2eQiAlHOJ98NeIatiQbCmldrFvio1h-ZsVtTPrpONhBoRsngNk3obtcKuNhJ_s0i1jbdyetO9sncgRU0uMYuMftHDdirsixHu2ON4nTch_ADU2TSgV2TdClVguya1uABd-fkFMHs4Do9oMUQ=	GBLWFWLUBRM2Z2I5VDTPJ3I66RHKHNKKKWGW6GQXWH7TI5VCMZVQJYSZ	LCHGeM9FNO8-kAHo08YFfYAAAAAAY00ieYOAqGDMFMk6A5BQwKFS4SvIHiOfOnSBAg19WS8Hl-4iDX80n10_gTSVOxuJXxZWjM8hT_hQ3uC1XP3CgIbZ28ESh-APATXehAtDDFSMKpche_f8CQhA-_Ntb3xY034P83xbXtjCRdJhQrEjql-PF8E=	1
2	2022-10-17 09:40:13.099038+00	2022-10-17 09:40:13.099038+00	EQC1	GCTHTFNJC75H523I5M6MM2BA3CLLMD2BAEDVBEOZ7UCFYXRAYU6RSUEF	Ws99ZI0FzEP8Yw24JHQZ3YAAAAAAY00jE27RF1MgmW5yb6tnqByeY1McMosLtzLi0etg6VYLOOdeQBbYiupbtyuRLjm4T8j9JZzQyonTiWuU8ieeGRFHv87nMgPCgNJfL_fBywqLHrjjGXiECO3ABRpg7ATd3sHG_AqeLeQL-tAbegjnsTe9NyY=	GAGREXGOLS4GTUGB2M4EZY5DS7FXQGCOIRK72F7J4IUUDRC7KTRVK3S6	FPUXm_zEL5bzA2Alp4lyYYAAAAAAY00jE77SHhSRiw3MPzyvQUYB0MCIDbqevHaf59Nq1WnCxbn1cVgDP-6HieQ_9V9qQsF2xJv2f7jeuevFWhvfcKy3LIOeXbMsEsGcksZvQMJpJ4g8hno94rHa5WRSAfMjKycccVbWs0-4dosmsVUTbw0eSP4=	2
3	2022-10-17 09:40:41.667996+00	2022-10-17 09:40:41.667996+00	CAF1	GBQPU5T7BLVRN2VE6ON7TOJZTP24E3FJI4O2SCLXDHMISYCGG2IUOWYX	QIXKwFJEcc3RjEVJ0LxVLoAAAAAAY00jLz5IB9_HEfC1oVumjGqeZRp5Z3eTyiOc2ZzP2LaSn7T8BG2Lx1n091Anz0h8c9IgLY2Q2--pgu1e1eLh6nMtMhYmMs2MUcCNVhr1kvIx8aUPNg67hicprogD2_kto1lQK2zrFqdc0UHr3W0vwb42frA=	GC3ZKKCOM5E7LFUZHMQTRQOOGTDN7DUO6F4ZA7AAIFJGCMBNSRNQMQIV	YWeOj6SxBn3kn7JbSfrRp4AAAAAAY00jL5WUY1RmWVmLamdF9eU8z3clopQA3-_XAxjBahAD6ETzHzrL7GKeF5TNOd6B9YMKOLUplFWdBcSNVOSTMClkwye8X5OcNjiM9oTaWpgwp_M2m2YwHPf-gBYariFoOUiBgo-5oFE5i0NNVPtYszvfGNk=	3
4	2022-10-17 09:42:54.255699+00	2022-10-17 09:42:54.255699+00	BI1	GBJTHF62E5P22DCAI2D3QLLCB5N5JKM6VCO365PMWEPUU3XDK22HPORH	rjbUqU5UMq4Ejm6G3b1sOYAAAAAAY00jtaSllwhDwqSWiblA05SJJgkfWwzKTh6aioTUddF94iumfuqzu2Qf1M177HmcbZVZ41KzrvduIX-Ygg-N1s6uRMwXHZdjjcz5D8zmKnnb0kfoHfIssgFqI-oT0w9MTxiCXtl667nvdnA_eSshhGSTRUw=	GDMPQC5UJTTJA5VTMOYYLI4STK6TNFYU62FHNZQBYCHNLLLQRNP46WEP	7-JmGIlGlskhleaHxmuPtoAAAAAAY00jtdg8UZd6COsfiqTy91WEDDXYKdSRy3IadwgMETwE7Pul58vijvN0VtXZtu_8s_f98UKcTFm-ZetWJvrtZdQisRzNcGBGBr5m9gSlour3PKASiQgcjl7hMvHPwFtdW5E6feQeAmVT-Q4wydZoijCfqMI=	4
5	2022-10-17 09:44:01.568338+00	2022-10-17 09:44:01.568338+00	BIG1	GBPWWPWBAEPJ6XWJASCCBQJZLU7QH57V2D3UFDFUBJ7GYZ737GKWIUZZ	6dyP-YzKu7hyJYlYdtkM7oAAAAAAY00j-hv0Tg1m5Zi6FJKXepAyv56GOsitJ5Y_ECbv3q0NklKRQfrSyIIguwWhCrqZf0eD4C2oG8UD9lRX8d9kLQ4chZDH89hD43v6FksgisBA94irGFpX_qB0eUfN3zuPNpszXc2QCuwQ4OKfbTxYq3ocz5E=	GAG3PEE6CQMMINQKL3VZQKK5DKIU7KAADC7KCZTKIK4H3QDQHAZRWMG3	fwUVmMOfcFGNVdxoCABwAYAAAAAAY00j-skkM2K-s97MTnPuWECu9t1gXj-gk6pJHr2x3z00qelAd3rZtUNgKoJo7xMFcRfmvuicx-oyRol8uD6QyYGeVSdlRkAi--whZNeUSb3Wt0MZNrYmhScMgzCSvL50abZZI2kqeycCSo0PP9YDfQavlxk=	5
7	2022-10-17 09:45:29.555346+00	2022-10-17 09:45:29.555346+00	BAER	GAX7NZRBMGZBCMQJN47D3KOFSKVGW5XPRB6DO2RQGGQHF6AOWWFE232G	M7ERwIQYmpjOdgFKOwX4iYAAAAAAY00kUqmAUon64hbE3UkVVua3PePy3YY7BFndGioVbAFGTyjo8S4Ke_xS5PvwVRamiviJN19jLrSElYLsfPL0J5afbMQK-PAzMhfFYMTi_QaCLedJurOGynF6Y3ERe779fd4vmO6Ajy5DKw6hgKBL9xZx5Ig=	GCL7MYSAZ5QEYCKV52AYXGJ22G6HSFFLAFT76BJCRBFB7XO52D5472J7	pxHKzOX08Nr154D8d-aal4AAAAAAY00kUjJs3h0dufyQJWkf0hPoBjLZO7oX0TEG9jdgzObeHCNW-uh7OG6gJUvdK5e7pmOiO1Flt1pAjF4RHGAvR3sIftdYgQDA99K0eJbJJ2GYpKZXzOz5LJmM1uyGQkQUWK8N_sRT4IprrZSujhHBSaAbYgk=	6
8	2022-10-17 09:46:06.128537+00	2022-10-17 09:46:06.128537+00	TIAU	GCNL65FXWSSCMVALTQRR2N656AX25GB7TBCLDTL7FAHYQQRRKVYGIKR6	YGsolpPA2DCGjxx20ox_VIAAAAAAY00kdA9Z1MyoTbggtoLuJHRvpeCfwS9Ia8eIoGah98Iq4PCIZzQDObckDnHo3Ufhp50aB2QARBS-3P9ij5dNOl5SEfqejk7xHEMZRq_cOE8S97uoaTUUMWMZywUmFenN9C104MSxlUa16cDez5or4o918No=	GBGDZTGISV7EDCCBG7KVL5H3SS3KRBW2B3MSHQ7QEMOJ3KROHK3GML67	mBfEsRFT1GdXdPUX9Pys_oAAAAAAY00kdEWEVy9tBC5sNDg5nVEyXpMtzOLOnEDDsw6QSZwj2StGsfzZxTMqD5KGaJroiDyt1bs7VwPwRFah-NuABNTzArajYomr3YCOnwooDAJCUnadz0kj2hO-3bLlmZWfHaSmjcY9b_vy0VbF7Ot00OdFRa0=	7
9	2023-04-14 13:37:58.457446+00	2023-04-14 13:37:58.457446+00	escr	GCKQ2HOZP23TH553S3BKE5BUZXKIINCSLD3IK3HI7VZOLJO67SETB6M2	Cy_S4KMdhjzxmdYVc5r3gIAAAAAAZDlXT4TLt9frGiAFd2h4OSryK_iBSbp5uBhrNu1LcZskxOtWjjQaPYv9OOIhQVeHKxtdz686mnXtHwkOihgsg4w-MtS1Xp7wwnN49yd5HrdYZBCvFdDZ4r28KeWwMUHQ5DeWCEUPqJ1iYZVwBptAzK6bd3A=	GCSXZYLI346XFGBIJCPEOFSYVWWMIDYWKFAHSSJAQYS7HHUBIXDQAPSN	qvHEqWvHyWRx9LKb_P6_Z4AAAAAAZDlXT1jpzbRsWLCLVRocvEs_breyOz88y8w_XGjFr0C6Cqu5ShU0lA3ywPjRHzU3bTauele9FCk81EjWiK42vrvN_2JTqXhTHvAXswFTX3P0WRLV9hldF95P6sGndQNnX-QxX5LHDByacj7hAWtkUZXRt9Q=	13
10	2023-09-08 13:30:58.547662+00	2023-09-08 13:30:58.547662+00	tria	GDXXL6HAPHHPZ7QFYKNEQWTKL76D2T7P6AJRASDMHBBFZAVQT56O2SYY	P2Oz6aqlP4slFz0giyluVIAAAAAAZPsiKkIYh9Pqtib1SUYSwxf9VwJggGU4r7svEIwXyHJFlajZnfMgGssKBy1SXV-9VvW3sQI4FpRYid-dmJXN9-gVokLRrEb1hXg7TbUtFZURY1Uju3yD__aBpNAJVqANFdBkfg2ud0RnD7IO4YtUL3gbeYc=	GAJD6WAG53WGV6EXDHQYXSLGTBUSMWI4WA24NNOZDJK3XFZEXW3KESHK	VNTvMpNOWrrPsSm0mwNM8oAAAAAAZPsiKr4Fq2cNRFnvwoY_FbmKOnp2mI5D481KsaZAy1Se_PpxfJRdL5uWKL50-tt9RGr-w62SN5-f_07LvhXrjJDi26mkMZPTW8NUU-oQdyZlCOap2TomLAgOxBx9YV4SrSTrvQacIg_pU3LhPyCu1pVxKA0=	24
\.


--
-- Data for Name: stellar_asset_trust_op_completed; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stellar_asset_trust_op_completed (id, asset_id, user_id) FROM stdin;
1	9	79
2	9	80
3	4	23
4	4	28
5	4	24
6	4	13
7	4	82
9	3	196
10	3	23
15	3	28
16	3	9
17	3	324
23	3	82
24	5	82
25	5	196
26	5	28
27	5	324
28	1	324
35	1	196
36	1	9
\.


--
-- Data for Name: stellar_currencyasset; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stellar_currencyasset (id, created, modified, code, issuer_public_key, issuer_secret, distribution_public_key, distribution_secret) FROM stdin;
\.


--
-- Data for Name: stellar_currencyasset_trust_op_completed; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stellar_currencyasset_trust_op_completed (id, currencyasset_id, user_id) FROM stdin;
\.


--
-- Data for Name: stellar_wallet; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stellar_wallet (id, created, modified, public_key, secret, user_id) FROM stdin;
1	2022-10-12 08:04:22.3091+00	2022-10-12 08:04:22.3091+00	GB3CQSFM5CW6XYX7WQVWB6BGSFSHASK3KE44VKZTGVWDF2CYLXHJX45S	9bkEkbvd9dKM5QeZ683VSIAAAAAAY0Z1BvMXEyGebZotgjkGEgF_h7ajhAG0J6gEKjcPrIi0dTtsnHTTyyNXRVctqnzgyqywbVvSIAVpk3R_HH9xlQeqc2hwUYr3KVafrzDDLnRBfCOG4gdeZkW9AI33KwKZ7X6gqjwKYbqnhp-7LSjFHF1xdjw=	28
2	2022-10-12 08:06:17.305993+00	2022-10-12 08:06:17.305993+00	GDEROSR4UQURLRANOBQTN3Q3DAIGJQ4J7ZWIB2OD47J3RKGWYGADION5	8jETBmzshMPbvtgO7B3phIAAAAAAY0Z1eX5V7m-H1N6DuaOhSlaho-ic5RYGPawSOTcVqheisppAW72JHrARZsro3pcgWTK0fYdF16egTYNdxxBmtDOYgeZcoNjYwruqQ4wIQeOYDFmlzLlP6BgPZgkB-QV1gJ4bezyyab9gYTgyY9puMxbpY8k=	10
3	2022-10-12 08:32:54.176909+00	2022-10-12 08:32:54.176909+00	GCQ5JBB66VT7RQZ77WQWDRLFN5PQXUDT7KH7AAAP6BPZIQFUP6CFPKVL	_NdHsgMAOEUF0ejh10jCJoAAAAAAY0Z7tnTJv1LWMRcImcfSPXlu2WbHMLcLQz4dXX3huAcv2xITx8ezGqkf1oI9fNMmLgxrfca5CfBZIuuad2O-l13Kye5Np9py5v6XaFKWHgHuCaS5uBIC5XYUedoXbgUrCCiK8OGYE7EVpMPWRPZRhFcRA-k=	12
4	2022-10-12 08:43:08.806295+00	2022-10-12 08:43:08.806295+00	GAULY2P6PEGT4AXMNRIPTQPSDZYC54EZ2SMDOQ2HTXF6RR3VAD2VBRYA	fGQ4vaMNxIITnLkrKX0oBYAAAAAAY0Z-HAtTjt0yi9kgtWiTjRwSINMCZvW-K_nE7sWhgwQoK1na1FVe6Tr94xcdmhy5kpCvc8IPtyzA5YJ4IhhBl6meIcbkWKDUhBHyNuX7n1nLpKo0DWPXmQlHJl07Wu6XBhsPFW-PfN2wwfwyhpGa9jbFtMg=	15
5	2022-10-12 08:43:49.554985+00	2022-10-12 08:43:49.554985+00	GBGHIUY7WEWGGVERT2R4NMM2ZC2BF6OOHLHLEK3HPMYHHEFFAXZLESM5	j1fW1ozhh0ZuHMgWVH7T4oAAAAAAY0Z-RTwFjI9jFn9rfCsqwD05aivb-TeOXO0KvJ8OyqQm53uMhh80r3gVeFks1B72o68Oc7GnDFWZimDisr1BuSAESV9EGb02xBQuAkvnfyNu8S1oyPXvDLKodPHePsrCCXzj9sZ9DtDRIp20MBfrzxAV5Xg=	23
6	2022-10-12 08:45:12.296962+00	2022-10-12 08:45:12.296962+00	GARIKMCWICKM734EDWKRVZTFLDUJONOFAEK5A33FJGJOZIBD6G62ZMBG	MSJzuWX3hEGUpl_mVnYpkoAAAAAAY0Z-mEuHp741E8-5JpR_l7M9FhjKPobDyMzrAthLr1i-ZSbXoNWILa92bqcqdwXAIAYUUkwSFeCGl_DSCVj_egyR7HSaaXoHDNA8ni0JJn-44gtZfm5ndIRdSTSA59vZFy5itpaVMsSGRdKhQQGxoPMP96Y=	32
7	2022-10-12 08:46:13.86455+00	2022-10-12 08:46:13.86455+00	GBDWXZHGZSRJHAXMXZARXH6HIZ4YM7MVKIWKNSETG6CX3VLKWRIS3N64	xUVG-4kLcRBs6DddJZxtiYAAAAAAY0Z-1QlWBzdT-WnWl1ioiLfGclDUSom0FQ-5_PfbDd0jg9B5tTBZnYb8c0H8XOwAhZ4gtqbBNIuQiyI6lU-gFD4I0czJ6wWsLh45g59SpJUg0PbdU7mybBJmX7OPvdh4HnMkmR-3sJl7ImbOp0DDMtRh57o=	9
8	2022-10-17 09:34:54.785306+00	2022-10-17 09:34:54.785306+00	GBURX3EVBXPSAQWBXUGZRQDMAM2DRNEXHEWWWE6OVCWV4KZZY25XTCC5	Av_YTj9tc8POwzAfDM6aVoAAAAAAY00hvj5MOQsxLKx3AFF_tMyKmbsDfm4dDvPwDP4FfQk7BIieSiLG6yow4XKOAcpjkQTQ4__R4-1zFMVp9qUkbbXE_3TWvMkWabQdJkHWkLX6109v_r0atn_k3lvwO2NohK4eu_l1HDz9iHJyvSIKjypkkdw=	11
9	2022-10-17 09:37:03.567851+00	2022-10-17 09:37:03.567851+00	GAJSTJA6RH4YEG5D3NAFR5GVN2VDROI5NRUSYLAZNR2YKSXCXLUT5LIZ	VdCYoL9DZZIonRC7oFLPRIAAAAAAY00iP4EfpvvNcPyMSxbr6yrEfGr1UYstb-vAfWdei0udBCcRTsk71B-2kqB0_ZRECNt5xH4qdjtKc6DgRK49fD9k6O-oCBaRgFoLjtS5XIXjYWksUiq3rh6SnI_11X_cSz9WfLv_PLjVyI4enpeV94RKRLQ=	13
10	2022-10-17 09:37:09.759745+00	2022-10-17 09:37:09.759745+00	GDYTWSITKVVJQOE5KBMFN3QZJXYFVM32UEU5FQ3WDYFBB4QLZ77ETIKV	OvbUuDCbLnWbEwhJ-QiFdIAAAAAAY00iRTAtcryu7v7NP2irBf3fM2nnsDD3HvAOAczGo0OK2FTubjmNP9MtwxU7Q5erOcgQqCO4q_Tvqtno0HwJ9iEwVq_hKcvWxc-mvMOvYi8mGUEZ-aNBScZ13bbrIKv1FxnAFrqy3GtblhLPAvShF0Yp1Gk=	14
11	2022-10-17 09:37:14.682587+00	2022-10-17 09:37:14.682587+00	GDIEQUBKS5I57I64B52SCOUWSKONDMHFKDIX36RZHZ4YJZQSRNTAIYTB	JstLi_W8MbT4CRtlr1yLsYAAAAAAY00iSvbVWYPgtRpxgZ5lw1F0YhnVMxwJaqZXbP1W_vwzRmzNSBWjH8193TrXRAfHbLzGIVTJ8yB6ALsY0UghEUNzq0MmMu3IThZ5WuXAjrTG5LICC9PB3p-xYqrtcMG2e0EXLuE5xoefWs1rzZdslqty5Ak=	24
12	2023-04-20 21:04:30.816692+00	2023-04-20 21:04:30.816692+00	GB3XMWHPNXCYQWMSNM74QH6GH2IFPGZRC7TWZ3U6P5FHSERIN3G3XMNY	SjEeCQkDh1SOQfY2nf6ltoAAAAAAZEGo3uWtcwQB0EouVDN4s0BURqgV1a5-LRm_elKImT7wTaF34wOriwxbkvkoF8gu4oE7LeWlbW77vuSjertkLLVJWfx-0FWlSlpz-Wq6pXff50rCgX_v5Xw1rLnBhg-HPWAmbzRx170kxnsB_6GaWD51uHo=	79
13	2023-04-21 10:39:08.292792+00	2023-04-21 10:39:08.292792+00	GBCDKJFCOFTEFA3ZGD74SKBQ7XTZUKJZXU42GAQRW43LX5SPGRZZ56AH	HO4tgxJ82J-QmbUrkLSBLYAAAAAAZEJnzBe30aWNVatpLazHJdCrLC8TjpCj_4VtIjeIh58uwnYJ6JDONF4hsA-WgAvnri-_JaEv9NJdd9l06YEyaKLKf7bIJUC_uLQ7xIGfES2H5q-JchLctb-DlK2teFEg8AvbBgSQeop7rRPBd_ElQi_vIxs=	78
23	2023-04-21 10:50:38.145427+00	2023-04-21 10:50:38.145427+00	GABERURBXXVSE6P5L5IAMVKN2MSNCJLNYFLGFEMY26JNFTUVXNO7UWEZ	OujLNvEn4n5DgK_CwfmVh4AAAAAAZEJqfmBXwCPOew0vtGDDwNIvMpduCvlsGdlXyM-KG9iu0ZU8PkKBg8cpvbr2CEeo3VRpIN41mKK1Y8kaLfK7j0BZp36_we4pzWjVL80vkt2OpighlfalT1ZfusF9KivI2qbxmkQLUthAlVltvJjhG_Jowc8=	4
24	2023-04-21 10:50:55.82402+00	2023-04-21 10:50:55.82402+00	GAJABNXQXUDXZ5GYYCLFHOOUMDDZEJEWGSKP5ODNIIQM74GARFAS27BW	Ws4U2KSTYv3_VE2QzUMaOIAAAAAAZEJqj8tVQjCHQWuGOzuPYZlhd5-3oLHwY5c6lSEBSWOEYVE8t2z7wE77_B-Ot5cmfCSI1nh2jhVUBE2YxLy-M2lQi3ML68OwLphQroszKUG9Zsc8dILr3lUAFwxqMTibP5lcXcKPr-uFl5f3o1m9rG7Yr_I=	26
25	2023-04-21 10:51:48.341514+00	2023-04-21 10:51:48.341514+00	GALXE2QC7WEG7JWPLGFZROOUL443WTZG3BQSOAQSQ4E4FMZRSQLRM3ZK	fWxpX6Ld2f2CW1QTgzhEIoAAAAAAZEJqxI9yVgeyaTGkvKVCtHQVIGLBK8yvkLt_wegMih5sTrmFIgchIkPYpa1X8-oaajawF9elw2ECfYwqSj6h4dlXBzEmLQd1q5DlICRVSfRRtJCJmD5qOA8meqj_mZNilJKD4hvVpUuJCZN5fS0B7jFGpu4=	29
26	2023-04-21 10:52:00.106791+00	2023-04-21 10:52:00.106791+00	GCBB76SRT27KNXQFXCCOKJXJELYUTA6ZJRXGA2HPGG6LLZWUTI6WPVFJ	ZFRtbj4g-oaueuop_zuZ34AAAAAAZEJq0BJUwbRBgZAQoUFEqOS1ADXLgAIxPBAVPURDr90fWIXzHi-X9y7jmjjlsQZqmdDPqXaKueyAtCfaymL-XNX-IT3N4OKPTaJXLXsm_ZJAp98uNyNS00fbygId8mgk5J9EafLvsc6J2glqFEN55XdV1ug=	39
27	2023-04-21 10:52:23.059896+00	2023-04-21 10:52:23.059896+00	GADTQIT4JTGTTVWFJLIHK3HJ3OG4TAFCLYRZDVGKS4O2BEUACDIJQBYR	ElUywr_SqSC8IOMzvQExMYAAAAAAZEJq5_rTkor8KNEmgvTEMzgKu46EW08I4lmUdoOH4RQKO0P7YxeA3aWNAlS-dqijIOlwmu0BLcbvnppsqbuq-kUuEtB0Gw6HWWwiXCGrHb8bQaLhbAI5_aYbaSz2XqzrIxmraE5vGWgA_gKaGECzw9AwDdk=	65
28	2023-04-21 10:52:41.333045+00	2023-04-21 10:52:41.333045+00	GB4KLR34ZYSM4SR7CTAXKM74VWD55GW6HTJ2NYBP2FDNEZPKVYGL3OAY	9o1FkXS7_dgHBqEAMwstf4AAAAAAZEJq-eq2V3xxoreu6dBIZAwiP2ZhIyVf-t4YZ7zqfRh_9s9P7BAbSH9IWJyCzuqlOnV3lDUZ40XW-cJpU93NedRB9ZA23V26M2C3o2Fm9n0l4EUGqyWh8x6WLSmDHojLilHZ_v2xwKR3X1cIumsCvfAKvXA=	74
29	2023-04-21 10:52:59.150561+00	2023-04-21 10:52:59.150561+00	GCSHMKOGUEJ3BZDID7G5DV7KCKM34AKGMTTUBJI2B4V6K7LXTEH57YAR	ZKzn3WjE2lJXeAsWHzw7P4AAAAAAZEJrCyx_DG50dRFBzxFxsnl0vHoVc7WyiqDWv7iDxF68hRH72qjjf2rfsHcizQdASsxS5rB0eTrpzQifuOSyHdWik5CFwLa-yAyCxZw_vHhw_s6eViM_F-EV8_rAr_9m6QwYQ52OnceETgYofzY3YBO26w8=	80
30	2023-04-21 10:53:58.207843+00	2023-04-21 10:53:58.207843+00	GBGTCYBLFA2BNSLM4H4MPVY5VWRM6GWOBWYJRHQUFJU2JWBD4HTS3P6H	inGajyVy-OgFl0Ca-eBtQ4AAAAAAZEJrRoyIcFWJlF5wHbEpm-RBVW29KRvsiyYnCadDWNQOZ-hjNn2b-4uDvYBdlX5O52VqekTVJzF58KRyVwEIh89UwoCkxrbOHppAGErPQds7rD7WJ-gs9JK_0bnBow10Ylb0RxUhy4xUHczenwovycCcK7k=	82
31	2023-06-26 05:40:12.322725+00	2023-06-26 05:40:12.322725+00	GBBPNBK3ZEADBOGRP7LPGXWD53QWZ6MKTG4G64UAO5QWK6NPD6NIZIWS	lg2JZEC3Xqum2b4tCfAx_oAAAAAAZJkkvPUo1ENNTCVjPzZE5DYG67hIRiZ5PkQoFPn-GNw17HyeTccKQ3yYegJJ-bvlzKw8DG5ETtXHF_tP3CxEcsMdTSUtFaQca6EP0yYlOFDhI9eM12JiyFGJcPc2DoAJBA3eaqsJuz3taAWlsDbHntkqwMs=	136
41	2023-06-26 05:49:06.193305+00	2023-06-26 05:49:06.193305+00	GCOKWEIZ25QQ7WGTXIXJPRUTZQ2JZEBQ5IWETQ2F6I4QCSXG442SHGOU	msZYEFaqKxaRcPSbeOv0NIAAAAAAZJkm0guRHPPqPJKbxAE6lcpA7szYEMijD_HSMqyTEVh3QpQbg0xIdg4dKZpTjjyY7d0Ko2cmH7_iYqFinT698q2C8sCsiE24fS5BnIlGjCVUFdk1TR2AjhSviZjyJ68kCKcFgV4XJpAtvt7rY27Z2UDG2cY=	84
42	2023-06-26 05:49:36.852343+00	2023-06-26 05:49:36.852343+00	GARG2RRMPLO77KBUSC4FDDXA3NMTNRLPES3PAVHRCR2F77GASM6F3DQD	AMLCOosfmoL0rOp85jaR14AAAAAAZJkm8MUEVfRCw1HgIYF7ddSFYqziz1u-dWf8jN17QPGO14ciz5w_9XXT_n1HR5ri-B83d0NtiWM36tD35SAffgz3LqMRqXJ5KVtFEuBHF8CuaSi8W958ZvjkZp_E3Y0QXYQZnlNQkyNWQY1EvKtCS_bWOTA=	85
43	2023-06-26 05:51:06.825323+00	2023-06-26 05:51:06.825323+00	GAYLFJ3ZM52X76NHAZASWDUOR2ZPSSDMV2PUVPX4KVDEDSLYET6TGX5Q	19i93XhKL4LKUqlgrKqLi4AAAAAAZJknSiQdBzbqe4b8KD_it_j9eV3cE8NbH2NjHrCU3ennnpPKXf4gTigGVDxi5I0TF9vhr7WsJVcuqd8edBkmMhKpFDPphV6CGezZWaC3LvXDUuCcTqs6xMtDEUpTWCeMTA2usuSCWwdysLUuypab66QFsp0=	86
44	2023-06-26 05:51:41.276488+00	2023-06-26 05:51:41.276488+00	GBGSOH4EHOWVN775ONJ45IO5YEGGRQQODH5FZPCCPFS43O47PK5SPXFO	UFhYE0IxF21NXIHsYRjyQoAAAAAAZJknbTtgU-VGWgktU5fgBLNoDOQAqcGttWsDmMUGEWtTzILu2msr4olIYH8-i2Ysdt6_3-bbE8_mz3RCqS6aN4vSjuTwUCuwZTmzfUBgTBiopxw5-_XNVxQgOHQM7W9xMJ51jrZiGBYBSpTIFRA2oCSzq6U=	87
45	2023-06-26 05:51:58.271159+00	2023-06-26 05:51:58.271159+00	GC2YIT24SNCDC6YSLVCOLRODD4CFSG5U5U3FKVXYARGHT4UCU36CY2HZ	KcKDHjkGVp0TZRRJVKTskoAAAAAAZJknfkVYXsOmGHG-3TENlNXqnVCszyUgCJUST9fZudH11AjfSDoVY8nnWNTR-j8S67tIAU2qjAUKwTl9An6zBGnGjAS9pvTzJIrpOr-XKoswuWSOrnaAZ1pRSUiI-Y8o8OyE2D82wVQbkqVsRmf-9_TZn7g=	89
46	2023-06-26 05:52:15.83992+00	2023-06-26 05:52:15.83992+00	GBCTLDILWIP3CUJXNWVSEVBC572UM7YR47QSN55XEEEAIP73WWTOCBJU	sH_yJ75XK_f-GGYGRdLMz4AAAAAAZJknj13YWPNU9cqW0twQuliFpCl8xrxbLIerzgj_t4_RbZnZkaIPEPeSpd7IOcT8AxDHwPSQBm5sQcrPyn6666b4rw87-I8eL-D4DxUZuRRr9XnTJ-lexm4JyKuIqHac3zChtXocXJBmsP5zXaVlnCCczv4=	90
47	2023-06-26 05:52:38.343591+00	2023-06-26 05:52:38.343591+00	GDR3CIB52CIO4Y2LDAWIA5KKQZOGSUM42ZLUBRCZLDYT5332V77BY6RB	yutc3q0eSOm6LVxyaj6o34AAAAAAZJknppbs7-vZIBYoOw29TJE2CQvtW-4CCIuChLaVONUNm8BELwEISJh49SH1OJbWRIgzmo0_2W65ZfqfizSqnM4AVtXnW7GfsTlDfBUDeNgQ9LtExhzkWGyN43HrDYAnLEBVTCOvmOh7NES8MwWzigtaAV8=	96
48	2023-06-26 05:52:49.811064+00	2023-06-26 05:52:49.811064+00	GA24TD3YDE63Q7Z3P3B3DVA4CY7ZQBJGRO2TF4YGOT54CAAHWZMWCOGB	RqqDx8Fv0zCVmhgFVKt_aIAAAAAAZJknsbL7-YmgrmGQaz1LNTYHQtJQg-FLwnpMV7kYBwMZ0wTS_EwA_ihdH-QBwlg7ecrzS_tWDOI7oDdGfAzHqUwpPhwmSnSsQPhCXhKFNii7coEle-Lulqc7aMrnHssiexIu1VSSGSIMmLRO9wEdQtxp0bU=	98
49	2023-06-26 05:53:03.029373+00	2023-06-26 05:53:03.029373+00	GBMZVSUEGLXZIOU7SP643SDS36KID66JDM6HII5M5SPOSHBEAFV6MIHC	_3dz06FkiWraBsbrUMnLC4AAAAAAZJknv5JXP1JBz02jmTJ2_ywS2ksZa4Y-MvmYiN6Zl8VunN8vsSggKQ5D3TNZUz9khTaIAQ7-8NVHpqxXrNtrGI-2f9mCA1giHkd_UvFGwYcHNugAj2I4rMrRg-J3rMGwqaJYQDMk-npuxw5vJJpuGfBHTDw=	99
50	2023-06-26 05:53:20.321515+00	2023-06-26 05:53:20.321515+00	GD7UG6B4JCSSDMIDBWNR2A3BUS3WNRYZH47AB224X6AYL3OQFHW5PH7N	XVKyT3OvmFUhJ_vmZj2Tz4AAAAAAZJkn0JQOeYABrDRI1d2Sw414gbr4F6HDa2M_ivlZjbLQV2cZ-2aaGJXDSO0NPlJyTc-hh3QUoQwDSS8Q1yIAeDmuuA5fDV0wWOB1Q2KflMUxwEtG-H5A2DZufZH6pof0FXbU7gIBGC4BLC9SXiccrzzFD7Y=	100
51	2023-06-26 05:53:37.915607+00	2023-06-26 05:53:37.915607+00	GDY34YUHZXCN3KSFQPUZNJMOGVBPPFXD2OI3JWSSMOBU2HZ2AK6B3IWY	asyGJPb4SpPOzNdYHsvM-oAAAAAAZJkn4WOQvmkVwEmf4l3A5abH_53Gl3IlHZGEMtFiCChnD4vGKaPZe_ZKtDk-hDXkKHPeflxGnFwHnjwAyZs0buuLZVCxcJWkNkipAFcF8ILXQ_qPGNlrk7UlyDWJnY3VzUxgYXp0hTrguLo50sQf_jdkLLE=	101
52	2023-06-26 05:54:06.660006+00	2023-06-26 05:54:06.660006+00	GCT6GJAVFVEY7ZW2Z6W3LB5E3PKIZ63DWFWOS5T2JEWVKJ5TVCZY5UL7	tU3o2mF-xZPsfA1V2e5dJ4AAAAAAZJkn_t73u-Hvc3X-GRnBnhRZ1UNso-JxmLTe19y1ELWj-XeGdJFTz6rdEqV-0MWg5k-Y6qFR18yt3rgLhBlM9eLSDYdUQ0zk2rMjZvDviSc29q0-YYcRhpfDLCsFiuopgfqUJH5t6n-XAmEL56FfCKjw3Xg=	109
53	2023-06-26 05:54:25.155787+00	2023-06-26 05:54:25.155787+00	GAEXDGIIKVI2FMUKZ5SEV4Z3XGDTH4URJPYK3WVLEEU2ATHJDXFVGSNY	qG4rh4NLuEdG94RJdzHgdoAAAAAAZJkoEeFYvs5XvwjLrSXKBe7p1upf11_LTalt9SrYgsS0zKJnTtdoOqbY4PshP5v2ih7Gfo_K7pgyd_38mb_JxtXZkEz06Ehg6ZvRq6pge9UXCgm75_oeRL4HXuEccNsMAuhssmi_4yYUfGQoUuWu9D98RLA=	113
54	2023-06-26 05:54:41.321811+00	2023-06-26 05:54:41.321811+00	GBBBARYPIAJZSB6EJ2TIBFM2AMC6NUD753EAQWWNKNRV7IDG6IL2LS4W	ecC8PBkZRPp0p2R5PRICLoAAAAAAZJkoIR2njq30_dqmlKrpzGYpDcZgwc2pObCRL4PfgG7C5k-DBme_XKTe3xaY4nDbrfgws9QeftdzGFfr1rs-T0YKHNLgjzVPt5YYXf29OGh0vNfuACwA2cwg_yMLwQiWCHvM9ZY5pl9cGR1upjfA9hDw5N8=	118
55	2023-06-26 05:54:59.030185+00	2023-06-26 05:54:59.030185+00	GAUXWYOIJZOQREW4ECWVY37K7LFNRJPAYGELW4HVZPKHORZE3Q3664JM	M4UpMKoDpPRTbrbJbPmAoIAAAAAAZJkoM8y7iJ34FwoxHRrbOqvz81Gx2HKwEjJLdSyCXrtiR07s7gBqq1R4r4WtbBXiM644yIS9YWuiJpD76AZ-mH0cTB42FzU73gJxOU5h75dp39GVjxF5aa9iRtdT7UwI6v5zAQeZvbW9eTp-biTw65Regr8=	120
56	2023-06-26 05:55:21.824141+00	2023-06-26 05:55:21.824141+00	GB6LHSDH3JSYAJT4DL36W765VRE7VNJXVOPC5IFKKYDIJ5I6AORRUKKH	DBzPOLy_WYcHr3QiFrsqBYAAAAAAZJkoSUbKVDmIamSvCfIo19EtbeRk3bpPiSDrKlximHFSCct8Fk7xSnzS3yN4MEmXn0E3Csf5J2EgtEbP7jTd8X4oh_sCNmglBxZ2k5iU2m3vZFkO1mZL_TOPtO0BDLBS4Uz5bMwE1gvjo3X5Af3u4S68Hi4=	121
57	2023-06-26 05:55:45.614197+00	2023-06-26 05:55:45.614197+00	GCXWPNKJYOVNYGIBCZ2V7EKXNUBUPYPYP2GGBBMSKODQWEUFXQTPYSWM	AlauXHCJuj947CRPZlzVuoAAAAAAZJkoYU_sV9T41-EzgsgHcIwDJEw6j34KeRTyYP__PgsaAFEebVYF5suwzhYWYJxCUQiA-ntWcOSei4vndMGLppeyXdd-SetKDSxwIIf0NPVZ7j06NtcXI7wDRahNc9YfMN1Ipaf-aoj796s8LoOrA5jRKaY=	122
58	2023-06-26 05:56:13.226735+00	2023-06-26 05:56:13.226735+00	GBCNZ74KFXWN2KU6IFOCYG6XXWEYOCXZTHVXYUQBHOJPWWZJWP5NMAVK	Fpk6zLrRYxq46Um4Xsd6j4AAAAAAZJkofR14dgxZluO2hVs9uMZUL-vN3UbY3YX394KEQEC4yZCxApOHoM1K8OuvFkjhaEajwP2MjEN9bk5oQdWCKyh3_0-vq30r9MJwFxXchiiXFug0rFsu0tOtMwjx4Is1A8_SzdxtZIjmGvQKxx8DHU-qM3Q=	125
59	2023-06-26 05:56:30.225882+00	2023-06-26 05:56:30.225882+00	GDLE7L46MHFJVXV5ZN52BO6PRNJILVUANGU7AQFHAU7NJQFXYIWDZZJF	b-_hvWGy7IIkC2Tjfc8IeoAAAAAAZJkojn_5MUkQAfwlovU9AbBLOIQ7xDWB6Yf3YP3x93CvZRks4GMxs_G8X1S7mBRfGxtSQYJqs1tCij-ahi_wf4SvxHhboyZ45UpCYWJlsHAhIwMTpBksr5AmeZB1u0KIcNxLBYc4FWKAly5o_LQibvwIMsw=	126
60	2023-06-26 05:56:52.966708+00	2023-06-26 05:56:52.966708+00	GCGLOZ2ALOHVISP4HH2BMJ4WPGL76WWKYLAPDVU5GICERTWIVIJRWYXY	yJRc9jmL3zQmgbjL7yx6MIAAAAAAZJkopUMsE8lvgEyMau1VxQ1fWmluqQHNSFqGoc51302F35Afj3p0fIUAR8E7k88kwt1COJKIrEUfN4JH4q9eUqkJo_zFt_Sxsgf4Fz9K5_q5fgJ5jllu0BQK_bHad_mvkvFtTodHjvZ4U0ivcURijkrqPq8=	131
61	2023-06-26 05:57:09.745394+00	2023-06-26 05:57:09.745394+00	GDU2G5WWHBGAL4LWUNDW3XOK5ERSWYJRY6VFE4EKG7HZEDBRXQZMYO5X	HyCpvEEA6g4pOkqy1IdM14AAAAAAZJkotepXgvUNHV8Ni62QmLhystwG035VMCy9jjQ-Po4QCoPC6rpvIA5lEZEEUNVtLkYgIZTJX7z_SagmC8d2Ru2PuH3CpgMaqu5XFTITsahGFUgYE0LLpGQg-_B_2wOy0V4pwo0gtQOAxz2Hvw43ex6TnWM=	133
62	2023-06-26 05:57:26.652757+00	2023-06-26 05:57:26.652757+00	GD42R5RZ4UKKYYBDW5RL6ZSQ772YXQSFGYMXKHLU4RC2BP7JAQIUV7IW	Hapsw38yaMiLWoPPpK4Pc4AAAAAAZJkoxi6JpPX7Smgls9fBsO5hVjNkNVH6raojlZHeikU-cFnaMjSoFmJjD3REz_qVd8qi6Lf2gxiSv_z9A04Wzitup9JPWr9dBADFioAus-L8YZXHJ9XNnv8UPjM74vd_sEMevNjEkaWVCLvLiuMrWo2MdVQ=	134
63	2023-06-26 05:57:38.156056+00	2023-06-26 05:57:38.156056+00	GCHOB6TID2Z5VYPPD2QONCO2ANLWKBS6IEK7VPYOUKTTWNOMNAF22FY2	qISMCEq9jdK7lmaT-QVR-IAAAAAAZJko0u_lKfXm03GdF-edqaLScxH5LDzeyq5dqM_rFWeKec4rCW6e7WltzCM1uoWbyMvngw52Cz86-8U0-7mHXw7J4tmZBESkLypnumFDaKKtAGtjTeLAZZnaxZu4xPdmXDCfrAhabOm0N8AVHsFATzeLXiQ=	135
64	2023-06-26 21:28:12.42498+00	2023-06-26 21:28:12.42498+00	GCFEVKP4GOPGRTPPDSYPHOE6T3CNIW4BRLI5BJA754Z7BCJEJ3X6K4P4	ZQT-A0O2mhvA-x3xsJO0cYAAAAAAZJoC7GeHcgg0PSaSndUBxHE2DwrqOXu_ilaaQYmp1xhoxQ3yLUMGdgdFT279w7jhmq9c4_fXXMKYu5WfgIsKxUbDyARYJZ96ccuitXoi-K72jUVFyObsBhUX0U4eAzjzNN4scwUrotufCaxUDXM5IxXGR7o=	137
65	2023-09-03 16:57:05.625791+00	2023-09-03 16:57:05.625791+00	GCBAQEPMCMUFO6ILOBKBSQYWXZ273A35P3ZBGMXCIM5QXOMOFJTAZAHF	SCOPDDNWENNK7T4HI4AQHI7PVGQMQGQI3WZ4LGEA6KEDSQTIGK2YBV2W	111
66	2023-09-03 16:57:11.625019+00	2023-09-03 16:57:11.625019+00	GDG5XGFSZG46HEHCZBFIBMLXQFUNDML5X6AJMHNJFVVUAY6ZJRUCCPAZ	SDURDVWAYHAC64SXTI7V34IU46UI4KUOSD6TQ37TO5PW7KAFOTP4S3KO	112
67	2023-09-03 16:57:16.960129+00	2023-09-03 16:57:16.960129+00	GC7M4AAV44IPMLIFU45RG24773IU6PZ6D3JOGGDZ6UIJDWPW65EWZMWN	SDXTYQD6SWAGXNVKAF3T4CO64JPHTCG6WBMZHIJVJIXDSDMAD6TMUXU2	116
73	2023-09-03 17:00:20.625941+00	2023-09-03 17:00:20.625941+00	GDFRA3UN3AWJBDFWNVSGPEH5U5WX3D7VUTEIHKBCBB67A3HZZBYKUVES	SBIFO4ELTU2ANNXZ3CV3K2TVPRKJTZGOXAC2UAGTODSEFXGQRZCUNNLA	144
74	2023-09-03 17:00:25.959868+00	2023-09-03 17:00:25.959868+00	GCOM56FDUOMS6V7ZRQKA53VGONUF3QDTU6QUKML2TPOLL6LMYMD2HW4A	SBUWWEJPFO5TBESEKZVSIWJRDPAVYROU7XMQWZM7T7AN5DSQZTQN5DIT	147
75	2023-09-03 17:00:30.624552+00	2023-09-03 17:00:30.624552+00	GAMGNRBFFDXVI7TZBLBGZFZQK6OLH42CB5VNQEMEMV7R3ETTINRDDKWC	SCSC4SS7DHSY7DBJXBBL7K2P4L2PG2MMG7ISHPKYTLJCSYDPLAQQPB2I	150
76	2023-09-03 17:00:35.626341+00	2023-09-03 17:00:35.626341+00	GBJRWNK4L3TPI6HHTOBSEVZKC3RB6ZD3KXNWO7ICBTMZ7UWMQEHJE4CC	SAYSKX6MKLU7KXRV22LAOJQKNCDIZUSY3ZSYIATUIVP5MFRM2K5CYKCX	152
77	2023-09-03 17:01:02.626149+00	2023-09-03 17:01:02.626149+00	GCFMWZ2DRRV72VGF7XR7MGZN4OKP6CRJTLGTYIZJ4PF7UFJANW5BJSJN	SC3MPGVGICCD3UTAQTHOUV7BOTJGXETR2ZYMC2MXMG7VCCB6QJORPTYW	154
78	2023-09-03 17:01:08.961315+00	2023-09-03 17:01:08.961315+00	GBYHHEM4TBEEKG5J2CJWJNECU2JOVACOGIUV5P4FHT54AVFV3UV5HA4V	SCSYBKSB5SSU4NJSMUXYQQNS2FSA2X6IDCANP4JKTWLCZDSDW7ONG6NM	157
79	2023-09-03 17:01:14.625538+00	2023-09-03 17:01:14.625538+00	GDBCTL5YQCWT53SJZQ2UOJ7RNIANFL753CU5UYTZP7O3247VPSIQAX3T	SASBZ5LL2MIOHYUUG3ATXLFXDX5JTRCSUNS46V4PPQWIVAVVS2ILIMEO	160
80	2023-09-03 17:01:19.961476+00	2023-09-03 17:01:19.961476+00	GBP3CZAGI266UEOFOZUG65BCTOTGJXVGMIISQQCVOR4H4NP4ZRNWCG5Z	SCXQU4TYGPOJDGGXQQD2LEVTUC5AW2NFG5BQ4DIMKGU6J7KUNCUMW6IH	163
82	2023-09-10 07:54:57.807435+00	2023-09-10 07:54:57.807435+00	GAG5M4OBHW5SMSPEVOGSAWZ4TIQ22KNZ2OT4BM4GT7KI4TC7SLRLM6WU	e_7b3TKoQJNWKsdqokksJYAAAAAAZP12Ud1l6NOamf_egDhbr66h92GL5J0IPrBT2FnjI7qy_mZLeFrypVn4CykCK4JMkL9u53PkG_P8Nws43rCy4Ir26CZp-0F-Mw64fiH6v79yhUx_NOTyB7JiXDP0jiySAM7bN2pPPFveSnE3VFAXSGJJ_2Q=	266
83	2023-10-26 20:18:26.649078+00	2023-10-26 20:18:26.649078+00	GAE7F4LPL2MYTMWR3NKIZUR6KTW2QYD7XXQY7C767COTUL45Q475VKUM	3JYFyapKS0K8sI_sgrx21YAAAAAAZTrJktLsMJjDCjNya5wEXNgTyd5bHeETIuVdVZIcmzeKMoWL6e69-Y7DJSmPxtmEUKTJACtlUU7rIQjTxoOR3hbyGgAfL7gI_5IZyqt7Bz3fYrkqqUWA_n4-ZHymRV7l69QM2x4rbjNyM3zwAQvP7DEhBF8=	318
84	2023-10-27 10:11:20.861535+00	2023-10-27 10:11:20.861535+00	GCMSQ7PB7IUDHYLV2TMHIYXVR7DWL4WERLD4NNVJJDRGOU6OEBALIHGP	iWEzrWNw23rr871ZCM9X-IAAAAAAZTuMyJBTtiLEDES_TwKQbDwjq-zmeOiZkPI9i64URwQBwfZ1DATDNnybiWaYiY6c7gPhVvfECHoVXmfstVuguBXLzDOWVzuivdAmUKZGTVKiC0r2AagHFvZdeF1DZZtx6RKl7-e5HGEgYqAeBnn8g_BFZgE=	196
85	2023-11-01 18:00:58.458386+00	2023-11-01 18:00:58.458386+00	GBPJ3NDJVX3QTP77P72WBCV2LO7ABQCEO6XGMDKRZBFVUZXBHQXDB5KR	nCM6wY3Fc-VikfhG8Cy1WoAAAAAAZUKSWnvnEMIcsJyboeANZtvV1h04FtKCx6d4OlkrHY87_HGv4CxlCIop0U5A2waE1E1Lsp8Xz1qEZZF-A2sSKUEN69jhq0DhdWIPU59Y1XD_knGgZ4aSz1JLs9hA5eBa6sV6_0NQjB4Sk-f305gtsfR_i0k=	324
\.


--
-- Data for Name: users_fiscalresidence; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_fiscalresidence (id, created, modified, street_address, city, postal_code, state, country, user_id) FROM stdin;
1	2022-08-28 02:40:40.308654+00	2022-08-28 02:40:40.308654+00	Condominio Cumbres de la Arboleda, manzana 7 casa 5	Fraijanes	01014	Guatemala	GT	20
3	2022-09-09 16:15:02.476076+00	2022-09-09 16:15:02.476076+00	Calle Pleamar 39. Door 44	Almerimar	04711	Almería	ES	4
4	2022-09-27 09:48:33.849552+00	2022-09-27 09:48:33.849552+00	Fake street, 25	Ibiza	07800	Islas Baleares	ES	25
5	2022-09-27 10:41:36.1778+00	2022-09-27 10:41:36.1778+00	Cooperativa Caucia 3	Coca	40480	España	ES	24
6	2022-09-27 11:10:25.32631+00	2022-09-27 11:10:25.32631+00	Calle Fuencarral 133, 4D	MADRID	28010	MADRID	ES	26
7	2022-09-29 10:15:14.480451+00	2022-09-29 10:15:14.480451+00	Cooperativa Caucia 3	Coca	40480	Segovia	ES	28
8	2022-09-29 15:42:31.965396+00	2022-09-29 15:42:31.965396+00	Cooperativa Caucia 3	Coca	40480	Segovia	ES	23
9	2022-10-01 07:32:57.167894+00	2022-10-01 07:32:57.167894+00	calle Doce de Octubre 2	Santa María de la Alameda (Estación)	28296	MADRID	ES	29
10	2022-10-01 07:32:57.197516+00	2022-10-01 07:32:57.197516+00	CALLE NARDOS 23 CHALET 15	LAS NAVAS DEL MARQUES	05230	AVILA	ES	29
11	2022-10-14 10:35:39.457893+00	2022-10-14 10:35:39.457893+00	EL JUNCAL 11 Bjo B	Loredo	39160	Cantabria	ES	39
12	2022-12-12 07:35:41.804023+00	2022-12-12 07:43:14.497185+00	Rúa Rosalía de Castro 1, 2ºH	O Temple	15679	A Coruña	ES	61
13	2023-01-03 12:27:28.183001+00	2023-01-03 12:27:28.183001+00	Avinguda Verdaguer 43, 2°1°	La Pobla de Segur	25500	Lleida	ES	65
14	2023-01-30 17:22:04.336633+00	2023-01-30 17:22:04.336633+00	Calle de la Legion 11 - Ático Puerta O	Ceuta	51001	España	ES	69
15	2023-01-30 17:30:58.15598+00	2023-01-30 17:30:58.15598+00	Cooperativa Caucia 3	Coca	40480	España	ES	70
16	2023-02-27 15:35:39.479123+00	2023-02-27 15:35:39.479123+00	carrer Pintor Dozeman, 36	Santa Cristina d'Aro	17246	Girona	ES	74
17	2023-03-30 10:21:17.790784+00	2023-03-30 10:21:17.790784+00	Cooperativa Caucia 3	Coca	48989	España	ES	78
18	2023-03-31 10:31:20.791307+00	2023-03-31 10:31:20.791307+00	Calle Ana Frank, 69 , 3ºC	Valdemoro	28342	Madrid	ES	79
19	2023-04-11 07:19:46.374211+00	2023-04-11 07:19:46.374211+00	CALLE GUISANDO, 50	MADRID	28035	MADRID	ES	80
20	2023-04-16 01:14:35.625535+00	2023-04-16 01:14:35.625535+00	Cooperativa Caucia 3	Coca	40480	Segovia	ES	82
21	2023-04-26 14:10:58.60676+00	2023-04-26 14:10:58.60676+00	Calle Real nr. 55 , bajo C	Las Rozas de Madrid	28231	Madrid	ES	84
22	2023-05-03 10:52:25.456698+00	2023-05-03 10:52:25.456698+00	calle real 55,bajo c	las rozas de madrid	28231	Madrid	ES	85
23	2023-05-09 10:19:33.763822+00	2023-05-09 10:19:33.763822+00	Calle Real nr. 55 , bajo C	Las Rozas de Madrid	28231	Madrid	ES	86
24	2023-05-25 15:55:32.263028+00	2023-05-25 15:55:32.263028+00	Ares del Maestrat 9 pta 50	Paterna	46980	Valencia	ES	89
25	2023-05-31 05:28:10.095457+00	2023-05-31 05:28:10.095457+00	Calle placido fernandez viagas 30	Valverde del Camino	21600	Huelva	ES	90
26	2023-06-09 11:30:35.03261+00	2023-06-09 11:30:35.03261+00	Calle de Llucena 7d	Moncofa	12593	Castellón	ES	87
27	2023-06-12 10:51:03.696204+00	2023-06-12 11:00:50.377739+00	Col Los Angeles Frente Estadio Los Angeles	Tegucigalpa	11101	Francisco Morazán	HT	93
28	2023-06-13 16:01:50.103377+00	2023-06-13 16:01:50.103377+00	c/ Gorbea 35	Legutio	01170	Álava	ES	96
29	2023-06-13 16:50:25.898088+00	2023-06-13 16:50:25.898088+00	Gabolatz Kalea, 5B-2 Dch.	Soraluze	20590	Gipuzkoa	ES	116
53	2023-06-26 21:43:37.434757+00	2023-06-26 21:43:37.434757+00	Cooperativa Caucia 3	Coca	40480	Segovia	ES	138
30	2023-06-13 18:36:39.140738+00	2023-06-13 18:44:30.109086+00	C/ Juana de Ibarborou 8, 3*C	Zaragoza	50013	Zaragoza	ES	101
31	2023-06-13 19:04:24.180051+00	2023-06-13 19:04:24.180051+00	Calle Juana de Ibarborou,8, 3ºC	Zaragoza	50013	Zaragoza	ES	113
32	2023-06-13 22:14:17.456504+00	2023-06-13 22:14:17.456504+00	ARANA, 28,1C	VITORIA-GASTEIZ	01002	ALAVA	ES	99
33	2023-06-14 11:55:51.499731+00	2023-06-14 11:55:51.499731+00	Calle Ego -gain n20 6A	Eibar	20600	Guipúzcoa	ES	120
34	2023-06-14 14:04:27.677953+00	2023-06-14 14:04:27.677953+00	Calle Maria Victoria 27	Hoyo de Manzanares	28240	Madrid	ES	119
35	2023-06-14 22:22:06.425978+00	2023-06-14 22:22:06.425978+00	C/BARRIONUEVO 4	AJALVIR	28864	MADRID	ES	109
36	2023-06-15 09:08:16.712822+00	2023-06-15 09:08:24.904318+00	Poboado da Magdalena C2, 4ºD	As Pontes de García Rodríguez	15320	A Coruña	ES	118
37	2023-06-15 09:14:26.00435+00	2023-06-15 09:14:26.00435+00	Urb. Los Lagos, Sierra de Gredos 3	Alcolea	14610	Córdoba	ES	98
54	2023-06-27 08:27:57.290057+00	2023-06-27 08:27:57.290057+00	qq	qq	qq	va	BB	92
55	2023-06-27 09:31:22.015475+00	2023-06-27 09:31:22.015475+00	Cooperativa Caucia 3	Coca	40480	Segovia	ES	139
56	2023-06-27 09:38:03.560417+00	2023-06-27 09:38:03.560417+00	Cooperativa Caucia 3	Coca	40480	Segovia	ES	140
39	2023-06-18 14:57:48.222696+00	2023-06-18 14:57:48.222696+00	C/ La Badina 70	Murchante	31521	Navarra	ES	121
40	2023-06-18 17:50:23.283221+00	2023-06-18 17:50:23.283221+00	alboraya nº 16 pº1	Tavernes Blanques	46016	Valencia	ES	122
41	2023-06-19 10:51:38.831326+00	2023-06-19 10:51:38.831326+00	Cooperativa Caucia 3	Coca	40480	Segovia	ES	123
42	2023-06-19 12:05:42.405406+00	2023-06-19 12:05:42.405406+00	Cooperativa Caucia 3	Coca	40480	Segovia	ES	124
43	2023-06-20 11:02:50.240816+00	2023-06-20 11:02:50.240816+00	Passeig Circumval.lacio, 38	SANT PERE DE RIBES	08810	BARCELONA	ES	100
44	2023-06-21 09:57:23.56166+00	2023-06-21 09:57:23.56166+00	c/ Calamocha n.11	Madrid	28021	Madrid	ES	125
45	2023-06-21 11:03:59.306965+00	2023-06-21 11:03:59.306965+00	Cooperativa Caucia 3	Coca	40480	Segovia	ES	131
46	2023-06-21 11:06:58.026645+00	2023-06-21 11:06:58.026645+00	Cooperativa Caucia 3	Coca	40480	Segovia	ES	132
47	2023-06-21 17:27:11.321387+00	2023-06-21 17:27:11.321387+00	Paseo Región murciana, 40 1ºC	El Palmar	30120	Murcia	ES	133
48	2023-06-21 17:31:41.209337+00	2023-06-21 17:31:41.209337+00	PS MAS ESTRUC 4    ( URB SURO DE LA CREU)	SANTA CRISTINA D´ARO	17246	GIRONA	ES	134
57	2023-07-11 18:42:52.891314+00	2023-07-11 18:42:52.891314+00	Calle Rosa De Lima 7	Las Rozas	28290	Madrid	ES	144
58	2023-07-13 15:27:24.734154+00	2023-07-13 15:27:24.734154+00	Barrio Irure 10	Soraluze	20590	Gipuzkoa	ES	115
49	2023-06-22 10:06:48.355878+00	2023-06-22 10:08:31.238126+00	C/ Naranjo de Bulnes nº16 1ºE	Lugo de Llanera	33690	Asturias	ES	135
50	2023-06-22 20:28:36.713791+00	2023-06-22 20:28:36.713791+00	C/ HIPÓCRATES 27	FUENLABRADA	28942	MADRID	ES	126
51	2023-06-23 09:17:54.411489+00	2023-06-23 09:17:54.411489+00	Pasaje Juan de Reina 2 bajo izquierda	Huelva	21006	Huelva	ES	136
52	2023-06-26 21:14:59.980274+00	2023-06-26 21:14:59.980274+00	Cooperativa Caucia 3	Coca	40480	Segovia	ES	137
59	2023-07-13 16:57:26.455122+00	2023-07-13 16:57:26.455122+00	Calle Téllez 30 Esc 8 Plante 7 Pta 2	Madrid	28007	Madrid	ES	110
60	2023-07-13 16:57:36.134401+00	2023-07-13 16:57:36.134401+00	Calle Téllez 30 Esc 8 Plante 7 Pta 2	Madrid	28007	Madrid	ES	110
61	2023-07-13 19:27:01.841438+00	2023-07-13 19:27:01.841438+00	C/ Pura Bascarán, 3 - 4º C	Las Palmas de Gran Canaria	35004	Las Palmas	ES	106
62	2023-07-14 05:31:11.272471+00	2023-07-14 05:31:11.272471+00	C/ Juan Bautista Monegro 10. Portal 7. 4 A	TORREJON DE ARDOZ	28850	Madrid	ES	108
63	2023-07-14 13:45:25.080842+00	2023-07-14 13:45:25.080842+00	Sierra Nevada,  23	LAS ROZAS DE MADRID	28290	Madrid	ES	111
64	2023-07-15 09:50:00.53314+00	2023-07-15 09:50:00.53314+00	C/ Doctor landa 3,1 G	Sopelana	48600	Vizcaya	ES	147
65	2023-07-15 12:10:50.571656+00	2023-07-15 12:10:50.571656+00	CALLE MESENA 56  1B	Madrid	28033	MADRID	ES	146
66	2023-07-15 15:32:14.569138+00	2023-07-15 15:32:14.569138+00	Calle Calderón de la Barca 1, 4º C	Alcobendas	28100	Madrid	ES	150
67	2023-07-15 17:28:10.974761+00	2023-07-15 17:29:03.640241+00	C/Txorierri,6,1dch	Leioa	48940	Vizcaya	ES	105
68	2023-07-17 09:07:16.323287+00	2023-07-17 09:10:00.757543+00	La Badina 70	Murchante	31521	NAVARRA	ES	107
69	2023-07-17 09:26:47.104979+00	2023-07-17 09:26:47.104979+00	Juana de ibarbourou n°8 3°C	Zaragoza	50013	Zaragoza	ES	112
71	2023-07-17 14:38:37.742637+00	2023-07-17 14:43:14.097276+00	Avda. Maresme 451- 4 -1	MATARÓ	08301	Barcelona	ES	148
72	2023-07-18 07:39:14.786755+00	2023-07-18 07:39:14.786755+00	camiño fontela 110 (coruxo)	vigo	36331	pontevedra	ES	152
70	2023-07-17 14:38:37.720619+00	2023-07-17 14:43:14.069505+00	Avda. Maresme 451- 4 -1	MATARÓ	08301	Barcelona	ES	148
73	2023-07-18 12:07:02.365938+00	2023-07-18 12:07:02.365938+00	c Hernán Cortés n5	Lepe	21440	Huelva	ES	171
74	2023-07-18 12:09:27.85101+00	2023-07-18 12:10:02.465953+00	C/ Hernán cortes N 5	Lepe	21440	Huelva	ES	173
76	2023-07-18 16:17:17.479459+00	2023-07-18 16:17:17.479459+00	Aginaga Auzoa 19, Mendibil Baserria	Eibar	20600	Gipuzkoa	ES	179
77	2023-07-18 16:45:05.035065+00	2023-07-18 16:45:05.035065+00	Vidal I Codina, 33 piso 4 puerta 1	Lleida	25005	Lleida	ES	154
78	2023-07-18 19:01:38.351658+00	2023-07-18 19:01:38.351658+00	Santa Ana 12 2b	Soraluce/ Placencia de las Armas	20590	Guipúzcoa	ES	167
79	2023-07-19 17:46:19.451588+00	2023-07-19 17:46:19.451588+00	Enric pubill lo parrano N 4 -1 b	Lleida	25005	Lérida	ES	183
80	2023-07-20 14:35:56.310115+00	2023-07-20 14:35:56.310115+00	Carretera del Norte 36 5A	Las Palmas	35013	Las Palmas de Gran Canaria	ES	185
82	2023-07-20 16:55:05.19608+00	2023-07-20 16:59:24.78475+00	angel guimera 90, baj	hospitalet del llobregat de	08902	Barcelona	ES	188
83	2023-07-20 18:33:56.307127+00	2023-07-20 18:33:56.307127+00	Estrada de Benfica 350 - 5 B	Lisboa	1500-098	Estremadura	PT	165
84	2023-07-20 19:00:21.899035+00	2023-07-20 19:00:21.899035+00	Santa Ana 12B	Soraluce - Placencia de las armas	20590	Guipuzcoa	ES	158
85	2023-07-21 09:28:22.80993+00	2023-07-21 09:28:22.80993+00	JCalle Ingeniero Francisco Ugarte 155 Colonia Arcos Sur	Guadalajara	44500	Jalisco	MX	189
86	2023-07-26 09:56:09.389144+00	2023-07-26 09:56:09.389144+00	Doctor Fleming 26	Lepe	21440	Huelva	ES	172
87	2023-07-27 14:11:11.517847+00	2023-07-27 14:11:11.517847+00	Santa Barbara 8	Colmenar viejo	28770	Madrid	ES	186
88	2023-07-27 19:00:20.744999+00	2023-07-27 19:00:20.744999+00	C/PEDRERA, 14	LORA DE ESTEPA	41564	Sevilla	ES	168
89	2023-07-28 12:01:43.424072+00	2023-07-28 12:01:43.424072+00	Avenida de Europa 23 portal 8 1⁰B	Pozuelo de Alarcón	28224	Madrid	ES	190
90	2023-07-28 19:33:17.020122+00	2023-07-28 19:33:17.020122+00	Estrada Velha de Queluz, 34-1° Dto	AMADORA	2700-838	Lisboa	PT	157
91	2023-07-28 20:47:20.87019+00	2023-07-28 20:47:20.87019+00	Rekalde 3	Soraluze	20590	Guipuzcoa	ES	163
92	2023-07-29 12:10:15.034424+00	2023-07-29 12:10:15.034424+00	Estrada de Velha Queluz n34, 1-Dto	Amadora	2700-838	Lisboa	PT	164
93	2023-07-31 17:20:25.703399+00	2023-07-31 17:20:25.703399+00	Barrio Irure 10	Soraluze	20590	Gipuzkoa	ES	178
94	2023-07-31 18:50:17.475174+00	2023-07-31 18:50:17.475174+00	Erdiko karrika, 1	Aizarotz	31866	Nafarroa	ES	155
95	2023-08-03 18:02:35.682815+00	2023-08-03 18:02:35.682815+00	C/Sancho Panza 4	Carranque	45216	Toledo	ES	191
96	2023-08-09 14:00:32.809741+00	2023-08-09 14:01:50.540759+00	La Pau	Segur de Calafell	43882	Tarragona	ES	174
97	2023-08-17 13:00:44.442189+00	2023-08-17 13:00:44.442189+00	La Pau 31	Segur de Calafell	43882	Tarragona	ES	193
98	2023-08-17 13:00:44.523319+00	2023-08-17 13:00:44.523319+00	La Pau 31	Segur de Calafell	43882	Tarragona	ES	193
99	2023-08-17 19:52:38.453069+00	2023-08-17 19:52:38.453069+00	567 Catalina Dr Apt A, Camarillo, CA.	Condado Ventura	93010	California	US	184
100	2023-08-28 07:06:12.095787+00	2023-08-28 07:06:12.095787+00	Cooperativa Caucia 3	Coca	40480	Segovia	ES	196
114	2023-09-04 20:33:10.749206+00	2023-09-04 20:33:10.749206+00	Calle uno	Valencia	32654	valencia	ES	230
115	2023-09-05 21:37:00.246278+00	2023-09-05 21:37:00.246278+00	Cooperativa Caucia 3	Coca	40480	Segovia	ES	263
117	2023-09-06 07:32:37.623627+00	2023-09-06 07:32:37.623627+00	Calle Doctor Zamenhoff	Valencia	46008	Valencia	ES	266
118	2023-09-06 08:47:28.655829+00	2023-09-06 08:47:28.655829+00	El Atazar, 5, 2ºI	Madrid	28045	Madrid	ES	267
119	2023-09-06 11:00:42.956066+00	2023-09-06 11:00:42.956066+00	Calle Pardela, 2	La Oliva	35660	Las Palmas	ES	268
139	2023-10-18 22:34:35.338327+00	2023-10-18 22:34:35.338327+00	Calle Maltes	Madrid	28008	Madrid	ES	324
120	2023-09-15 14:38:25.351576+00	2023-09-17 22:20:07.55687+00	Calle Honduras 23	Valdemoro	28341	Madrid	ES	13
121	2023-09-21 15:14:08.85494+00	2023-09-21 15:14:08.85494+00	Rosalia de Castro nº1  piso 2ºH,	Cambre	15679	A Coruña	ES	273
122	2023-09-27 22:51:33.791876+00	2023-09-27 22:51:33.791876+00	6031 S Kolmar Ave	Chicago	60629	Illinois	US	166
123	2023-09-27 23:08:20.413138+00	2023-09-27 23:08:20.413138+00	6031 S Kolmar Ave	Chicago	60629	Illinois	US	182
124	2023-09-27 23:11:34.498384+00	2023-09-27 23:11:34.498384+00	Sofora	Madrid	28020	Madrid	ES	277
125	2023-09-28 07:03:19.668835+00	2023-09-28 07:03:19.668835+00	Barrenkalea 28, 1	Bergara	20570	Gipuzkoa	ES	279
126	2023-09-28 09:02:08.824106+00	2023-09-28 09:02:08.824106+00	Zeleta 1	Soraluze	20590	Guipúzcoa	ES	156
127	2023-09-28 12:59:35.831448+00	2023-09-28 12:59:35.831448+00	Ctra Barriks a Sopelana N10 - 1IZq	Barrika	48650	Bizkaia	ES	159
128	2023-09-28 15:35:43.662811+00	2023-09-28 15:35:43.662811+00	Avenida de Madrid 4	Zaragoza	50004	Zaragoza	ES	276
130	2023-09-28 22:51:02.872914+00	2023-09-28 22:51:02.872914+00	Txurruken	Soraluze	20590	Gipuzkoa	ES	282
131	2023-09-29 11:54:26.316729+00	2023-09-29 11:54:26.316729+00	Avd Peset Aleixandre 19 bj	Godella	46110	valencia	ES	289
132	2023-09-30 18:57:40.795422+00	2023-09-30 18:57:40.795422+00	calle veinticinco n 12 urb. guadalcantara Golf-bl 1 portal 2 bajo F	san pedro de alcantara	29667	Malaga	ES	290
133	2023-10-02 09:45:55.039038+00	2023-10-02 09:45:55.039038+00	Hortaleza 18	Madrid	28004	Madrid	ES	291
134	2023-10-02 19:08:49.990799+00	2023-10-02 19:08:49.990799+00	calle plaza olmo 1	tebar (cuenca)	16710	CUENCA	ES	153
81	2023-07-20 15:45:24.236427+00	2023-10-11 18:20:31.413691+00	C/. Egipto n°3- 2°D	Móstoles	28938	Madrid	ES	160
136	2023-10-18 10:23:10.112147+00	2023-10-18 10:23:10.112147+00	C/ Japón 16 8º 1	Alcorcón	28923	Madrid	ES	318
137	2023-10-18 10:24:36.00119+00	2023-10-18 10:24:36.00119+00	Castelao 1, 5ºF	Burela	27880	Lugo	ES	316
138	2023-10-18 13:52:45.827102+00	2023-10-18 13:52:45.827102+00	Alosa, 18	Piera	08784	Barcelona	ES	313
140	2023-10-19 10:42:48.278547+00	2023-10-19 10:42:48.278547+00	Magdalena,63.1°k	Villaviciosa	33300	Asturias	ES	326
141	2023-10-22 22:12:01.00428+00	2023-10-22 22:12:01.00428+00	President Lluís Companys 27	Sant Feliu de Guíxols	17220	Girona	ES	332
142	2023-10-23 11:22:46.84907+00	2023-10-23 11:22:46.84907+00	ESTOCOLMO,10	MALAGA	29630	ESPAÑA	ES	333
143	2023-10-23 14:33:28.555546+00	2023-10-23 14:33:28.555546+00	Sopela Barrika errepidea 10	BARRICA	48650	Bizkaia	ES	170
144	2023-10-23 16:20:59.774441+00	2023-10-23 16:20:59.774441+00	Avd. Tarragona 52,2° 3°	Vilafranca del Penedès	08720	Barcelona	ES	334
145	2023-10-23 16:31:22.116954+00	2023-10-23 16:31:22.116954+00	C/ Juan Bautista Monegro 10.P 7. 4A	Torrejon de ardoz	28850	Madrid	ES	145
146	2023-10-24 10:20:22.847905+00	2023-10-24 10:20:22.847905+00	Avda. Tres Forques, 11, pta. 21	Valencia	46018	Valencia	ES	310
152	2023-10-24 19:19:21.386751+00	2023-10-24 19:19:21.386751+00	av conde soto ameno 51 1a	Alicante	03005	Alicante	ES	177
129	2023-09-28 17:09:35.307336+00	2023-10-26 20:11:46.600592+00	Faraon    bloque 1     plata 2   puerta D	Malaga	29014	Malaga	ES	278
153	2023-10-27 16:20:22.889658+00	2023-10-27 16:20:22.889658+00	Numancia, 77, esc. Izq. 5°B	Barcelona	08029	Barcelona	ES	331
154	2023-10-27 22:35:03.097511+00	2023-10-27 22:35:03.097511+00	Calle Óbolo n°29 2°A	Madrid	28054	Madrid	ES	321
155	2023-10-28 16:58:19.184884+00	2023-10-28 16:58:19.184884+00	Irure auzoa 10	Soraluze	20590	Gipuzkoa	ES	336
156	2023-10-29 11:33:35.53827+00	2023-10-29 11:33:35.53827+00	C. Bruc	Vilanova i la Geltru	08800	Barcelona	ES	337
157	2023-10-29 23:37:03.227757+00	2023-10-29 23:37:03.227757+00	Pinzón 18-4°A	Gijón	33213	Asturias	ES	330
75	2023-07-18 12:58:15.588479+00	2023-10-30 10:08:58.706579+00	Polígono 19 parcela 135	Mondéjar	19110	Guadalajara	ES	175
158	2023-10-30 11:01:19.127896+00	2023-10-30 11:01:19.127896+00	Calle Héroes 2 de Mayo Muriedas	Cantabria Muriedas	39600	Cantabria	ES	328
135	2023-10-07 08:07:30.427203+00	2023-10-31 12:12:36.389185+00	Villaveza 7, 2do Centro	Madrid	28021	Madrid	ES	192
159	2023-10-31 17:31:04.848909+00	2023-10-31 17:31:04.848909+00	Platería, 5, 1º D	Valladolid	47003	Valladolid	ES	339
160	2023-11-02 10:12:53.063753+00	2023-11-02 10:12:53.063753+00	Pasaje Escritor Diego Simancas	Córdoba	14010	Córdoba	ES	275
161	2023-11-03 15:59:48.387972+00	2023-11-03 15:59:48.387972+00	Mayor, 24	Madrid	28013	Madrid	ES	297
162	2023-11-04 09:29:13.903546+00	2023-11-04 09:29:13.903546+00	rafael casanova,6	sant vicenç dels horts	08620	Barcelona	ES	342
163	2023-11-09 06:46:51.451128+00	2023-11-09 06:46:51.451128+00	Estasio Kalea 9, 1. B	Soraluze, Gipuzkoa	20590	España	ES	114
164	2023-11-10 19:29:27.850496+00	2023-11-10 19:29:27.850496+00	Camarena, 172, 1-4	Madrid	28047	Madrid	ES	307
165	2023-11-15 14:57:39.652511+00	2023-11-15 14:57:39.652511+00	Cooperativa Caucia 3	Coca	40480	Segovia	ES	9
166	2023-11-20 19:13:50.008047+00	2023-11-20 19:13:50.008047+00	Ronda de Atocha 16, esc izda. 1ºA	Madrid	28012	Madrid	ES	345
\.


--
-- Data for Name: users_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_user (id, password, last_login, is_superuser, email, first_name, last_name, is_staff, is_active, date_joined, restore_password_code, restore_password_code_requested_at, is_email_verified, verification_code, newsletter, two_factor, two_factor_code, two_factor_code_created, phone, birthday, id_document_image_back, id_document_image_front, id_document_image_me, id_document_number, id_document_type, nationality, status, is_blocked, is_canceled, deleted_date, is_deleted, type, marital_status, profession, cod) FROM stdin;
129	argon2$argon2id$v=19$m=102400,t=2,p=8$ODVqbThDV3VOZkkyU01yUW0zc01TdQ$4JTsL5OoVhFRWZ8CWiWiUw	\N	f	kimmdamm@gmail.com	PILAR	TOBARIAS AVELLANEDA	f	t	2023-06-20 21:30:07+00	\N	\N	f	7780dc08defc3780de75036c908fd76bd520dca46bebd4c4ee41fbf285781516197900708b270cce3ceb070c94038df727c1b6012a6257f63116e88ca5fa0430	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_129
274	argon2$argon2id$v=19$m=102400,t=2,p=8$ZXcycHJLaFJ2aHVlMDd2S3JkN2FJVg$SNMNN9F1QlYx5VslGtNQng	\N	f	gg@pecprojects.com	ginés	guillén	f	t	2023-09-22 15:24:46.843728+00	\N	\N	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
13	argon2$argon2id$v=19$m=102400,t=2,p=8$TkRaWllqN0p4TU51S3Z0dHpiNEFsWQ$45EonP55S0GdtSX5WlQtiA	2023-09-14 11:21:13+00	f	vcallejo@blockimpulse.com	Victor	Callejo González	t	t	2022-08-09 14:49:20+00	3b08cac07ee7746715cfb56b4c225156220fdbd337b0906fc81d68a53e330deaff3502025841930b46c10f88d25a1e510459b90c88923e31316b9bc8fb0149ea	2022-08-09 14:49:20.370237+00	t	\N	f	f	\N	\N	+34644166710	1997-12-29			id_documents_me/87041e829791d83111670652feadadf5e7989bfaa3336a89f0a111dc6d574de8.jpg	50727027K	dni	ES	validated	f	f	\N	f	legal	divorced	\N	pf_13
5	argon2$argon2id$v=19$m=102400,t=2,p=8$d2Q1aEhCZXlJckxHN3hvdHkwRWZaUA$VCQcp8y13WgGNSpYmVCyhw	\N	f	adngarde19@gmail.com	David	Navas	f	t	2022-07-31 16:56:25+00	7bc8e171f24f61ce08427402fd51e77967d83c9c7064da99928b7b3c66d07a926cc93ce61c7c750f1c0ef9b5fb05f5e75799b14117b449fdfe2423f2165d1231	2023-11-04 15:32:46.962212+00	t	\N	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_5
9	argon2$argon2id$v=19$m=102400,t=2,p=8$Y3ozdUNQbWQxSnQwZ0lnVUxZc1BDbg$vft+h1KcrHUATkMvhjf2Qg	\N	f	admin@claddingprices.com	Victor	Callejo Gonzalez	f	t	2022-08-09 14:41:01+00	750857457c565cbabf589b9b07d56e2486f725f41a8c6f920dd1daeeb014c3ce51958979a825643f4ca38823eb43d08dfba87d2326a449619cb479b89bc522c4	2022-08-09 14:41:01.891679+00	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	validated	f	f	\N	f	legal	\N	\N	pf_9
2	argon2$argon2id$v=19$m=102400,t=2,p=8$QndpeTl1WFZYZGI1MXBWNkpaM3VDRg$LzMiXFBQXOKLcFZjcjAhvw	\N	f	mgomez@vottun.com	Aniol	Carbo	f	t	2022-07-18 11:09:49+00	\N	\N	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_2
3	argon2$argon2id$v=19$m=102400,t=2,p=8$a1ptOWtEcDdGa2JVWmRxVlRIYWJrcg$T0dbaxjnrDIjnXaUPv9JNw	\N	f	snapmiguelav@gmail.com	Angel	Perez	f	t	2022-07-18 22:12:22+00	\N	\N	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_3
6	argon2$argon2id$v=19$m=102400,t=2,p=8$dEVyR1RUdDJTTVRhSDBlZ1dxa3VkdQ$Wp/FkYLPhFDo/4gWzdsWDQ	\N	f	definitive.agency@gmail.com	Oriol	Tarrago	f	t	2022-08-04 20:41:02+00	\N	\N	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_6
8	argon2$argon2id$v=19$m=102400,t=2,p=8$aDBHd1k4bWVIVVZJOGpzcjhWRHA2UA$531QebRA5EfEsbi+qC7BVw	\N	f	ernestoesc85@gmail.com	Ernesto	Escalona Rando	f	t	2022-08-08 17:37:06+00	\N	\N	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	legal	\N	\N	pf_8
10	argon2$argon2id$v=19$m=102400,t=2,p=8$UW0zTXV6blNtT3JDdEpaMHVQRlB0WQ$uiefuiUDRltTA/0DKgJ0eg	\N	f	r@whitebear.trading	Rafael	del Castillo Ionov	f	t	2022-08-09 14:42:04+00	7d75694bcf20a447a591d0d1afadffb66742ead4f4df72d73bd3e3d91025e334221a56f91322ffccb79a029e8c83cdbaa5ccb4198a78b53d8cd79f305d613d75	2022-08-09 14:42:04.181196+00	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	validated	f	f	\N	f	legal	\N	\N	pf_10
11	argon2$argon2id$v=19$m=102400,t=2,p=8$eW5YQ3NMZFJzQkdpMVlZeWw3am02RA$9YOT49ButBUnVxt5LgjPmg	\N	f	david.ramon.riera@gmail.com	David	Ramon Riera	f	t	2022-08-09 14:43:22+00	fa83c5c0f5ed58dc5ec26ae467fa0121e7477179fa5a676e7dd96fba7034d40f692e8a82330509fe6172459b839dbf45fd676ce5576bfd3dc988cdb298dbf34f	2022-08-09 14:43:23.000207+00	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	validated	f	f	\N	f	legal	\N	\N	pf_11
12	argon2$argon2id$v=19$m=102400,t=2,p=8$ek0zdE9BSjZ3dXVSNHBZRUtaSUZpaA$SOB0ciK/9v17vVMcWUK+2A	\N	f	jflores@email4job.com	Jose	Flores	f	t	2022-08-09 14:46:04+00	a73c993727b39bfec73a72e02b08639bd5bac660ce069082a227cfa9b3f631090ebfc680f8111e78d0e877f3ca2bfe5a5cd50e5cebba6960b60bb53874226000	2022-08-09 14:46:04.953104+00	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	validated	f	f	\N	f	legal	\N	\N	pf_12
14	argon2$argon2id$v=19$m=102400,t=2,p=8$SW9iYlFvU1pZZHQ0R3JmS2dyUzd5RA$IWI3FA8vYhqXKre0Iiw7/Q	\N	f	barbatusaeronautics@gmail.com	Marcos Antonio	Vila Cañellas	f	t	2022-08-09 17:58:42+00	b8e788a69665ba90a73b921ac422a2e326eb3040dff10beae7f5685b5678252a3ee2557e847bfac8cf0ae0f0cf881246ccb757803e9d96dd6110db56570cdd00	2022-10-05 14:44:48.861332+00	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	validated	f	f	\N	f	legal	\N	\N	pf_14
15	argon2$argon2id$v=19$m=102400,t=2,p=8$S0kxeGJ4MEhlTkV5VGFrZ214Wmo3eQ$EL83ucmnbHhI+wz3kwZiqg	\N	f	javier@tierra.audio	Javier	Pascual Soriano	f	t	2022-08-09 18:07:57+00	16d26d5942b9a81e8d008c876dc11d1d125009bfbeb2abf629e6e398bb92493b0cef3526f643b566fccfa23d18a00ce634ad299aa8beacf9b35fa49d5d9bc3f1	2022-08-09 18:07:57.892686+00	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	validated	f	f	\N	f	legal	\N	\N	pf_15
16	argon2$argon2id$v=19$m=102400,t=2,p=8$cThLbHBpYmVsU3RjeVJKcmdxNFdEWg$QkWU5UzpenvywrSJWfSakw	\N	f	jmbarbancho@inmobiliariabarin.com	juan miguel	barbancho cornejo	f	t	2022-08-18 06:43:53+00	\N	\N	t	\N	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_16
17	argon2$argon2id$v=19$m=102400,t=2,p=8$ODVmMGRIa0E0dWpBOEdkUWZ6eE1ZbA$3Rn3uSZIpWEeDLzFMMHirg	\N	f	marcosolvg@gmail.com	Marcos	Revilla García	f	t	2022-08-18 12:59:30+00	\N	\N	t	\N	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_17
18	argon2$argon2id$v=19$m=102400,t=2,p=8$OE9LQkJmZndUb2FnajFpdHQ4enpJcQ$ULtg5In0gzwHemt32kIjJQ	\N	f	100432408@alumnos.uc3m.es	omar	voos	f	t	2022-08-19 21:48:39+00	\N	\N	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_18
19	argon2$argon2id$v=19$m=102400,t=2,p=8$bjFKZ2wwZWhreWN4SFlOaThDNFNQNg$TROQDL2Y2YFaydKY00Zgjw	\N	f	alexa.daniela.2710@gmail.com	Daniela	Castro sosa	f	t	2022-08-24 23:10:50+00	\N	\N	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_19
20	argon2$argon2id$v=19$m=102400,t=2,p=8$NXlJb3phYnU1MUpPVmR1SkZlR3RPUw$IM4SlW7BwKzP1hPGcOnNQA	\N	f	alexander.a.herrera.c@gmail.com	Alexander	Herrera	f	t	2022-08-28 02:30:44+00	\N	\N	t	\N	t	f	\N	\N	+502 4119 3655	1972-01-16	id_documents_back/79e22928881bd85e54cb4744566b4dfd117fcfede9f6c776817f62929ef36f2e.jpg	id_documents_front/1acfcd1709b5ecfb3233ece211fd5abfde0a30159f655bb7def285c5ca733f81.jpg	id_documents_me/268314193de8a598c02784890f1ca4a088e7be64750e2b9362bb78cc81cbc5b8.jpeg	2389548380101	dni	GT	validating	f	f	\N	f	natural	married	Ingeniero Quimico Industrial	pf_20
21	argon2$argon2id$v=19$m=102400,t=2,p=8$TzZDb05lc2w0cFdkSTBUMms2SjVqbg$Vp7b73pzNSWah9F7ITLvWA	\N	f	jdsabinal@gmail.com	José	Montesinos	f	t	2022-09-16 15:05:49+00	189b58e84ef9774adc91e74881122101e01d1a0bf570519fe6da64e7988df7e8a8d1eccd96ad3b27fc2a0cae8ede9ee38fed4463ce15c0fe0061ea01e60c92df	2023-07-05 21:50:14.096941+00	t	\N	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_21
22	argon2$argon2id$v=19$m=102400,t=2,p=8$MUp1bzRtaEZSTk1QY2Z0TGtQbzVpVw$95yMTgKwLkcWHgw6umTC3A	\N	f	joaquin.lopez.lerida@gmail.com	Joaquin	lopez lerida	f	t	2022-09-19 15:07:45+00	\N	\N	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_22
58	argon2$argon2id$v=19$m=102400,t=2,p=8$cmxod1VTckVWMWRxSmZSaVJMdkVNTA$IZHjzfKNuaYPTDX5YRnhdA	\N	f	test2@mecexis.com	Test2	User2	f	t	2022-11-02 14:31:00+00	785d9c13cbaf9d28f9c2f7d5997c81e8ae34267889f31eeb3fd1ab02ca53cad09f1301a16d5913c48d6c0609678f2eea4a76b62befa983fb645d59557127928c	2022-11-02 14:31:00.759404+00	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_58
62	argon2$argon2id$v=19$m=102400,t=2,p=8$SFFQQXpCV2JNRjRNeUJ1SExwZnBoNg$EA/GjUmTiCelH9opuJ+7Mg	\N	f	alejandro5284@gmail.com	alejandro	noriega	f	t	2022-12-15 20:55:07+00	\N	\N	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_62
67	argon2$argon2id$v=19$m=102400,t=2,p=8$dTNyYkU3VGZBdnFUMEE1UlZnWnVCOA$h1h44dCLGBha0MUmnm3Gfw	\N	f	guillermo.salazar.verdejo@hotmail.com	Guillermo	Salazar Verdejo	f	t	2023-01-22 09:55:23+00	\N	\N	t	\N	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_67
30	argon2$argon2id$v=19$m=102400,t=2,p=8$eXZqWmRZdkcyYTQzaGlDNGVzbzZTMw$z1hf2nF0vq+ujGzMYKol/g	\N	f	icastello@sgrr.es	IRENE	CASTELLÓ	f	t	2022-10-04 10:08:15+00	\N	\N	t	\N	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_30
191	argon2$argon2id$v=19$m=102400,t=2,p=8$a2dRMHBiaDh0ME9GMlVRN3d6M3dwbw$ZovZeLPzFrgQvH6lxEINIg	\N	f	trabajarparati@gmail.com	Isabel	Diaz-Toledo Ruiz	f	t	2023-08-03 17:55:42+00	\N	\N	t	\N	t	f	\N	\N	+34 652 84 20 48	1987-02-05	id_documents_back/d632aca630b1f6bbecdc8023c762a8fbed09654dd0c77aa9def043ec9d830f9a.jpg	id_documents_front/798327c772718a86171cf3e0ae482cb0638756531d707b89b6ee39b4b98d3954.jpg	id_documents_me/60dd335477b8a3d6fd82ac7df89ffcbae26d55a1c70ac118a0bea0f70dd0abe1.jpg	53562811C	dni	ES	validated	f	f	\N	f	natural	divorced	Empresaria en el Sector de la Salud	pf_191
31	argon2$argon2id$v=19$m=102400,t=2,p=8$OXM1cmJTQUIwTUpVQUVLbmNjbmZEUg$IxMqMcFFJo6xE0mUm/nl/w	\N	f	racomo@yahoo.com	.	.	f	t	2022-10-07 10:33:52+00	\N	\N	f	4f3ab247bad996f0b1f5e3ef0beb0e076bf5bb4c728f8494c834408f25b30dfc382072e0d1af62b0548918247f2fc4f7e96735df237ad7f1530e7245f44569da	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_31
269	!B5U2Np5YERVAF7egdaMYN6NFOJjJneiMdNNMOI9f	\N	f	info@stockencapital.com	info	StockEnCapital	f	t	2023-09-06 17:45:52.850009+00	\N	\N	f	2cffcc7cda40f51a0c730cac0664d1895d740446951c20a5783cb07e210dd9195d6eeb0dbb57144df8d10229ece1af8bd986c29c82b53ef763c198c070ac87b4	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
25	argon2$argon2id$v=19$m=102400,t=2,p=8$aVY3eW5YQW90ejQxNFJEa2Z5b2prag$Qex12aKmQzduIzw2BdmrHA	\N	f	test1@mecexis.com	Mecexis	Test1	f	t	2022-09-27 09:44:32+00	39bf83cb030b9c93adc696c11f99ff77b33e36dbd13331ea16af0a3c737e4e4573f9a387283c3cbba7b13b218cce4ab5cc80b14008cde682aec2e1b900427871	2022-11-14 11:18:33.619097+00	t	\N	t	f	\N	\N	+34 664 00 00 00	1994-09-18	id_documents_back/8f9ede7599ce11fef1687ad661b847b959b3517f0d256b47122f106c8695da62.png	id_documents_front/e3c2d22c9660d3df254ca881447e705cc818d925e9183659b6280569c27b8b69.png	id_documents_me/5f4c888744683e57a7d0913754d83ad269cfe0979cfc7044a61c6f16711d853f.png	48000000Z	dni	ES	incomplete	f	f	\N	f	natural	single	Developer	pf_25
26	argon2$argon2id$v=19$m=102400,t=2,p=8$cGJ2RzA2Y3NHQlFmSUx1WHBzRXgzSw$Rjub7BC52Yziyfc7ImGsUA	\N	f	humberto@twoforall.eu	Humberto Enrique	Villanueva Bautista	f	t	2022-09-27 10:41:28+00	\N	\N	t	\N	t	f	\N	\N	+34 685 80 72 08	1984-07-11	id_documents_back/9ce2c04623c49251745ea2df532dc506e99ebcad4629b2906eca30f2f821dfa3.jpg	id_documents_front/f97ca8ad3d8c52794c66f48eab19027e08cd7516c8dbaace0156133c6e567019.jpg	id_documents_me/ff03f6c6a556691b974fbd9a97a1c8d1ca4a10db0d3e3f29cea894e5cd1e5a42.jpg	G23875207	passport	ES	validated	f	f	\N	f	legal	married	Inversor	pf_26
27	argon2$argon2id$v=19$m=102400,t=2,p=8$UHNzUGl3T3pTMThtY2xGOU5WWVZScA$5Q4YT2ft2DhdYBNk/Eooig	\N	f	alejandro_elbaz@elbaz.es	Alejandro	Elbaz Culebras	f	t	2022-09-28 20:45:30+00	\N	\N	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_27
32	argon2$argon2id$v=19$m=102400,t=2,p=8$N0RWY3VsU05SOGtHVXR0UW40YUVIdw$fJSVemEPe+Ws4TlyR3U1nw	\N	f	vila.ma@me.com	Marcos A	Vila Cañellas	f	t	2022-10-07 16:27:21+00	1bd9ea68d991e995078321feec2ad4a1c1a219f6e8b04c82647ba4d2a0204ab92d034986c54ed81e846fade70069cb493be53c034a6971ab086571e4f5e4a46f	2022-10-07 16:27:22.011229+00	t	\N	t	f	\N	\N	688915260	1973-02-19	id_documents_back/a0e991e6d9442915852a206d84532ed0c56533c624dcddbedd1fc565384769a5.png	id_documents_front/44b02e4c775c0224fdf183c6a3b23951f52cc3dccefb18ae4f8e5e94aa0b86a5.png	id_documents_me/f403450bd37669350ba50ee08d0b0d07a57391694896f17199a91fc438c5812d.png	43081431Q	dni	ES	validated	f	f	\N	f	natural	married	\N	pf_32
33	argon2$argon2id$v=19$m=102400,t=2,p=8$Z2Z4U2k1azYzYWIwR3RaNmhRVlZ4eA$U/eFCxpOTuYFVOsr4jbmoA	\N	f	carlosblascobueno@gmail.com	Carlos	Blasco Bueno	f	t	2022-10-10 10:29:55+00	\N	\N	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_33
34	argon2$argon2id$v=19$m=102400,t=2,p=8$RG1WWEZyTGE0cDVXa1BWejNhVkg5Tg$+imYh0GR9fY5o5icVojN3A	\N	f	luisrodriguez@live.com.ar	luis	rodriguez	f	t	2022-10-10 17:51:09+00	\N	\N	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_34
35	argon2$argon2id$v=19$m=102400,t=2,p=8$a3V0eW0zOTNIT2RpN2p3bFM0blI4Uw$9kURtL4VTGUjdTUzU7J7iw	\N	f	byfemoweb3@gmail.com	Fernando	Moreno	f	t	2022-10-11 15:58:35+00	\N	\N	f	a5bc6e5f63c0ac3c64438cbdcead925cffabadc3f41f807ded8dad9fd001212a22fd92f268817cbb214b8a4c6d99377fe34c8133e78c6ffd0739995c2bc8ed78	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_35
36	argon2$argon2id$v=19$m=102400,t=2,p=8$M3lYbkxUYUh0d2g5V0hTenk3SUgzTQ$Weycfrgw6b9Ck5TgDeaXbw	\N	f	byferweb3@gmail.com	Fernando	Moreno	f	t	2022-10-11 16:00:08+00	\N	\N	t	\N	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_36
37	argon2$argon2id$v=19$m=102400,t=2,p=8$MURaNjhOOE5JMDJPU3lNZ2ZlNlZMdQ$mni8+B9zX5kuP9JF4iDwrQ	\N	f	jrperezperez22@gmail.com	Javier	Perez	f	t	2022-10-13 11:23:37+00	\N	\N	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_37
38	argon2$argon2id$v=19$m=102400,t=2,p=8$V0FzN2JaNUZxNFI3MkZKbXprMXl3bA$GoKwt58r53cLX1cYlr3/hg	\N	f	prossenger@gmail.com	Axel	Gonzalez	f	t	2022-10-13 16:48:23+00	\N	\N	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_38
39	argon2$argon2id$v=19$m=102400,t=2,p=8$bTd0S29GakVCVlNoZ0JsMTlPeHJSbg$NLgo8vuF3CvkEhERgh/kMg	\N	f	mmanriqueordax@gmail.com	Miguel Angel	Manrique Ordax	f	t	2022-10-14 10:33:30+00	\N	\N	t	\N	t	f	\N	\N	+34 627 58 74 74	1970-07-13	id_documents_back/0bc0a21a8b85208a10b2b6bb4b864746b9af07f125a459e6c8ec3ba1768bb53e.jpg	id_documents_front/05149db7f7e15e50d32f71bb91d2deea59ee6a7d343ca40fd8a9d6a451f9ad3c.jpg	id_documents_me/3b60e58f59db37c9296eb8366b5e2cb88c6ca07a705762ad779046d3dd4ec1dc.jpg	13793990Q	dni	ES	validated	f	f	\N	f	legal	single	Consultor	pf_39
59	argon2$argon2id$v=19$m=102400,t=2,p=8$ZXE1S0ZuN0NycUdIYkVXbFI2b0xZYg$5rDsacu34JCZ1rmlegmbiA	\N	f	pedro_ortiz70@yahoo.es	Pedro	Ortiz	f	t	2022-11-03 11:12:38+00	c66103384a56117844ba6b34d6920a3a1a530a60279e143bae239e3181b241014040c50fb81b097d633bd211a6d46a0dbe95e78818fe37d0b1bfec65e6272ce1	2022-11-03 11:12:38.912974+00	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_59
60	argon2$argon2id$v=19$m=102400,t=2,p=8$dGpBVG5iaGR6VDl4cGdUZk9xcVh6aQ$1evqzruGCf5T14+TAL2fZw	\N	f	kallejo+20@gmail.com	Carlos	Prueba 1	f	t	2022-12-06 08:17:59+00	80ee368cbcb7662186e69afb2ec45058c0003675fd26e8a2f46d03602353f070effebe38c242b101dd5c321a120f6da9fc1251ffa43198a0f055d612e07e22e0	2022-12-06 08:17:59.583895+00	t	\N	f	f	\N	\N	+34 644 16 67 10	2009-12-07	id_documents_back/fbbb63851fb21f572c04b98df4c073784d27a4e4a9d6d11c63614bbcbb488556.jpg	id_documents_front/fdda557b2ce02472f7f7865d2412f0273b7cc0eadaa35cf9f919e9a0908f2329.jpg	id_documents_me/dfde56f4ada9bced03ff8f7d141624e52eca189ee29174bf9ba08181042bc5e9.jpg	71149278	dni	ES	incomplete	f	f	\N	f	natural	single	CEO	pf_60
61	argon2$argon2id$v=19$m=102400,t=2,p=8$Z1ozQjhLb2RJbURJZUpYNEFST2ZrSQ$w5QZRuAsyJw3aGlD/fXF4Q	\N	f	otroenfoquesl@gmail.com	Ramón	Corujo Pardo	f	t	2022-12-12 07:34:30+00	\N	\N	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	legal	\N	\N	pf_61
63	argon2$argon2id$v=19$m=102400,t=2,p=8$NnNoalFKNVV6aVZrT1ZHdHhMUVJYdw$Li9Ujj8GpaQQbmW0qc7rrQ	\N	f	gonzalo1987@gmail.com	Gonzalo	Sáenz	f	t	2022-12-20 15:58:12+00	\N	\N	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_63
64	argon2$argon2id$v=19$m=102400,t=2,p=8$WjVpZWt3dWxSekZtWmFTMDVvUGhOYw$A1yi62mgQbgQJH8//lUCkw	\N	f	sg@intlaw.eu	Simone	Guaglianone	f	t	2022-12-28 13:09:33+00	\N	\N	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_64
94	argon2$argon2id$v=19$m=102400,t=2,p=8$MEpRV1VLSXZibHhrYW1MbWdGTzhwMA$iYpjC8Doxc/uNXRVLkftEg	\N	f	kallejo+70@gmail.com	Carlos	Tres	f	t	2023-06-12 10:39:57+00	300b29598eb46706e3468cd615abdd8d977c7c22dfcaa6e46fc5166f3f5988cc3a992efa09704ea76dd7e99ba1529125d2c9ec14a79608b1f9bcd172de56865e	2023-06-13 08:06:40.369843+00	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_94
130	argon2$argon2id$v=19$m=102400,t=2,p=8$eDdDTG04QUJSWVpKZnEyUERKSlR2RQ$UL7Z52guPegISQBDXHbBxQ	\N	f	tiavinos@gmail.com	OLGA	GARCIA	f	t	2023-06-21 08:38:59+00	\N	\N	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_130
131	argon2$argon2id$v=19$m=102400,t=2,p=8$VnRvNldPeE5OaHFIdHpyMDVpbUZHRg$I6H81aJjyxRNYz22IvKkxA	\N	f	kallejo+17@gmail.com	Carlos	Callejo	f	t	2023-06-21 11:02:18+00	\N	\N	t	\N	f	f	\N	\N	+34 644 16 67 10	1997-06-25	id_documents_back/dcb6ea8ecb2d05fbef987b2bbb010a6ce53cc637684686dbecf81275aa852cfa.jpeg	id_documents_front/20fd2ab832043598c7d7b247eeb9b1636ca104be0922724e5cef85d2a3bd205e.jpeg	id_documents_me/48a90b23b5d28e08ece8beee6459ad2a333ac34a67ef4726ab31ca859ee1130c.jpeg	766655334	dni	ES	validated	f	f	\N	f	natural	widowed	rf	pf_131
74	argon2$argon2id$v=19$m=102400,t=2,p=8$UmlnSU5iNkZ2a01GSno4eDJPbUlySg$SDkSnzbv75PO5SP8bRM0UA	\N	f	riccardo@braccaioli.com	Riccardo	Braccaioli	f	t	2023-02-27 09:48:41+00	de9b6e17ea2605111f8effff11c61355bc57bfc62a671fbd0106f5659980b84de6b29634590c4d4daafd524e49649890790922641c0bb09fbb4115d9ef808012	2023-02-27 09:48:41.639339+00	t	\N	f	f	\N	\N	+34 677 37 69 49	1982-06-26	id_documents_back/1d0a84c22df5b72ce8759ec2d7242af7f54c0f050e108108cbf9bf42faaab836.jpg	id_documents_front/143044a1b7219e13a94863239dfaca48f74f64ce98a4c146ef3bfea95a721683.jpg	id_documents_me/f5656ee79e496978c9f261cd6846a482addb6c50ab9645e7d0622dba2d4fd263.jpg	AY5861342	dni	IT	validated	f	f	\N	f	legal	single	Escritor	pf_74
69	argon2$argon2id$v=19$m=102400,t=2,p=8$c3ZSTml3NDZxWFV4a1pvY0xZUHZNQw$/3ooKCBJWsT626/QcbKCpg	\N	f	xperiend@gmail.com	Xperiend	Protocol	f	t	2023-01-30 16:55:59+00	93a00b050e2888de18d0f77d4ae6ab3411721ede92b684287e9ff95cc7abd89dc371e30f86aafc1860a3406642c2b6d44bfc29cb92139b1d002c4d2dc79b7bb3	2023-01-30 16:56:00.143253+00	t	\N	f	f	\N	\N	+34628559740	1980-04-25	id_documents_back/8bb2aec90bf6784be75a7a233ed90cdb051b285c67e12ab4b2874d73ed1219dd.jpg	id_documents_front/b4f6be6a9b3ac3e0459c232afd77c246b9942a8a734692a3df45d345e8cfc9b6.jpg	id_documents_me/b203a8b7f4d2e31ec65bb5fd098d62ff4405445c894a9cb07ae396daba2564db.jpg	45105678X	dni	ES	in_validation	f	f	\N	f	legal	married	Comercial	pf_69
66	argon2$argon2id$v=19$m=102400,t=2,p=8$ejY1VjZPYmp4UjlIMlFVVGNRdFFuRg$WbPC6YTTaGrdxDg3a0177Q	\N	f	braccaioli.riccardo@gmail.com	Riccardo	Braccaioli	f	t	2023-01-11 13:18:12+00	\N	\N	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_66
65	argon2$argon2id$v=19$m=102400,t=2,p=8$RzZISFhLTGZyZ01URFhPRFVLWTVuOQ$rSlmhalDcPTvmP9D0kLZLA	\N	f	pyreneestimingsolutions@gmail.com	Javier	Herrera Santos	f	t	2023-01-03 12:03:23+00	\N	\N	t	\N	t	f	\N	\N	+34 644 39 91 82	1985-03-17	id_documents_back/5461ef12ecd6c1ae5e6478e6caf452cb9343db351898a275ce4a81d12fa8057f.jpg	id_documents_front/aa0a240db21c4ac90943d0404cc63699b42ed848f9465164199990e411895aad.jpg	id_documents_me/ae6b27c6113047a254ecf8a06440a1221bdec0e1f09a620644f6193f5a0ecb64.jpg	70937095N	dni	ES	validated	f	f	\N	f	natural	married	Autónomo	pf_65
68	argon2$argon2id$v=19$m=102400,t=2,p=8$Z044R25oRzlMNGpYNElZN3FPMEM4bg$fNIwCM9Md7b2wqMqua6zlA	\N	f	crb.bellver@gmail.com	Christian J.	Bellver Muñoz	f	t	2023-01-24 14:52:15+00	\N	\N	t	\N	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_68
70	argon2$argon2id$v=19$m=102400,t=2,p=8$SURxeVJYZG9KbHRLSnVhNUdzcFBPWg$hz8B5BwTynTehRYIQdEoUw	\N	f	kallejo+30@gmail.com	Carlos	Gonzalez Callejo	f	t	2023-01-30 17:28:58+00	a4b5a9c5b8465c8e73f6694b7c33711ad172ca810d2dea0e66c6b607320b0f2ce2792c072c601976b4174028887c038804f75e6efd4da1b5760d92ea1a70bc17	2023-01-30 17:28:58.786709+00	t	\N	f	f	\N	\N	644166710	1988-03-20	id_documents_back/d612e9602ee878bbba1d6e2fe024fe7a12bb02edfd516f76c17e8d64990663eb.png	id_documents_front/33f0cfc50070d8dce98d9e883f701229cac32261022c1fe8fb7cde46267589aa.png	id_documents_me/a24dde65e3032c852da6c3f23a2ca8abaefe27a3998ee132655d98806537996c.png	71149272Z	dni	ES	in_validation	f	f	\N	f	legal	separated	CEO	pf_70
71	argon2$argon2id$v=19$m=102400,t=2,p=8$WFJxcjdXRE1Jb1RwOEpjbFNTZVRiTA$qH7tOYOAVLYKUjOkZ8Mjrg	\N	f	roberto.sanchezlar@gmail.com	Roberto	Sanchez	f	t	2023-02-01 00:10:54+00	5e87d31a59e80c3b24dcf638bd0e8f5a802b76687c921c9e5dccbd7ac0acfa82b7c1a2a002516526a150f3e7fb0dbd8e2f8299f70cb8ca29f5cdfc8ad220418b	2023-02-01 00:14:06.253269+00	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_71
72	argon2$argon2id$v=19$m=102400,t=2,p=8$WnFvUFpvY3lrZlJHNlhYUDZUVlNrMg$h0AeyhgIgD9gZwbsxx4GyA	\N	f	alberto@atalayateam.com	JOSE ALBERTO	GARCIA ZAFRA	f	t	2023-02-08 00:06:13+00	\N	\N	t	\N	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_72
73	argon2$argon2id$v=19$m=102400,t=2,p=8$TUpOdkF5OHRLbDNCanFUQUNQaGRPVQ$f++bliIOForBlm0IekThXQ	\N	f	micaelabuffagni@gmail.com	Laura Micaela	Buffagni	f	t	2023-02-20 12:49:03+00	\N	\N	t	\N	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_73
75	argon2$argon2id$v=19$m=102400,t=2,p=8$ZlgwckFOc1cwSHI4ZXlJSHlmTWUxWA$d4eEKz76xz5Nat+RI0kxtQ	\N	f	eduardo@promoo.es	Eduardo	Gampel	f	t	2023-03-01 12:10:27+00	\N	\N	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_75
76	argon2$argon2id$v=19$m=102400,t=2,p=8$T0pnYjlVM2dZNG5IVFpDZXcwS3RaYQ$tRx+nIhrq7uI2odBs2vYug	\N	f	albertvaldes01@arkand-arkibit.com	Alberto	Valdes	f	t	2023-03-23 16:53:55+00	\N	\N	t	\N	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_76
77	argon2$argon2id$v=19$m=102400,t=2,p=8$ODd0a21vYXkxbThPbjJCTDduQm9JWA$/BS7EnMa8gcIWhO/e8/mpQ	\N	f	ashok@mxicoders.com	Ashok	ashok@mxicoders.com	f	t	2023-03-27 00:20:29+00	\N	\N	t	\N	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	legal	\N	\N	pf_77
78	argon2$argon2id$v=19$m=102400,t=2,p=8$VUhLV1lrdEdjM0c0NE1nRG9Ib3BHZg$xtEfgdnDoZUQjvfFXA/ueA	\N	f	kallejo+2@gmail.com	Carlos	González Callejo	f	t	2023-03-30 10:05:21+00	2bd0783e9e745857532900cc58e2661cfc83ed5d1cba3641942134fb6155dcdfdf0f3aed534177d764d020513ab67d7b89dd9c595ac88fe5e67ae017dd8506b5	2023-03-30 10:05:21.593305+00	t	\N	f	f	\N	\N	+34 645 11 66 77	1957-07-03	id_documents_back/7781ae2247dfe29111063ec18874be0f2c68d776897696637ba93864240c1864.png	id_documents_front/55104cd3c5b612f2d24ddd2585558bb0aa2759ca43fd20ff16d5ce65aa219d09.png	id_documents_me/78fdbffb442a59e04100a71ca588a0fc2c2ef0db66d628cd23bd084b937a7557.png	71149272Z	dni	ES	validating	f	f	\N	f	natural	married	CEO	pf_78
79	argon2$argon2id$v=19$m=102400,t=2,p=8$RnJiZGxpejNqY3dmYUF6U0FZY3RxWA$kZCgX6Y4MzZJeIZLnnfD6w	\N	f	viktorcallejo@gmail.com	Victor	Callejo Gonzalez	f	t	2023-03-31 10:25:40+00	\N	\N	t	\N	t	f	\N	\N	+34 639 81 51 15	1976-01-04	id_documents_back/a3b8c9f0d4425bfa2b17b68f43a50f0e0a57f72e2dfa647eb6edcf260134b66f.jpg	id_documents_front/de571fbbecb7b25518a441b420057ace1406863b873603828c51852ed81c3b23.jpg	id_documents_me/066de7a4a94596cd993f58f097a1ef0c20572c1c5b7753f4fdaf641944565273.jpg	50727027K	dni	ES	validated	f	f	\N	f	natural	divorced	Empresario	pf_79
81	argon2$argon2id$v=19$m=102400,t=2,p=8$dU9mdXZ4T2ZXNVBoNlFSb3JTeG56Wg$GcXFbdvcS+3GNj1MUnKVag	\N	f	kallejo+1@gmail.com	Manolo	Callejo	f	t	2023-04-14 11:43:59+00	30f28542bf6a355d15cea7533e2c4339b1c474c010e2c4f1e96fefa62f01168011aa5ac37ae540e77a1488351b057dd3e800d95b1c27465492348416d466c079	2023-04-14 11:43:59.93214+00	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_81
86	argon2$argon2id$v=19$m=102400,t=2,p=8$NFlSUlFpbEFJOWtVaG51cXFhTmpUcw$VaRQrQ9HIif7opvQ9MTnsA	\N	f	davidenkeeper@hotmail.com	DAVID JULIO	ESTRELLA SANCHEZ	f	t	2023-05-09 10:16:44+00	c6682a6212d889695e3a303862c5263a2fe08922625d7863db9f7bee5721f5ef9470588b32035d2fc2999284b23903d53da59eedb9456c48bf2f16fca15596e4	2023-05-09 10:16:45.161027+00	t	\N	f	f	\N	\N	+34607775551	1973-07-09	id_documents_back/64893a2e67a51fd70e3ff020de7b95132801748947713b6967cad30141ad1dbf.jpeg	id_documents_front/3547c4c560595517a1c98fbe086d3e32ec96d912ebc4a41b06846fc7c6cfe6a9.jpeg	id_documents_me/aba04e3c233540cec32f2eb03135c307f9302e572e7fe4386f91bfce08d17bb2.jpeg	03110952H	dni	ES	validated	f	f	\N	f	natural	single	empresario	pf_86
88	argon2$argon2id$v=19$m=102400,t=2,p=8$SnMwSTVpN2JHQTdJTkJRcXpreE9yQQ$l7vqXMoz69yWEOCV+7Dv2g	\N	f	kallejo+40@gmail.com	Manuel	Rodríguez	f	t	2023-05-12 09:58:55+00	\N	\N	f	7b3f163ff014785b58094822f16913c388c81f9bd02503a95df2dbe05bd3d240cba9fe8befa5950b7d422846e8a9f9dc9cad8f27dce3ea2b8bb61ed14179a885	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_88
89	argon2$argon2id$v=19$m=102400,t=2,p=8$TlVwdzFXdWRJUWFXV0xRa05rckIwMg$RJTNUWS+twEs1nuUaA3r0A	\N	f	cerocash2020@gmail.com	Cristian	Abratte	f	t	2023-05-25 15:47:46+00	\N	\N	t	\N	t	f	\N	\N	+34 616 18 64 38	1965-12-06	id_documents_back/44c896734a9652b5a23fde517f138a74407af839a07ee9c31314b555553048c7.jpg	id_documents_front/99ed95f55887111b068d3170aedd7f5fa485317d328d7fa95dbc0e344af9b152.png	id_documents_me/5f21f132eeb98bce3b7b1059cbd2ad5264d317ada7106136c7a4a2bc7f027de0.png	YA7104334	passport	AR	validated	f	f	\N	f	natural	married	consultor	pf_89
90	argon2$argon2id$v=19$m=102400,t=2,p=8$aDV5Q0hSQU9kb3RwNlFBMlNCNlEwQw$5F3s9ErdZNFemHNSk5gojQ	\N	f	benjaminespanolgarrigos@gmail.com	Benjamin	Español Garrigós	f	t	2023-05-31 05:17:51+00	\N	\N	t	\N	t	f	\N	\N	+34 610 91 83 80	1975-02-02	id_documents_back/98bffd235e261b4c23e43dba90f5e4bfbdce363936c16131301dcc404b617d22.png	id_documents_front/2546ba9702569856b6cb1b4b576037860a5ba213eb3f747cc0a0d492fefbd46a.png	id_documents_me/f2f913c1eea771ec16edabdd225ca1ec5a973612141fe473e8fdf0b3045111e3.png	18998782T	dni	ES	validated	f	f	\N	f	natural	married	Terapeuta	pf_90
141	argon2$argon2id$v=19$m=102400,t=2,p=8$cDhKSmVZTkpjMWQyM0tTWVdQOUZadA$gExvpPbscRJL3Fam+Lqfgw	\N	f	kallejo+31@gmail.com	Carlos	Callejo	f	t	2023-07-04 13:19:16+00	8d190881430e32da042ac2cedee6edd8209b3ec252f0f5b133b15e784fa6ac1447f229e1d808f0ce4de04ae172acb817819238f9f4c28458126db7b71ea4bf0e	2023-07-04 13:19:16.440555+00	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_141
342	argon2$argon2id$v=19$m=102400,t=2,p=8$MFc4bFFvV25QSmhCT1NzVFpzcER5bw$nk8oTKdag6toitlwEOsvJw	\N	f	jordirosellsvh@gmail.com	jordi	rosell	f	t	2023-11-04 09:15:56.342501+00	\N	\N	t	\N	t	f	\N	\N	34649132949	1967-12-11	id_documents_back/8e4de9c2f13efcddee95e320be02113edf46e985fd72d7aea0f612355bea8058.jpg	id_documents_front/92630aaee936bfaba9e7413c6d4f124ef7d511b84353c6d8acbe241f86a3f22f.jpg		79280597B	dni	ES	validated	f	f	\N	f	legal	\N	\N	pf_342
91	argon2$argon2id$v=19$m=102400,t=2,p=8$VEp1T0VZbUJxZkJvYXJCNTd0cTMwUQ$sgo0c6qq0XNDyoRemdPaYA	\N	f	famartinc@gmail.com	Francisco	Martin	f	t	2023-06-05 18:44:56+00	\N	\N	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_91
87	argon2$argon2id$v=19$m=102400,t=2,p=8$Q21YamowS0lDY2pHbmU3cHJjRDNSaA$OYCaTGTA4It8WVsDKNRzMQ	\N	f	evadibars@gmail.com	Eva Desamparados	Ibars Novella	f	t	2023-05-09 12:04:22+00	\N	\N	t	\N	f	f	\N	\N	+34 698 83 88 55	1982-05-05	id_documents_back/bb8e681093fd3c1fd9859a7c9f62597faf5637da5bc88ffcecd2cb88e1fcfb12.jpg	id_documents_front/28cacd757e5c7c3e613a556d85709e600192b6fe5a44d0bda4113ddba7131476.jpg	id_documents_me/f460731886e74c5a9c9c47f54a036a9ec5c9dad5c018977d933a4d3aabf89a13.jpg	44865566H	dni	ES	validated	f	f	\N	f	natural	divorced	Arquitecto	pf_87
311	!vgeXLnwAQXDWAh74REvcZk8pxLGQAF4iKEm3Hdjs	\N	f	aquiyosoy71@gmail.com	MrBlanco77777		f	t	2023-10-17 23:07:38.909444+00	\N	\N	f	b4aa8664a9af1791ea6dd075cf2df0c1e6db89ca2f315fc6066c93f323f3fe6e63641e2ecd55b495e4b3044039e922af363cba2f2e344972365aab414d7d2b97	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
80	argon2$argon2id$v=19$m=102400,t=2,p=8$VmdKSEtvUTZROVVQZkNLMVZMeHQ5cQ$F3vXNYkd46aiHqDtzcXXzA	\N	f	rdelcastillo@gmail.com	Rafael	del Castillo Ionov	f	t	2023-04-11 07:15:13+00	\N	\N	t	\N	t	f	\N	\N	+34 608 94 22 04	1983-09-26	id_documents_back/0840c913db8caf1a4b1a5f89b13757e08ff7d2d9d215d2ac6c87e2176b3e340f.jpeg	id_documents_front/f38f8fa799159800febdf26eccd4e11365b10b3d399163482d6944f029b59c42.jpeg	id_documents_me/359bdc7e8df5112f8d57721bab3bee3643ace768e7ac6faa73b354809c51275d.jpeg	51461117C	dni	ES	validated	f	f	\N	f	natural	divorced	abogado	pf_80
83	argon2$argon2id$v=19$m=102400,t=2,p=8$MEdmYVJVOUprdUU5eUNhOUpNNWVPaA$+TA/XJjUQMEsIBffCYer4A	\N	f	kallejo+10@gmail.com	Carlos	Callejo González	f	t	2023-04-16 02:08:29+00	\N	\N	f	6b449147d0b3f81a696581f449d395b32b470fddcc8430dc400bbd66336a56594e0942cf5c3fb72341374ae836bc2ca455e3043b400e53a6a3ecdd9e55527e48	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_83
84	argon2$argon2id$v=19$m=102400,t=2,p=8$NlV5Um5oZ25Hb1ZTQlhDWDVwRnloSA$Ywe/X/eKsArq0pfxw4q6jA	\N	f	exitoprospero@hotmail.com	David Julio	Sanchez Estrella	f	t	2023-04-26 14:08:03+00	91dc49e9a50e5463217a18a52d902469ba8b2b3306393e9cbdddbd0bbd863f5bbe184fe4a60a9ee72478b996327695d1f2ee67eeabde7d18160086fb4e43ce54	2023-04-26 14:08:03.264975+00	t	\N	f	f	\N	\N	+34607775551	1973-07-09	id_documents_back/a83796a801d2ed6c987704e3595af235e9e82810ea5d24e753e2e16715194ad5.jpeg	id_documents_front/01af905427d5464659977a01ae3628ca94ca18590d15be85fe8428a4a51177a7.jpeg	id_documents_me/09de50886873de121115102021c1ef9761493c6ee39c9f41c62fca029a085ad3.jpeg	03110952H	dni	ES	validated	f	f	\N	f	legal	single	empresario	pf_84
85	argon2$argon2id$v=19$m=102400,t=2,p=8$ZlNhT3VyN1l6SU5jY1UxaEI1eE1nNw$V33C3SgTvjmXCgM8o8h/Zw	\N	f	persianasfotovoltaicas@gmail.com	Paula Andrea	Pineda Pineda	f	t	2023-05-03 10:46:18+00	\N	\N	t	\N	t	f	\N	\N	+34 643 25 79 67	2023-04-26	id_documents_back/20ea435df54c21fa6364f5e6ecc314e18d5530808f1b65e05e8529f7a73ee367.jpg	id_documents_front/4635648df68e13012c532d1f440756c10e2e8b994fce94c8b6aaf410bdfb5601.jpg	id_documents_me/24867b279755ad8d565c44295ccbfea7b96b1c8c90a1cd220d9ab1749ed5bd79.jpg	12432047H	dni	CO	validated	f	f	\N	f	natural	divorced	xxx	pf_85
93	argon2$argon2id$v=19$m=102400,t=2,p=8$TFhxWW5pc0Fkcjc0bHljZGhtYll0Rw$U2nvA+8hzZ3lq2V0TdgV/Q	\N	f	kallejo+69@gmail.com	Rodrigo	Erazo	f	t	2023-06-12 10:35:23+00	\N	\N	t	\N	f	f	\N	\N	+504 9465-3801	1993-06-15	id_documents_back/c4ab1b7f793d6f8beee8d73c31dce0ca56aee9d07bf97b247600204817744aab.png	id_documents_front/485a7bb9e25b31e99db51f38a591c05ae5e5ba31d580e675278ef782c7eb36f1.png	id_documents_me/a89326f6558e41f262680853862f4bc7d3f41ccbad71e4166cd544a3e954d62c.png	21328929833	dni	HN	in_validation	f	f	\N	f	legal	divorced	Porgramador	pf_93
95	argon2$argon2id$v=19$m=102400,t=2,p=8$SEdsVk1pOThWS0Z4dXhaWmhxa1pKVg$e7GNeprAj1FDtc3LqQ1Kcw	\N	f	kallejo+71@gmail.com	Rodrigo	Erazo	f	t	2023-06-13 08:07:35+00	cd1a32ef0cc0ee8cc611ae481f94735954a551d2be90f59b78906e7800a6b5853cea99f5816b3261541c637ffed9440170a8a29ed1e666838ac8eaa3ba490d95	2023-06-13 08:42:11.345622+00	t	\N	f	f	\N	\N	+504 9465-3801	2023-06-13	id_documents_back/53c7ea7d9b63a1db43a15351ff56dec193c1a7a0d9416bfed9bb302b14cf5336.png	id_documents_front/12789a64da8d13e71560581caa8eb1f6eb9971d6476bcc4b484b346f9f25ab9b.png	id_documents_me/5aae4cde714748c9c406bf4de96974579a26fd600af19d2d162ddfa295ca3ebc.jpg	232323232323	dni	AO	incomplete	f	f	\N	f	natural	single	asdsadsad	pf_95
151	f9a37f3cdea8ddb7a89532613e662dbb547bd71b9d27a455d5566aa529fa9c6945f2a862818fd55cbad0927d07c70ab8ba4e32dc010f6a64ee701f867804472a	\N	f	xavier@xepigar.com.delete.2d2470	Xavier	Piña	f	f	2023-07-17 16:10:30+00	\N	\N	f	84a2f46ed1d6cd83ffc33ac599af5288974404b588d3b46be09e2824f2c56b902c7f1a75004cc91d0e217b9d6510e88457165650f0521c7e8e952bc96a901a09	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	2023-07-18 05:58:12.472527+00	t	natural	\N	\N	pf_151
286	argon2$argon2id$v=19$m=102400,t=2,p=8$aFdIbEd4Y0p0d1ZsWUVHN2dCUm05eg$C4F2z3q5fI/yYKYxsYf+hw	\N	f	info@cerrodelavega.es	ramón	giménez	f	t	2023-09-29 06:47:18.782109+00	\N	\N	t	\N	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
312	argon2$argon2id$v=19$m=102400,t=2,p=8$UGVqeWtkOEpqWHcyRENXR0pXb2VoMg$CE0A5Sqg56IXh1fptRM1nA	\N	f	nurigu@gmail.com	núria	ruiz guimet	f	t	2023-10-18 04:18:03.481734+00	\N	\N	f	9b161716eb643d825893abd4abdd44e4deb6e532f045af910aefe82ac5aab81915d3dd53262f5ed461e87ddee772c08871d40f6b3110e5c2182c1d5a0b81a706	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
296	argon2$argon2id$v=19$m=102400,t=2,p=8$S3NqZlR3TG1pY1lobzh0SXZvdDdIbw$+RppBx0k2/wk2WVZ2ytpbA	\N	f	daniel@tuti.fund	daniel	codina	f	t	2023-10-04 08:12:22.631345+00	\N	\N	t	\N	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
332	argon2$argon2id$v=19$m=102400,t=2,p=8$ZTVrZ25wT1hKS090bzcwdkM2MDdGYQ$oe9xt+rEWwTM+KTZBhO+gQ	\N	f	francesclamora@hotmail.com	francesc	Lamora Recuero	f	t	2023-10-22 21:57:52.368049+00	\N	\N	t	\N	f	f	\N	\N	34689190089	1983-12-06	id_documents_back/bd8527a9acc885779dd3ad3d4a8e7fad5d4d9f3baf99d612b01e02277e6505a0.jpg	id_documents_front/aef9160cfc25ef2c48c7624e3c40e9376ed38b0afcd5a00577cff5fe21ffdce0.jpg	id_documents_me/6cd2b2fd58146f05f204df0eda45da5c2bbd1607c4227e1f4643e77e5024fbf1.png	40536658D	dni	ES	validated	f	f	\N	f	natural	\N	\N	pf_332
168	argon2$argon2id$v=19$m=102400,t=2,p=8$cWpaVkRKcXlWMHZ4VDEzV3Y0SnFlOQ$IJUve+nhmz6peZ2uuYDNUQ	\N	f	rossamador1122@gmail.com	Rosalía	Fernández Amador	f	t	2023-07-18 10:57:59+00	5fd613bb4db1e48632deb4ed6e8bf0b0484232b06122a457203574cc61d1e6e4c06d3d283077cf83aca6bc0049bd7bc843bbca5fc6efd092dbb5fe5631775f62	2023-07-18 10:57:59.365577+00	t	\N	f	f	\N	\N	+34 621 14 49 35	1976-02-11	id_documents_back/c350df55f58298cf41b3839c53f519be1322798ada59a5bc249ccd55cba20d14.jpg	id_documents_front/d2f5ab859a77aadf77b09bf557a4095e812c6d54f500b3fece2e43cb306be4cc.jpg	id_documents_me/a5fd0cff205a86a1b57ea9ddfab27a6a2bcf26bb01709f27c3b69762dfe2fb38.jpg	25339022Z	dni	ES	validated	f	f	\N	f	natural	single	Producción agroalimentaria	pf_168
304	argon2$argon2id$v=19$m=102400,t=2,p=8$ZWUzV1BRV3VmTHhGS045SUhUUDQwOQ$dgZOePXGlRPQ80HxMcJ4dw	\N	f	jorge@servivuelo.com	jorge	zamora	f	t	2023-10-11 15:43:48+00	\N	\N	t	2edd961f7e5cf8bc87ea9c60ee7b386458f3a5805ffcdc6934b71050fecbcfe347b9dd56b6e013f725462f7821a3665bb41bb9cfba48662e4d942b03cdb0c0d0	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
102	4b3fcba3fb7293cb09d9f22ef3bad275bc90df12c5ae5916f4f6d1afa8e0a453ab5b49640ecbf271c3e1a48509da31879ddec94152b757edecc026b6d6753469	\N	f	martagarcia@gmail.com.delete.a3bc54	Marta	García Pérez	f	f	2023-06-13 13:51:04+00	a3c4cec5131b0decc260865b25422d7c8e7c02e22f2e63f96b8d054e957b37ca6bf22a34edaee1bdf007d50a0850a6628320de3f2eb287893c081dd674aeca1d	2023-06-13 13:51:04.943811+00	f	a76bb0ba7059ac98c68c109fbe94f8bdd9608823b5c29ee544e8840a6311c8e6281d1e6f41b89450ea02ffed4f32b4da895169391840d2e36c414303152973c1	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	2023-07-15 08:19:12.976859+00	t	natural	\N	\N	pf_102
103	0f9b9fa4463208a0a80acf05934d98e25d7f68a7b57cee0c227f931a2064ebb8dabda0b5a6da0fadf73afcf2550485ed6496ea2114ccd6b43b11f39231d787c3	\N	f	adriangarciacristina@gmail.com.delete.98fa46	Cristina	Adrian Garcia	f	f	2023-06-13 13:53:15+00	37b8d88ca9185fd36247aa92b4fe96c547ccb14b25bd8c5c1ebd9faad92c6532cadbe8024c291159a25bb8382f8e6f2f96c65836351346b907829f3eb54bd48f	2023-06-13 13:53:15.54393+00	f	70d291a5506362543e9fcf09f4fd4c3d9b4bb58caf7506c41ef5e43ed0c3e0a271865d157d05edbd303350dbe5bac458390eac40fe11f039a543962187f2cfa6	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	2023-07-15 09:07:07.422349+00	t	natural	\N	\N	pf_103
104	f083fd6023ddd606c656f274cea5a2791b29e93849a45dd74ab9422c19724ad70950503b24e79548014c1c64d847905082afc65a65179c4a1aaa7ff46480ee5c	\N	f	josebaiglesiasvilanova@gmail.com.delete.b6f945	Joseba	Iglesias Vilanova	f	f	2023-06-13 13:54:30+00	3eb3a18f39e4237f381d8c0a69b68c9ac462707fa528c1c470a720e5e1f113c27516803fce9be4b25d48e217a9e2ef4655cdce9b3c9bc1e5ecfceff66c8b6b92	2023-06-13 13:54:30.651727+00	f	82bd774ef073f442f36a97dc9ad40ae8018b201ae1eda09d797c2252019bd392e122d9778354a299c2d271b87574908a354574894fc1f2b85debd4211447a10d	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	2023-07-15 09:03:06.090277+00	t	natural	\N	\N	pf_104
105	argon2$argon2id$v=19$m=102400,t=2,p=8$ZG1JUmhkS3ZXYVdobmVFRG9uM2ppaQ$aaAyAN27FnNJD6I9Gom2ww	\N	f	lorena.merchan81@gmail.com	Lorena	Merchan	f	t	2023-06-13 13:55:13+00	6359bf799cee44af2fab4d39d57cfdff45d2e9965c6bbc4e453d4ca736a0779689f9cdd7facba08df69eeb41848072bf802f3e0f5d56fac0360e252c707a4ad6	2023-06-13 13:55:13.551947+00	t	\N	f	f	\N	\N	+34 606 78 37 73	1981-11-11	id_documents_back/1cd0b84fcefbc187445ae86f27312fd2e660fa77b71300c99039d0008cc9bacf.jpg	id_documents_front/0fb5306b72e381849af13b864df455585bc698269bb8c38936265f32b03e476b.jpg	id_documents_me/ac5ff28f8853f045f1191286fd525c0e8f9197ec57f07a8dbd5bdd01b1574f53.jpg	78902236T	dni	ES	validated	f	f	\N	f	natural	widowed	Asesora de cosméticos naturales	pf_105
279	argon2$argon2id$v=19$m=102400,t=2,p=8$UUlPcnQ3Z2p6T3JBZXVGOTlTbkJQTA$V4XP3zMgISylTIPC6E8HHg	\N	f	edanthonyrg@gmail.com	Eduardo Antonio	Rodríguez García	f	t	2023-09-27 18:09:35.860387+00	fa79d52dbe2b94d1cb206314fb386cb0cc59db69c9017f548fc86588940268b14116bf777a5acb3880b00b42f034aedcf14961cc7c1fdff159e6d79b443563b3	2023-09-28 06:53:59.810863+00	t	\N	f	f	\N	\N	34613466591	1997-09-27	id_documents_back/a9417df61a0fc1807f5e1f69e3e4fbbd9a9df7a6f3f3b5272a2c46f59888faef.jpg	id_documents_front/632be045156ae369d00743e03d78a933602486cf79cd9eef8f533c8a2be5aaf9.jpg	id_documents_me/f982eb852560c3ca52a72332a97696553c4cbf241b29e5063d86a6c115cba1b3.jpg	Y9907654G	nie	ES	validated	f	f	\N	f	natural	\N	\N	pf_279
120	argon2$argon2id$v=19$m=102400,t=2,p=8$V24wRGRzTmxHSzZndXE1YVo4ekppMA$7K4CLwmQYg3InyziWy++2g	\N	f	harka78@icloud.com	Harkaitz	Balzategui Aldekoa	f	t	2023-06-13 14:13:08+00	51fb02d4c3a37662f11b7d59122a1bf90ba37f136a192cd73218bfb72bb3ef829d88e4f88edc2b679a388a9a7b43bc0e01fe64d103caf06637b8cc0865131701	2023-06-13 14:13:08.779026+00	t	\N	f	f	\N	\N	+34 687 50 17 70	1978-02-13	id_documents_back/f27b8bb8633c4a1391b404fb3aa688a8961fc524d6d6d6bc01530c707c4af0fa.jpg	id_documents_front/62d7acd4986f51030f067c2c1fb69182af02e6eb23cd4c672f9579b5c79e39c9.jpg	id_documents_me/3ea4bc3a0c7bac5bcd7ed3eadf1b68888e3f1cd6563c5eaccc178a538f5fb20f.jpg	15396768Q	dni	ES	validated	f	f	\N	f	natural	married	Comercial	pf_120
113	argon2$argon2id$v=19$m=102400,t=2,p=8$ejRubmJNZ09sWDZOOEF1UXp2UURSRQ$B/9C5io61u2sPyacMhQ+4g	\N	f	angie26504@gmail.com	Ángela	Casado Alba	f	t	2023-06-13 14:08:37+00	a091d9635c34f830e40860380bed4a5e8ecb5a10ba7e1524e0c07d02cd7ce63e4069e7ec74b7892343fb7fbee973f18ccbc6bfb695cb8d0e272a0af41cf8fb7f	2023-06-28 20:15:40.571543+00	t	\N	f	f	\N	\N	+34 673 36 23 05	2004-05-26	id_documents_back/3cfcb5592f8662ee9ff68f664d28c2f507845cc91b5813386465b6cb92587960.jpeg	id_documents_front/2a1571f4f03eee4e63d7fde5b25fff62c7114b1545806d10b08435d0e0dabc85.jpeg	id_documents_me/0280305910ab3b75a4b1cecd7b321dcb63a8b05cd18484d2b78633d846d88964.png	17462646B	dni	ES	validated	f	f	\N	f	natural	single	Estudiante	pf_113
138	argon2$argon2id$v=19$m=102400,t=2,p=8$cktWdGt6QUZmNmJvZEl0UGZyMHgyTA$LEfhebrh9J2dv7yX70WL3Q	\N	f	kallejo+23@gmail.com	Carlos	Manuel 2	f	t	2023-06-26 21:42:43+00	\N	\N	t	\N	f	f	\N	\N	+34 655 44 43 33	1946-06-06	id_documents_back/d8a1e9fa8a24cbeab247acf2547e74c5b9b9b0099fb3a3c029f0fe946abf6b02.jpg	id_documents_front/ff6cefaab1a5053aaaf31f84aa067854c5422c446d3e9297e0bf03a43a6bb7a1.jpg	id_documents_me/ebce0bde4d532eb0a7b6ce3c0689892629624b4d444ef19329a41b4aa3130475.jpg	341413423A	dni	ES	validating	f	f	\N	f	legal	single	ssss	pf_138
152	argon2$argon2id$v=19$m=102400,t=2,p=8$OEpMMmw4dmhrbzJhbTJ6RnYyWU5rYQ$GGCXqDjdArprwSfjDhv+Rg	\N	f	monica.villar.fernandez@gmail.com	monica maria	villar fernandez	f	t	2023-07-18 07:31:35+00	\N	\N	t	\N	t	f	\N	\N	+34 675 11 33 15	1985-12-07	id_documents_back/76e0838ab7a43c6948972e66dded8bdf9a10177a5db490c43b5c03c7f9bb893d.jpg	id_documents_front/d27a46cb722cddbfa5c2dae8040874608311635f43d16e11898c0b70cec311f6.jpg	id_documents_me/62b7fec0cc84cfb24413c0daed9a7d9d7e44e7d35c07e3a233007e6d512c872c.jpeg	53186346L	dni	ES	validated	f	f	\N	f	natural	single	networker	pf_152
161	2f9dee363fe4b313b45be7bd0781176b764b358b31746e1c5c308b751123452ebf14f7405bee19c9a8322274f2fc2cb7c522f4ddd59befe6e29bae045b79934d	\N	f	marina.imagen@gmail.com.delete.87bbea	Marina	Arenaza Iparraguirre	f	f	2023-07-18 10:52:20+00	60ef9044b594f6fbbc35c4570d6af6446c69ac89d5747e77e6b7650c11f01df40d91787237ee4bb9fe97aa7e25d7425e159642d326d50a2e7249957f50fb15f0	2023-07-18 10:52:20.871321+00	f	49af7b1b12b55f475c1628c3651755630aca7f3e3a964a428e44a446eea4cb18ed45dba4b36d8f388043774691c13b4145cfc309c0fc61fb0758d53c168f2610	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	2023-08-18 11:40:16.620821+00	t	natural	\N	\N	pf_161
333	argon2$argon2id$v=19$m=102400,t=2,p=8$Sm1INEdaejRMbndpQnZIWHRiaTd3SA$UmXGSdCStMngjk2cUFMtdg	\N	f	jmpalmarodriguez@gmail.com	jose miguel	Palma Rodriguez	f	t	2023-10-23 11:11:51.30174+00	\N	\N	t	\N	t	f	\N	\N	34693577946	1970-03-29	id_documents_back/96eeca736efac80c44b47588af652a22760e08da9b083a9a2f582dfd64c34a19.jpeg	id_documents_front/fb7e5e9f62ef52e0a4970962793ef08745686e472b3c0a1aabe3030fd9810bd4.jpeg		27384246D	dni	ES	validated	f	f	\N	f	natural	\N	\N	pf_333
98	argon2$argon2id$v=19$m=102400,t=2,p=8$THNBdVp2VzQzME5HMkF3RVg5VVF3RA$Ekax5LpG/6zuofQ9KHBy5w	\N	f	anayeyu@gmail.com	Ana María	Lázaro Mena	f	t	2023-06-13 13:41:59+00	8809746b85c5f3fef0272e69f0183694ae3d011ca6977a0663266afea00a2579f5631d0a86addc6860c5ecebdfa1a3400fdaef8ce391a4a06a9d9da90d29337c	2023-06-13 13:42:00.384867+00	t	\N	f	f	\N	\N	+34 661 46 22 59	1982-08-31	id_documents_back/6b27a9ca17428530b6216605c4d522faf122487848171b576cf1a63fb9d5c25c.jpg	id_documents_front/9e25d38256e2442c2826f00f50f60e2d0fc866320b73282cca79fa725c32baf2.jpg	id_documents_me/4ae07a55596de9825791bf35cb36ed361f8ac1b278b3ec9279d550d617e26b75.jpg	30968916Z	dni	ES	validated	f	f	\N	f	natural	married	Ama de casa	pf_98
116	argon2$argon2id$v=19$m=102400,t=2,p=8$OWo1bWdxM2tKdWpoWG15cXJUNXVyWg$o2YLmlcAYiEkRyi1EpbHMg	\N	f	ainhoagalarraga@gmail.com	Ainhoa	Galarraga Zanguitu	f	t	2023-06-13 14:10:27+00	73c79f88052f6fbfc73f5e39292378c2d7a6212b4696643995dbd5fb83579c84c36fdc49cd172ec4f3e19b7299e19214f81ec63bc936cd1ef812945b0f4a25f8	2023-06-13 14:10:27.302579+00	t	\N	f	f	\N	\N	+34 652 75 78 43	1973-04-25	id_documents_back/dc70f264da33ca7c5ad315d18834b35e4f2d6a41f3aefe32a5077fa909e8ddca.png	id_documents_front/e2a2efba079d3e062bc4a6b3fc4b65d3a8dd3c792f900b61bc816ae6d413e1eb.png	id_documents_me/0ddf1650a97c5047224ae9f7f1283d87532bc5a36fc1629d6a627d9dfd3d93e3.png	15391139E	dni	ES	validated	f	f	\N	f	natural	married	Net work marketing	pf_116
196	argon2$argon2id$v=19$m=102400,t=2,p=8$SUVScURlaXk3dDd1Y1ZlUlVsd2I1VA$o0sIfrmM/w9dytUlbFu3FA	\N	f	kallejo+3@gmail.com	Prueba	Prueba +3	f	t	2023-08-28 07:03:37+00	\N	\N	t	\N	f	f	\N	\N	+34 644 16 67 10	1988-03-19	id_documents_back/c481b80ec7800f2d4304859abe70e8a3eb3c840b2e172ebe4c32b2136f55d1eb.jpg	id_documents_front/93f6b330d84a667b81bb8f37ee2c3a383d396063ee238de296711b4cca613a42.jpg	id_documents_me/15a389249320e0997a8fe6f903ddc3a5688557256de2ba050739a3373f679141.jpg	71149272Z	dni	ES	validated	f	f	\N	f	natural	separated	CEO	pf_196
321	argon2$argon2id$v=19$m=102400,t=2,p=8$RG9jZkIwM29aZkdYcU5KN2xVTE4wZQ$ltV76U8GIckekwtWV1gbBw	\N	f	naa41160@hotmail.com	alfonso javier	novillo alcolea	f	t	2023-10-18 17:02:10+00	\N	\N	t	74cc6d18ae02b9f2e80829a1498f0cfaa083fe500180417a1627bc5e044e8f6d0109863db73baf0cf416f0fc2b4a7a7eec5e1507268d68b12f226b2f073d9ee7	t	f	\N	\N	34660583329	1960-11-04	id_documents_back/a9b5e2aff3a6160f0291615ad54341a41ba9866f074825ee265927e31c261465.jpg	id_documents_front/5b769cc197e7d1c4bda4f2e87995f209f802f4407882a4d76297d004308b5de0.jpg		00685025Q	dni	ES	validated	f	f	\N	f	natural	\N	\N	pf_321
121	argon2$argon2id$v=19$m=102400,t=2,p=8$dEJmVHg4WVJ2N0tIc3dzVGhXdkpONQ$kWklMsd7a2hmHr40RhABng	\N	f	rubenalava@hotmail.com	Ruben	Alava Martin	f	t	2023-06-18 14:27:29+00	\N	\N	t	\N	t	f	\N	\N	+34 629 00 90 33	1981-05-21	id_documents_back/1dfb813f7b99210a2a37a9f83eae48dfa7041cb4e7880138170b586d8fab9bd5.jpg	id_documents_front/1750cf65965a3a1c5901849e61e8acce50753633660975722fdac5355ccbf4be.jpg	id_documents_me/8f991c7ff38984dc56e0d9bc0233106b5d4de547d14c534f3f8be05fb4447ab9.jpg	33443288T	dni	ES	validated	f	f	\N	f	natural	single	Fontanero	pf_121
123	argon2$argon2id$v=19$m=102400,t=2,p=8$enh4UEp4Y25XNmVTV2NXSkVtTzBiYg$+ioho+8/DGu+Hhi5hF2W6A	\N	f	kallejo+15@gmail.com	Carlos	Rodríguez Rubio	f	t	2023-06-19 10:50:22+00	\N	\N	t	\N	f	f	\N	\N	+34 655 44 43 33	2023-06-20	id_documents_back/4e22708da2114f2cbe2f7b88a00a84e39dd437721835290e6006d6bd2203dc51.png	id_documents_front/a5b70080677197e13f2a82694f13f0d0e541b18aced494ef03e0e1ef3ad9f3ed.png	id_documents_me/37f635bfde830a0d4dd68ceb067fdf70f1901eacdbc8f6d75924895b85671f5c.png	700023986	dni	ES	in_validation	f	f	\N	f	natural	married	sdvc	pf_123
124	argon2$argon2id$v=19$m=102400,t=2,p=8$eTNpYTRvUUJHNzY5UkN2M0k2eUplMw$SqrAy2gvXs6oBup+qkKY7Q	\N	f	kallejo+16@gmail.com	Thiago	l	f	t	2023-06-19 12:04:17+00	\N	\N	t	\N	f	f	\N	\N	+34 644 16 67 10	2016-06-14	id_documents_back/651c611d88ef1ab9a8d98a40ca436959ae84fa335783a86e1a302cae3e26ed41.png	id_documents_front/19bd2fd6f0ccc9683cba8f7296ba27f617d773989fd08d9941a32fa09f50e0b1.png	id_documents_me/7e7eaf28775baabcfe0a8ded7bc911ac4525c59cb7475e8f0f6a9405d587baad.png	43534545	dni	ES	validating	f	f	\N	f	natural	single	ce	pf_124
128	argon2$argon2id$v=19$m=102400,t=2,p=8$eHdRd0NUNjZtdE0zcVIyOWdramhHNw$byOKPOdKU1zUMw3PSNC+Eg	\N	f	pilichitobarias12345@gmial.com	PILAR	TOBARIAS AVELLANEDA	f	t	2023-06-20 19:10:13+00	\N	\N	f	87a9554c005e0905473871873d1622cee184dc5d74699e2c039694a4082593aeaaa320285a176e15a71196461a0407b92e4541fd9266ad1db96203edecb59bc3	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_128
132	argon2$argon2id$v=19$m=102400,t=2,p=8$NmpNbHI0b1RLSjZZbFlIajUzRzQ2Yw$ZM8mcwkZOI+O0138ZywyVw	\N	f	kallejo+18@gmail.com	Carlos	Empresa	f	t	2023-06-21 11:05:48+00	\N	\N	t	\N	f	f	\N	\N	+34 644 16 67 10	2014-06-26	id_documents_back/2c504d4dc625b4eedb6bee9cac824ccd9ca9ab067a773653f333f4b2ace9bc71.jpeg	id_documents_front/cdd424b856dbf5da12e7ef849b40c988a035ca7c70696c4991c7988f7a15abd2.jpeg	id_documents_me/1a463e1575003c98ba33e77a666ab9c4be6e8b69e455f7365e5e2026e37bef62.jpeg	76836723A	dni	ES	validating	f	f	\N	f	legal	widowed	wed	pf_132
133	argon2$argon2id$v=19$m=102400,t=2,p=8$TUlnazl6MTdqVDJUZ1Bid0R2dzFaaQ$7gMh9N5Ti/Vg2pyRGbyZhQ	\N	f	quintorro81@gmail.com	Jorge	Herrero Pérez	f	t	2023-06-21 16:50:24+00	\N	\N	t	\N	t	f	\N	\N	+34 670 51 35 68	2023-06-21	id_documents_back/2eb73f64b2750662d2a8e87dcece676adf3797a5234822bf135e902ac1633abe.jpg	id_documents_front/e367449780c793939214a6d3471ed7d5cdd6a653a0123be8116db1150647a4ca.jpg	id_documents_me/b9e2a97f8d1cca10b8df8eda2fb5502d5bd23d36bf4aaec0ef2b53bc142bd273.jpeg	47066764R	dni	ES	validated	f	f	\N	f	natural	married	Ingeniero	pf_133
134	argon2$argon2id$v=19$m=102400,t=2,p=8$SFZmMnR1eUFxUlhlUWdHTnN1V1RoZA$qCQ81AcGE6Yu+hgGR1SDhw	\N	f	pilichitobarias12345@gmail.com	pilar	tobarias avellaneda	f	t	2023-06-21 17:13:12+00	\N	\N	t	\N	t	f	\N	\N	+34 695 37 39 41	1971-08-12	id_documents_back/e5ff0280ba363c870d8e385535f45b7adad7d640d5169adbbc72a56744bc295a.png	id_documents_front/eb07ba7a40d6e60449227ca97c1347d1200ac154156ea5ecfd0e552ec9b2ef17.png	id_documents_me/62edc0349149b28480102a49a1a9b9cc8cc89a89461d3329e20cf68d1af9a52a.jpg	40440666L	dni	ES	validated	f	f	\N	f	natural	married	AMA DE CASA	pf_134
135	argon2$argon2id$v=19$m=102400,t=2,p=8$YjVFYktWNVlQNTcwR3dKd21KNzZ2Yw$9ua+sIsE6wwtUcmv06DqYQ	\N	f	beatriche2bgt@hotmail.com	Beatriz	González Tejedor	f	t	2023-06-22 09:54:30+00	\N	\N	t	\N	t	f	\N	\N	+34 620 19 16 30	1979-10-19	id_documents_back/f78d5a3f5b1ecab10407f45139fba665c1da07788cd9bed0daf1f493ccb10302.jpg	id_documents_front/33b628ec5a6b698d4848bd7edaa56f6806db4022f70df63820c84e53f4a292e9.jpg	id_documents_me/95619b8d92b913143cf20228cc14b3efda2bb4a7b374ff45d8c86201464d18f0.jpg	71424414F	dni	ES	validated	f	f	\N	f	natural	married	Dependiente	pf_135
156	argon2$argon2id$v=19$m=102400,t=2,p=8$ZzhCS21yVlIxOXlUSzZFSUVqYUU5Rg$Q2oK/8JeiUk6/5VJYafEOA	\N	f	mrascongarcia@gmail.com	maria	rascon	f	t	2023-07-18 10:45:40+00	d9efcb9bc5f1e76421c3d8f924015f57fe89dc7ab7959d85e8f94c22833551d2623e1e7deae84464649864acd508dc60ab5b8b43c777254921d58a5dd8297cf7	2023-10-02 14:29:04.99135+00	t	\N	f	f	\N	\N	34678140347	1958-02-06	id_documents_back/0545314b071c3439e8c97020b97397649d3fbbd4d7b24a155b88eec12020c681.jpg	id_documents_front/796c969195de66058b2edfcd60553a66e28ffc5a59065d5cd43249be601bae62.jpg	id_documents_me/fde69700d18f95133599de40e32feaf0ae194a11e0e9e2f4c8d003df218d4e88.jpg	15356024M	dni	ES	validated	f	f	\N	f	natural	\N	\N	pf_156
125	argon2$argon2id$v=19$m=102400,t=2,p=8$YnBxalgxQmJ3ckhybFZnTW5JYjF5Rg$kuQVsEsRVGvfc1fUtfPSEg	\N	f	abrujos@hotmail.com	José Antonio	Gutierrez Pindado	f	t	2023-06-20 18:04:39+00	\N	\N	t	\N	t	f	\N	\N	+34 669 84 27 36	1964-09-12	id_documents_back/ddf6f72dc87c9d3c4aa104be89b2d5e6e3fa2760501faf8a3af3a5c8332b6158.jpg	id_documents_front/00373a1d82ea49948ffc33ec5c6eafa40cedbd7897401ee5733ca8a74855dfd6.jpg	id_documents_me/1a1fa3261fb63a1d2ba1d1f7368a0363a87853a090061165b2ca4ac2a561267d.jpg	05263258F	dni	ES	validated	f	f	\N	f	natural	divorced	Mago	pf_125
126	argon2$argon2id$v=19$m=102400,t=2,p=8$WU9YWDFheVFQME1jeEQza1Q4eEpuaw$5eKcg+3hiGpaZztbvfR7FA	\N	f	jlopez@somosecoenergy.es	Javier	López	f	t	2023-06-20 18:21:45+00	\N	\N	t	\N	t	f	\N	\N	+34 619 96 51 74	1973-12-09	id_documents_back/0107af859344f76ec43629e8ab4d4cbb19bbc16af5cef7e138ea030f54dc152b.jpeg	id_documents_front/76f65667450b9bcbd36256a3799dc8986ffe7b30d364a1ac342130efe9883ef3.jpeg	id_documents_me/68a6606639b8f4aa738b2592b82f3c9643c7331514194c67f9272b5233f6b3f4.jpeg	09456387Y	dni	ES	validated	f	f	\N	f	natural	married	Comercial	pf_126
127	argon2$argon2id$v=19$m=102400,t=2,p=8$T1BoaTF5QUwwVDc5TDZOZ3JJaGN2Qw$556Hh7lujBlGP/DrYMlVaw	\N	f	pilikim20@hotmail.com	Pilar	Tobarias Avellaneda	f	t	2023-06-20 18:36:36+00	47ad7b7e5069b28b34b313301d83d3f91ab24163be3c5624503dbaaf6a14d4d838ca5de10fd005d57e5ea865a27c1e262185f41b9ec778bd37936ca3357a17a2	2023-06-21 16:52:52.720725+00	f	d587c71cef1c2ac76d9c44603bd97a71d9cfc6500746210f6b3e2697bb7d4a98d0f7761573f1e70556d9c4fbe53bd87c0bae8db92e2cde158f34ae4d439c2c7b	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_127
137	argon2$argon2id$v=19$m=102400,t=2,p=8$UTlKYnhWaWNVQUFWMlhxRlJObHZCWA$+pB8BbMH/SSEBxv57U+WZw	\N	f	kallejo+22@gmail.com	Carlos	Manuel	f	t	2023-06-26 21:13:07+00	\N	\N	t	\N	f	f	\N	\N	+34 666 66 66 66	2023-06-19	id_documents_back/8e9608d9f82a4e42dae2e7d59b83a17991dee3f2a9da1accb402fdd3c11dc127.jpg	id_documents_front/6298ded67dd6754c06e3c8f919e8ceec6ddf7630698b65f5087549d3c73adf1a.jpg	id_documents_me/01f257fd0d769bcd451a75b00289e0f8bd783e592fd40fb55b8eb09fc60611f8.jpg	71149272Z	dni	ES	validating	f	f	\N	f	legal	married	dfef	pf_137
139	argon2$argon2id$v=19$m=102400,t=2,p=8$NlhZdVkzSEJLV2gyS24xUG45WTRjdg$c80acCFGDO49/9+RkCIDuQ	\N	f	kallejo+27@gmail.com	Carlos	Callejo 3	f	t	2023-06-27 09:30:11+00	\N	\N	t	\N	f	f	\N	\N	+34 655 44 43 33	2003-06-17	id_documents_back/8dff47c0c3a02ba79390f809d3f6337578768fede7353e53de6d46b9e5941294.jpeg	id_documents_front/b8d5b97a9bcfe49f2a26d29d0067f7573861640ce5e1f9ac20764897096d41a3.jpeg	id_documents_me/6ea387d2ae482ec9a1bbb8947eb8e28c14be6f9ea527f6771a3459092c1b8543.jpeg	WER3453	dni	ES	validating	f	f	\N	f	legal	married	es	pf_139
140	argon2$argon2id$v=19$m=102400,t=2,p=8$QXJiTW9zVDdLR2t2OVczMDA3SnlSeQ$6jF4nN//MX8xlsiDxqSImA	\N	f	kallejo+28@gmail.com	Carlos	Manuel	f	t	2023-06-27 09:37:01+00	\N	\N	t	\N	f	f	\N	\N	+34 666 66 66 66	1988-05-31	id_documents_back/8139dfa7a2a8a7067a41326e879b26144ae0463331a389b27df2a48c3dff117f.jpg	id_documents_front/4d0db72b504c2a86bcceea9e8adc6afaaa9817f8629e88af08d57c87a5fe4bcf.jpg	id_documents_me/14a93e6dd1d678b65ab577d3043d5263b9708e1e1fb077f291c68487adb78076.jpg	4564	dni	ES	in_validation	f	f	\N	f	legal	separated	ess	pf_140
142	argon2$argon2id$v=19$m=102400,t=2,p=8$cW5XZVZJVVFGTm5ZVDhmdElNSzVzaA$FzXQwSij6AcZ9+jhmOWDWQ	\N	f	superfluo83@gmail.com	Ricardo	Andrino Miguel	f	t	2023-07-07 14:31:51+00	\N	\N	t	\N	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_142
136	argon2$argon2id$v=19$m=102400,t=2,p=8$VnljQ01qOEFhMHBsZmdPNEtDU0l2Zg$JWJ+91bRVUh1QijXuJ36Nw	\N	f	kardaskinges2011@gmail.com	Ana Marina	Gomez Arreciado	f	t	2023-06-23 09:09:27+00	\N	\N	t	\N	t	f	\N	\N	+34 664 51 29 53	1967-07-30	id_documents_back/667751452c9c2a29a7b76136002298893e9750bf5183a21a30f316461a3ef80c.jpeg	id_documents_front/891e09579786225a7bce22e4ea52182df6a3c69e85f500d1e26b13036e7cb71d.jpeg	id_documents_me/1061bd12e9dab945e4f0ba59b5d810b2a4b9033de5b092a33bd182c47ec903a6.jpeg	75540433S	dni	ES	validated	f	f	\N	f	natural	married	Técnica Media	pf_136
201	md5$ssn1Wvmuo8QcFLG5GRWYas$1acfd7855ad864abacffe05482f67043	\N	f	kallejo+5@gmail.com	carlos	callejo	f	t	2023-09-03 20:34:43.912389+00	\N	\N	t	\N	f	f	\N	\N	34644166710	1988-03-20	id_documents_back/ae797736163742cf801a9e763b474f73f41775ba02d323874d1f014fc4b0f398.jpg	id_documents_front/ecb8443d5ff1b2dde2990507d2559b9624c8406ce63b4e1e8a2a23fddefd224e.jpg	id_documents_me/b97a050a6e3833114f9a3625439e37439b921f57e3d10bf7b4ec0a75c78c94ef.jpeg	71149272Z	dni	ES	validating	f	f	\N	f	natural	\N	\N	\N
297	argon2$argon2id$v=19$m=102400,t=2,p=8$R2hJb0NkTEp3bkpUYk9YZm53Q2lWZA$BKGiq9QSQ5Zju+8C0f9OCw	\N	f	pilar.esteban.herrera@gmail.com	Pilar	Esteban Herrera	f	t	2023-10-05 15:40:31+00	0cdcf75500a7cd9a206dab444a5990cf70a71f418f304a1979cedaf56f0a70ee3c3355a25486fa31f8e5ddbbc07868066791d5f889c33bc2c2af37aff9ad1f94	2023-11-01 05:43:17.651194+00	t	de1da0ab1576dab2c4afc12be8baf3ba0f13e1b96bbeee70aebd6eda813f5e89136d368b18f0569b751dfb9e7d70eb0947f403da95fb37b4f176720182fc2013	t	f	\N	\N	34686275877	1974-10-12	id_documents_back/afc3325773ce7fd51cb6a18acd5af6b65c4379492c15037a94b35dd97fb77929.jpg	id_documents_front/a2d15980ae450e54eeea2fd4115028809c93cee514da1c1e90b16bcb345373b7.jpg	id_documents_me/e3520fa3d5803e38c026e2604af233691106ed39187a6cceb250abd5742c0d1a.jpg	02253115N	dni	ES	validated	f	f	\N	f	natural	\N	\N	pf_297
202	argon2$argon2id$v=19$m=102400,t=2,p=8$c0hEN21tSGRsRlNlSEQwa1o0dUJaTA$rT6yqRxblcolaprNameRpw	\N	f	jegewak414@synclane.com	teste1	teste	f	t	2023-09-03 20:48:31.266917+00	b06ae0d651fb24af8907ecb3aa34d823002290259093bc169215078fd187514ce1f94334f6a562ea15018491b115fe446ac51a536e08773b31757026d3496099	2023-09-05 20:58:13.967855+00	t	\N	f	f	\N	\N	34123456789	2000-10-10	id_documents_back/cdf6c36275bfe8a0be0c1a4cb5f35eac43d12b31d588f598c95f845401fa38e6.jpeg	id_documents_front/a5957030be7f7bbd28b003299624cc2cd0093ae6b774ba9055f301e4795ad017.jpeg		123456879	dni	ES	validating	f	f	\N	f	natural	\N	\N	\N
143	argon2$argon2id$v=19$m=102400,t=2,p=8$NmY3UDNqMjBsS0ZZMzhQNTBDeDhVWA$WcxTofCVpB2LySFi57Uekw	\N	f	cio@ofisher.net	David	Stein	f	t	2023-07-09 00:13:53+00	\N	\N	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	legal	\N	\N	pf_143
150	argon2$argon2id$v=19$m=102400,t=2,p=8$OWszZE41VmRUM21UZHZuakVMUFBocg$ZPxoKXPyc5yM35alSQUWhA	\N	f	posesodegerasa@gmail.com	Jose Maria	de la Torre Montesino	f	t	2023-07-15 12:41:28+00	310de41330db64b6530384cd0146af3708e88de3d46934cdb7665cb4d6406841a104696d1e352f91a2616ce81224da16c6b2c153317e6dffdf0dfd1570e2de44	2023-07-15 12:41:28.356843+00	t	\N	f	f	\N	\N	+34 655 38 27 67	1967-04-04	id_documents_back/7b9bdd40f2215d4dd79097806803b94f7253b9588cbb4d5b566591b36babb00f.jpeg	id_documents_front/dcb62b253d4ea8f4f2d57051eb452956529e54efc08a6cf928a8e1c53a8e9cea.jpeg	id_documents_me/0e6f28f7f4e415fb0956e939b252b31f32b882c1ebf44d6849432cdc9f0784c3.jpg	50824517Z	dni	ES	validated	f	f	\N	f	natural	single	Desempleado	pf_150
122	argon2$argon2id$v=19$m=102400,t=2,p=8$cEZhV2E1ZThYNGtGbXBvUURNWXV6WA$pX9rVXnm+vc3KiMbColdcg	\N	f	dossmingo@gmail.com	Jose Manuel	Domingo Campoy	f	t	2023-06-18 16:39:20+00	55956c11d1644bfa3c26cfc45ddb793bdee62721ee3a5c4761e53a19e7b13053b7c87cff9be2d04ec28a3abc4d92544588aa587134c271ce252d3e2505c0707a	2023-10-14 11:55:05.202967+00	t	\N	t	f	\N	\N	+34 690 66 56 68	1974-02-14	id_documents_back/1472007eb7c78f5055539d9f70522bf87b9611cac208f533328a835800f8ce6a.jpg	id_documents_front/e8f49b120e41d9fed3cdc48a92ed68285bb590d7c152e262362099b230f090fd.jpg	id_documents_me/0ff86972fc6465be30914bfbab09c14f35b9fb9d1e39a988c2cb2d0447153786.jpg	29168375M	dni	ES	validated	f	f	\N	f	natural	married	ING MANTENIMIENTO	pf_122
144	argon2$argon2id$v=19$m=102400,t=2,p=8$YWV1ZktLZDdldTU4ZVNoaVpUUjlpSQ$GDMVPlMW1hP/Fm5k0fRNvA	\N	f	despertandoturealidad@gmail.com	GUSTAVO	CAMAÑAS GONZALEZ	f	t	2023-07-11 18:35:10+00	\N	\N	t	\N	t	f	\N	\N	+34 682 77 52 02	1978-08-30	id_documents_back/96c90b80bb62a258f661789a545719a240e5d5c733788fbf4ae49bcd5fa67830.png	id_documents_front/d44938c6bb38daa3e5631f008f38a27d79f1872d17d00dc66ed922f6dbd549ff.png	id_documents_me/1dd9354a659f4428325d8d60fa3f3906ced31be67b7f910dd0918b13a6d78f07.png	14306304M	dni	ES	validated	f	f	\N	f	natural	single	escritor	pf_144
310	argon2$argon2id$v=19$m=102400,t=2,p=8$S2xWYXZrejJqZVlSSGN1bE4yamZQdA$pg+zbJgIHj6UZVlYs8HCtw	\N	f	eslavapolo@gmail.com	jose luis	eslava polo	f	t	2023-10-17 23:00:19+00	c0e5083c029310c974f2a8be965e7bdbd7bb9facb5359678dc15c5fe277846c8c7b1fc8d70f7f7bc5d395fbca95233edb242aa30f267021883d645b7d033894d	2023-10-19 07:21:19.153201+00	t	b3d50d41881e40eb9f960aff966c93ae0d8c3830da464d57a47966dee15da413d2a24695adaf955a5e2a104f631954460cdb309bc1825613140c7794983e229a	t	f	\N	\N	34619113720	1956-09-22	id_documents_back/d7e8f44fc7abea3abb971b3c9863abb930228e71c7c65a25f99b004a8f603acf.jpg	id_documents_front/0a9124e1b918a3cadd635978879baba035f79f58e5372d91e3234dd811f4c920.jpg	id_documents_me/d9933ac7fae1a2566350d14fd05ec108a0b28937ff5ade18122d3af268a241a3.JPG	22663712H	dni	ES	validated	f	f	\N	f	natural	\N	\N	pf_310
117	5c5588175c4cfb059be4f3f86d19b72b5bcf704bddbb0b21fe5fa1c360d641cbd5e1fb9eeac0e9bc1ac512a3fdf344326aeb867f74f663775d204624c798c8b6	\N	f	natiroldos54@gmail.com.delete.e9cf86	Natividad	Roldos Bonamusa	f	f	2023-06-13 14:11:10+00	ea7281da1f8dc3116f43ad0da68056ae18cb11e4c9b97d4e7db3db1778fbae12b5fd99d67fb01ed22ad226ae13d017ce4164dcf8b313ad0624ad4e99780e7463	2023-06-13 14:11:10.356243+00	f	e8d0ce927a60147986dfbaa95a285d315361d720a91ee6a19b10495b3ad56871821f1d8b2056f033e27258f29deaf231244d8ea6b67f112573ea68bbecdeab16	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	2023-07-15 09:04:33.429705+00	t	natural	\N	\N	pf_117
147	argon2$argon2id$v=19$m=102400,t=2,p=8$Z2xwZ0NTVUtRUzlVem9YR09NU2h4bA$1Thw0vzFWxOmneZPyjmuQw	\N	f	josebaiglesiasvilanova@gmail.com	Joseba	Iglesias Vilanova	f	t	2023-07-15 09:03:49+00	5c9f6b3143f193a5a71b24247b7ce99e824ab22d6a4184676eb49fc86cb4d658f66af1b3113f7f6250aa9140895ca01dfd7c838ff9aadc62f0d0d098333fbf70	2023-07-15 09:03:49.578522+00	t	\N	f	f	\N	\N	+34 692 17 87 75	1983-10-15	id_documents_back/45ef6c1c4af483a06d68cd58982b5536a77108955e2e47d1ef927a2816a4d6c6.jpeg	id_documents_front/a31150dc1c67df7988b53ec7be5e37f88dadc7a32ec1fb2ee80ba3934085eec4.jpeg	id_documents_me/bf940fc55654f070d4c90dea955cb0a93c1f72148cf166bca72b56cf640c1db1.jpeg	16079936S	dni	ES	validated	f	f	\N	f	natural	single	Comercial	pf_147
336	argon2$argon2id$v=19$m=102400,t=2,p=8$WlJrSGFzM1piN0V0a241cmlUVWVaNg$zqB7Js43vzYXRSZIlrzfbw	\N	f	aoregiosoro@gmail.com	aitor	oregi	f	t	2023-10-28 16:53:15.756201+00	\N	\N	t	\N	f	f	\N	\N	34647315575	1968-08-14	id_documents_back/b70993080cd0e2bd35ea5c2e60725344a8267fd394dee8c4e5e8d6f806326456.jpg	id_documents_front/4b74b9779cdbafaf1141518daf32b8aea3650ddf0184e516e689f799ffdf053a.jpg		15372186K	dni	ES	validating	f	f	\N	f	natural	\N	\N	pf_336
194	argon2$argon2id$v=19$m=102400,t=2,p=8$N3N3ZnQyNHE3YU9hRkRXckt1YTVSTg$G1HprWubiOkdIVgedLSqzQ	\N	f	marinaarenaza@hotmail.com	Marina	Arenaza Iparraguirre	f	t	2023-08-18 11:40:54+00	010be1fb3402a57401b31eae03e7acf086334bc9189aa85d953498a2bf338480ed7da24c66728afd8f1440c45d9b5a47671b70182ceb466e451d2ec714935956	2023-08-18 11:40:54.905111+00	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_194
325	argon2$argon2id$v=19$m=102400,t=2,p=8$cUlEUURjVHR2MHE2bVcweHB1aFpJNg$BARZ4T8XffWboLj4M7+fFg	\N	f	frangarcia400d@outlook.com	francisco josé	garcía hidalgo	f	t	2023-10-19 10:13:25.125834+00	\N	\N	t	\N	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
327	argon2$argon2id$v=19$m=102400,t=2,p=8$dVh5aXp6MUNsQm5IYnBZbGFEeVlNYg$EmhUI0t+wNXMpfEFwPSkpw	\N	f	rosidigu@live.com	maria	diez gutierrez	f	t	2023-10-19 14:57:33.209284+00	\N	\N	f	d7af123a92681ae1ca876b24baced471f0af9e25f8bc727b31a6e3f7244f3248181c92f68b7b9386ed7408b0aea80bd33fbc00bb17326563f5b528a12e5d2cb2	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
186	argon2$argon2id$v=19$m=102400,t=2,p=8$RndhWDFOZ1phMFM1WldseEpHREx6Tg$ixqapj7X29McB/8n1KxtzQ	\N	f	nuskita555@gmail.com	Ana	Lopez	f	t	2023-07-18 11:11:15+00	e1c721ab1f305ed17c64be51345f01ac47ab451322c79e5839b035d46d27f4ea21bc7fea8c4a211d6fe4e7f4995af5e0142ae99d679f5e4bc543123cea320689	2023-10-10 12:58:21.399789+00	t	\N	f	f	\N	\N	+34 625 18 43 85	1975-05-04	id_documents_back/84e039275eefa3726fc37f8f3fba2b642bae28b43d82835473dfe2e17d389ea7.jpg	id_documents_front/f296f7dd067abfa095a846ffa51446e9b6e18bf06b6069dfdce9b921211522b4.jpg	id_documents_me/5ade4e66d84334d2183ed4cc9a9c3f37a8bdb753101127e0c2660290607d327b.jpg	05428968W	dni	ES	validated	f	f	\N	f	natural	single	Profesora	pf_186
162	1c07c0e78a67cb889a7ccf95ddee56e96d9dace15c2b9bc834c2569f35c239a424bd5a0dec403717646efbbd9d3ec1d72bbdf89c13c346de1a84e358997eb626	\N	f	elmeunil@gmail.com.delete.6edd57	Núria	González Amigo	f	f	2023-07-18 10:53:02+00	5eba1bb703b0130e90fe4b0a9a14a12348191e4182afc8338ef9f682066c08df4fb3a5d5ea54681cfab1418cc93527973f242e4a1cec799a23f80a47eb99b4f6	2023-07-18 10:53:03.076646+00	f	244acdd442a991e4acf6651d23fc944f6b90b7e9be435350c322f6a7717d9c00ff750f2002773bc6bbca9039129591500427a5dfae3fb09dfd89b9632604d0c6	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	2023-08-20 13:17:43.135341+00	t	natural	\N	\N	pf_162
261	argon2$argon2id$v=19$m=102400,t=2,p=8$YUllR09rSlB5TmV3SFRqSk8wcU9Law$Fxn5hk1CT7dxd+iSlJoC4w	\N	f	dolis11728+1@picvw.com	test test	test	f	t	2023-09-05 21:10:33.325722+00	\N	\N	f	0cb24ed760e424fa27674b5547a89ce8bb4ad35071e0073194e6d3738effe0731d5ba4b1def68eee6339bc0c5d3cdb3ce97471ef520e418de5b23f11dd466af1	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
305	argon2$argon2id$v=19$m=102400,t=2,p=8$ajdWWmIxTnBlajJ5VEJYaG05MjZzdQ$J+ul6xvYMfnaLoxzcQuNKg	\N	f	yadiramolero@gmail.com	yadira beatriz	molero fuenmayor	f	t	2023-10-15 16:48:26.99569+00	\N	\N	f	91b1fec613b340872fe6e198980fed9a1f3c40cbcc5c2d580b5c783fcaa0c09d0c9d3063877e0dd18a21336d3a4a8b10bb3daefcb14bd4b401b507780798453b	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
163	argon2$argon2id$v=19$m=102400,t=2,p=8$MGhQdG9VSTJIeUNNWU5YVmt3MDBZaQ$5MHapNxZUrCfWWhUOZv3XA	\N	f	nereplen@gmail.com	Nerea	Rodriguez Rascon	f	t	2023-07-18 10:53:52+00	94cd380d31e0b9863181f4be7a0785aa16df6214475341809c44e3acb67d3e09a0a8875960d1f9569ccd43ffb2cdefe857d4653d6412936a742ec6eb654ff24d	2023-07-18 10:53:52.491436+00	t	\N	f	f	\N	\N	+34 687 69 86 12	1984-03-10	id_documents_back/ed2fdf653349a0499d2327ced50b53da0b62851bd0d2dbcd7e32b31cd94ef563.png	id_documents_front/3992464ae3d915384be38dea741c656a3d90730d4f3a51d15d814fc52a434754.png	id_documents_me/78bedd952cda5d58d99633039677ed8a00fa91b6c4825e51553562e2acce7739.png	72576123Z	dni	ES	validated	f	f	\N	f	natural	married	Esteticista	pf_163
164	argon2$argon2id$v=19$m=102400,t=2,p=8$M1VpVmxOb1NGQkxZVkhodkF0M0traA$BkVFmKHJJixO813dXwW9WQ	\N	f	liuwangpt@gmail.com	Yameng	Liu	f	t	2023-07-18 10:54:30+00	5b09dd6227d7c9f28ef0f5997a2138a70a342fdc085209ab006da81125ceed362493201be7a0076aa01015bb3bf0db37304289a01f1d665869d7ad93f351bc92	2023-07-18 10:54:30.460455+00	t	\N	f	f	\N	\N	+351 929 055 766	1978-08-20	id_documents_back/e80e55583ede7af15eb4f32798255493bbd6e24637565d401aab90cdacdff419.jpg	id_documents_front/1d12f564314c62e109cb24b99e41f1139359cbce71125d26b52a8472621abcb0.jpg	id_documents_me/5f0e2ea23081a2f197a520f514ab80b5f6ed17559ce13d53013a1cb0dc317b26.jpg	30960409	dni	PT	validated	f	f	\N	f	natural	divorced	medico da medicina chines	pf_164
176	20a300727bc070dedd324f1e52fe2d5c90a01b77306452342ccd3ce9c686698129eadbd7b98fe04a58f7fc798eb4857551f6b985be9647386f7ed0214743f704	\N	f	yumava@hotmail.com.delete.d89d13	Yuliana Margot	Valerio Alania	f	f	2023-07-18 11:04:18+00	db24ad491f8bad9cb894ae95891ca9c4ad04b62dd56a871c8934d82063897079973e80be33dbedcc95801e93bb12a62634b4554eaa346ec1180868f762a42fc8	2023-07-18 11:04:18.83583+00	f	11d3ff2d461468e6f2c5fec7e8bc9f590cdad7b9847ce8e467420d102d5027a07ba225b1efedd528bfc94cfc57a3246605bedc88d34291dd96f2e7be703c92b7	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	2023-08-07 10:57:54.890291+00	t	natural	\N	\N	pf_176
179	argon2$argon2id$v=19$m=102400,t=2,p=8$a0k1aFdPNno0T2VLNkdkaWhvSHNSQw$wCmdvs4qon6eTYudJw+3dA	\N	f	soniadeba@gmail.com	Sonia	Amiama Rodriguez	f	t	2023-07-18 11:05:55+00	f5e9cbe5cb5ae534355135fc0cfa267258f4c020ca80a61de97a7fd5de287b41623144bea125570a6fe80ead57ad4b44e424e01acdf995dbbbb1d3da90c6e09e	2023-07-28 07:32:55.155274+00	t	\N	f	f	\N	\N	+34 669 90 12 74	1986-02-05	id_documents_back/4875503d876d6babcc58dc1eb0a9ca909a6eb04d4a9b69c885a642d58a66f3a2.jpg	id_documents_front/a4a34c6981dbc67e7930a668cbb7234067581afb32bfbb58a4bb0b7f4d4b2e3d.jpg	id_documents_me/1e79a2514f8f5d32dbe19ef7979ce609af54a6759986fdbff9cc69a134ce7f66.jpg	72460497D	dni	ES	validated	f	f	\N	f	natural	married	Trabajadora Social	pf_179
195	argon2$argon2id$v=19$m=102400,t=2,p=8$ZXUxN1dpU2FJSlIxWjJNM1BiYTB6Qw$9qYEi7bazKtkv3Lr5RqMZw	\N	f	naji.bizri@equito.app	Naji	Bizri	f	t	2023-08-21 12:03:37+00	\N	\N	f	d42b8d5fe1f6db953542cf073d6dbb8461c27421812777d89dc1fc2ea8661836846f14f83c55a670eb791299bad1beb733503a7776963c5119e010a4c20986f2	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_195
183	argon2$argon2id$v=19$m=102400,t=2,p=8$eDcwajZoZTNRUXgxV2hoZjVYVURwbg$pzBFMboUiFL/wkmb7UO97g	\N	f	davidruemanonelles@gmail.com	David	Rué Manonelles	f	t	2023-07-18 11:09:11+00	acb64d352b6bf89cf27a03cfa91bfa5aa810a5278af8e0f9f1c6affe9b49f8cb7286b23f0e417d3dbe9c23f18d48608854bbe6844085fb116b4b630e175e8901	2023-07-18 11:09:11.699857+00	t	\N	f	f	\N	\N	+34 667 67 23 15	1973-09-12	id_documents_back/74a2a1a88884f5962df0d45edc1ba2cc62e7aec32aa1d062713f1742bf3366ea.png	id_documents_front/6b9e11cf6807f42226e0a749f25a7f8966d2aad2837a4bd41d5ccb28a98b66d5.png	id_documents_me/53eb77ca90fb9ccc44be1a435a5d3b7f480f5f0a2d61c36cae396edfc4ee13bf.png	43736241Q	dni	ES	validated	f	f	\N	f	natural	divorced	Sector servicios	pf_183
287	!YT7cZGu4WJ4LMqQLAgA1fFrL96AOqFbBlWOBRDJc	\N	f	leolower@gmail.com	Leonardo	Lower	f	t	2023-09-29 09:55:32.335709+00	\N	\N	f	1355834d36a834bb509d972a4cf3f0729afab2dad253c6659f1d43ee52431bdd346c73b433dd53cf89ae406736c7632a9ce7e4fd203e8f770adb9acd579a0016	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
112	argon2$argon2id$v=19$m=102400,t=2,p=8$VjNGOFJzNkdwVE9UcVJ5YWlMUFRWQw$I3rVS2m6xBW04ByQgZnAXw	\N	f	sandracasado13@gmail.com	Sandra	Casado Alba	f	t	2023-06-13 14:08:01+00	952ad225dca69e9b3ff9986e44cdea43666015b354705f1542a160a4478586d0089571fe50701fcf77573c6868c05c4942eb895c495424bbfb557fcd299dc409	2023-06-13 14:08:02.322142+00	t	\N	f	f	\N	\N	+34 637 30 79 52	1996-08-28	id_documents_back/2012a11c5a87cc2a6ff373449db1f39d2a9f12a9cca39044c02e3dc6794eb887.jpeg	id_documents_front/2c25be6010ad65687beb132b788f4ea7ff74b893463eb4fe3742a63add47adbe.jpeg	id_documents_me/fbe28aafc0b0bb50394da9c545bb59de7a4e5f2e111fddedc18f4dd079a3ec5e.jpeg	17462645X	dni	ES	validated	f	f	\N	f	natural	single	Hoster	pf_112
345	!vcTucNttz6lFoHd3LSJgdC3Vv1NE9JL7jalIogZq	\N	f	mjhuertas@thelighthouse.team	María José	Huertas	f	t	2023-11-20 19:07:59.453102+00	\N	\N	t	\N	f	f	\N	\N	34+34619364782	1976-06-27	id_documents_back/b214139dd784dd51785c4d880844ecdc241e17df746161122da1f3ad0136870d.jpeg	id_documents_front/76d2cd70072cfedfbb7560d2ef42f9d029af79df6256a864505ff7cc0e055ede.jpeg		44280127K	dni	ES	validated	f	f	\N	f	natural	\N	\N	pf_345
170	argon2$argon2id$v=19$m=102400,t=2,p=8$WGdpeDYxZ1UzanllcklwdmFmOGtDbQ$sgd7o4a86RSTDuQ7H22SxA	\N	f	koldobikacs@gmail.com	Koldobika	Vadillo Astika	f	t	2023-07-18 11:00:04+00	b413afb863139fea6afc8057bede6cf2504db720a292d36d61e8aff31d269919fd11a7d2b8b7470a38eb6c162f16e1bac055cfb649c0d6ec94e0208ea0db2080	2023-10-23 14:26:37.659702+00	t	\N	f	f	\N	\N	34686129066	1975-07-28	id_documents_back/c5d2ba33f428fdd85577e3dd5e3b969e4e9861bca6adebe075692df7de017da5.jpg	id_documents_front/e148d724325c6f7843acf77b2de9ffabe4f7751896cdc08537d4ea3a7c331b13.jpg		16061417B	dni	ES	validated	f	f	\N	f	natural	\N	\N	pf_170
173	argon2$argon2id$v=19$m=102400,t=2,p=8$NGNrVnFOQ2ZHZFZUcm5zaVRBMXFsRA$n3EnA0yyliIU6FBVe82YzQ	\N	f	mariarodriguezmena92@gmail.com	Maria Bella	Rodriguez Mena	f	t	2023-07-18 11:02:39+00	301199c40a273f2990a00ea080b682d7e2c8a73b7de443b400cc943bdeddff83d5e533b43ef35854c952cf8727b39c9d6cb3b883b4bf819417e68ee5a84e9a60	2023-07-24 19:01:47.404754+00	t	\N	f	f	\N	\N	+34 655 09 85 97	1992-02-15	id_documents_back/90f4d3b1d0106f4641108439cda0297aa9e21f781ae68e7ba43cd150ea985be6.png	id_documents_front/0854e14603e2110dd122a019cad36076210a07de490a01df55a157fc2288ff79.png	id_documents_me/14e117cfb728dad153c8ca7d2ec276509650eb19992a7a5116e3ee384654105e.webp	29610491S	dni	ES	validated	f	f	\N	f	natural	single	Recolectora	pf_173
157	argon2$argon2id$v=19$m=102400,t=2,p=8$aGxDdVhrdjlHNmFqbUd4NFBKaktqZw$/xSF0lN+H6Gc9wLz7gBkJA	\N	f	augustocp.coutinho@gmail.com	Jose Augusto	Coutinho	f	t	2023-07-18 10:49:15+00	24715fbdf722643c9ab553adff52fe610a54f568be9a6d73b143e092ff97281a0ed530d2ea23df84e002ce31ec317be25fb5ef3cc0f2b034601c95225e1b8538	2023-07-18 10:49:15.909481+00	t	\N	f	f	\N	\N	+351 920 053 356	1952-07-17	id_documents_back/9661ce5eea7d901a2cee167fcf00c9c7d82f7a7ec96bfda84db9e17dc32918b6.jpg	id_documents_front/4429f42a6f442ab0815452a02e9bdb885d05db0f647175bedb42b3110cc0e6c5.jpg	id_documents_me/1ab47868d21f5754876357203f07dc8a6c4eb579e1ff76f03b7c6178c66587e2.jpg	02527073	dni	PT	validated	f	f	\N	f	natural	separated	Terapeuta MTC	pf_157
187	argon2$argon2id$v=19$m=102400,t=2,p=8$Y0lkcUdmWHkxb043cWxzOHNhOVdCOQ$pTMvksoru3vgdn6GoIsXTg	\N	f	xavier@xepigar.com	Xavier	Piña	f	t	2023-07-19 15:53:19+00	\N	\N	t	c3a842d7719b8d8b626f68a184fc5ece38c08bdf7838b104b3b637cdd9f688d799df01b19dced54db2d90d3d207c44fb03327dcb7265773d417ff43eb59f96ad	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_187
149	argon2$argon2id$v=19$m=102400,t=2,p=8$V1ZaaG4xQ0hzdURMREFhdzZyMHpSWA$EePrcig5PRbod9mkwlM5XA	\N	f	cristinaadrian@yahoo.es	Cristina	Adrián	f	t	2023-07-15 09:07:56+00	b86e690b0ae413e250933fe75b322b4d812ef372cb15b5c0b3f57e33dc72b5969208cfd5d3294e42fa921b133068e73192d595397ddfbef703d259fafc69c0de	2023-07-15 09:07:56.615841+00	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_149
288	!62Nyc6nKsMVWZKhUJ53TcLjP4yMvGMQ1CHIouiza	\N	f	vzamorano1@gmail.com	Vicente	Zamorano Montagut	f	t	2023-09-29 11:40:48.582411+00	\N	\N	f	66c0e951c513d2a634f3a8491076af04b00c80890eba5e24cc8779561a85d50054446936fc079d865d3641e4dc7dfcca962039dd4ee9d840528d7eda8fed2f90	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
178	argon2$argon2id$v=19$m=102400,t=2,p=8$YXYxRndCWHZFZ2N5ekVoUmo1T25Ybw$dBKyD5ZGtjIeudE/PeqlSg	\N	f	m.garmendia2001@gmail.com	Maddi	Garmendia Oregi	f	t	2023-07-18 11:05:23+00	cc74a2ca7bf3be1793a0b3b86ed7244d6c0f2750316f87496de2c793d4d1ef86cc3d80fde2c9e1084d1d74e871a1a479582f83b74c023a904ff0cf2cbf1d37ed	2023-07-18 11:05:23.685818+00	t	\N	f	f	\N	\N	+34 677 08 82 68	2001-06-19	id_documents_back/c604b23acbcb47e3ebb49fd64905d07c3afe37c3fd8a099a165c679ce4bf2bb2.png	id_documents_front/17419cca82dc33cd1d45eaeb7bd119f3351bc54130278aff6b0515afdf47cb46.png	id_documents_me/6c17a67820a9e7e2901d79de1a2d9f28f13aa773b1876fbc24aecbf411523b86.png	45167262T	dni	ES	validated	f	f	\N	f	natural	single	Estudiante	pf_178
171	argon2$argon2id$v=19$m=102400,t=2,p=8$ZjdKeHB1OVNYMkh0TTU1eGh1Q2dGeA$qDO3PihjIWHfXicge1Cvug	\N	f	jesusrm.rr@hotmail.com	Jesús	Rodríguez Mena	f	t	2023-07-18 11:01:33+00	81969585eaacbdef744ef205c35eb2f16f5e62e6554905e499cc398c9f67c8a0ab45debd085cdb1bfc61ceab83574605723f3d3a1184791144629446b9b7f0fd	2023-07-18 11:01:34.005374+00	t	\N	f	f	\N	\N	+34 659 81 80 31	1990-06-01	id_documents_back/a61a97b69ffc39a7c24ce12b639f16da221905cc1be06139a0c05798c837fa57.png	id_documents_front/1304771e2aba2b3952637b688fd523fc3d04835098a09ad999989957c9b60422.png	id_documents_me/2886b1635486cad9657c3d251aebf9cb261f283005790777b3ac199052f382d0.jpg	29606835Q	dni	ES	validated	f	f	\N	f	natural	single	mecanico	pf_171
146	argon2$argon2id$v=19$m=102400,t=2,p=8$cTNzNXQyS0dqQlJzdmlyTk5MdTBZMQ$OcCuMmG0FYJ78fdCmgVuTQ	\N	f	martagarciahc@gmail.com	mgp	gp	f	t	2023-07-15 08:19:48+00	61dd73e5ab4dda9530ebb3d7a5876ddc620a2d882c20cd648f3101cace1eff43160a8a0a07101e54ac8d730b49059003eaff0fb8f00b9daf7c91f673e614b535	2023-07-15 08:19:48.963095+00	t	\N	f	f	\N	\N	+34 650 62 21 75	1963-11-05	id_documents_back/70e9a3eecc46c4fdb9527de2947292861defb16d42ba128a5b9f0333bae364ef.jpeg	id_documents_front/f563264a4bba82461c6b57b8544512b4dd5f5225bfb799db80dbb763fb265afc.jpeg	id_documents_me/09b18e8970a9535761b8f42ff5570294b2da36eac287d9b2b3d667104a6d260c.jpeg	05255358L	dni	ES	in_validation	f	f	\N	f	legal	married	Hogar	pf_146
316	argon2$argon2id$v=19$m=102400,t=2,p=8$VHNVMlNGQlQ4eUhFMTRCWEV4Y0xJQw$fPr4WNY2MI0774J9aLGYJA	\N	f	manuelmongarcia@gmail.com	Manuel	Mon	f	t	2023-10-18 09:57:16+00	\N	\N	t	882c38c02a3a91ea2fce3b632f9c63a5620425b6fddd0b670f41cd38be2927cc0916c9f83a83b8f7eac64597a32bd0c0963c4dbb5ee220a2d41a972d648e255c	f	f	\N	\N	34639242612	1971-06-09	id_documents_back/bfae3a894f9abce8ef2ad1ef6d4f7115e4684b5f2a8ebd4f7a5f01aab95d0371.jpeg	id_documents_front/385ce5b8169db1916aed78b741ebbc0d9a5e978a9871343406ac030df1a05759.jpeg	id_documents_me/d2f59f2cbc434af90578986ff33de113f2e610ececea2eb9b758833dfe228bf0.jpg	339939369S	dni	ES	validating	f	f	\N	f	natural	\N	\N	pf_316
169	argon2$argon2id$v=19$m=102400,t=2,p=8$Wmd5WUxpWE9MY3hTemlJck1qa2N4eg$vt1MLUL5CPC3rACJyv+Usw	\N	f	paulanpi27@gmail.com	Paula Andrea	Pineda Pineda	f	t	2023-07-18 10:59:09+00	ecdb09877a081c4d744004800205329a02fd17df9d0c5e7d5ac9b85954d5317f06d3848625d40a8c14bd92fa6b0ed15e061c4d73c39a812ea0d5d18b8361ff2c	2023-07-18 10:59:09.341806+00	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_169
180	argon2$argon2id$v=19$m=102400,t=2,p=8$SUVmTHNnT09IUU9oY2RUc29vaDg5Nw$zic4LUYbJEbU0dyvxvgIPg	\N	f	padreindependientef@gmail.com	Federico	Calderón Rengel	f	t	2023-07-18 11:06:33+00	2024a5998ab9398544827de3160fcda46b2afbbd2f744f7ceb72e0c685f7164bd73367e83c2597fb66bcb5c175a26360ec75b1f933823180b2cd51fda0b0a528	2023-07-18 11:06:33.555259+00	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_180
181	argon2$argon2id$v=19$m=102400,t=2,p=8$eUdXdWJHT2NaTFc5UmFLcU4xNWpGWA$Tk3u+yRa3TwfDopcIGUc4Q	\N	f	erleitxu.t@gmail.com	Erlei	Churruca Maiztegui	f	t	2023-07-18 11:07:54+00	0e4df35830e981bbca71144026f2192dd3af404e8aef69cd46b54da1d14a4853477c47948b6b357581be9f90cba8e6f68f674f357f891debc88da08eabac7527	2023-07-18 11:07:54.345038+00	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_181
109	argon2$argon2id$v=19$m=102400,t=2,p=8$NWZtS3kzR3VSYXVkenVURm04MTVOdw$xoHzyv4fnRTiuipy+F6+kQ	\N	f	gemar68@gmail.com	MARÍA DEL CARMEN	MARTÍNEZ MARTÍN	f	t	2023-06-13 14:05:34+00	bde624db323e0cf4a639db105373e2ef500dee44053560404865da863eefeed2321a3b07ac2f205c9042ec7b44091cd12c7c7da465d64fae52e3e3d1d7f667e8	2023-07-17 10:58:29.752061+00	t	\N	f	f	\N	\N	+34 646 59 38 26	1961-05-05	id_documents_back/f82a80834f022baafda41359ee430f2d3834d6a54e07a50bcb8f9eb374b24a97.jpg	id_documents_front/51e8f8dfd9caa71a2c7bb676b22de14a721bd1e9418f6c4ef919b57779c3d045.jpg	id_documents_me/f03b1838b4efeb34999f9b0fa6a520681e4380c170a0d9932de220fae072951b.jpg	08959266F	dni	ES	validated	f	f	\N	f	natural	married	Diplomado en profesorado de E.G.B.	pf_109
165	argon2$argon2id$v=19$m=102400,t=2,p=8$QlZqclFkYnZOUVhvQlNGRUM4VVpzUA$KLjLR8bZIpZgEUy5v1+QHA	\N	f	ligia.angela.ventura@gmail.com	Lígia Ângela	Varela Rodrigues Machado dos Santos	f	t	2023-07-18 10:55:35+00	f1c499a154e6b2dbf4f84d2b0c03b06819491fd8c03535866eda454778ec52b9305120d16eeac70d7e26abc1d79cfa925a8b3761d68b7c31a406fcc32fa34756	2023-07-18 10:55:36.127297+00	t	\N	f	f	\N	\N	+351 914 019 316	1967-09-10	id_documents_back/3ea6e5fce17863b855869a7ec707ede03e472c223311776e511737dd11386b6f.png	id_documents_front/d5880ac6e7625ca4aac98327f845e46d700237724ffdd6fa309c39ce4ec48238.png	id_documents_me/e766c5fc1e45cec99ef866cd4a9fa8e9da14416adfee86466fc7b772cf316297.png	8074092	dni	PT	validated	f	f	\N	f	natural	divorced	bancaria	pf_165
160	argon2$argon2id$v=19$m=102400,t=2,p=8$WFVISmVPb0VkTlhlSzg0aGtOc1ExaQ$ajko3HxD8dyri/kyHPq1Tw	\N	f	javipersuasivo@gmail.com	Francisco Javier	Lozano García	f	t	2023-07-18 10:51:30+00	b43f09d57aa347ca70211a8532747ffd73ceb2a865015c1b496965b0a5150a50283448e1e579256db855e4ba381c746b26e07a6a17e29b2e5f0781ea129efdb2	2023-07-20 15:08:53.814893+00	t	\N	f	f	\N	\N	+34 629 86 65 75	1967-06-30	id_documents_back/245e977a5f35c0e4450afcfaeb4631ec542a87293bd33344c5d128ec9745c8a4.jpg	id_documents_front/aa198a895b2153f18f97006520d462e4d803028ccd0112ea936b46b32b4d9be3.jpg	id_documents_me/52296a314f97c34c986e82c4c6061f0a2180c32a807742705f53f0fa37b7b731.jpg	07532613K	dni	ES	validated	f	f	\N	f	natural	single	Agente de Handling	pf_160
199	argon2$argon2id$v=19$m=102400,t=2,p=8$bkZadE1TR1JKaTlaSmJ5UWpQTlgyaw$eyaCgmt2yvbnMZUaRsL7Nw	\N	t	rodri.595@hotmail.com	rodrigo	erazo	t	t	2023-09-03 15:28:23+00	e94371bc13946171722c634a6f0432687ddcffe3b4c42a09e1e67914a99ac7fd98a1d3583fbbf6446986b1a41c7e92ee9002cee084c544f0666b3820cd518d00	2023-11-07 17:25:15.292214+00	t	\N	f	f	\N	\N	50494653801	1995-05-12	id_documents_back/4a4239af1b8d7869d5d8bed8946d116b63fd8bbfa7ad017baaf06ac377bec5c8.png	id_documents_front/9b167f10e90f13a1e69d6648b8b97a9b25cf427a0c28c8214147829abcef638d.png	id_documents_me/541ef25c3b2fed3185ac53a800becc37524fb4d3ef83cf6eb724e9e5fd96b566.gif	1503199601073	dni	HN	validating	f	f	\N	f	natural	\N	\N	pf_199
262	argon2$argon2id$v=19$m=102400,t=2,p=8$ZzRQZFFuOGxFUk56b21WUGpaYzlRSw$LvBi1v3wAIXrPSmgHcaFOg	\N	f	rocasin596@cohodl.com	test te	test	f	t	2023-09-05 21:12:00.517182+00	\N	\N	t	\N	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
101	argon2$argon2id$v=19$m=102400,t=2,p=8$TkdxSWtDeVR5MkQ5WGZhS096MXNVVA$llqtc4fMf0rAYTy0J33SOg	\N	f	estrellasanan@gmail.com	Estrella	Alba García	f	t	2023-06-13 13:50:16+00	33bce867110cd309e38c08a80d4707a482e577142dd8e335b57c34f56d90b70080ecb21fe1eb6b1cd1479ce650f5e0ecb280af84b321d8cfdd79085824527002	2023-06-13 13:50:16.675488+00	t	\N	f	f	\N	\N	+34 687 51 22 70	1971-10-17	id_documents_back/6bbb9adfa6e313563b94a96cb9e5fdd6b856edced5fa1f228c777dd99a8ab645.png	id_documents_front/7ab85ce3af76e588c29e744960442544c688186aad2d79306262bcd487aea6de.png	id_documents_me/6cc5ef68716e725b13fe7fb1336dbb79716687aeb48b50a1757984b20072021c.jpeg	25162561D	dni	ES	validated	f	f	\N	f	natural	separated	Dependienta óptica	pf_101
175	argon2$argon2id$v=19$m=102400,t=2,p=8$b1FWMUV4ZkVRV3ByZlk2TzVzaEFCdw$v5VZ/tX2SIjBtjLjcQ/lpA	\N	f	esperanza67147@hotmail.com	Silvia Elena	Barrios Joaquín	f	t	2023-07-18 11:03:41+00	c4133799afd4513c4b77f9e0f726e000f009fd37a8c39b4367dae1c5993bc4cc50645f07b74a18435dde8186c45a82479c9225d5ac5033280f32c59a0b5778b5	2023-07-18 11:03:42.012374+00	t	\N	f	f	\N	\N	+34 669 90 28 10	1967-03-02	id_documents_back/9b69d7ffd4329490d0f809bf8c472ebe9c92b67664684b7016684c32c9bb011d.jpg	id_documents_front/86b0aa30af783d155d7155e2cc8ae5e44125e94fc784f5dc10f7a0c0621e82cf.jpg	id_documents_me/3cda16dbf8bec447106b19d0fd48285a3ad32159f40c28b66c4d28590a789435.jpg	X7507256X	nie	PT	validated	f	f	\N	f	natural	divorced	Empleada logística	pf_175
190	argon2$argon2id$v=19$m=102400,t=2,p=8$UzJBcE9WSjltUzJrQnEyMm10RFVqZg$Pto3CqXURavKUJpiGBVRrA	\N	f	adriangarciacristina@gmail.com	Cristina	Adrián García	f	t	2023-07-27 21:41:42+00	\N	\N	t	\N	f	f	\N	\N	+34 699 90 50 93	1977-06-13	id_documents_back/02d6728a8c3c2ac59f1df00cfa27ca10d1885961be75ef2590061ec942f768b0.jpg	id_documents_front/d4f079001713e38b2ae35ba3443104f4ab3103211cbabc16f23cec18443271b7.jpg	id_documents_me/2c54877e24fb7b979d1170179cc6ff9b2ad2d55c0fcc36c276a127569b1a813d.jpg	52989547P	dni	ES	validated	f	f	\N	f	natural	married	Profesora secundaria	pf_190
189	argon2$argon2id$v=19$m=102400,t=2,p=8$QUU5SUtzZ2RkNm1iYURURnNmTXhESw$23KTjRHlx0k/kwzzhjWvtA	\N	f	roberto.espinosavera@yahoo.com.mx	Roberto	Espinosa Vera	f	t	2023-07-21 08:58:14+00	43873b8600a001fe4d1c8e1edb5c1a1bdb227b99e7b2316fb66904098fa13852a50adf7480fcc951935f5aad0e17a68cc52e2f3e4824c9ab8a897e77e5700086	2023-07-21 09:04:58.742797+00	t	\N	t	f	\N	\N	+52 33 3368 0987	1986-02-09	id_documents_back/5d29ff3d1f3087f2521d7c12723d82929f46c7fed4dac896bd979dcc0fcc4c8f.jpg	id_documents_front/3498085543be42fdecbd4c13d11aa56b3a3703f57b478f9bbf8ee7e0be1d4c45.jpg	id_documents_me/2383a6086bacc8b27a7e4ec5cb544db131e8b8ebf1375711bf2f9235ea43f354.jpg	31234208	passport	MX	validated	f	f	\N	f	natural	single	Abogado	pf_189
114	argon2$argon2id$v=19$m=102400,t=2,p=8$Z0RMa2RiZm5XQVQxdTRHRTllSE5VYw$iXuvEcm4L/nKDXk6QjrNxg	\N	f	mgoenagajuez@gmail.com	Myriam	Goenaga Juez	f	t	2023-06-13 14:09:08+00	a4c57f2844c12e482ded75fdb1338e960bf2019c2f2851f99d1182d9408afc13022237db9cfa026cadee2ee426df4eb343292c47fdaed78f19135570f4e6ce41	2023-10-24 13:45:17.414754+00	t	\N	f	f	\N	\N	34+34 659 21 46 06	1973-05-19	id_documents_back/ad3c446daf2ba0c100b5a5592e68172803e1c1d7f21a3a93e85f6458400a865a.jpg	id_documents_front/abb38a4246b11384c65a2e526f3cbf504fd340e7cc4ea12c80755e46c4eee154.jpg	id_documents_me/ca6ff6e72ec6eff6e3efa6ffa1832ebfd2b87b581069260c22c6c0b20dd0a7ca.png	72446261X	dni	ES	validated	f	f	\N	f	natural	married	Recepcionista	pf_114
188	argon2$argon2id$v=19$m=102400,t=2,p=8$UEo2NzNIU1gydFhSYThPRTF2MnoyNA$VNKOCaRRMiLrOgLjD16Apw	\N	f	elmeunil@hotmail.com	Nuria	González Amigo	f	t	2023-07-20 16:43:12+00	\N	\N	t	\N	t	f	\N	\N	+34 635 61 02 94	1967-04-03	id_documents_back/deb061376dbf125acd71c8ca7705fb672873f0f94ffa275fbd1a1f9f1c2900c3.png	id_documents_front/b2e21d4d4bcbe95b66188f9b39ccbf26bb4cc69fe723130792c09ead6df33f5d.png	id_documents_me/43b2ac2a0c0712e010f6a3aa92234e7760286fd0dfeff03503f7e76d1c231bad.png	37331043L	dni	ES	validated	f	f	\N	f	natural	married	Sanitaria	pf_188
300	argon2$argon2id$v=19$m=102400,t=2,p=8$WnBmQkRxMTE4NndjZnNiQzdDdklzQw$7MjVXjp86Apgu014VxrFag	\N	f	oxummanagement@gmail.com	José	García Martínez	f	t	2023-10-09 10:26:29.673205+00	\N	\N	f	ee730c0c602e292d12beee2b9819a0e4db622434fee6b1e8faf1bb196bcf2b57e6bf931e59aca76b6e386fb5050e80a1afd3f5aa7fb9c0510de5ed4624147dde	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
118	argon2$argon2id$v=19$m=102400,t=2,p=8$SnZHZWhXWVBtc3Mza0J4UGVST3h4Vg$de6JbIDN/CCCSmkvX1GBSw	\N	f	albertoxav@hotmail.com	Alberto	Carril Vidal	f	t	2023-06-13 14:11:59+00	ae871e5e4e9194caa6940f2e783666109d7f216f9d6b812438994c6a5ada359fc836250136241d2dd4db71c8c6f74b2e4ca00c5c2080a726d8cb78597cd13031	2023-06-13 14:11:59.382019+00	t	\N	f	f	\N	\N	+34 636 08 70 84	1992-07-18	id_documents_back/fd310d3db405376a346fbedc11a21b43ce126a4e7447d266c37ee7152e66d5d8.jpg	id_documents_front/12c6b085865cf57ee244b81668baadc285242a323343fd4937d14f0b0cc0dda1.jpg	id_documents_me/53e8129064e972398c953d5ff7c5ebe4b83b1c59600d625595bb25139470bf9a.jpeg	78806976Y	dni	ES	validated	f	f	\N	f	natural	single	Operador de Central Térmica	pf_118
106	argon2$argon2id$v=19$m=102400,t=2,p=8$bzFoQnZFS05xMTJmcXdwU0J3MnZIVw$HtelTTV1UgroH/vDaFHzxw	\N	f	jadesame@gmail.com	Pino	Santana Melián	f	t	2023-06-13 14:02:40+00	cae85a6fcd85825e8b077f6a61f319b12d8d7bf1a19e95eb79088177fb73df32abcf168bc9c15de917e64188179232b676f924b0082d344a99bde04f93c6def7	2023-06-13 14:02:40.701123+00	t	\N	f	f	\N	\N	+34 606 79 72 09	1965-09-22	id_documents_back/566d492138eecb6dd1d6f80dbfca2790560be60c1ad9b4088198192632193087.png	id_documents_front/55a328f5f0815c466163aa68186de9bec0309ea89a4ec3b6d28e1e30665646a6.png	id_documents_me/6d26931e8299d711db828961417a7084dc204146af8149eb823b3eb45b5d50ef.jpg	42831573F	dni	ES	validated	f	f	\N	f	natural	single	Diseñadora	pf_106
317	argon2$argon2id$v=19$m=102400,t=2,p=8$eDhtUnVOd2hLb1VpblpWbGNGRDVMMw$HW/Tb5IvR0PMvm758fGZsg	\N	f	druidaloko@yahoo.com	miguel	diaz ollero	f	t	2023-10-18 10:00:55.176155+00	\N	\N	f	5f248e33a0c17b01cc83b84ca92cd466fca631dadd0129bfa52018ded67ea90247597ad8ba6c3404d18f491d5ed01518c2620c4693ff20992f2de86406b4feb9	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
198	!lIB4XuSzJS3lk1jCg5DZW5KByZFZbG3hZ3Hx3RDA	\N	f	rodrigoloco.595@gmail.com	rodrigo	erazo	f	t	2023-09-03 15:25:46+00	\N	\N	f	45cbb8cd1d856313e968c889f1ed940a1264b30e5df66f0aadc8de031f2c1e9aea7dc79008d6e85d166fc2eac8e6139d23b0662ae32a288f008623f91b1216e1	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_198
99	argon2$argon2id$v=19$m=102400,t=2,p=8$Z29TbEtWWkNmMnEzUHNJZU9wVmFUOA$Z3Ljjwzk2YUzMDoOIIBurw	\N	f	btola18@gmail.com	Roberto	Lasarte Aldasoro	f	t	2023-06-13 13:43:05+00	730b89419d06bd40c662ecdcdbc0120349dd487247b90a01199099e2a75afe98dd93eb792e91ee6412b0194d10f29e43e8841e9cd497f3ec1d9bd87bde521542	2023-06-13 13:43:05.453396+00	t	\N	f	f	\N	\N	+34 617 02 76 17	1973-11-18	id_documents_back/b1d57cf0d7a7055fd38a657888484b999f8d2e8a3fc17fc5eb6d196e65cba55b.jpg	id_documents_front/f11c0ce32c2418657cef3404227f966e1cc4223129f155d6fd7e468624dcfe7c.jpg	id_documents_me/b1c4d595f2356a4ab38ce87c18d7a6339ccfa3e47857f172a7127119e4923fa1.JPG	18596279C	dni	ES	validated	f	f	\N	f	natural	married	Técnico Organizacional 1ª	pf_99
82	argon2$argon2id$v=19$m=102400,t=2,p=8$WkFQY2FEblBhODlYS3d1clNiNFVPbw$nh/kgkT4KcUHOyVnbd6lyQ	\N	f	consulting@blockimpulse.com	Carlos	Callejo González	f	t	2023-04-16 01:10:45+00	\N	\N	t	\N	t	f	\N	\N	+34 644 16 67 10	1988-03-19	id_documents_back/22504f91b7661212c7730643c3bd4b476a8a9e37f8fa4f63100ce1066cde21db.jpg	id_documents_front/1b285bdad45550b3828bb64180d3f42c8c9e5069e99e717e5decd6bf32eac69a.jpg	id_documents_me/bb63bb079d52b3521ee5652aa6d351e504036243a3be6f836aeec5c88a57d3a9.jpg	71149272Z	dni	ES	validated	f	f	\N	f	legal	single	CEO	pf_82
200	md5$YgzH8Vjocc1aCm8jA5cxpv$4adb14da283cb666a83c8c36331c8046	\N	f	ssadas@gmail.com	asdasdsad	asdfasdfdsfasd	f	t	2023-09-03 15:48:07+00	\N	\N	f	28842b313a84d0b8d1f0f6c3969e87734453039470b283539f714f1eff3a1d25259d030b66ea5d40b7735f682d7b02887f8c4e9dfc322385ac35ae002d586966	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_200
4	argon2$argon2id$v=19$m=102400,t=2,p=8$T0JLdW1PTEgxZVlyTG9XSFUxWkNTNA$FMPGRHQrMuO5m7syt+6xOA	\N	f	fpalomar90@gmail.com	FRANCISCO JAVIER	PALOMAR TORRES	f	t	2022-07-31 11:01:38+00	20174d766b71b87ccdcc47b7d40171c3ee3aad767b9d938216a86371e943fe598b07655109b254df625131c8cef51f71d8ee078212b5c8e4fd7dcb05586681f0	2023-04-21 16:48:57.69299+00	t	\N	t	f	\N	\N	+34 629 15 56 85	1972-05-05	id_documents_back/3e1d8122c504d84ae4d2824d1d973eccfc98de5c76aab75d707ed2253bf73b42.jpg	id_documents_front/a92efdb5c0da6614c757092aaafeca0e1a78c816a59f388c348e6c90c1e7082c.jpg	id_documents_me/1dba931680fd6ac09b07125438012dd8eeaf7610a98112e6b456994bf4e56017.jpg	08913699A	dni	ES	validated	f	f	\N	f	natural	single	Empleado de Banca	pf_4
197	md5$uEFB91LUxipJw7tOCkHHhc$1d9232a9c0a89d5be46c374377d98296	2023-09-03 20:39:08.310418+00	t	marcos@admin.com	.	.	t	t	2023-09-02 19:16:48+00	\N	\N	f	d3b2379f95b091fd5ca464f49e5513aef43db1054e1b93fac91ffd8ea564c88984b1b1a224cf131271dcb58b3458d00d43474641235b4426f611232b9e37598f	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_197
107	argon2$argon2id$v=19$m=102400,t=2,p=8$YTVjNDJyWEFTd2lJcXJXZFdDWmpNbw$hWPS/sHrsK7OLwrWowULPA	\N	f	rnalava@gmail.com	Ruben	Alava Martin	f	t	2023-06-13 14:03:33+00	472bac9d57f8e662d843eab1f207c6ecf169becd0a1f1fa3b1809702bfd4cf2df386b1f16cdb8eb9ab25cfa3b45b1de9bbb537f25214b1bd8bdb6415ac1cff1b	2023-10-18 15:44:34.804668+00	t	\N	f	f	\N	\N	+34 629 00 90 33	1981-05-20	id_documents_back/0e736e36a0e80fbaac718dea2db6c350af4f7421ae0b0f0a9a6c9e19f4ee4f98.jpg	id_documents_front/e77db217b090bcb292634aadee900ea290c5e7e32c6bbe5006d35caed780a7ef.jpg	id_documents_me/6bfab19f6cb6239420a20b1f6121bdfe5ca2c876fe836f88feb5fc76068bb640.jpg	33443288T	dni	ES	validating	f	f	\N	f	natural	single	Fontanero	pf_107
24	argon2$argon2id$v=19$m=102400,t=2,p=8$RFBZaGozVURZckZSMThZcU42UzhENQ$G7071Jic4UuPPxJnZqZPZQ	\N	f	acallejo48@gmail.com	Ángel Lucas	Callejo Callejo	f	t	2022-09-26 15:42:15+00	d09af827c653f449ded521bd3e9696e2f4f2b340dfa9e1a7461e605214ac0be4ec3a3a349733afe88ed1cd6d30d865e3bf4d61968113e2639d0691cc0ca6ab73	2022-09-26 15:42:16.096105+00	t	\N	f	f	\N	\N	663974498	1948-02-28	id_documents_back/4864d84bb4e69d8984900efa4bfc512928badd78fde6bad521c87758a2fb3d33.jpg	id_documents_front/3fe7322ff7b64bb02b0816e00d9ac03f151d6b566d731edd85565f4565b0fa94.jpg	id_documents_me/468725217f23bd1d5d8a5d03599f015251249fb7c9fc1fdce82a7eecbe0b736f.jpg	00639206J	dni	ES	validated	f	f	\N	f	natural	married	Comercial	pf_25
29	argon2$argon2id$v=19$m=102400,t=2,p=8$elRkbVpIREtuOFVoekxOVEpXZ0pKRw$XGSN2HfYq26Bv0ZlDPHV0Q	\N	f	cbellver@claddingprices.com	Christian José	Bellver Muñoz	f	t	2022-10-01 07:12:12+00	\N	\N	t	\N	f	f	\N	\N	+34 660 60 66 30	1979-08-13	id_documents_back/144be099af85d57c9df0cda854118eecb686814176f08cd7b4077143b3e24e1b.png	id_documents_front/e9b85d55d4b76637e754905ac813c5783a234237cbb54cb8a31da66a52f33e31.png	id_documents_me/45416301f7bcb8476dd220c2db8faea2f72d7676e3b15483dcd6d2c2807724e2.png	06584685-S	dni	ES	validated	f	f	\N	f	legal	married	AUTÓNOMO	pf_29
322	argon2$argon2id$v=19$m=102400,t=2,p=8$aU52bHJiZkZJck13T3BwOHJ6ck1IRQ$nTOptqWrs05m+d+YCiCSBw	\N	f	peke2772@gmail.com	carmen	villagrasa esmel	f	t	2023-10-18 19:48:20.715897+00	528015155d0fd165cf9c7b454bfaf92e157756a4e9cda33b8d77561507fb9e474931474c5a7eed46087c41a4b05c07df5bd1911bb037db9ed593adf50b6d1561	2023-10-22 12:49:40.589512+00	f	68ea726dfdaef03b9f56d73eb00eada4616d95cf04665cdc09aa83660bca9efec87a79ad142e42b6b903b870766f0c3969497ff10fa418beb8f43776902c65fc	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
184	argon2$argon2id$v=19$m=102400,t=2,p=8$VW1VSmQ1VTZaWW90aU1jOFh2Sndobg$xfF0goTYjqPtEgN590dAmA	\N	f	arrazayuya@gmail.com	Obdulia	Bautista Mendoza	f	t	2023-07-18 11:10:00+00	c6b48ca6d53d629e0422663bbfcbdd821d7d5af068282c51916c96935b7c264b82b457f1a7de27472cf52dacbf7028a7217fcfb96f6d98796c3cc5bdda598044	2023-07-18 11:10:00.658274+00	t	\N	f	f	\N	\N	+1 805-616-3054	1980-10-29	id_documents_back/0c20a7b843575c95562e345a64d7531f5cecea7a9df585c39f21e8dfda0fa522.jpg	id_documents_front/74a8ca18e78d0a0d76e7dd10876988697a85bb03a45def6691c9570022d9a5dd.jpg	id_documents_me/0fecb5dc991b369e701a4feacd99f87b201f95c3eb17a3f3ca90d44b9f8b0dc1.jpg	Y2694173	dni	US	validated	f	f	\N	f	natural	married	Healing	pf_184
266	argon2$argon2id$v=19$m=102400,t=2,p=8$aklmS0lva092VXY3aVdvU3V3eVJvOA$oyc2+8a276kLJyuO8iJ3rA	2023-09-12 07:27:09.074483+00	f	thiagocmach@gmail.com	Thiago	Machado	t	t	2023-09-06 07:25:26+00	\N	\N	t	\N	f	f	\N	\N	34321654987	1990-10-10	id_documents_back/e4fd3a84da70e83bfc740d373cf5182ff52b75d19233a415f599f31280d3cc0f.jpeg	id_documents_front/9645c205c997c9c0d925a7910b0fe721e6772ee6ad6771ba19499a3fb5241206.jpeg		321654987	dni	ES	validated	f	f	\N	f	legal	\N	\N	pf_266
263	argon2$argon2id$v=19$m=102400,t=2,p=8$SnBRZ08zN3BBSVdwQ0FBeEVxWDMxdQ$iXC7rFbxQVkQPD89XkHuFA	\N	f	hola@blockimpulse.com	carlos	prueba	f	t	2023-09-05 21:35:55.985116+00	\N	\N	t	\N	f	f	\N	\N	34644166712	1988-03-10	id_documents_back/981ba2615e2bef851d3d4186e9bc7ba0acb0c5ee278283e1c6e2289f2cc4a2d2.png	id_documents_front/f5355a3df0dd7f2111eac8dc3eccfcb78d851a8f02b8971a9ba606f502d3873d.png		00639206K	dni	ES	validating	f	f	\N	f	natural	\N	\N	pf_263
323	argon2$argon2id$v=19$m=102400,t=2,p=8$dHhMeEtCSzBqT0cyVUVjUk9EMWhZZQ$TVfU9MgF3USOxVoH3WxQvw	\N	f	jifet70969@wisnick.com	test	test	f	t	2023-10-18 21:00:22.49647+00	\N	\N	f	0a4653bdeb596ebb91a9749a75505d70bc3fb19567be8b43450a5bdab84f1172fb1fe2d44bbcb4d27915f5c6ed95369cb21decb6c130a2ba99cf2b76eea9e263	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
158	argon2$argon2id$v=19$m=102400,t=2,p=8$bTh4M1NDZ1ZGa1F3dlpTZVp1TUU2cg$w9NfueiAt2hAr2fsL0wLMQ	\N	f	rascongarciavictoria@gmail.com	Victoria	Rascón García	f	t	2023-07-18 10:50:04+00	77a4b34b54372cdc5645a974c6fe116fc625d589ef01f2fad7d9659e303d3ae1f8d8850be8f92d87ef0f894f9bcf031d58b23373e9a9eec6d40d73549654f3d9	2023-07-18 10:50:04.444346+00	t	\N	f	f	\N	\N	+34 615 73 10 24	1960-08-08	id_documents_back/4626ae0399becb596bbd953bd9fa089d87a8e5553190fe9d401bd4f82f2ff36e.jpg	id_documents_front/31c6bb46f0e5fb04ff24906871d3c7d97f742ba88c063832fc1c389f2540187f.jpg	id_documents_me/fb1ea347a8dd27fb7a2c5a5266f829c9a5ca0df1a295cf39f61634f432a539a3.jpeg	15366739W	dni	ES	validated	f	f	\N	f	natural	married	especialista en mecanizados	pf_158
159	argon2$argon2id$v=19$m=102400,t=2,p=8$YWNtTkdhN3RHcXM4UGdscG1OMDdqNQ$PwME0TTXRHYdiVFHwnodgA	\N	f	leirecs@gmail.com	Leire	Rodriguez Rascon	f	t	2023-07-18 10:50:47+00	ef342d9e0170eaa4c91b9b250a0003109beae7f18d666ac170ef7fba5cd0d97d20a2232bcd291581438d417190fedf4975e33d3def136aa62a506243b7591298	2023-10-23 14:33:38.283234+00	t	\N	f	f	\N	\N	34606158545	1979-05-08	id_documents_back/d81431b092f7f2df986bccab1802b71feb2aca03c7ee1158a7843eb36c4983a7.jpg	id_documents_front/affc581bf145e519f2379925fabdc206d27cabb9c48ce58d9885adeb08c115c1.jpg		72576124S	dni	ES	validated	f	f	\N	f	natural	\N	\N	pf_159
272	argon2$argon2id$v=19$m=102400,t=2,p=8$aXlmWVpDUlRJNlo4ZXN1Q1R1VFpGbA$ioD9Pufu5JpoJa84DAOzMg	\N	f	leloup07@gmail.com	leloup	leloup	f	t	2023-09-16 09:58:03.200074+00	\N	\N	t	\N	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
177	argon2$argon2id$v=19$m=102400,t=2,p=8$Ymhkc1d5RG9MR2NEWEN5bzQ0NkZ2SA$TOyi6VpA+miAH7069fXkQA	\N	f	angelmnavarrol@gmail.com	Angel Miguel	Navarro Lopez	f	t	2023-07-18 11:04:51+00	2072074cea434eb0752db771cc63b79c9ab8ade01a960a79bc50d7353009e993ed473a4313e05bdd6a355a6d6773fbd80999c30c933f7127372a0e1fc26589a4	2023-10-24 19:06:32.782552+00	t	\N	f	f	\N	\N	34634507495	1965-10-12	id_documents_back/ecbf592970a81a48b22c44777747867220c29c5098934c0b9cf0b515e8bcd807.jpg	id_documents_front/881a88f751f04b0611f770f34f52fdfe46047242760d14cabc3eaac05f2a276d.jpg	id_documents_me/d06206831ef400e092d8eb4ff5f23de3b9c6c908470434842a327e1fbb7d08c5.jpg	73992246G	dni	ES	validated	f	f	\N	f	natural	\N	\N	pf_177
166	argon2$argon2id$v=19$m=102400,t=2,p=8$cUZtcGFWNVYza2N0ZlJTWnA1M3ZteA$pvbfjIwd5Xs9KFumo7TzrA	\N	f	carradafrancisco7@gmail.com	Francisco	Carrada Tello	f	t	2023-07-18 10:56:23+00	5bf7fac1b5f5650cae072a8fc1d9d0b68360e6c99f86f90ed447abbb99badd3a81a74e306b801e746fd385f7b691cd8fc8775caf646ccd9f75b9dc681da239f4	2023-09-27 22:09:56.472753+00	t	\N	f	f	\N	\N	1(312) 404-5019	1982-01-24	id_documents_back/717ae76ff51bfa09750c2bdce7de3c030f0c61c2a292790bf8cec4e5b3f2c31d.jpeg	id_documents_front/b5d206eb854b4bc5b1a2f9be213e1215351c6d3a85bd84b5c043e70acd0c876b.jpeg		A00354115	dni	MX	validating	f	f	\N	f	natural	\N	\N	pf_166
289	argon2$argon2id$v=19$m=102400,t=2,p=8$MDlnenVVNFdvWGU4bXg0aDhrMjBBTg$QEs25Yf2dfBWzMrCO4uW5g	\N	f	vzamorano@hispalabs.com	Vicente	Zamorano Montagut	f	t	2023-09-29 11:42:09.095911+00	072ed19d73db1f4a67451ba19bcd11e6272f5b174aa704c92806af4ea4f091f3c3a0e06a82c22bc37d76806e8c97740827ebf181acf88b7dc1cfbd5e17411aff	2023-10-04 08:55:06.828243+00	t	\N	f	f	\N	\N	34620720329	1979-08-29	id_documents_back/3d68ea185636654cdb3ddba8a45ce8aa340f6b57a76ce8cf34162ba6f6e3f3fb.jpg	id_documents_front/bfd191e905d4627805f42f2a99f4000cb4476f7ec0fbeec8a1e7824320b861f7.jpg		48435931R	dni	ES	validated	f	f	\N	f	natural	\N	\N	pf_289
193	argon2$argon2id$v=19$m=102400,t=2,p=8$UWV1Y3NOTWZMbk9XbnRpOFRZdFI1Nw$i9YosKV0+JiTsdmLXBxjvg	\N	f	silvia.mayfairbar@gmail.com	Sílvia	Carrasco Velasco	f	t	2023-08-07 12:02:21+00	58ebb5c3ebf14715efa7c6c9ba97cd5508d29cdb75c5e9027d59e9f7e8e095fe3af4f44e509416e4ed186c130268a6c5e8b4ebece3cc5750c1fbf94051a4da73	2023-08-07 12:02:22.052035+00	t	\N	f	f	\N	\N	+34 640 74 56 23	1981-06-13	id_documents_back/77bb6e461fc673ecb292b2b17d401f18b2b398178c98a1148865caa0c4ee5804.jpg	id_documents_front/e801f1b8d69a33b12c3e18ea38fd1c26f259a6b40e6658857d23b4c1da18b685.jpg	id_documents_me/34bb23f0adba1c7307df70fc19f2e2e821898b628962fc97e3863f12fc0e9e7d.jpeg	47637297L	dni	ES	validated	f	f	\N	f	natural	single	Camarera	pf_193
290	argon2$argon2id$v=19$m=102400,t=2,p=8$T0pQREU0M2VrMlE5Nm95ODBvdUlaeQ$H/ppGTxOkJQxLA5Y2xvvcw	\N	f	marina.imagen@gmail.com	marina	arenaza iparraguirre	f	t	2023-09-30 18:53:06.931524+00	\N	\N	t	\N	t	f	\N	\N	34634401195	1969-08-11	id_documents_back/39804ecc464570db00aac1bd7e7bb85ef5e69bb70643f52c4fad3aa6c1d8be82.jpeg	id_documents_front/1fc64328222825f0660ab8c46af0d579ef70b8735c3caf07c25d6bd166ec19dd.jpeg	id_documents_me/5e2699877683a1fb121906f1cf9656b700e2c693f3bfc51574bd5b8355bdfecd.jpg	50771213R	dni	ES	validated	f	f	\N	f	natural	\N	\N	pf_290
337	argon2$argon2id$v=19$m=102400,t=2,p=8$UnROQUtEODBiZDU3NDRNdFdzNkRPYg$GeT72kQDKJ7RS1ltEfDK7Q	\N	f	saulparisbocos@gmail.com	saúl	paris bocos	f	t	2023-10-29 11:22:38.156572+00	\N	\N	t	\N	t	f	\N	\N	34611777221	1986-09-07	id_documents_back/ee28db5463bd3043a216bf9445f6e471415b964de1a65039d56e42035caa2bb7.jpg	id_documents_front/902ad9bd647f53ea6fbca636d6c12b2f07afe5759bdd57aac1dc5708f45bd661.jpg		71154940R	dni	ES	validated	f	f	\N	f	natural	\N	\N	pf_337
258	argon2$argon2id$v=19$m=102400,t=2,p=8$eXNLMmcxcmZTRGVSS1ZKT0ZBMm4wUg$wHLiuS26vA2pFkfbBVvfpg	\N	f	dolis11728@picvw.com	test test	test	f	t	2023-09-05 19:58:57.726886+00	\N	\N	f	a7bff4abf1a2328122fa7881dc197f60aa38b116c355d72b2c0d767db49e64b7374b1ffaa26566f11d67b301b6c882fd6905f6483f5115e49f6107209c273249	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
167	argon2$argon2id$v=19$m=102400,t=2,p=8$ZDZmSmdPc0h1a0x2bG9rcFhyd3dsUQ$XYaSGC0GcFhTcT+qxphzjg	\N	f	joitturri@gmail.com	jon	Oñederra Rascón	f	t	2023-07-18 10:57:03+00	f0a21a874e0e17d9e60063496ae8fd82dc06371f799dced87d32bc5ad3ce13e2f3a4b86b8806bda4d08d7f37b2ef6719c080487b0d09e339b950e2c2a93fab81	2023-07-18 18:45:54.332403+00	t	\N	f	f	\N	\N	+34 671 11 31 51	1987-07-01	id_documents_back/306cab0b653893de71d252bd46a2b3ed7bdeea0700b0ab6509d4760faa7b5bd1.jpeg	id_documents_front/81813d7eeb387e8bf8e9eda4c1513a3f9ff853937bcb3b7e5d6bc3e49e46a5a1.jpeg	id_documents_me/855f5f27cc0bd9a43f0b001c4abfb96e1c6873af6c34cdbde26f850780243c17.jpg	44343580V	dni	ES	validated	f	f	\N	f	natural	single	Tecnico contrucción ligera	pf_167
307	argon2$argon2id$v=19$m=102400,t=2,p=8$U1JvQ2RVcXhyRk5ONlR2Q1g5c3VCRA$AcV5sQWThILD4S5PGGA5uw	\N	f	wysocki1810@gmail.com	Pawel Piotr	wysocki	f	t	2023-10-17 20:58:58+00	\N	\N	t	7658c87e464d120646f457472af935abb5be7b20a9614f3d2a61cf794550652a4fa6409340510bfb22f3f6eb5f3da3c77274899e33f6023629153ccb071f72d6	t	f	\N	\N	34644837169	1997-04-22	id_documents_back/2c20ce387607745015b78227fc414438498a049ea338011bbe70d1e2cddb53f8.jpg	id_documents_front/c3a5297afe7e535c4ee66bc00da6fb1b0ed5d677403284916d41da551134a746.jpg		Y2075592V	nie	PL	validating	f	f	\N	f	natural	\N	\N	pf_307
276	argon2$argon2id$v=19$m=102400,t=2,p=8$NWw2OE4zNVVMN3NMZmZnUXBKMWE0OQ$yzW6r/6pA8gDkMrzfUoelA	\N	f	bernalbeer@gmail.com	Jorge	Bernal Fernando	f	t	2023-09-27 18:06:11.791483+00	3182fc241b8e553caaa7c8855a0276e5c29b3e8f2db7680e475f9acffe4d48775c4356b5d2af35e64451c67a3cf9184b879c9e93b36dae6dd44c2ca031d23fdd	2023-09-27 18:06:11.935814+00	t	\N	f	f	\N	\N	34+34 618 736 134	1997-04-11	id_documents_back/0ef87c1263126337c4bc584001cd8544992b11424d6da1de95212b869cb1d011.jpg	id_documents_front/4c74b88577aa1d9edff5bd0fb60308a67f90f1d744729ae6896ef5950bb80b95.jpg		73134882B	dni	ES	validated	f	f	\N	f	natural	\N	\N	pf_276
334	argon2$argon2id$v=19$m=102400,t=2,p=8$SWJlMGJ0MUJYU2NYZEkybjRwdW9sUw$kDr/mrwtJNW0afdHIMusRg	\N	f	ernestoguardadopartida@gmail.com	ernesto	Guardado Partida	f	t	2023-10-23 16:06:10.82763+00	\N	\N	t	\N	t	f	\N	\N	34651535113	1973-05-17	id_documents_back/eeb454781e3486fa9c3e0308029b818423af963ecce23b83091a150b7fcec07f.jpg	id_documents_front/1e473a8c144570a8d3e2cab0b297b7c4a7f2be3f653e67b349514f2cd3d4b2e5.jpg	id_documents_me/9542cc3019cf2a605db94b63c35b51e8e09078fd94afb929b35eb46188f34b56.jpg	77310390F	dni	ES	validated	f	f	\N	f	natural	\N	\N	pf_334
182	argon2$argon2id$v=19$m=102400,t=2,p=8$cWFtdjROa0FoaXplUWlNMzc3T3VMaw$GZbCzyGWajSnbwDZmetZeg	\N	f	sarahiboes@gmail.com	Sarahi Jazmín	Bonilla Esquivel	f	t	2023-07-18 11:08:26+00	bb9b45b17a865dacb70c93610e68e118e026fee8529974067f0fd463f3b8b469be3a7b05fbcc42943459e7b7950cdc44701f00402ba69134974a1f0d4cf32fe2	2023-09-27 23:00:32.564866+00	t	\N	f	f	\N	\N	1312 586 0306	1984-05-17	id_documents_back/d5b01a56776828527d635b945971ee929f33f2ca51847368b6d186507f0db606.jpeg	id_documents_front/d13060fd4c79ee4500328cf17af0869d1901f828eda1123ee3b9d8873fa5f939.jpeg		A00697765	dni	MX	validating	f	f	\N	f	natural	\N	\N	pf_182
267	argon2$argon2id$v=19$m=102400,t=2,p=8$TTNUc2ZrOWxpaE5LWU91WW1jaXlzVA$KmtVEKu9+TsH4lIBn6LHQQ	\N	f	atapiatenis@gmail.com	alejandro	tapia	f	t	2023-09-06 08:45:36.963255+00	\N	\N	t	\N	f	f	\N	\N	34630423889	1998-04-12	id_documents_back/524c03249e987433708ca7731ff5d21c2975ac327e912cdefdcec89c7b7a4720.jpg	id_documents_front/d95ce8dddc3997f0ea3c5fe183a1e0812aae887dc118290128e928b6adec86cb.jpg	id_documents_me/f8dbdf184989928aca3530d88bb860a239004f647fe95ee3978b71a29a3924e0.jpeg	07271440J	dni	ES	validated	f	f	\N	f	natural	\N	\N	pf_267
271	!u0AfVpNaJqCDqaOL9Upl73yERZ3kCRoHwjkvqj3M	\N	f	vcallejo@stockencapital.com	Víctor	Callejo González	f	t	2023-09-12 08:28:47.281819+00	\N	\N	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
284	!pm9K8jfy9WHGyWQWXaA9zrOUp4OC0hZKiCYpKl0K	\N	f	cristiandelsaz@gmail.com	Cristian	Rodriguez	f	t	2023-09-28 13:49:52.884733+00	\N	\N	f	e0fbc4e40f3980c3b8314abd8a1eef7b8857ead342314d55d6b4340d308802b2397ebef10c461568654b2fbbeaa8031b0c9f72c3440d9fc2748cc68d62e92cc8	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
192	argon2$argon2id$v=19$m=102400,t=2,p=8$YjM2UldQYnllRzFsRWVDWWhVZDYwcg$eAc4nzxK7KAgbW195egxuA	\N	f	yumava@hotmail.com	Yuliana Margot	Valerio Alania	f	t	2023-08-07 10:58:41+00	c241a4053298d5310de90d404ca6a130b771ee6f1e47dd0083c9c5a8507c26047f77151ce64b092678d744f465cf5d3cd38c44d4d5b7023b8e296cba4f167273	2023-08-07 10:58:41.795063+00	t	\N	f	f	\N	\N	34659297205	1972-01-22	id_documents_back/cba620de821c2b310748080ee6c3cccbbcd5058e6de913e7d4624df7098bf105.jpg	id_documents_front/11c17c819ef2903264a7a3ce9a92582bcabbbe2253043079498ae654d4ea9357.jpg	id_documents_me/5cea65221718d3cea01be72efb02c082d5a276bc65bc76ce60240413b9c7f40d.jpg	49352796V	dni	ES	validated	f	f	\N	f	natural	\N	\N	pf_192
282	argon2$argon2id$v=19$m=102400,t=2,p=8$YkVDZEMzaDNya2ttZ3JaVW1rTzBWNg$LduULj/YIKWl32PUoALQPQ	\N	f	info@beeleafpainrelief.com	erlei	churruca maiztegui	f	t	2023-09-28 03:26:45.600768+00	\N	\N	t	\N	f	f	\N	\N	34633769195	1985-01-29	id_documents_back/1ab1f675d690cf2f67c0290945078a4a7f380b34a4189f68ea7107e43d789bdd.jpeg	id_documents_front/cffc91a1b2e824e5c9f6e5991759e95c5b9dd7e3d5fec17ad9c320d1fb159802.jpeg	id_documents_me/caf03e8077cd91c1a1a766edc9e631c26ba1b673a09a48a8b074b397c4b8e60c.jpeg	XDC888677	passport	ES	validated	f	f	\N	f	natural	\N	\N	pf_282
291	argon2$argon2id$v=19$m=102400,t=2,p=8$MENGRHlIRlI3QkRPbUFPcFdjbVcwNw$Xn4AOv8+rlUIgrcJzRBK/w	\N	f	eaznar07@gmail.com	enrique	aznar	f	t	2023-10-02 09:36:58.487675+00	\N	\N	t	\N	t	f	\N	\N	34639324678	1964-03-18	id_documents_back/84df5aae296cbc21136bcf91ca665e9db193ec222c332b6bf787bf72bc87649e.jpg	id_documents_front/5958f6c8fbb5c36141b92b32463183980f508e3415be4d98f4138e180cbfe878.jpg		46225630T	dni	ES	validated	f	f	\N	f	natural	\N	\N	pf_291
153	argon2$argon2id$v=19$m=102400,t=2,p=8$cUJpRnlZRkE4RzBETHVGaGJvRkZicg$ybCf8/zqxzozet5BIiQJtA	\N	f	josemameli40@gmail.com	Jose Manuel	Del Río Cuevas	f	t	2023-07-18 10:41:17+00	05733767453c7bdc0dd8bd9eb1d6cd58da5032f6791fbf750ac007143e3d4c602c67baaeb115a991bacc352073a5b402a11d9c7c660950c1843f39a7a9c3d989	2023-07-18 10:41:18.025002+00	t	\N	f	f	\N	\N	34676923590	1966-06-18	id_documents_back/ce7ac5f383e2c873c3e25eace563ba22df0bc1e038bbaba56d820af9ff867226.jpg	id_documents_front/5d1d9de1761448a8dafd48b9591d187b0c581c45110697d127a36e5799fd7e2e.jpg	id_documents_me/93eae91896d2e35afa06b02dd6f8bf08af09838e8059983d04befedf6e9239a6.jpg	04576040Y	dni	ES	validated	f	f	\N	f	natural	single	Agricultor	pf_153
185	argon2$argon2id$v=19$m=102400,t=2,p=8$NGNnVmhabmZyQUE5YlBraDBLcDVIUQ$uJLQkuqqqWyDu+1gjKS0SA	\N	f	carmenhr2006@hotmail.es	Maria del Carmen	Hernández Ram	f	t	2023-07-18 11:10:48+00	cc2052adf95c96dd7639e873b3463700e7b77c641271c4513887d3e38ad002ce91aef8d73c0ff80713721e3d3a7d8bd39bd6b112ced56337ad78327c83212242	2023-10-10 10:17:38.608884+00	t	\N	f	f	\N	\N	+34 686 72 88 16	1967-07-17	id_documents_back/eaa575dc40e05f37d90f7196fb0eaba413001678154215ad975e4975d9af652f.png	id_documents_front/6a935fb25ca51a970abca685845529d311098a4e6fe7301ea0ec84e575af2c3b.png	id_documents_me/e21904faacf8642c56ef9ff6ec7fe07a9762f3a7f5cc76cd1cd9cff5bcee8e62.png	43668874Q	dni	ES	validated	f	f	\N	f	natural	single	Auxiliar de Comedores Escolares	pf_185
339	!UeI9aoaExblxbUXwoz4wKGoZPOClHgAqsb2pvyEh	\N	f	joseluis@hernandezagustin.com	Josele		f	t	2023-10-31 17:27:21.789715+00	\N	\N	t	\N	f	f	\N	\N	34610447912	1971-02-13	id_documents_back/ff715ef4e418fb57d4549d46ee3dc88f13c5c99782749ec6a715dae0b9a54b26.jpg	id_documents_front/8301180a04d31905f84849508f98e0576e2aba3a68ecd4819a863b8995279eaa.jpg		12388387N	dni	ES	validating	f	f	\N	f	natural	\N	\N	pf_339
92	argon2$argon2id$v=19$m=102400,t=2,p=8$UzlQY1B0OGlXU0RnQnBqOWZjWk03Ug$qwHP5Na7dYb24FYVB/lLyg	2023-10-18 22:32:07.596704+00	t	thiagocmachado@yahoo.com.br	Thiago	Carvalho Machado	t	t	2023-06-06 18:36:34+00	133ee85fd616d30ddd2470510eddbb88b5eab378f3bf6f6ba454978140614c65534ccb2e0295185605bc5873ed16f5898d63ab1b82af3dcf7dee6642e63ae994	2023-09-12 20:51:07.366164+00	t	\N	f	f	\N	\N	34+34 653 57 93 25	2000-06-20	id_documents_back/70aedc035b60a5e2753eb0427b8bd5fe6053297fa046dded0760eea08e09bb78.jpeg	id_documents_front/0843159574f9a804ca10462dcfed438bca4b9ed4f313f0d6b45400baea54300b.jpeg	id_documents_me/91007661806c111fbedd60926ebb586989a352ac20752b411558e95aba594f93.png	D33323233D	nie	ES	validated	f	f	\N	f	legal	single	dd	pf_92
259	argon2$argon2id$v=19$m=102400,t=2,p=8$d0UyUkEwNXBmZUcwYmN0a1NtQmlFNA$Gc+KYm9LDNUmEQmyGoYWJQ	\N	f	jopab84759@gameszox.com	test te	test	f	t	2023-09-05 20:47:35.038562+00	\N	\N	t	\N	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
278	argon2$argon2id$v=19$m=102400,t=2,p=8$NjMzdENmSHZkUTB0VkJVamdwdzlmQg$pftz0U1qTFTc2+L5tltvBQ	\N	f	gsynedl@hotmail.com	Nuria Ester	Diaz De Luna	f	t	2023-09-27 18:07:45.82969+00	9a05e25e174f96a81fa3bfc103c3197f71f8c7be9b1bfe86f3c48bb1457cb7680ea06fd141f743b3f9854992851538d81622c2293e51f09dde0e78a45c3160e2	2023-09-27 18:07:45.95758+00	t	\N	f	f	\N	\N	34603313663	1980-05-10	id_documents_back/00d3d415ace0865bdc835ea7b99baeb2f7c2c3149f9559ce9bb13061d96aac64.jpeg	id_documents_front/93b73d92cf2551efc622d54518c3662d0de00862bbd30103a515e1194ac28179.jpeg	id_documents_me/fa2f8c2676b5f1457403c97ed17dce81e450518ba725193a56fe0f5a494f2baa.jpeg	26801042Q	dni	ES	validated	f	f	\N	f	natural	\N	\N	pf_278
145	argon2$argon2id$v=19$m=102400,t=2,p=8$ckR6NmhUc2k2OHhhR29vdjRkMG5FOQ$xumUo5lBEsyuTgNzYD4KNA	\N	f	beindos@hotmail.com	Beatriz	Medina García	f	t	2023-07-14 05:25:37+00	53e72863657a6eb717b92c6c79580bffa991467a04ada20fd325f31398a2680baefa21f6d937e79d266b74e1d4a76c4c10e97ecda20836189775f5fbb540efbc	2023-10-23 16:24:02.446293+00	t	\N	t	f	\N	\N	34616613571	1980-05-24	id_documents_back/8700ed922f38c814887fb19156e80213c5fe86d4502ab74dc17487e6ed937e00.jpeg	id_documents_front/81f54c1b5942439f8d2fd8d882a00582b0cff99b16cf1d099d7ec5492222ffe0.jpeg		52877099F	dni	ES	validated	f	f	\N	f	natural	\N	\N	pf_145
265	argon2$argon2id$v=19$m=102400,t=2,p=8$bnJmY3pCQnNVekxhMjdUWW54Y0tqcg$6UYKHWLcKjCk586dRoq4RA	\N	f	fmoreno@stockencapital.com	fernando	moreno	f	t	2023-09-06 06:10:25.161232+00	\N	\N	t	\N	f	f	\N	\N	34687007030	0074-10-02	id_documents_back/6fc24132d9f6f5b714695206e37b1d07a15d72e181efcf86fad9b5d92e23caa2.png	id_documents_front/5d3410408b030052419e3fe22927454d3c4f9af0bf04af7d1aab376d6a360f7f.jpg	id_documents_me/81828f9df46b6993373a8a9531cb87f75d113554dd37ef80f59b8b76a27e82e9.jpg	Y7791614X	nie	ES	validating	f	f	\N	f	natural	\N	\N	\N
318	argon2$argon2id$v=19$m=102400,t=2,p=8$UXE2N1E1ZlV5OW84OTRURlVjV0w5bQ$avGpvtsr489pe+4MILWFUQ	\N	f	mdiazollero@gmail.com	MIGUEL	DIAZ OLLERO	f	t	2023-10-18 10:10:07+00	\N	\N	t	a382d5fbd78b3d61fc0b22da895314d4f755a32a801ca61236ec3c53bdfcd5a2a1a2a4c88119da4283f7e41fb86216d724db13a92dae7b42744d3319f6d5f334	t	f	\N	\N	34645820825	1980-02-28	id_documents_back/2d57cfe9713b6f6184a1a00199fb30fc0f9f88bac938ecb7f407915023f503b1.jpg	id_documents_front/6a7ddd95cb40f9cddd1f54c00232b1749dd5659f1862c95b2cfae5e0e84f3c88.jpg	id_documents_me/832e3d64f90fb92174195df1cfaebe5290f97531f8fdb7a2c2ae6800734b5a4e.jpeg	46936979M	dni	ES	validated	f	f	\N	f	natural	\N	\N	pf_318
229	argon2$argon2id$v=19$m=102400,t=2,p=8$dG5kVVpqYkw3SzVYVlFIV3JOc01udw$+EUGs6O1aJENNRtgDU4dig	\N	f	strcod1@gmail.com			f	t	2023-09-04 20:27:06.376792+00	\N	\N	f	4e643728b66721ad3d60d2171fa5c3e14d1a65dc3e154b408451a675b78fda82ee1403109696d523187e4c35752d4b2ffdd373da801d5a7ec64483956f267527	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
231	argon2$argon2id$v=19$m=102400,t=2,p=8$bHd0Y1V6N3RPc1B3Y2s2QzBtY2loZQ$9E1NjvS7Mn7khAXJ0I3JPg	\N	f	strcod11@gmail.com			f	t	2023-09-04 20:58:43.951201+00	\N	\N	f	6627573b4964b73a7ff75b8d34a96af0176b62ce88162e93610deda08bd38cb538b9f2370a4098dfbcea9c6694423e1ae0602eb2b2c3cb2904ed62531ffa3a1f	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
230	argon2$argon2id$v=19$m=102400,t=2,p=8$UVk5UFkzMkMyM0pMRGZVYktQRXJLUg$z6kMAq60acLvwpn7ny06cQ	\N	f	hojewa9109@nickolis.com	teste2	teste	f	t	2023-09-04 20:27:54+00	\N	\N	t	5e57e6a41cb1f9687e717c95780067f65a209cbab3dd0aebb4c8e9c60d1bbb88e17e956afe044ce0962d9265d9e60890b804905bb6c1de9a93f45c9f19ca20e2	f	f	\N	\N	34321654798	2005-08-29	id_documents_back/acb9735c41a6d633804ee652cfff5b33de00f19af8db73915c8b07c6db87ed6f.jpeg	id_documents_front/144ff536a18196fb0c88f4fc0ade6ea4cbe5fab17f3fb73db709259d3884f4d2.jpeg		321654987	dni	ES	validating	f	f	\N	f	natural	\N	\N	pf_230
232	argon2$argon2id$v=19$m=102400,t=2,p=8$bEdIZmpORENiRThOVEgyM3Z0UGRlWg$GuJ4M/4b8c5di4bieKmfwA	\N	f	yevoje5914@gameszox.com	teste3	teste	f	t	2023-09-04 21:00:25.64034+00	\N	\N	f	d956d0b71a0c84b5ff95b15162e2328c67eeeeb414d6e011e41e44fee7ff06c9993b0390b71c905a3ba21253e9982cfdd9259c7055216dee45975b95457cb517	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
268	argon2$argon2id$v=19$m=102400,t=2,p=8$QW9LZUFPU0dLZHpENVpGSWdXSFB2UQ$Y/zMqzQxPr/QDyLo5MkMdg	\N	f	lorenapcampillo.edu@gmail.com	lorena	pérez	f	t	2023-09-06 10:58:21.619232+00	\N	\N	t	\N	t	f	\N	\N	34633674367	1986-10-04	id_documents_back/3b114bf3a709f1c6fc11b2720a06f97a993b427d1490ea7ceb08d8aaded7741b.jpg	id_documents_front/618dc5ae64cbc39a5be91cd0d6275774e78f5a118fe18ba87966d8bd84aeeee5.jpg		47463936D	dni	ES	validated	f	f	\N	f	natural	\N	\N	pf_268
228	argon2$argon2id$v=19$m=102400,t=2,p=8$UG5WVHVEQlFtbXZUT0Y2U2UwU2tpOA$LXNQFoJP8E7e7eWTgaDREw	\N	f	strcod@gmail.com	Marcos	Serrano	f	t	2023-09-04 20:22:02.344733+00	bc4994a216072e5db5a980e31b1aa9c67173cf24ad995bfb07f116db8a30e82177d28b5ef0371542bb39f2801bc62a1f0e38ea6cac5e0c023757447b8ae2d7cd	2023-09-12 20:34:36.075797+00	f	f589c859ec91db515d5e1e19661568b45a003e96dd97e8bb169d67589db13f1f093303a246411f6591f0a63ad75ae0d8d01e86adf4f0f1e419306535e8cf4c9f	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
285	!Ers51GAL3c3SfhwQtOY4r1BW4tZBovD1kbGt3Oc3	\N	f	info@portage.es	infor	macion	f	t	2023-09-29 06:45:10.319931+00	\N	\N	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
108	argon2$argon2id$v=19$m=102400,t=2,p=8$U09MTlJvU3h6NG05SzROTE5JZllPVQ$zPJx5lgEye0/iAYMOKbN0g	\N	f	beindos@gmail.com	Beatriz	Medina García	f	t	2023-06-13 14:04:10+00	d3465e7341f807e4e5962c1b1e430d525fbd151d57efd453b71b32b44922969b26a0a35371085988b71b68922227e69834883583881db49075af369e7d5e7669	2023-06-13 14:04:11.097592+00	t	\N	f	f	\N	\N	+34 616 61 35 71	1980-05-23	id_documents_back/b17526138d9bf907b2b6907425abafe0e5df33a1b4f90a3544bb8bccdd239d54.jpeg	id_documents_front/1865bf289752a1318b30c87b65fa2c9e8c7ba37e76d01536617c03a9ff0d661c.jpeg	id_documents_me/42955c806c2dec3936af3004e54ea83162047088c2f11b8cc7943c74432b0d6c.jpeg	52877099F	dni	ES	validated	f	f	\N	f	natural	single	Técnico especialista en radio diagnóstico	pf_108
293	!M89d5EIEZRGGceL9vsw7JmtCVx8SRzVrfjcSGQk5	\N	f	nasvolador@gmail.com	Àlex	Duran	f	t	2023-10-03 09:13:11.420912+00	\N	\N	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
273	!rwQJcAQuKOZngx7pAtQALQgQuqkomurkCMbOM7U9	\N	f	ramoncorujo1970@gmail.com	ramon	corujo	f	t	2023-09-21 14:32:19.107076+00	\N	\N	t	\N	f	f	\N	\N	34630941084	1970-01-16	id_documents_back/165fd0da5c480c9c84b4a13b10c5128f108fb6fa2a94e33ca2b0f5f9571e436e.jpg	id_documents_front/204b8ca9e01c4e2c673f217ed2b2feba0edc70bd12ba5cd466e199985a70f73d.jpg		32796523H	dni	ES	validating	f	f	\N	f	legal	\N	\N	pf_273
295	!VxJMjgNaHZQAYGYpsivqKEswxS1KJxOkiuRvMHoh	\N	f	gegantspedrera@gmail.com	Gegants	Pedrera	f	t	2023-10-04 08:05:11.730417+00	\N	\N	f	04e7c0e477cff9dd8cb71530e2541831c20853d67f9b6e68543d10ad01d6f650781750a0252bd9650bab2bee95749df4b582fdab0cc4d4570bc086b22526ead5	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
294	!aiI3iusWCduKhTTZyifIZGCBH18yiHlf8VKWJuez	\N	f	dcodina@verus.es	Daniel	Codina	f	t	2023-10-04 08:04:46.344519+00	\N	\N	t	\N	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
324	argon2$argon2id$v=19$m=102400,t=2,p=8$aWRpMXBsS2tUNkl6clBRZjlBVkU5Vw$W6ZlhRYNstwCV1Th1G+YAw	\N	f	alvarolinarescabre+chamo00@gmail.com	chamo	linares	f	t	2023-10-18 22:31:11+00	1055a966356e1635aa4d83689ae85f494419ef7712cf28be7c02e9a646b3ed2226de5324dd4324a7e1b87ac6991b4a1db4da7e32ecc306b7cfd971a93b2ad702	2023-10-18 23:00:49.324208+00	t	\N	f	f	\N	\N	34640559988	2005-10-18	id_documents_back/fba0a9716ef41d8ff0eb4413a72ecd0e0fbc0a3ffdc6f29073a6197d4e630047.png	id_documents_front/482ed0c6e7f82ffc65b104c49ef3f0da35931594f482aab2d5cebc7b62c4c7da.png		05060908A	dni	ES	validated	f	f	\N	f	natural	\N	\N	pf_324
299	argon2$argon2id$v=19$m=102400,t=2,p=8$ckNPYUtJTWlKRDZzdnpwN2F4SThFNg$nHIw9tLRrmDKi0BuUwh22w	\N	f	psiquegaia@gmail.com	montserrat	fernández pastor	f	t	2023-10-07 18:14:05.221396+00	3a04ab40de7895553213085ae45ec7c1d181e696a30734a16a73729c1939bcbc92523c15686aaadaabb1e95acd3f5f8f1fc3c8238429bda3b9062549b03f184a	2023-11-08 18:51:18.474201+00	f	f7a546fceb023ff78ec29730e450b885d8574998b32a57aab72e9e905da217512fa541bfa5db295865e535aab80520332c88a3ba281c1e2de1ca4ab6cedd3260	t	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
309	!m3MSKbZZnMxmXQFvYmfVLAXYPyftQplzFQ9OhhQD	\N	f	rosidigu55@gmail.com	MARIA ROSA	DIEZ GUTIERREZ	f	t	2023-10-17 21:18:44.421861+00	87795c4fb80b90455a46e71fa48690232ba7ba692413099e753e4ff66d1ab470f7d7bae85d0af4df5c9a012aa4f812a600c06e3d7083cfa6c59c922e2a385692	2023-10-18 12:53:13.20778+00	f	2ee7a304b534309dc8bf737408f67ae7b7aa4b8cdec6005341932bdbe43013ed39ca574be99007755cd788b99bd7890cf719be9e2ae68d028f608e7e0cf8d23f	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
174	argon2$argon2id$v=19$m=102400,t=2,p=8$d3E0Y1BPRlN1dlJYa093MnZxSm04SQ$2/HzM2abDfOi+E8QZ3dKEw	\N	f	raquel.carrasco@me.com	Raquel	Carrasco Velasco	f	t	2023-07-18 11:03:04+00	244d9ada6cb56c5b33b2bf0fb8e1ce8306d1f0020178935c3539883974d1fb398d63336aba2b0c2d7a1350abe104d17ab884c54e45e1c0b64f4578c21a1a4e63	2023-07-18 11:03:04.385741+00	t	\N	f	f	\N	\N	+34 606 88 55 71	1979-11-06	id_documents_back/5a028876e121cbab15d35f1c94da67429a7ee84fe6e67f593c7bc096e0480f70.jpg	id_documents_front/93743d8eb11789d5c3d19d299c7b810bb78e12e6565037f720abdb917d37ddee.jpg	id_documents_me/8d4766b0fdb2e718d0b418932cc47902826d85bc2139fb176eb1f0e67a566ecf.JPG	47634420V	dni	ES	validated	f	f	\N	f	natural	married	Empresaria	pf_174
100	argon2$argon2id$v=19$m=102400,t=2,p=8$RXJsYUNWWW1lcEdTaFBWSVlIWTNsSA$C2pYL2ngJ8dCGb6g09M0gQ	\N	f	ondadali@gmail.com	Alberto	Castellvi Miro	f	t	2023-06-13 13:45:03+00	bf95ae34012d417bee49a4772cbad504a71a39247a0db70dcc1dd0ee0a3e4ad001e76d042977057f83a766724cc51344e9c9e535b2b2bd404e4ae401b1cb25b1	2023-10-03 11:06:56.500966+00	t	\N	f	f	\N	\N	+34 696 58 85 71	1971-07-11	id_documents_back/b2e9247471c44979d0ab6bbede61e18feeef49b0341bc9a70795106416eab838.jpeg	id_documents_front/f068fedb62679d406a2f3c11d1eaa0388627ec61c177b24e8aae91d2598594e8.jpeg	id_documents_me/79421fd4996f9f111f8f4a324d1a8e75bd69f7d81d5c61561259d66a5a19c1b6.jpeg	39877834C	dni	ES	validating	f	f	\N	f	legal	divorced	Economista	pf_100
1	argon2$argon2id$v=19$m=102400,t=2,p=8$ZVpTbVdaUURSUzlpUFlUSXR6WGFkcg$X0LU++aK+Lt1OQRRaStyyA	2023-11-17 09:04:27.823157+00	t	stockencapital@mecexis.com	Stocken Capital	Admin	t	t	2022-07-11 11:05:20+00	\N	\N	f	a16ea49d64ebd588ac32fa093823eaf48d265f9bec323be78cbf0a0af5d3fa6734131783647b3052c289a43d018f4bdf2b191ba70bc1954f9c573cc788c12304	f	f	\N	\N	\N	\N		id_documents_front/f3614b725dd747d1c63d206df790e98d420b97a5a12f08a5d9252f32783e751a.png		\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	pf_1
277	argon2$argon2id$v=19$m=102400,t=2,p=8$cXNyZnhDYmlHMDY1azZxRURtVURLeg$ybcBKF0Kt14rZwb6iK2o5Q	\N	f	elisamoncayo08@gmail.com	Elisa	Moncayo	f	t	2023-09-27 18:07:01.792735+00	550a6ed2630a8f1fb1b3dd0bb3f338e05c5d13c435bb3a67921adbf71f91445e5acc090037fb130d5ecd1a56dce18c9dd5ac7967ccdc46ca55e5fd6dab3b3627	2023-10-30 09:56:18.05775+00	t	\N	f	f	\N	\N	34601288826	2002-10-16	id_documents_back/af370056671c00576acdbfb0a33ec09f7cc459796a58873d456b335fa4938dbd.jpeg	id_documents_front/d2fad481ff6570333616cab05679bd3019ff2b290ace57505a1f861cdb50b6a7.jpeg	id_documents_me/7c922eece65b6e83d6bb064de98f2e78402255e467682456492331a4046a7883.jpg	51474322T	dni	ES	validated	f	f	\N	f	natural	\N	\N	pf_277
96	argon2$argon2id$v=19$m=102400,t=2,p=8$bjZhMVZ1d3dDUEM2RXRLQUFJUWhWQQ$Yk12DvwXSdeAHB8Ne36nvg	\N	f	legu35@gmail.com	Jorge	Lasarte Aldasoro	f	t	2023-06-13 13:10:56+00	4c77ee45123fb1fda5a8a5b922345d4dd9a353609d765ce487f93977bc9439826a5c6b0429ddd5ac5cc30eb6fbfc28e50827353ba706f917cdca3ebdea0dd06d	2023-06-13 13:10:57.32233+00	t	\N	f	f	\N	\N	+34 655 72 70 99	1972-05-25	id_documents_back/a77bb2e5b64fea5d8bd007cda02fcafdc7b4c0fea9d3f5bbba428d86c58aba49.jpg	id_documents_front/9793dbdaa52e267f7f7ae6577e6531ce90ad93153a595cfe851a10a6d5365e1d.jpg	id_documents_me/5f0b0add52b158f15213095a18ba1681d6eb28a2802c339f66bca685fb2976af.jpg	16303770J	dni	ES	validated	f	f	\N	f	natural	married	Técnico especialista electrónico	pf_96
326	argon2$argon2id$v=19$m=102400,t=2,p=8$b1h1TUxyWlpkcFhXeU1malpldWxXYw$faVBJ3fsKKk+/WNfLAUwNA	\N	f	zoilagarciarilla@gmail.com	María Zoila	García Rilla	f	t	2023-10-19 10:20:24.40253+00	\N	\N	t	\N	f	f	\N	\N	34636891663	1957-03-01	id_documents_back/b3fb28d884b9336a9303288b280f7f1228987cf48b08ccac4efa863a6c36f908.jpg	id_documents_front/b31d0539ab27f8ce12b972e54a5c114655faebd2d518bb45f1590180d779d2cf.jpg		10817062R	dni	ES	validated	f	f	\N	f	natural	\N	\N	pf_326
331	argon2$argon2id$v=19$m=102400,t=2,p=8$ZWZIUXhpTkpIc1Y4ekJBOWViNW9mUg$0MDGsqtEHXDu14xijx8Brw	\N	f	jordi.dcm@gmail.com	jordi	Castellvi Miro	f	t	2023-10-22 14:09:45.055204+00	\N	\N	t	\N	t	f	\N	\N	34649083274	1968-10-01	id_documents_back/65067e4e17296b431f16e344ed652bfd39d652d9b332b7eb3735269c81418ad6.jpg	id_documents_front/933790830fca71b01ea0f64517a83b034ffa1564df6bcc4104a6295aaecf5d30.jpg		78578827V	dni	ES	validated	f	f	\N	f	natural	\N	\N	pf_331
111	argon2$argon2id$v=19$m=102400,t=2,p=8$Tkw3ZkNDNUlraHNrc3Z1UDB5OWZBeA$BiQJXzHUkTeMROHgMy7Qmw	\N	f	pcrsoluciones@gmail.com	Maria del Pilar	Cárdenas Ramos	f	t	2023-06-13 14:07:29+00	401ab471f576394dda2bda9c11d74311a9547a4f0e94ceb0983dd0d8274fd7b23b1182d857b095b93fc053436aa084e289e1fb35434cb7e85995580cd1cc1d9a	2023-06-13 14:07:30.289753+00	t	\N	f	f	\N	\N	+34 650 53 12 05	1958-03-08	id_documents_back/2ae3db57743a30f4fad6cc4c753d5a8bb26cc77fd4039dfdd989916bd2fb603e.png	id_documents_front/4aa60c906349321d039baf307fd3d81da9f63a9256a2e791de123848c84123d8.png	id_documents_me/27640eb26ce95efab0e613b38ef28d45bb85352c3a784eb0620ed93f6cda707e.png	01809648P	dni	ES	validated	f	f	\N	f	natural	divorced	Consultor informático	pf_111
328	argon2$argon2id$v=19$m=102400,t=2,p=8$bks5R0hmYXRhY1R1QnhFdHRzN252SA$aBbIFuLsQRn+k7f6kJwxPA	\N	f	diezmariarosa9@gmail.com	María Rosa	Díez	f	t	2023-10-19 15:11:37.291472+00	\N	\N	t	\N	t	f	\N	\N	34692159864	1953-03-16	id_documents_back/cd32ee02450e9d7abf4030a98210f3d3a0b259b3de4d7be8101613bd695c9ceb.jpg	id_documents_front/3176699235738da189dfd7aedff1237b7bdab967da568d91576b480cf1144740.jpg		13694834J	dni	ES	validated	f	f	\N	f	natural	\N	\N	pf_328
148	argon2$argon2id$v=19$m=102400,t=2,p=8$QkdMOEVzcFdodmtOTEVXc3doMVZEWA$u94BcNO1fOlFAO2+/nZuLg	\N	f	natiroldos54@gmail.com	Natividad	Roldós Bonamusa	f	t	2023-07-15 09:05:03+00	3bd78bec6b034710361383772b7fcbcb93666fefc7cb114590ecd6976e7b81ad02e48ff86421c4b2e659dfd90960510cfbd22c561e2098ff1cb6a612a95583e4	2023-10-29 14:41:31.041387+00	t	\N	f	f	\N	\N	+34 629 27 81 43	1954-03-20	id_documents_back/23033ac97a9bec198dbc13f18f68b8cb8fb9d1209377dd45aeae0dd47a109a9d.png	id_documents_front/bf5d6b2d1835dd61bfff1e27c60ec080ba12581497855c7b36f7e663ba7a95c8.png	id_documents_me/bd6762b2ccdf172528e296855e2cf659a01df5390795217e4a5a1ed1775289db.png	46109730C	dni	ES	validated	f	f	\N	f	natural	divorced	Quiromasajista- Jubilada	pf_148
115	argon2$argon2id$v=19$m=102400,t=2,p=8$bXVNaEJCU0pOM3l6a2FOZDhXTGZhUQ$u3PATAE9J8Ea2kpUu+ywig	\N	f	feli.oregi@gmail.com	Felisa	Oregui Osoro	f	t	2023-06-13 14:09:51+00	9e85ae50299e6309f2795713bd411faf2e004b00fa79b1fd307d47fdac8a07c2895ff93265d7b48b1e61574eea98171b4bfab59647c67d22bd54721f5ecb9532	2023-10-22 18:44:52.948043+00	t	\N	f	f	\N	\N	+34 699 57 30 75	1965-08-05	id_documents_back/d13ee422b60fe8596de5a88e4558820e7d92483e243c8b91413c2d504325cd6b.png	id_documents_front/9acfc9b8343da94703529f1c537970e649a4d8cdb55ed3f681c38dcd1776779d.png	id_documents_me/618e1db3e472db9c1b82966f7ab752de2581c65904aa8fda894972c1b1dee283.jpeg	15371984A	dni	ES	validated	f	f	\N	f	natural	married	Logopeda	pf_115
28	argon2$argon2id$v=19$m=102400,t=2,p=8$Y1RreWxVN3U0ZTBvYm14RWhCV0xBNg$FMcqmZ9N1Mv1DRkEMXIZEw	2023-09-11 11:19:03.573936+00	f	ccallejo@stockencapital.com	Carlos	Callejo González	t	t	2022-09-29 10:04:07+00	cef78558f81e6650326472e2e09ac5fcd591dfbba463fd94c5b888d06efb4348ee646d69734c0f79a986d7998d4ec657b37ec0b1ba1639ec487a65e52bb47b10	2023-09-12 20:55:19.493298+00	t	\N	t	f	\N	\N	+34 644 16 67 10	1988-03-19	id_documents_back/b2dbdd7d46e0d909be5165170d6360c44555da084f03e3aa6aef9e18b4233891.jpg	id_documents_front/e2edeb99eed07f9283cd253552adb48619ed4fefe69502c1f7e8738b33b1869a.jpg	id_documents_me/9a3f0e33e10cc6d09b88ef8be06c13d5fce1175e1e942fefeac4de89f633ed47.jpg	71149272Z	dni	ES	validated	f	f	\N	f	legal	separated	CEO	pf_28
313	argon2$argon2id$v=19$m=102400,t=2,p=8$bTF1QnU2Vm5KYjZCRkJZUXRmMDNNbg$NkQi+lb/idQIvpp9/oAf9Q	\N	f	nurugu@gmail.com	núria	ruiz guimet	f	t	2023-10-18 04:20:34+00	6d7ecc4db26baa2a1727dadbfe6d9cf295f7256ce0deed5a8429cfa7279d9baf20561a119c6b0c55df3b0da44d08a7ea3cb8dca9ed666c4ba6cec7bf48698c49	2023-10-18 11:21:54.960408+00	t	b4c4b08c16071dd31ab54d56abba545fbab3e2a014fbb4b43b028cd636d349b1f0f3de8057a59dfe20a30adba5cf801b67e38c1643301557d6e5f92dfcbda88d	t	f	\N	\N	34677179267	1977-05-27	id_documents_back/1ccb135d989d12f0f64df949d7967c47a93b017c1cb5a12b1485d165c8035577.jpg	id_documents_front/dffe9a64acd6b5bd61df967d05c99d790726d5537b04815b4bba1c4a061973b8.jpg	id_documents_me/5619ff634ffac7765816530eb90020fb2686b0745f8aef581a2b994df3372e44.jpg	14268021V	dni	ES	validated	f	f	\N	f	natural	\N	\N	pf_313
155	argon2$argon2id$v=19$m=102400,t=2,p=8$SE95TEw1NEUzR1RWc05FajVYblJ4cQ$5etDzdDuq+mcSz0SOEToaw	\N	f	ikerfp@gmail.com	Iker	Fernandez Palacio	f	t	2023-07-18 10:43:32+00	b7efe305db7d5085be4de53173f52dce13f3187ab90ae62b1a9cbfdde0077ddae06623b285d4ba76f3338329df41f8679ff04881d939f9553c40f58df6d10013	2023-10-29 18:35:15.671136+00	t	\N	f	f	\N	\N	+34 696 87 87 78	1978-12-13	id_documents_back/a663eefb3ac62b0180179e36f3b08149a98ba72b1424bae749f7ed4d779386d1.jpg	id_documents_front/ce8f5318325e18e359729e9fd3f8b76dd673da877fc61924de5436f8e7aa9c89.jpg	id_documents_me/3ddf324d609f6ef14d5bed62e86e17d625a545c857b07925d704d3e62b941b48.jpg	44975743W	dni	ES	in_validation	f	f	\N	f	legal	single	Veterinario	pf_155
172	argon2$argon2id$v=19$m=102400,t=2,p=8$NXdnV2pQQndBeXU0aGgwemh2WFp5Tg$ExbxfviQ046sKWGn3D7o5A	\N	f	alberto.rf2017@gmail.com	José Alberto	Redondo Fernández	f	t	2023-07-18 11:02:05+00	1ad09ca55afdbf3cd89ef38bf448efe992c697757bb816d5eac4a4d9d18a8c7c258a8a9ad997cad7dfdd80818ac8e9c1cb71a1755460d8972b78618a44574cf1	2023-07-26 20:37:46.10885+00	t	\N	f	f	\N	\N	+34 652 37 70 38	1987-03-11	id_documents_back/8e9cb50b5f244faa241983cbce7f7adab506400c8bee14e00f3632422d979971.png	id_documents_front/a9c004ad0cc58afda2e873a649336284c223ea45e11ca915e97b8b6e601efabb.png	id_documents_me/b0748c404d15e97f88426bb91ad0d0dea4e553c026ad1dc302ecda3837d9a745.png	44240346F	dni	ES	validated	f	f	\N	f	natural	single	Operario almacén	pf_172
23	argon2$argon2id$v=19$m=102400,t=2,p=8$ODllVWVvUzlSajZyN1p0MUo2b2gwNQ$T3KiNKkRkaP8ZykexodWUA	2023-09-09 09:58:52.704131+00	f	kallejo@gmail.com	Carlos	Callejo	t	t	2022-09-22 07:49:58+00	9aa0a3ce71fd5f16bde165874d1ac974fc3b4ef0e825354234450170be31249da60bf3e4639609e7c51ea58d0a09adc6e21fff82dfc1ee0c8fb81a325c9d48de	2023-09-12 20:48:56.53455+00	t	\N	f	f	\N	\N	+34 644 16 67 10	1988-03-19	id_documents_back/7a974890f35ba5cb11c14625a944b8ad9ee38ce4c9da3d8e219f45487b5f3f78.jpg	id_documents_front/3f99679d7f67b66a7f38ce6eb08ac7d37d9b9bd2208a5dde51d09ae1c9d7c2d0.jpg	id_documents_me/09af78d46b32f41620212f054de28545b4af9ad8fb142a1ce1042c9da0e9abf9.jpeg	71149272Z	dni	ES	validated	f	f	\N	f	legal	separated	CEO	pf_23
330	argon2$argon2id$v=19$m=102400,t=2,p=8$NGNMZ3E2UXRYbEtFSU8wSnJ6SGdUMA$/a5c4fQ966VvWjW/kHeE1g	\N	f	piliychuso@hotmail.com	M°del Pilar	rodriguez garcia	f	t	2023-10-22 09:39:00+00	35aecbbb22aa79b51557700f3660ef1266d4613a0adaf6633fbdacc36fd02b73cbafd08527318a7e517cb4009feb1e03bea0190b0d4c7231072f735a57c1d779	2023-10-22 22:24:57.270945+00	t	caa252089e75f80e04c3ce2172f1184e7842a7b2f4ae9c81367046caf08504e4c6c79a6d7378b608f5b9c0c714f672939951551505e14ddd0dfd8dcdac138c9a	t	f	\N	\N	34606559657	1954-04-13	id_documents_back/09eb8d63e9d2d0771e44fc52c277917f17f17a07ddbcff817301fef699cd7ab7.jpg	id_documents_front/1855869befe1e9fff38f26c0aa0ad33b95508594f0172525fd66c5e2096d7737.jpg	id_documents_me/ed8c4f663b2b2ca9a518ea761d9a660dbc164bdd6ed8299148eabc53f6d48e9b.jpg	10795630H	dni	ES	validated	f	f	\N	f	natural	\N	\N	pf_330
154	argon2$argon2id$v=19$m=102400,t=2,p=8$dFJiWmdHeGpMbkpjZnQxZTE0d2xGSw$uhQYqBKEm38J0CjTqgDzaQ	\N	f	esterue@gmail.com	Ester Margarita	Rue Manonelles	f	t	2023-07-18 10:42:35+00	8542592fc9be0911d8c92e08152e3cf649f9b518c0de75551dce9c8eb1f7e4c70287026a5447dc176fd882551a0ffcfc060832174fa0080521ec4268d59e5a8a	2023-10-22 16:18:14.405413+00	t	\N	f	f	\N	\N	+34 616 65 67 87	1975-09-12	id_documents_back/d514cddec0297265dc9a81e5d25961e59d17f84176305dfac7ac6a72b10f8b31.jpg	id_documents_front/fb753e758959f47762e9ec180daea75da07bd8c3f1af5a1e7dd48ebf786ceac1.jpg	id_documents_me/a74248ff877765f4d4e9cf4a6f79406a61328374e171195adbdaafee995e9b72.jpg	43736242V	dni	ES	validated	f	f	\N	f	natural	single	Socio autonomo	pf_154
341	!fD3GT6LoTE88gg3yoy0SBHyuCSzGvUTpDyEljTG7	\N	f	immabalasch1967@gmail.com	Imma	Balasch	f	t	2023-11-02 17:44:21.014821+00	\N	\N	f	e7f87e83c46210dbc883569a4475fb8bfe680b1bbb78c5041361fb919707c54450f6a569f1a04227ae5fb7e3e038c82e76a719b92b09f8ec1011f62453d6fe01	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
119	argon2$argon2id$v=19$m=102400,t=2,p=8$R2UzWTBIR2xjVkI0SW9SRTdYbWptcw$NX+Vx7sCTLS8keRRDi5T+g	\N	f	zx10alex@hotmail.com	Alejandro	Izquierdo Merchan	f	t	2023-06-13 14:12:37+00	9985bf1b12dd5c4726f3d7b9da0bf0ba42540cabc06eca93145cbe8c37d4a7fd201ec1559915f3b47144a47d5a4918e5ae40c83fd56d9c45dc52b1e30997b64f	2023-06-13 14:12:37.547177+00	t	\N	f	f	\N	\N	+34 619 26 44 82	1969-04-17	id_documents_back/a0869af97cde87acb0ac6ca899d5e9e9c170b04f88e3e0f49758dad784082459.jpg	id_documents_front/867a52f219caf81a1efccf590d9056834ef9deff634813331c52706d77c114c1.jpg	id_documents_me/66a66fc8471e89fdc2d0e1956fc98aaf613afa602b74fedddc9d87e85872705a.jpeg	33505653N	dni	ES	validated	f	f	\N	f	natural	married	Autonomo	pf_119
110	argon2$argon2id$v=19$m=102400,t=2,p=8$ZUJXSDB1aVFwQm9KMlJzZXJtVk1mQg$y58nVpv5K6dgwOSneShWVw	\N	f	angelmmt70@gmail.com	Angel Manuel	Moya Tellez	f	t	2023-06-13 14:06:42+00	5f3b15dbf8e08d354f3831bb6d7b7011b6d2ab6002f565bb5d6731835e7ea20087f5e4f5160592969f6e953fbfa59eefdd57d5f6e1f926d57e31e8f33c5b3346	2023-06-13 14:06:42.406417+00	t	\N	f	f	\N	\N	+34 619 61 60 59	1970-06-14	id_documents_back/9ca53b79009b670d0669b3324eb745ae300c53a15496f2f5801319f17d1beea3.jpg	id_documents_front/e1c1875a0de1bf7c5de2e5e6e855bf92bc53562501007cd8cfdd02066e85cacc.jpg	id_documents_me/718fa3686529b6c4e2888590f49a5615fdd884ee6a5fb17b72c5a284c49ba0f3.jpg	50956661T	dni	ES	validated	f	f	\N	f	natural	divorced	Administrativo .Desempleado	pf_110
343	!4F6LNJbMyTCilLX0AW9XYUHeuTbHUjx3NajiaUuJ	\N	f	cripto.broh@gmail.com	Cripto	Broh	f	t	2023-11-13 01:30:07.711474+00	\N	\N	f	9a0fdd330f454c63b965dea86148c2d1a55b3ddb7dbb636ac52bbe86ef04ccb047b0f9f542ede133f8135db9b4a3ed31305ad4784467044a1552a5bb2025b9ec	f	f	\N	\N	\N	\N				\N	\N	\N	incomplete	f	f	\N	f	natural	\N	\N	\N
275	argon2$argon2id$v=19$m=102400,t=2,p=8$QzFPeUxyYjRncDgxWXhLN0c0ZkJoRQ$dJKjEMRW1pLmPROkE5zm/w	\N	f	gloriatoledano26@gmail.com	Gloria	Toledano Cuadro	f	t	2023-09-27 18:05:25.845847+00	32a6d2b57d68910841e0e097385813c3eb555d41b8c7ab1bb26bbe67dd93e556f6ecc838bc845189bcf3d006ea57583500cbe60118ab3501e750ee3860a4076b	2023-10-27 06:15:02.360979+00	t	\N	f	f	\N	\N	34675977690	1989-01-15	id_documents_back/5845c8541ef718f1840a56d77a4e856de9c1cbf1f85f633e9850d662901e5fa4.jpg	id_documents_front/a5a79cf5e08db2389c0b0dcdcf72ae65cf11af8bcb3d943430dae658f96b9fb9.jpg		30994759M	dni	ES	validated	f	f	\N	f	natural	\N	\N	pf_275
\.


--
-- Data for Name: users_user_favorited_companies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_user_favorited_companies (id, user_id, company_id) FROM stdin;
6	13	6
8	23	14
10	273	6
13	156	14
14	147	14
15	90	13
16	101	14
17	271	13
18	23	10
19	172	14
21	175	14
22	318	14
23	316	14
24	146	14
27	332	13
28	307	14
29	177	14
30	278	14
31	297	14
32	332	14
33	122	13
34	110	14
36	342	13
\.


--
-- Data for Name: users_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: users_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: votes_vote; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.votes_vote (id, vote, created, agenda_item_id, stellar_transaction_hash, cod, content_type_id, object_id) FROM stdin;
28	in_favor	2023-09-19 06:16:56.713978+00	49	\N	pf_82	7	82
29	against	2023-09-19 09:48:39.934547+00	50	\N	pf_82	7	82
30	in_favor	2023-10-13 08:52:17.58848+00	53	\N	pf_82	7	82
\.


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

SELECT pg_catalog.setval('public.auth_permission_id_seq', 248, true);


--
-- Name: capital_increases_capitalincrease_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.capital_increases_capitalincrease_id_seq', 13, true);


--
-- Name: companies_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.companies_category_id_seq', 10, true);


--
-- Name: companies_company_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.companies_company_id_seq', 30, true);


--
-- Name: companies_company_investors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.companies_company_investors_id_seq', 1, false);


--
-- Name: conversations_contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conversations_contact_id_seq', 1, false);


--
-- Name: conversations_conversation_documents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conversations_conversation_documents_id_seq', 2, true);


--
-- Name: conversations_conversation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conversations_conversation_id_seq', 29, true);


--
-- Name: conversations_conversation_partners_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conversations_conversation_partners_id_seq', 9, true);


--
-- Name: conversations_conversationhistory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conversations_conversationhistory_id_seq', 34, true);


--
-- Name: conversations_message_documents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conversations_message_documents_id_seq', 1, false);


--
-- Name: conversations_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conversations_message_id_seq', 11, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1046, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 62, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 292, true);


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_site_id_seq', 1, false);


--
-- Name: documents_document_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.documents_document_id_seq', 121, true);


--
-- Name: documents_document_related_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.documents_document_related_users_id_seq', 255, true);


--
-- Name: documents_historydocument_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.documents_historydocument_id_seq', 1, false);


--
-- Name: documents_useractiondetail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.documents_useractiondetail_id_seq', 1, false);


--
-- Name: documents_usersessionlog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.documents_usersessionlog_id_seq', 1, false);


--
-- Name: mangopay_basemangopaytransaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mangopay_basemangopaytransaction_id_seq', 345, true);


--
-- Name: mangopay_mangopaybankaccount_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mangopay_mangopaybankaccount_id_seq', 4, true);


--
-- Name: mangopay_mangopaykycdocument_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mangopay_mangopaykycdocument_id_seq', 137, true);


--
-- Name: mangopay_mangopayuser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mangopay_mangopayuser_id_seq', 150, true);


--
-- Name: mangopay_mangopaywallet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mangopay_mangopaywallet_id_seq', 133, true);


--
-- Name: meetings_agendaitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.meetings_agendaitem_id_seq', 57, true);


--
-- Name: meetings_document_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.meetings_document_id_seq', 71, true);


--
-- Name: meetings_historymeetingsdocument_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.meetings_historymeetingsdocument_id_seq', 35, true);


--
-- Name: meetings_meeting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.meetings_meeting_id_seq', 42, true);


--
-- Name: meetings_participant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.meetings_participant_id_seq', 33, true);


--
-- Name: oauth2_provider_accesstoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oauth2_provider_accesstoken_id_seq', 118, true);


--
-- Name: oauth2_provider_application_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oauth2_provider_application_id_seq', 3, true);


--
-- Name: oauth2_provider_grant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oauth2_provider_grant_id_seq', 1, false);


--
-- Name: oauth2_provider_idtoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oauth2_provider_idtoken_id_seq', 1, false);


--
-- Name: oauth2_provider_refreshtoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oauth2_provider_refreshtoken_id_seq', 118, true);


--
-- Name: offers_document_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.offers_document_id_seq', 72, true);


--
-- Name: offers_historyoffersdocument_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.offers_historyoffersdocument_id_seq', 51, true);


--
-- Name: offers_offer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.offers_offer_id_seq', 160, true);


--
-- Name: offers_proposal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.offers_proposal_id_seq', 159, true);


--
-- Name: operations_operation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.operations_operation_id_seq', 119, true);


--
-- Name: options_option_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.options_option_id_seq', 6, true);


--
-- Name: options_useroption_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.options_useroption_id_seq', 1, false);


--
-- Name: partners_partner_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.partners_partner_id_seq', 57, true);


--
-- Name: payments_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payments_payment_id_seq', 269, true);


--
-- Name: snitch_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.snitch_event_id_seq', 1, false);


--
-- Name: snitch_eventtype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.snitch_eventtype_id_seq', 1, false);


--
-- Name: snitch_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.snitch_notification_id_seq', 1, false);


--
-- Name: social_auth_association_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.social_auth_association_id_seq', 1, false);


--
-- Name: social_auth_code_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.social_auth_code_id_seq', 1, false);


--
-- Name: social_auth_nonce_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.social_auth_nonce_id_seq', 1, false);


--
-- Name: social_auth_partial_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.social_auth_partial_id_seq', 1, false);


--
-- Name: social_auth_usersocialauth_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.social_auth_usersocialauth_id_seq', 40, true);


--
-- Name: stellar_asset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stellar_asset_id_seq', 11, true);


--
-- Name: stellar_asset_trust_op_completed_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stellar_asset_trust_op_completed_id_seq', 36, true);


--
-- Name: stellar_currencyasset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stellar_currencyasset_id_seq', 1, false);


--
-- Name: stellar_currencyasset_trust_op_completed_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stellar_currencyasset_trust_op_completed_id_seq', 1, false);


--
-- Name: stellar_wallet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stellar_wallet_id_seq', 85, true);


--
-- Name: users_fiscalresidence_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_fiscalresidence_id_seq', 166, true);


--
-- Name: users_user_favorited_companies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_favorited_companies_id_seq', 36, true);


--
-- Name: users_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_groups_id_seq', 1, false);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 345, true);


--
-- Name: users_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_user_permissions_id_seq', 1, false);


--
-- Name: votes_vote_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.votes_vote_id_seq', 30, true);


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
-- Name: capital_increases_capitalincrease capital_increases_capitalincrease_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.capital_increases_capitalincrease
    ADD CONSTRAINT capital_increases_capitalincrease_pkey PRIMARY KEY (id);


--
-- Name: companies_category companies_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies_category
    ADD CONSTRAINT companies_category_pkey PRIMARY KEY (id);


--
-- Name: companies_company companies_company_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies_company
    ADD CONSTRAINT companies_company_code_key UNIQUE (code);


--
-- Name: companies_company_investors companies_company_investors_company_id_user_id_cc1d17cc_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies_company_investors
    ADD CONSTRAINT companies_company_investors_company_id_user_id_cc1d17cc_uniq UNIQUE (company_id, user_id);


--
-- Name: companies_company_investors companies_company_investors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies_company_investors
    ADD CONSTRAINT companies_company_investors_pkey PRIMARY KEY (id);


--
-- Name: companies_company companies_company_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies_company
    ADD CONSTRAINT companies_company_pkey PRIMARY KEY (id);


--
-- Name: companies_company companies_company_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies_company
    ADD CONSTRAINT companies_company_slug_key UNIQUE (slug);


--
-- Name: conversations_contact conversations_contact_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations_contact
    ADD CONSTRAINT conversations_contact_pkey PRIMARY KEY (id);


--
-- Name: conversations_conversation_documents conversations_conversati_conversation_id_document_40a8b973_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations_conversation_documents
    ADD CONSTRAINT conversations_conversati_conversation_id_document_40a8b973_uniq UNIQUE (conversation_id, document_id);


--
-- Name: conversations_conversation_partners conversations_conversati_conversation_id_partner__4f8b61a3_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations_conversation_partners
    ADD CONSTRAINT conversations_conversati_conversation_id_partner__4f8b61a3_uniq UNIQUE (conversation_id, partner_id);


--
-- Name: conversations_conversation_documents conversations_conversation_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations_conversation_documents
    ADD CONSTRAINT conversations_conversation_documents_pkey PRIMARY KEY (id);


--
-- Name: conversations_conversation_partners conversations_conversation_partners_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations_conversation_partners
    ADD CONSTRAINT conversations_conversation_partners_pkey PRIMARY KEY (id);


--
-- Name: conversations_conversation conversations_conversation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations_conversation
    ADD CONSTRAINT conversations_conversation_pkey PRIMARY KEY (id);


--
-- Name: conversations_conversationhistory conversations_conversationhistory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations_conversationhistory
    ADD CONSTRAINT conversations_conversationhistory_pkey PRIMARY KEY (id);


--
-- Name: conversations_message_documents conversations_message_do_message_id_document_id_bee6704f_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations_message_documents
    ADD CONSTRAINT conversations_message_do_message_id_document_id_bee6704f_uniq UNIQUE (message_id, document_id);


--
-- Name: conversations_message_documents conversations_message_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations_message_documents
    ADD CONSTRAINT conversations_message_documents_pkey PRIMARY KEY (id);


--
-- Name: conversations_message conversations_message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations_message
    ADD CONSTRAINT conversations_message_pkey PRIMARY KEY (id);


--
-- Name: currencies_currency currencies_currency_currency_asset_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.currencies_currency
    ADD CONSTRAINT currencies_currency_currency_asset_id_key UNIQUE (currency_asset_id);


--
-- Name: currencies_currency currencies_currency_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.currencies_currency
    ADD CONSTRAINT currencies_currency_pkey PRIMARY KEY (code);


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
-- Name: django_site django_site_domain_a2e37b91_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_domain_a2e37b91_uniq UNIQUE (domain);


--
-- Name: django_site django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: documents_document documents_document_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents_document
    ADD CONSTRAINT documents_document_pkey PRIMARY KEY (id);


--
-- Name: documents_document_related_users documents_document_relat_document_id_user_id_4e5fa7a9_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents_document_related_users
    ADD CONSTRAINT documents_document_relat_document_id_user_id_4e5fa7a9_uniq UNIQUE (document_id, user_id);


--
-- Name: documents_document_related_users documents_document_related_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents_document_related_users
    ADD CONSTRAINT documents_document_related_users_pkey PRIMARY KEY (id);


--
-- Name: documents_historydocument documents_historydocument_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents_historydocument
    ADD CONSTRAINT documents_historydocument_pkey PRIMARY KEY (id);


--
-- Name: documents_useractiondetail documents_useractiondetail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents_useractiondetail
    ADD CONSTRAINT documents_useractiondetail_pkey PRIMARY KEY (id);


--
-- Name: documents_usersessionlog documents_usersessionlog_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents_usersessionlog
    ADD CONSTRAINT documents_usersessionlog_pkey PRIMARY KEY (id);


--
-- Name: mangopay_basemangopaytransaction mangopay_basemangopaytransaction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mangopay_basemangopaytransaction
    ADD CONSTRAINT mangopay_basemangopaytransaction_pkey PRIMARY KEY (id);


--
-- Name: mangopay_mangopaybankaccount mangopay_mangopaybankaccount_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mangopay_mangopaybankaccount
    ADD CONSTRAINT mangopay_mangopaybankaccount_pkey PRIMARY KEY (id);


--
-- Name: mangopay_mangopaybankwiredeposit mangopay_mangopaybankwiredeposit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mangopay_mangopaybankwiredeposit
    ADD CONSTRAINT mangopay_mangopaybankwiredeposit_pkey PRIMARY KEY (basemangopaytransaction_ptr_id);


--
-- Name: mangopay_mangopaykycdocument mangopay_mangopaykycdocument_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mangopay_mangopaykycdocument
    ADD CONSTRAINT mangopay_mangopaykycdocument_pkey PRIMARY KEY (id);


--
-- Name: mangopay_mangopaydeposit mangopay_mangopaypayment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mangopay_mangopaydeposit
    ADD CONSTRAINT mangopay_mangopaypayment_pkey PRIMARY KEY (basemangopaytransaction_ptr_id);


--
-- Name: mangopay_mangopaytransfer mangopay_mangopaytransfer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mangopay_mangopaytransfer
    ADD CONSTRAINT mangopay_mangopaytransfer_pkey PRIMARY KEY (basemangopaytransaction_ptr_id);


--
-- Name: mangopay_mangopayuser mangopay_mangopayuser_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mangopay_mangopayuser
    ADD CONSTRAINT mangopay_mangopayuser_pkey PRIMARY KEY (id);


--
-- Name: mangopay_mangopaywallet mangopay_mangopaywallet_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mangopay_mangopaywallet
    ADD CONSTRAINT mangopay_mangopaywallet_pkey PRIMARY KEY (id);


--
-- Name: meetings_agendaitem meetings_agendaitem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meetings_agendaitem
    ADD CONSTRAINT meetings_agendaitem_pkey PRIMARY KEY (id);


--
-- Name: meetings_document meetings_document_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meetings_document
    ADD CONSTRAINT meetings_document_pkey PRIMARY KEY (id);


--
-- Name: meetings_historymeetingsdocument meetings_historymeetingsdocument_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meetings_historymeetingsdocument
    ADD CONSTRAINT meetings_historymeetingsdocument_pkey PRIMARY KEY (id);


--
-- Name: meetings_meeting meetings_meeting_call_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meetings_meeting
    ADD CONSTRAINT meetings_meeting_call_id_key UNIQUE (call_id);


--
-- Name: meetings_meeting meetings_meeting_minutes_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meetings_meeting
    ADD CONSTRAINT meetings_meeting_minutes_id_key UNIQUE (minutes_id);


--
-- Name: meetings_meeting meetings_meeting_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meetings_meeting
    ADD CONSTRAINT meetings_meeting_pkey PRIMARY KEY (id);


--
-- Name: meetings_participant meetings_participant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meetings_participant
    ADD CONSTRAINT meetings_participant_pkey PRIMARY KEY (id);


--
-- Name: oauth2_provider_accesstoken oauth2_provider_accesstoken_id_token_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_provider_accesstoken
    ADD CONSTRAINT oauth2_provider_accesstoken_id_token_id_key UNIQUE (id_token_id);


--
-- Name: oauth2_provider_accesstoken oauth2_provider_accesstoken_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_provider_accesstoken
    ADD CONSTRAINT oauth2_provider_accesstoken_pkey PRIMARY KEY (id);


--
-- Name: oauth2_provider_accesstoken oauth2_provider_accesstoken_source_refresh_token_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_provider_accesstoken
    ADD CONSTRAINT oauth2_provider_accesstoken_source_refresh_token_id_key UNIQUE (source_refresh_token_id);


--
-- Name: oauth2_provider_accesstoken oauth2_provider_accesstoken_token_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_provider_accesstoken
    ADD CONSTRAINT oauth2_provider_accesstoken_token_key UNIQUE (token);


--
-- Name: oauth2_provider_application oauth2_provider_application_client_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_provider_application
    ADD CONSTRAINT oauth2_provider_application_client_id_key UNIQUE (client_id);


--
-- Name: oauth2_provider_application oauth2_provider_application_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_provider_application
    ADD CONSTRAINT oauth2_provider_application_pkey PRIMARY KEY (id);


--
-- Name: oauth2_provider_grant oauth2_provider_grant_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_provider_grant
    ADD CONSTRAINT oauth2_provider_grant_code_key UNIQUE (code);


--
-- Name: oauth2_provider_grant oauth2_provider_grant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_provider_grant
    ADD CONSTRAINT oauth2_provider_grant_pkey PRIMARY KEY (id);


--
-- Name: oauth2_provider_idtoken oauth2_provider_idtoken_jti_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_provider_idtoken
    ADD CONSTRAINT oauth2_provider_idtoken_jti_key UNIQUE (jti);


--
-- Name: oauth2_provider_idtoken oauth2_provider_idtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_provider_idtoken
    ADD CONSTRAINT oauth2_provider_idtoken_pkey PRIMARY KEY (id);


--
-- Name: oauth2_provider_refreshtoken oauth2_provider_refreshtoken_access_token_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_provider_refreshtoken
    ADD CONSTRAINT oauth2_provider_refreshtoken_access_token_id_key UNIQUE (access_token_id);


--
-- Name: oauth2_provider_refreshtoken oauth2_provider_refreshtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_provider_refreshtoken
    ADD CONSTRAINT oauth2_provider_refreshtoken_pkey PRIMARY KEY (id);


--
-- Name: oauth2_provider_refreshtoken oauth2_provider_refreshtoken_token_revoked_af8a5134_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_provider_refreshtoken
    ADD CONSTRAINT oauth2_provider_refreshtoken_token_revoked_af8a5134_uniq UNIQUE (token, revoked);


--
-- Name: offers_document offers_document_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers_document
    ADD CONSTRAINT offers_document_pkey PRIMARY KEY (id);


--
-- Name: offers_document offers_document_proposal_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers_document
    ADD CONSTRAINT offers_document_proposal_id_key UNIQUE (proposal_id);


--
-- Name: offers_historyoffersdocument offers_historyoffersdocument_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers_historyoffersdocument
    ADD CONSTRAINT offers_historyoffersdocument_pkey PRIMARY KEY (id);


--
-- Name: offers_offer offers_offer_capital_increase_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers_offer
    ADD CONSTRAINT offers_offer_capital_increase_id_key UNIQUE (capital_increase_id);


--
-- Name: offers_offer offers_offer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers_offer
    ADD CONSTRAINT offers_offer_pkey PRIMARY KEY (id);


--
-- Name: offers_proposal offers_proposal_operation_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers_proposal
    ADD CONSTRAINT offers_proposal_operation_id_key UNIQUE (operation_id);


--
-- Name: offers_proposal offers_proposal_payment_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers_proposal
    ADD CONSTRAINT offers_proposal_payment_id_key UNIQUE (payment_id);


--
-- Name: offers_proposal offers_proposal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers_proposal
    ADD CONSTRAINT offers_proposal_pkey PRIMARY KEY (id);


--
-- Name: operations_operation operations_operation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operations_operation
    ADD CONSTRAINT operations_operation_pkey PRIMARY KEY (id);


--
-- Name: options_option options_option_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.options_option
    ADD CONSTRAINT options_option_name_key UNIQUE (name);


--
-- Name: options_option options_option_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.options_option
    ADD CONSTRAINT options_option_pkey PRIMARY KEY (id);


--
-- Name: options_useroption options_useroption_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.options_useroption
    ADD CONSTRAINT options_useroption_pkey PRIMARY KEY (id);


--
-- Name: options_useroption options_useroption_user_id_name_2fafb39f_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.options_useroption
    ADD CONSTRAINT options_useroption_user_id_name_2fafb39f_uniq UNIQUE (user_id, name);


--
-- Name: partners_partner partners_partner_cod_company_id_ea741457_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partners_partner
    ADD CONSTRAINT partners_partner_cod_company_id_ea741457_uniq UNIQUE (cod, company_id);


--
-- Name: partners_partner partners_partner_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partners_partner
    ADD CONSTRAINT partners_partner_pkey PRIMARY KEY (id);


--
-- Name: payments_payment payments_payment_mangopay_payment_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments_payment
    ADD CONSTRAINT payments_payment_mangopay_payment_id_key UNIQUE (mangopay_transaction_id);


--
-- Name: payments_payment payments_payment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments_payment
    ADD CONSTRAINT payments_payment_pkey PRIMARY KEY (id);


--
-- Name: snitch_event snitch_event_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.snitch_event
    ADD CONSTRAINT snitch_event_pkey PRIMARY KEY (id);


--
-- Name: snitch_eventtype snitch_eventtype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.snitch_eventtype
    ADD CONSTRAINT snitch_eventtype_pkey PRIMARY KEY (id);


--
-- Name: snitch_eventtype snitch_eventtype_verb_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.snitch_eventtype
    ADD CONSTRAINT snitch_eventtype_verb_key UNIQUE (verb);


--
-- Name: snitch_notification snitch_notification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.snitch_notification
    ADD CONSTRAINT snitch_notification_pkey PRIMARY KEY (id);


--
-- Name: social_auth_association social_auth_association_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.social_auth_association
    ADD CONSTRAINT social_auth_association_pkey PRIMARY KEY (id);


--
-- Name: social_auth_association social_auth_association_server_url_handle_078befa2_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.social_auth_association
    ADD CONSTRAINT social_auth_association_server_url_handle_078befa2_uniq UNIQUE (server_url, handle);


--
-- Name: social_auth_code social_auth_code_email_code_801b2d02_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.social_auth_code
    ADD CONSTRAINT social_auth_code_email_code_801b2d02_uniq UNIQUE (email, code);


--
-- Name: social_auth_code social_auth_code_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.social_auth_code
    ADD CONSTRAINT social_auth_code_pkey PRIMARY KEY (id);


--
-- Name: social_auth_nonce social_auth_nonce_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.social_auth_nonce
    ADD CONSTRAINT social_auth_nonce_pkey PRIMARY KEY (id);


--
-- Name: social_auth_nonce social_auth_nonce_server_url_timestamp_salt_f6284463_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.social_auth_nonce
    ADD CONSTRAINT social_auth_nonce_server_url_timestamp_salt_f6284463_uniq UNIQUE (server_url, "timestamp", salt);


--
-- Name: social_auth_partial social_auth_partial_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.social_auth_partial
    ADD CONSTRAINT social_auth_partial_pkey PRIMARY KEY (id);


--
-- Name: social_auth_usersocialauth social_auth_usersocialauth_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.social_auth_usersocialauth
    ADD CONSTRAINT social_auth_usersocialauth_pkey PRIMARY KEY (id);


--
-- Name: social_auth_usersocialauth social_auth_usersocialauth_provider_uid_e6b5e668_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.social_auth_usersocialauth
    ADD CONSTRAINT social_auth_usersocialauth_provider_uid_e6b5e668_uniq UNIQUE (provider, uid);


--
-- Name: stellar_asset stellar_asset_company_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stellar_asset
    ADD CONSTRAINT stellar_asset_company_id_key UNIQUE (company_id);


--
-- Name: stellar_asset stellar_asset_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stellar_asset
    ADD CONSTRAINT stellar_asset_pkey PRIMARY KEY (id);


--
-- Name: stellar_asset_trust_op_completed stellar_asset_trust_op_completed_asset_id_user_id_5068d3fb_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stellar_asset_trust_op_completed
    ADD CONSTRAINT stellar_asset_trust_op_completed_asset_id_user_id_5068d3fb_uniq UNIQUE (asset_id, user_id);


--
-- Name: stellar_asset_trust_op_completed stellar_asset_trust_op_completed_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stellar_asset_trust_op_completed
    ADD CONSTRAINT stellar_asset_trust_op_completed_pkey PRIMARY KEY (id);


--
-- Name: stellar_currencyasset stellar_currencyasset_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stellar_currencyasset
    ADD CONSTRAINT stellar_currencyasset_pkey PRIMARY KEY (id);


--
-- Name: stellar_currencyasset_trust_op_completed stellar_currencyasset_tr_currencyasset_id_user_id_41a7f1bb_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stellar_currencyasset_trust_op_completed
    ADD CONSTRAINT stellar_currencyasset_tr_currencyasset_id_user_id_41a7f1bb_uniq UNIQUE (currencyasset_id, user_id);


--
-- Name: stellar_currencyasset_trust_op_completed stellar_currencyasset_trust_op_completed_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stellar_currencyasset_trust_op_completed
    ADD CONSTRAINT stellar_currencyasset_trust_op_completed_pkey PRIMARY KEY (id);


--
-- Name: stellar_wallet stellar_wallet_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stellar_wallet
    ADD CONSTRAINT stellar_wallet_pkey PRIMARY KEY (id);


--
-- Name: stellar_wallet stellar_wallet_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stellar_wallet
    ADD CONSTRAINT stellar_wallet_user_id_key UNIQUE (user_id);


--
-- Name: users_fiscalresidence users_fiscalresidence_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_fiscalresidence
    ADD CONSTRAINT users_fiscalresidence_pkey PRIMARY KEY (id);


--
-- Name: users_user users_user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user
    ADD CONSTRAINT users_user_email_key UNIQUE (email);


--
-- Name: users_user_favorited_companies users_user_favorited_companies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_favorited_companies
    ADD CONSTRAINT users_user_favorited_companies_pkey PRIMARY KEY (id);


--
-- Name: users_user_favorited_companies users_user_favorited_companies_user_id_company_id_a9fbb7f8_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_favorited_companies
    ADD CONSTRAINT users_user_favorited_companies_user_id_company_id_a9fbb7f8_uniq UNIQUE (user_id, company_id);


--
-- Name: users_user_groups users_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_groups
    ADD CONSTRAINT users_user_groups_pkey PRIMARY KEY (id);


--
-- Name: users_user_groups users_user_groups_user_id_group_id_b88eab82_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_groups
    ADD CONSTRAINT users_user_groups_user_id_group_id_b88eab82_uniq UNIQUE (user_id, group_id);


--
-- Name: users_user users_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user
    ADD CONSTRAINT users_user_pkey PRIMARY KEY (id);


--
-- Name: users_user users_user_restore_password_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user
    ADD CONSTRAINT users_user_restore_password_code_key UNIQUE (restore_password_code);


--
-- Name: users_user_user_permissions users_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: users_user_user_permissions users_user_user_permissions_user_id_permission_id_43338c45_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_user_id_permission_id_43338c45_uniq UNIQUE (user_id, permission_id);


--
-- Name: users_user users_user_verification_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user
    ADD CONSTRAINT users_user_verification_code_key UNIQUE (verification_code);


--
-- Name: votes_vote votes_vote_agenda_item_id_content_t_3114f042_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes_vote
    ADD CONSTRAINT votes_vote_agenda_item_id_content_t_3114f042_uniq UNIQUE (agenda_item_id, content_type_id, object_id);


--
-- Name: votes_vote votes_vote_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes_vote
    ADD CONSTRAINT votes_vote_pkey PRIMARY KEY (id);


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
-- Name: capital_increases_capitalincrease_company_id_2dd84b4d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX capital_increases_capitalincrease_company_id_2dd84b4d ON public.capital_increases_capitalincrease USING btree (company_id);


--
-- Name: companies_company_categories_id_b6c4c436; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX companies_company_categories_id_b6c4c436 ON public.companies_company USING btree (categories_id);


--
-- Name: companies_company_cod_2328f962; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX companies_company_cod_2328f962 ON public.companies_company USING btree (cod);


--
-- Name: companies_company_cod_2328f962_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX companies_company_cod_2328f962_like ON public.companies_company USING btree (cod varchar_pattern_ops);


--
-- Name: companies_company_code_b4b3e879_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX companies_company_code_b4b3e879_like ON public.companies_company USING btree (code varchar_pattern_ops);


--
-- Name: companies_company_investors_company_id_cf55bbf4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX companies_company_investors_company_id_cf55bbf4 ON public.companies_company_investors USING btree (company_id);


--
-- Name: companies_company_investors_user_id_3b016ef5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX companies_company_investors_user_id_3b016ef5 ON public.companies_company_investors USING btree (user_id);


--
-- Name: companies_company_legal_representative_id_ce4dfba4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX companies_company_legal_representative_id_ce4dfba4 ON public.companies_company USING btree (legal_representative_id);


--
-- Name: companies_company_slug_cddc66aa_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX companies_company_slug_cddc66aa_like ON public.companies_company USING btree (slug varchar_pattern_ops);


--
-- Name: conversations_conversation_company_id_122724fe; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX conversations_conversation_company_id_122724fe ON public.conversations_conversation USING btree (company_id);


--
-- Name: conversations_conversation_creator_id_3de68382; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX conversations_conversation_creator_id_3de68382 ON public.conversations_conversation USING btree (creator_id);


--
-- Name: conversations_conversation_documents_conversation_id_a520b337; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX conversations_conversation_documents_conversation_id_a520b337 ON public.conversations_conversation_documents USING btree (conversation_id);


--
-- Name: conversations_conversation_documents_document_id_1105dbc0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX conversations_conversation_documents_document_id_1105dbc0 ON public.conversations_conversation_documents USING btree (document_id);


--
-- Name: conversations_conversation_partners_conversation_id_ac6e3b4d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX conversations_conversation_partners_conversation_id_ac6e3b4d ON public.conversations_conversation_partners USING btree (conversation_id);


--
-- Name: conversations_conversation_partners_partner_id_bc190265; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX conversations_conversation_partners_partner_id_bc190265 ON public.conversations_conversation_partners USING btree (partner_id);


--
-- Name: conversations_conversationhistory_conversation_id_ef438669; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX conversations_conversationhistory_conversation_id_ef438669 ON public.conversations_conversationhistory USING btree (conversation_id);


--
-- Name: conversations_conversationhistory_creator_id_b724cdf7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX conversations_conversationhistory_creator_id_b724cdf7 ON public.conversations_conversationhistory USING btree (creator_id);


--
-- Name: conversations_message_conversation_id_f1a2d5e9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX conversations_message_conversation_id_f1a2d5e9 ON public.conversations_message USING btree (conversation_id);


--
-- Name: conversations_message_creator_id_6247eee0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX conversations_message_creator_id_6247eee0 ON public.conversations_message USING btree (creator_id);


--
-- Name: conversations_message_documents_document_id_bce582b0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX conversations_message_documents_document_id_bce582b0 ON public.conversations_message_documents USING btree (document_id);


--
-- Name: conversations_message_documents_message_id_11f05fe2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX conversations_message_documents_message_id_11f05fe2 ON public.conversations_message_documents USING btree (message_id);


--
-- Name: currencies_currency_code_165b7e38_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX currencies_currency_code_165b7e38_like ON public.currencies_currency USING btree (code varchar_pattern_ops);


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
-- Name: django_site_domain_a2e37b91_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_site_domain_a2e37b91_like ON public.django_site USING btree (domain varchar_pattern_ops);


--
-- Name: documents_document_company_id_a2323c19; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX documents_document_company_id_a2323c19 ON public.documents_document USING btree (company_id);


--
-- Name: documents_document_creator_id_e53c7296; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX documents_document_creator_id_e53c7296 ON public.documents_document USING btree (creator_id);


--
-- Name: documents_document_related_meeting_id_3655541d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX documents_document_related_meeting_id_3655541d ON public.documents_document USING btree (related_meeting_id);


--
-- Name: documents_document_related_operation_id_f0cd3e91; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX documents_document_related_operation_id_f0cd3e91 ON public.documents_document USING btree (related_operation_id);


--
-- Name: documents_document_related_users_document_id_b59f104d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX documents_document_related_users_document_id_b59f104d ON public.documents_document_related_users USING btree (document_id);


--
-- Name: documents_document_related_users_user_id_f5ae5d43; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX documents_document_related_users_user_id_f5ae5d43 ON public.documents_document_related_users USING btree (user_id);


--
-- Name: documents_historydocument_creator_id_5ef4a743; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX documents_historydocument_creator_id_5ef4a743 ON public.documents_historydocument USING btree (creator_id);


--
-- Name: documents_historydocument_document_id_cee359cd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX documents_historydocument_document_id_cee359cd ON public.documents_historydocument USING btree (document_id);


--
-- Name: documents_useractiondetail_company_id_97963439; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX documents_useractiondetail_company_id_97963439 ON public.documents_useractiondetail USING btree (company_id);


--
-- Name: documents_useractiondetail_session_id_e7baf4a6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX documents_useractiondetail_session_id_e7baf4a6 ON public.documents_useractiondetail USING btree (session_id);


--
-- Name: documents_usersessionlog_user_id_72905266; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX documents_usersessionlog_user_id_72905266 ON public.documents_usersessionlog USING btree (user_id);


--
-- Name: mangopay_basemangopaytransaction_cod_4a7070ab; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mangopay_basemangopaytransaction_cod_4a7070ab ON public.mangopay_basemangopaytransaction USING btree (cod);


--
-- Name: mangopay_basemangopaytransaction_cod_4a7070ab_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mangopay_basemangopaytransaction_cod_4a7070ab_like ON public.mangopay_basemangopaytransaction USING btree (cod varchar_pattern_ops);


--
-- Name: mangopay_mangopaybankaccount_cod_16473157; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mangopay_mangopaybankaccount_cod_16473157 ON public.mangopay_mangopaybankaccount USING btree (cod);


--
-- Name: mangopay_mangopaybankaccount_cod_16473157_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mangopay_mangopaybankaccount_cod_16473157_like ON public.mangopay_mangopaybankaccount USING btree (cod varchar_pattern_ops);


--
-- Name: mangopay_mangopaybankaccount_user_id_1efeffeb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mangopay_mangopaybankaccount_user_id_1efeffeb ON public.mangopay_mangopaybankaccount USING btree (user_id);


--
-- Name: mangopay_mangopaybankwiredeposit_to_user_id_71a14e73; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mangopay_mangopaybankwiredeposit_to_user_id_71a14e73 ON public.mangopay_mangopaybankwiredeposit USING btree (to_user_id);


--
-- Name: mangopay_mangopaykycdocument_cod_96c83ba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mangopay_mangopaykycdocument_cod_96c83ba6 ON public.mangopay_mangopaykycdocument USING btree (cod);


--
-- Name: mangopay_mangopaykycdocument_cod_96c83ba6_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mangopay_mangopaykycdocument_cod_96c83ba6_like ON public.mangopay_mangopaykycdocument USING btree (cod varchar_pattern_ops);


--
-- Name: mangopay_mangopaykycdocument_user_id_8a4e361d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mangopay_mangopaykycdocument_user_id_8a4e361d ON public.mangopay_mangopaykycdocument USING btree (user_id);


--
-- Name: mangopay_mangopaypayment_user_id_f5ba9655; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mangopay_mangopaypayment_user_id_f5ba9655 ON public.mangopay_mangopaydeposit USING btree (to_user_id);


--
-- Name: mangopay_mangopaytransfer_from_user_id_8f629f37; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mangopay_mangopaytransfer_from_user_id_8f629f37 ON public.mangopay_mangopaytransfer USING btree (from_user_id);


--
-- Name: mangopay_mangopaytransfer_to_user_id_192815a2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mangopay_mangopaytransfer_to_user_id_192815a2 ON public.mangopay_mangopaytransfer USING btree (to_user_id);


--
-- Name: mangopay_mangopayuser_cod_57e3bc46; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mangopay_mangopayuser_cod_57e3bc46 ON public.mangopay_mangopayuser USING btree (cod);


--
-- Name: mangopay_mangopayuser_cod_57e3bc46_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mangopay_mangopayuser_cod_57e3bc46_like ON public.mangopay_mangopayuser USING btree (cod varchar_pattern_ops);


--
-- Name: mangopay_mangopayuser_user_id_16f19700; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mangopay_mangopayuser_user_id_16f19700 ON public.mangopay_mangopayuser USING btree (user_id);


--
-- Name: mangopay_mangopaywallet_user_id_abdecccd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mangopay_mangopaywallet_user_id_abdecccd ON public.mangopay_mangopaywallet USING btree (user_id);


--
-- Name: meetings_agendaitem_meeting_id_07815bb0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX meetings_agendaitem_meeting_id_07815bb0 ON public.meetings_agendaitem USING btree (meeting_id);


--
-- Name: meetings_document_agenda_item_id_05269058; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX meetings_document_agenda_item_id_05269058 ON public.meetings_document USING btree (agenda_item_id);


--
-- Name: meetings_document_creator_id_ce7348bc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX meetings_document_creator_id_ce7348bc ON public.meetings_document USING btree (creator_id);


--
-- Name: meetings_historymeetingsdocument_creator_id_5e09a29f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX meetings_historymeetingsdocument_creator_id_5e09a29f ON public.meetings_historymeetingsdocument USING btree (creator_id);


--
-- Name: meetings_historymeetingsdocument_document_id_b1eb6e87; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX meetings_historymeetingsdocument_document_id_b1eb6e87 ON public.meetings_historymeetingsdocument USING btree (document_id);


--
-- Name: meetings_meeting_company_id_15255a07; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX meetings_meeting_company_id_15255a07 ON public.meetings_meeting USING btree (company_id);


--
-- Name: meetings_meeting_creator_id_ba60be78; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX meetings_meeting_creator_id_ba60be78 ON public.meetings_meeting USING btree (creator_id);


--
-- Name: meetings_participant_meeting_id_4a769a34; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX meetings_participant_meeting_id_4a769a34 ON public.meetings_participant USING btree (meeting_id);


--
-- Name: meetings_participant_user_id_b38e7254; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX meetings_participant_user_id_b38e7254 ON public.meetings_participant USING btree (user_id);


--
-- Name: oauth2_provider_accesstoken_application_id_b22886e1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX oauth2_provider_accesstoken_application_id_b22886e1 ON public.oauth2_provider_accesstoken USING btree (application_id);


--
-- Name: oauth2_provider_accesstoken_token_8af090f8_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX oauth2_provider_accesstoken_token_8af090f8_like ON public.oauth2_provider_accesstoken USING btree (token varchar_pattern_ops);


--
-- Name: oauth2_provider_accesstoken_user_id_6e4c9a65; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX oauth2_provider_accesstoken_user_id_6e4c9a65 ON public.oauth2_provider_accesstoken USING btree (user_id);


--
-- Name: oauth2_provider_application_client_id_03f0cc84_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX oauth2_provider_application_client_id_03f0cc84_like ON public.oauth2_provider_application USING btree (client_id varchar_pattern_ops);


--
-- Name: oauth2_provider_application_client_secret_53133678; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX oauth2_provider_application_client_secret_53133678 ON public.oauth2_provider_application USING btree (client_secret);


--
-- Name: oauth2_provider_application_client_secret_53133678_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX oauth2_provider_application_client_secret_53133678_like ON public.oauth2_provider_application USING btree (client_secret varchar_pattern_ops);


--
-- Name: oauth2_provider_application_user_id_79829054; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX oauth2_provider_application_user_id_79829054 ON public.oauth2_provider_application USING btree (user_id);


--
-- Name: oauth2_provider_grant_application_id_81923564; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX oauth2_provider_grant_application_id_81923564 ON public.oauth2_provider_grant USING btree (application_id);


--
-- Name: oauth2_provider_grant_code_49ab4ddf_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX oauth2_provider_grant_code_49ab4ddf_like ON public.oauth2_provider_grant USING btree (code varchar_pattern_ops);


--
-- Name: oauth2_provider_grant_user_id_e8f62af8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX oauth2_provider_grant_user_id_e8f62af8 ON public.oauth2_provider_grant USING btree (user_id);


--
-- Name: oauth2_provider_idtoken_application_id_08c5ff4f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX oauth2_provider_idtoken_application_id_08c5ff4f ON public.oauth2_provider_idtoken USING btree (application_id);


--
-- Name: oauth2_provider_idtoken_user_id_dd512b59; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX oauth2_provider_idtoken_user_id_dd512b59 ON public.oauth2_provider_idtoken USING btree (user_id);


--
-- Name: oauth2_provider_refreshtoken_application_id_2d1c311b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX oauth2_provider_refreshtoken_application_id_2d1c311b ON public.oauth2_provider_refreshtoken USING btree (application_id);


--
-- Name: oauth2_provider_refreshtoken_user_id_da837fce; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX oauth2_provider_refreshtoken_user_id_da837fce ON public.oauth2_provider_refreshtoken USING btree (user_id);


--
-- Name: offers_historyoffersdocument_creator_id_89690ff0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX offers_historyoffersdocument_creator_id_89690ff0 ON public.offers_historyoffersdocument USING btree (creator_id);


--
-- Name: offers_historyoffersdocument_document_id_c0b6e0f3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX offers_historyoffersdocument_document_id_c0b6e0f3 ON public.offers_historyoffersdocument USING btree (document_id);


--
-- Name: offers_offer_company_id_623c4621; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX offers_offer_company_id_623c4621 ON public.offers_offer USING btree (company_id);


--
-- Name: offers_offer_for_user_id_123defbd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX offers_offer_for_user_id_123defbd ON public.offers_offer USING btree (for_user_id);


--
-- Name: offers_offer_user_id_4fbc0994; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX offers_offer_user_id_4fbc0994 ON public.offers_offer USING btree (user_id);


--
-- Name: offers_proposal_offer_id_04f106db; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX offers_proposal_offer_id_04f106db ON public.offers_proposal USING btree (offer_id);


--
-- Name: offers_proposal_user_id_a8d68715; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX offers_proposal_user_id_a8d68715 ON public.offers_proposal USING btree (user_id);


--
-- Name: operations_operation_company_id_a5943d84; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX operations_operation_company_id_a5943d84 ON public.operations_operation USING btree (company_id);


--
-- Name: operations_operation_from_user_id_7fd8c572; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX operations_operation_from_user_id_7fd8c572 ON public.operations_operation USING btree (from_user_id);


--
-- Name: operations_operation_to_user_id_bbca8815; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX operations_operation_to_user_id_bbca8815 ON public.operations_operation USING btree (to_user_id);


--
-- Name: options_option_name_42a60494_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX options_option_name_42a60494_like ON public.options_option USING btree (name varchar_pattern_ops);


--
-- Name: options_option_public_name_b9237778; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX options_option_public_name_b9237778 ON public.options_option USING btree (public_name);


--
-- Name: options_option_public_name_b9237778_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX options_option_public_name_b9237778_like ON public.options_option USING btree (public_name varchar_pattern_ops);


--
-- Name: options_useroption_public_name_2eeaa9e5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX options_useroption_public_name_2eeaa9e5 ON public.options_useroption USING btree (public_name);


--
-- Name: options_useroption_public_name_2eeaa9e5_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX options_useroption_public_name_2eeaa9e5_like ON public.options_useroption USING btree (public_name varchar_pattern_ops);


--
-- Name: options_useroption_user_id_01488187; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX options_useroption_user_id_01488187 ON public.options_useroption USING btree (user_id);


--
-- Name: partners_partner_company_id_e5c5fedc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX partners_partner_company_id_e5c5fedc ON public.partners_partner USING btree (company_id);


--
-- Name: partners_partner_content_type_id_a0059c54; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX partners_partner_content_type_id_a0059c54 ON public.partners_partner USING btree (content_type_id);


--
-- Name: partners_partner_user_id_c9159f29; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX partners_partner_user_id_c9159f29 ON public.partners_partner USING btree (user_id);


--
-- Name: payments_payment_from_user_id_cc566b32; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payments_payment_from_user_id_cc566b32 ON public.payments_payment USING btree (from_user_id);


--
-- Name: payments_payment_user_id_f9db060a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payments_payment_user_id_f9db060a ON public.payments_payment USING btree (to_user_id);


--
-- Name: snitch_event_actor_content_type_id_2ad2cc94; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX snitch_event_actor_content_type_id_2ad2cc94 ON public.snitch_event USING btree (actor_content_type_id);


--
-- Name: snitch_event_target_content_type_id_06e9448e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX snitch_event_target_content_type_id_06e9448e ON public.snitch_event USING btree (target_content_type_id);


--
-- Name: snitch_event_trigger_content_type_id_8b86ecfb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX snitch_event_trigger_content_type_id_8b86ecfb ON public.snitch_event USING btree (trigger_content_type_id);


--
-- Name: snitch_eventtype_verb_e0dbde6d_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX snitch_eventtype_verb_e0dbde6d_like ON public.snitch_eventtype USING btree (verb varchar_pattern_ops);


--
-- Name: snitch_notification_event_id_0283365f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX snitch_notification_event_id_0283365f ON public.snitch_notification USING btree (event_id);


--
-- Name: snitch_notification_user_id_9f5bdce1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX snitch_notification_user_id_9f5bdce1 ON public.snitch_notification USING btree (user_id);


--
-- Name: social_auth_code_code_a2393167; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX social_auth_code_code_a2393167 ON public.social_auth_code USING btree (code);


--
-- Name: social_auth_code_code_a2393167_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX social_auth_code_code_a2393167_like ON public.social_auth_code USING btree (code varchar_pattern_ops);


--
-- Name: social_auth_code_timestamp_176b341f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX social_auth_code_timestamp_176b341f ON public.social_auth_code USING btree ("timestamp");


--
-- Name: social_auth_partial_timestamp_50f2119f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX social_auth_partial_timestamp_50f2119f ON public.social_auth_partial USING btree ("timestamp");


--
-- Name: social_auth_partial_token_3017fea3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX social_auth_partial_token_3017fea3 ON public.social_auth_partial USING btree (token);


--
-- Name: social_auth_partial_token_3017fea3_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX social_auth_partial_token_3017fea3_like ON public.social_auth_partial USING btree (token varchar_pattern_ops);


--
-- Name: social_auth_usersocialauth_uid_796e51dc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX social_auth_usersocialauth_uid_796e51dc ON public.social_auth_usersocialauth USING btree (uid);


--
-- Name: social_auth_usersocialauth_uid_796e51dc_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX social_auth_usersocialauth_uid_796e51dc_like ON public.social_auth_usersocialauth USING btree (uid varchar_pattern_ops);


--
-- Name: social_auth_usersocialauth_user_id_17d28448; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX social_auth_usersocialauth_user_id_17d28448 ON public.social_auth_usersocialauth USING btree (user_id);


--
-- Name: stellar_asset_trust_op_completed_asset_id_bd42c6f5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX stellar_asset_trust_op_completed_asset_id_bd42c6f5 ON public.stellar_asset_trust_op_completed USING btree (asset_id);


--
-- Name: stellar_asset_trust_op_completed_user_id_af5e299a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX stellar_asset_trust_op_completed_user_id_af5e299a ON public.stellar_asset_trust_op_completed USING btree (user_id);


--
-- Name: stellar_currencyasset_trus_currencyasset_id_6ed8310e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX stellar_currencyasset_trus_currencyasset_id_6ed8310e ON public.stellar_currencyasset_trust_op_completed USING btree (currencyasset_id);


--
-- Name: stellar_currencyasset_trust_op_completed_user_id_064aab92; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX stellar_currencyasset_trust_op_completed_user_id_064aab92 ON public.stellar_currencyasset_trust_op_completed USING btree (user_id);


--
-- Name: users_fiscalresidence_user_id_5b29aae4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_fiscalresidence_user_id_5b29aae4 ON public.users_fiscalresidence USING btree (user_id);


--
-- Name: users_user_cod_7b7c3ebf; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_user_cod_7b7c3ebf ON public.users_user USING btree (cod);


--
-- Name: users_user_cod_7b7c3ebf_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_user_cod_7b7c3ebf_like ON public.users_user USING btree (cod varchar_pattern_ops);


--
-- Name: users_user_email_243f6e77_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_user_email_243f6e77_like ON public.users_user USING btree (email varchar_pattern_ops);


--
-- Name: users_user_favorited_companies_company_id_445a86b5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_user_favorited_companies_company_id_445a86b5 ON public.users_user_favorited_companies USING btree (company_id);


--
-- Name: users_user_favorited_companies_user_id_08ed230f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_user_favorited_companies_user_id_08ed230f ON public.users_user_favorited_companies USING btree (user_id);


--
-- Name: users_user_groups_group_id_9afc8d0e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_user_groups_group_id_9afc8d0e ON public.users_user_groups USING btree (group_id);


--
-- Name: users_user_groups_user_id_5f6f5a90; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_user_groups_user_id_5f6f5a90 ON public.users_user_groups USING btree (user_id);


--
-- Name: users_user_restore_password_code_6e6b2df8_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_user_restore_password_code_6e6b2df8_like ON public.users_user USING btree (restore_password_code varchar_pattern_ops);


--
-- Name: users_user_user_permissions_permission_id_0b93982e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_user_user_permissions_permission_id_0b93982e ON public.users_user_user_permissions USING btree (permission_id);


--
-- Name: users_user_user_permissions_user_id_20aca447; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_user_user_permissions_user_id_20aca447 ON public.users_user_user_permissions USING btree (user_id);


--
-- Name: users_user_verification_code_743ac4c1_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_user_verification_code_743ac4c1_like ON public.users_user USING btree (verification_code varchar_pattern_ops);


--
-- Name: votes_vote_agenda_item_id_2274f311; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX votes_vote_agenda_item_id_2274f311 ON public.votes_vote USING btree (agenda_item_id);


--
-- Name: votes_vote_content_type_id_c8375fe1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX votes_vote_content_type_id_c8375fe1 ON public.votes_vote USING btree (content_type_id);


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
-- Name: authtoken_token authtoken_token_user_id_35299eff_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_35299eff_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: capital_increases_capitalincrease capital_increases_ca_company_id_2dd84b4d_fk_companies; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.capital_increases_capitalincrease
    ADD CONSTRAINT capital_increases_ca_company_id_2dd84b4d_fk_companies FOREIGN KEY (company_id) REFERENCES public.companies_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: companies_company companies_company_categories_id_b6c4c436_fk_companies; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies_company
    ADD CONSTRAINT companies_company_categories_id_b6c4c436_fk_companies FOREIGN KEY (categories_id) REFERENCES public.companies_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: companies_company_investors companies_company_in_company_id_cf55bbf4_fk_companies; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies_company_investors
    ADD CONSTRAINT companies_company_in_company_id_cf55bbf4_fk_companies FOREIGN KEY (company_id) REFERENCES public.companies_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: companies_company_investors companies_company_investors_user_id_3b016ef5_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies_company_investors
    ADD CONSTRAINT companies_company_investors_user_id_3b016ef5_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: companies_company companies_company_legal_representative_ce4dfba4_fk_users_use; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies_company
    ADD CONSTRAINT companies_company_legal_representative_ce4dfba4_fk_users_use FOREIGN KEY (legal_representative_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: conversations_conversation conversations_conver_company_id_122724fe_fk_companies; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations_conversation
    ADD CONSTRAINT conversations_conver_company_id_122724fe_fk_companies FOREIGN KEY (company_id) REFERENCES public.companies_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: conversations_conversation_documents conversations_conver_conversation_id_a520b337_fk_conversat; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations_conversation_documents
    ADD CONSTRAINT conversations_conver_conversation_id_a520b337_fk_conversat FOREIGN KEY (conversation_id) REFERENCES public.conversations_conversation(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: conversations_conversation_partners conversations_conver_conversation_id_ac6e3b4d_fk_conversat; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations_conversation_partners
    ADD CONSTRAINT conversations_conver_conversation_id_ac6e3b4d_fk_conversat FOREIGN KEY (conversation_id) REFERENCES public.conversations_conversation(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: conversations_conversationhistory conversations_conver_conversation_id_ef438669_fk_conversat; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations_conversationhistory
    ADD CONSTRAINT conversations_conver_conversation_id_ef438669_fk_conversat FOREIGN KEY (conversation_id) REFERENCES public.conversations_conversation(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: conversations_conversationhistory conversations_conver_creator_id_b724cdf7_fk_users_use; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations_conversationhistory
    ADD CONSTRAINT conversations_conver_creator_id_b724cdf7_fk_users_use FOREIGN KEY (creator_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: conversations_conversation_documents conversations_conver_document_id_1105dbc0_fk_documents; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations_conversation_documents
    ADD CONSTRAINT conversations_conver_document_id_1105dbc0_fk_documents FOREIGN KEY (document_id) REFERENCES public.documents_document(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: conversations_conversation_partners conversations_conver_partner_id_bc190265_fk_partners_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations_conversation_partners
    ADD CONSTRAINT conversations_conver_partner_id_bc190265_fk_partners_ FOREIGN KEY (partner_id) REFERENCES public.partners_partner(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: conversations_conversation conversations_conversation_creator_id_3de68382_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations_conversation
    ADD CONSTRAINT conversations_conversation_creator_id_3de68382_fk_users_user_id FOREIGN KEY (creator_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: conversations_message conversations_messag_conversation_id_f1a2d5e9_fk_conversat; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations_message
    ADD CONSTRAINT conversations_messag_conversation_id_f1a2d5e9_fk_conversat FOREIGN KEY (conversation_id) REFERENCES public.conversations_conversation(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: conversations_message_documents conversations_messag_document_id_bce582b0_fk_documents; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations_message_documents
    ADD CONSTRAINT conversations_messag_document_id_bce582b0_fk_documents FOREIGN KEY (document_id) REFERENCES public.documents_document(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: conversations_message_documents conversations_messag_message_id_11f05fe2_fk_conversat; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations_message_documents
    ADD CONSTRAINT conversations_messag_message_id_11f05fe2_fk_conversat FOREIGN KEY (message_id) REFERENCES public.conversations_message(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: conversations_message conversations_message_creator_id_6247eee0_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations_message
    ADD CONSTRAINT conversations_message_creator_id_6247eee0_fk_users_user_id FOREIGN KEY (creator_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: currencies_currency currencies_currency_currency_asset_id_13b2b800_fk_stellar_c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.currencies_currency
    ADD CONSTRAINT currencies_currency_currency_asset_id_13b2b800_fk_stellar_c FOREIGN KEY (currency_asset_id) REFERENCES public.stellar_currencyasset(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: documents_document documents_document_company_id_a2323c19_fk_companies_company_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents_document
    ADD CONSTRAINT documents_document_company_id_a2323c19_fk_companies_company_id FOREIGN KEY (company_id) REFERENCES public.companies_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: documents_document documents_document_creator_id_e53c7296_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents_document
    ADD CONSTRAINT documents_document_creator_id_e53c7296_fk_users_user_id FOREIGN KEY (creator_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: documents_document_related_users documents_document_r_document_id_b59f104d_fk_documents; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents_document_related_users
    ADD CONSTRAINT documents_document_r_document_id_b59f104d_fk_documents FOREIGN KEY (document_id) REFERENCES public.documents_document(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: documents_document_related_users documents_document_r_user_id_f5ae5d43_fk_users_use; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents_document_related_users
    ADD CONSTRAINT documents_document_r_user_id_f5ae5d43_fk_users_use FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: documents_document documents_document_related_meeting_id_3655541d_fk_meetings_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents_document
    ADD CONSTRAINT documents_document_related_meeting_id_3655541d_fk_meetings_ FOREIGN KEY (related_meeting_id) REFERENCES public.meetings_meeting(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: documents_document documents_document_related_operation_id_f0cd3e91_fk_operation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents_document
    ADD CONSTRAINT documents_document_related_operation_id_f0cd3e91_fk_operation FOREIGN KEY (related_operation_id) REFERENCES public.operations_operation(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: documents_historydocument documents_historydoc_document_id_cee359cd_fk_documents; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents_historydocument
    ADD CONSTRAINT documents_historydoc_document_id_cee359cd_fk_documents FOREIGN KEY (document_id) REFERENCES public.documents_document(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: documents_historydocument documents_historydocument_creator_id_5ef4a743_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents_historydocument
    ADD CONSTRAINT documents_historydocument_creator_id_5ef4a743_fk_users_user_id FOREIGN KEY (creator_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: documents_useractiondetail documents_useraction_company_id_97963439_fk_companies; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents_useractiondetail
    ADD CONSTRAINT documents_useraction_company_id_97963439_fk_companies FOREIGN KEY (company_id) REFERENCES public.companies_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: documents_useractiondetail documents_useraction_session_id_e7baf4a6_fk_documents; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents_useractiondetail
    ADD CONSTRAINT documents_useraction_session_id_e7baf4a6_fk_documents FOREIGN KEY (session_id) REFERENCES public.documents_usersessionlog(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: documents_usersessionlog documents_usersessionlog_user_id_72905266_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents_usersessionlog
    ADD CONSTRAINT documents_usersessionlog_user_id_72905266_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: mangopay_mangopaybankwiredeposit mangopay_mangopayban_basemangopaytransact_8f335080_fk_mangopay_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mangopay_mangopaybankwiredeposit
    ADD CONSTRAINT mangopay_mangopayban_basemangopaytransact_8f335080_fk_mangopay_ FOREIGN KEY (basemangopaytransaction_ptr_id) REFERENCES public.mangopay_basemangopaytransaction(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: mangopay_mangopaybankwiredeposit mangopay_mangopayban_to_user_id_71a14e73_fk_users_use; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mangopay_mangopaybankwiredeposit
    ADD CONSTRAINT mangopay_mangopayban_to_user_id_71a14e73_fk_users_use FOREIGN KEY (to_user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: mangopay_mangopaybankaccount mangopay_mangopaybankaccount_user_id_1efeffeb_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mangopay_mangopaybankaccount
    ADD CONSTRAINT mangopay_mangopaybankaccount_user_id_1efeffeb_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: mangopay_mangopaykycdocument mangopay_mangopaykycdocument_user_id_8a4e361d_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mangopay_mangopaykycdocument
    ADD CONSTRAINT mangopay_mangopaykycdocument_user_id_8a4e361d_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: mangopay_mangopaydeposit mangopay_mangopaypay_basemangopaytransact_cd59d58a_fk_mangopay_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mangopay_mangopaydeposit
    ADD CONSTRAINT mangopay_mangopaypay_basemangopaytransact_cd59d58a_fk_mangopay_ FOREIGN KEY (basemangopaytransaction_ptr_id) REFERENCES public.mangopay_basemangopaytransaction(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: mangopay_mangopaydeposit mangopay_mangopaypayment_to_user_id_b1ab7f6c_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mangopay_mangopaydeposit
    ADD CONSTRAINT mangopay_mangopaypayment_to_user_id_b1ab7f6c_fk_users_user_id FOREIGN KEY (to_user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: mangopay_mangopaytransfer mangopay_mangopaytra_basemangopaytransact_d76323ba_fk_mangopay_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mangopay_mangopaytransfer
    ADD CONSTRAINT mangopay_mangopaytra_basemangopaytransact_d76323ba_fk_mangopay_ FOREIGN KEY (basemangopaytransaction_ptr_id) REFERENCES public.mangopay_basemangopaytransaction(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: mangopay_mangopaytransfer mangopay_mangopaytra_from_user_id_8f629f37_fk_users_use; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mangopay_mangopaytransfer
    ADD CONSTRAINT mangopay_mangopaytra_from_user_id_8f629f37_fk_users_use FOREIGN KEY (from_user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: mangopay_mangopaytransfer mangopay_mangopaytransfer_to_user_id_192815a2_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mangopay_mangopaytransfer
    ADD CONSTRAINT mangopay_mangopaytransfer_to_user_id_192815a2_fk_users_user_id FOREIGN KEY (to_user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: mangopay_mangopayuser mangopay_mangopayuser_user_id_16f19700_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mangopay_mangopayuser
    ADD CONSTRAINT mangopay_mangopayuser_user_id_16f19700_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: mangopay_mangopaywallet mangopay_mangopaywallet_user_id_abdecccd_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mangopay_mangopaywallet
    ADD CONSTRAINT mangopay_mangopaywallet_user_id_abdecccd_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: meetings_agendaitem meetings_agendaitem_meeting_id_07815bb0_fk_meetings_meeting_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meetings_agendaitem
    ADD CONSTRAINT meetings_agendaitem_meeting_id_07815bb0_fk_meetings_meeting_id FOREIGN KEY (meeting_id) REFERENCES public.meetings_meeting(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: meetings_document meetings_document_agenda_item_id_05269058_fk_meetings_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meetings_document
    ADD CONSTRAINT meetings_document_agenda_item_id_05269058_fk_meetings_ FOREIGN KEY (agenda_item_id) REFERENCES public.meetings_agendaitem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: meetings_document meetings_document_creator_id_ce7348bc_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meetings_document
    ADD CONSTRAINT meetings_document_creator_id_ce7348bc_fk_users_user_id FOREIGN KEY (creator_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: meetings_historymeetingsdocument meetings_historymeet_creator_id_5e09a29f_fk_users_use; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meetings_historymeetingsdocument
    ADD CONSTRAINT meetings_historymeet_creator_id_5e09a29f_fk_users_use FOREIGN KEY (creator_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: meetings_historymeetingsdocument meetings_historymeet_document_id_b1eb6e87_fk_meetings_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meetings_historymeetingsdocument
    ADD CONSTRAINT meetings_historymeet_document_id_b1eb6e87_fk_meetings_ FOREIGN KEY (document_id) REFERENCES public.meetings_document(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: meetings_meeting meetings_meeting_call_id_195a944a_fk_meetings_document_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meetings_meeting
    ADD CONSTRAINT meetings_meeting_call_id_195a944a_fk_meetings_document_id FOREIGN KEY (call_id) REFERENCES public.meetings_document(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: meetings_meeting meetings_meeting_company_id_15255a07_fk_companies_company_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meetings_meeting
    ADD CONSTRAINT meetings_meeting_company_id_15255a07_fk_companies_company_id FOREIGN KEY (company_id) REFERENCES public.companies_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: meetings_meeting meetings_meeting_creator_id_ba60be78_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meetings_meeting
    ADD CONSTRAINT meetings_meeting_creator_id_ba60be78_fk_users_user_id FOREIGN KEY (creator_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: meetings_meeting meetings_meeting_minutes_id_f772076b_fk_meetings_document_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meetings_meeting
    ADD CONSTRAINT meetings_meeting_minutes_id_f772076b_fk_meetings_document_id FOREIGN KEY (minutes_id) REFERENCES public.meetings_document(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: meetings_participant meetings_participant_meeting_id_4a769a34_fk_meetings_meeting_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meetings_participant
    ADD CONSTRAINT meetings_participant_meeting_id_4a769a34_fk_meetings_meeting_id FOREIGN KEY (meeting_id) REFERENCES public.meetings_meeting(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: meetings_participant meetings_participant_user_id_b38e7254_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meetings_participant
    ADD CONSTRAINT meetings_participant_user_id_b38e7254_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: oauth2_provider_accesstoken oauth2_provider_acce_application_id_b22886e1_fk_oauth2_pr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_provider_accesstoken
    ADD CONSTRAINT oauth2_provider_acce_application_id_b22886e1_fk_oauth2_pr FOREIGN KEY (application_id) REFERENCES public.oauth2_provider_application(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: oauth2_provider_accesstoken oauth2_provider_acce_id_token_id_85db651b_fk_oauth2_pr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_provider_accesstoken
    ADD CONSTRAINT oauth2_provider_acce_id_token_id_85db651b_fk_oauth2_pr FOREIGN KEY (id_token_id) REFERENCES public.oauth2_provider_idtoken(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: oauth2_provider_accesstoken oauth2_provider_acce_source_refresh_token_e66fbc72_fk_oauth2_pr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_provider_accesstoken
    ADD CONSTRAINT oauth2_provider_acce_source_refresh_token_e66fbc72_fk_oauth2_pr FOREIGN KEY (source_refresh_token_id) REFERENCES public.oauth2_provider_refreshtoken(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: oauth2_provider_accesstoken oauth2_provider_accesstoken_user_id_6e4c9a65_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_provider_accesstoken
    ADD CONSTRAINT oauth2_provider_accesstoken_user_id_6e4c9a65_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: oauth2_provider_application oauth2_provider_application_user_id_79829054_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_provider_application
    ADD CONSTRAINT oauth2_provider_application_user_id_79829054_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: oauth2_provider_grant oauth2_provider_gran_application_id_81923564_fk_oauth2_pr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_provider_grant
    ADD CONSTRAINT oauth2_provider_gran_application_id_81923564_fk_oauth2_pr FOREIGN KEY (application_id) REFERENCES public.oauth2_provider_application(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: oauth2_provider_grant oauth2_provider_grant_user_id_e8f62af8_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_provider_grant
    ADD CONSTRAINT oauth2_provider_grant_user_id_e8f62af8_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: oauth2_provider_idtoken oauth2_provider_idto_application_id_08c5ff4f_fk_oauth2_pr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_provider_idtoken
    ADD CONSTRAINT oauth2_provider_idto_application_id_08c5ff4f_fk_oauth2_pr FOREIGN KEY (application_id) REFERENCES public.oauth2_provider_application(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: oauth2_provider_idtoken oauth2_provider_idtoken_user_id_dd512b59_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_provider_idtoken
    ADD CONSTRAINT oauth2_provider_idtoken_user_id_dd512b59_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: oauth2_provider_refreshtoken oauth2_provider_refr_access_token_id_775e84e8_fk_oauth2_pr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_provider_refreshtoken
    ADD CONSTRAINT oauth2_provider_refr_access_token_id_775e84e8_fk_oauth2_pr FOREIGN KEY (access_token_id) REFERENCES public.oauth2_provider_accesstoken(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: oauth2_provider_refreshtoken oauth2_provider_refr_application_id_2d1c311b_fk_oauth2_pr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_provider_refreshtoken
    ADD CONSTRAINT oauth2_provider_refr_application_id_2d1c311b_fk_oauth2_pr FOREIGN KEY (application_id) REFERENCES public.oauth2_provider_application(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: oauth2_provider_refreshtoken oauth2_provider_refreshtoken_user_id_da837fce_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_provider_refreshtoken
    ADD CONSTRAINT oauth2_provider_refreshtoken_user_id_da837fce_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offers_document offers_document_proposal_id_9c16af73_fk_offers_proposal_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers_document
    ADD CONSTRAINT offers_document_proposal_id_9c16af73_fk_offers_proposal_id FOREIGN KEY (proposal_id) REFERENCES public.offers_proposal(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offers_historyoffersdocument offers_historyoffers_creator_id_89690ff0_fk_users_use; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers_historyoffersdocument
    ADD CONSTRAINT offers_historyoffers_creator_id_89690ff0_fk_users_use FOREIGN KEY (creator_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offers_historyoffersdocument offers_historyoffers_document_id_c0b6e0f3_fk_offers_do; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers_historyoffersdocument
    ADD CONSTRAINT offers_historyoffers_document_id_c0b6e0f3_fk_offers_do FOREIGN KEY (document_id) REFERENCES public.offers_document(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offers_offer offers_offer_capital_increase_id_64fa82ed_fk_capital_i; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers_offer
    ADD CONSTRAINT offers_offer_capital_increase_id_64fa82ed_fk_capital_i FOREIGN KEY (capital_increase_id) REFERENCES public.capital_increases_capitalincrease(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offers_offer offers_offer_company_id_623c4621_fk_companies_company_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers_offer
    ADD CONSTRAINT offers_offer_company_id_623c4621_fk_companies_company_id FOREIGN KEY (company_id) REFERENCES public.companies_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offers_offer offers_offer_for_user_id_123defbd_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers_offer
    ADD CONSTRAINT offers_offer_for_user_id_123defbd_fk_users_user_id FOREIGN KEY (for_user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offers_offer offers_offer_user_id_4fbc0994_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers_offer
    ADD CONSTRAINT offers_offer_user_id_4fbc0994_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offers_proposal offers_proposal_offer_id_04f106db_fk_offers_offer_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers_proposal
    ADD CONSTRAINT offers_proposal_offer_id_04f106db_fk_offers_offer_id FOREIGN KEY (offer_id) REFERENCES public.offers_offer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offers_proposal offers_proposal_operation_id_f4cb3598_fk_operation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers_proposal
    ADD CONSTRAINT offers_proposal_operation_id_f4cb3598_fk_operation FOREIGN KEY (operation_id) REFERENCES public.operations_operation(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offers_proposal offers_proposal_payment_id_71ec353a_fk_payments_payment_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers_proposal
    ADD CONSTRAINT offers_proposal_payment_id_71ec353a_fk_payments_payment_id FOREIGN KEY (payment_id) REFERENCES public.payments_payment(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offers_proposal offers_proposal_user_id_a8d68715_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offers_proposal
    ADD CONSTRAINT offers_proposal_user_id_a8d68715_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: operations_operation operations_operation_company_id_a5943d84_fk_companies; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operations_operation
    ADD CONSTRAINT operations_operation_company_id_a5943d84_fk_companies FOREIGN KEY (company_id) REFERENCES public.companies_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: operations_operation operations_operation_from_user_id_7fd8c572_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operations_operation
    ADD CONSTRAINT operations_operation_from_user_id_7fd8c572_fk_users_user_id FOREIGN KEY (from_user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: operations_operation operations_operation_to_user_id_bbca8815_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operations_operation
    ADD CONSTRAINT operations_operation_to_user_id_bbca8815_fk_users_user_id FOREIGN KEY (to_user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: options_useroption options_useroption_user_id_01488187_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.options_useroption
    ADD CONSTRAINT options_useroption_user_id_01488187_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_partner partners_partner_company_id_e5c5fedc_fk_companies_company_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partners_partner
    ADD CONSTRAINT partners_partner_company_id_e5c5fedc_fk_companies_company_id FOREIGN KEY (company_id) REFERENCES public.companies_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_partner partners_partner_content_type_id_a0059c54_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partners_partner
    ADD CONSTRAINT partners_partner_content_type_id_a0059c54_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partners_partner partners_partner_user_id_c9159f29_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partners_partner
    ADD CONSTRAINT partners_partner_user_id_c9159f29_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: payments_payment payments_payment_from_user_id_cc566b32_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments_payment
    ADD CONSTRAINT payments_payment_from_user_id_cc566b32_fk_users_user_id FOREIGN KEY (from_user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: payments_payment payments_payment_to_user_id_7dfa9b08_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments_payment
    ADD CONSTRAINT payments_payment_to_user_id_7dfa9b08_fk_users_user_id FOREIGN KEY (to_user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: snitch_event snitch_event_actor_content_type_i_2ad2cc94_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.snitch_event
    ADD CONSTRAINT snitch_event_actor_content_type_i_2ad2cc94_fk_django_co FOREIGN KEY (actor_content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: snitch_event snitch_event_target_content_type__06e9448e_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.snitch_event
    ADD CONSTRAINT snitch_event_target_content_type__06e9448e_fk_django_co FOREIGN KEY (target_content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: snitch_event snitch_event_trigger_content_type_8b86ecfb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.snitch_event
    ADD CONSTRAINT snitch_event_trigger_content_type_8b86ecfb_fk_django_co FOREIGN KEY (trigger_content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: snitch_notification snitch_notification_event_id_0283365f_fk_snitch_event_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.snitch_notification
    ADD CONSTRAINT snitch_notification_event_id_0283365f_fk_snitch_event_id FOREIGN KEY (event_id) REFERENCES public.snitch_event(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: snitch_notification snitch_notification_user_id_9f5bdce1_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.snitch_notification
    ADD CONSTRAINT snitch_notification_user_id_9f5bdce1_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: social_auth_usersocialauth social_auth_usersocialauth_user_id_17d28448_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.social_auth_usersocialauth
    ADD CONSTRAINT social_auth_usersocialauth_user_id_17d28448_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stellar_asset stellar_asset_company_id_abb22de8_fk_companies_company_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stellar_asset
    ADD CONSTRAINT stellar_asset_company_id_abb22de8_fk_companies_company_id FOREIGN KEY (company_id) REFERENCES public.companies_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stellar_asset_trust_op_completed stellar_asset_trust__asset_id_bd42c6f5_fk_stellar_a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stellar_asset_trust_op_completed
    ADD CONSTRAINT stellar_asset_trust__asset_id_bd42c6f5_fk_stellar_a FOREIGN KEY (asset_id) REFERENCES public.stellar_asset(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stellar_asset_trust_op_completed stellar_asset_trust__user_id_af5e299a_fk_users_use; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stellar_asset_trust_op_completed
    ADD CONSTRAINT stellar_asset_trust__user_id_af5e299a_fk_users_use FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stellar_currencyasset_trust_op_completed stellar_currencyasse_currencyasset_id_6ed8310e_fk_stellar_c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stellar_currencyasset_trust_op_completed
    ADD CONSTRAINT stellar_currencyasse_currencyasset_id_6ed8310e_fk_stellar_c FOREIGN KEY (currencyasset_id) REFERENCES public.stellar_currencyasset(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stellar_currencyasset_trust_op_completed stellar_currencyasse_user_id_064aab92_fk_users_use; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stellar_currencyasset_trust_op_completed
    ADD CONSTRAINT stellar_currencyasse_user_id_064aab92_fk_users_use FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stellar_wallet stellar_wallet_user_id_ee8eb8e3_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stellar_wallet
    ADD CONSTRAINT stellar_wallet_user_id_ee8eb8e3_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_fiscalresidence users_fiscalresidence_user_id_5b29aae4_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_fiscalresidence
    ADD CONSTRAINT users_fiscalresidence_user_id_5b29aae4_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_favorited_companies users_user_favorited_company_id_445a86b5_fk_companies; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_favorited_companies
    ADD CONSTRAINT users_user_favorited_company_id_445a86b5_fk_companies FOREIGN KEY (company_id) REFERENCES public.companies_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_favorited_companies users_user_favorited_user_id_08ed230f_fk_users_use; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_favorited_companies
    ADD CONSTRAINT users_user_favorited_user_id_08ed230f_fk_users_use FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_groups users_user_groups_group_id_9afc8d0e_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_groups
    ADD CONSTRAINT users_user_groups_group_id_9afc8d0e_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_groups users_user_groups_user_id_5f6f5a90_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_groups
    ADD CONSTRAINT users_user_groups_user_id_5f6f5a90_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_user_permissions users_user_user_perm_permission_id_0b93982e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_user_permissions
    ADD CONSTRAINT users_user_user_perm_permission_id_0b93982e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_user_permissions users_user_user_permissions_user_id_20aca447_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_user_id_20aca447_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: votes_vote votes_vote_agenda_item_id_2274f311_fk_meetings_agendaitem_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes_vote
    ADD CONSTRAINT votes_vote_agenda_item_id_2274f311_fk_meetings_agendaitem_id FOREIGN KEY (agenda_item_id) REFERENCES public.meetings_agendaitem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: votes_vote votes_vote_content_type_id_c8375fe1_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes_vote
    ADD CONSTRAINT votes_vote_content_type_id_c8375fe1_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

