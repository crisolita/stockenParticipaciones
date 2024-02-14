-- CreateEnum
CREATE TYPE "StatusOrderCtaParticipe" AS ENUM ('VENTA_ACTIVA', 'SALDO_BLOQUEADO', 'PENDIENTE_FIRMA', 'COMPRA_TERMINADA', 'RECHAZADA');

-- CreateEnum
CREATE TYPE "StatusActivo" AS ENUM ('ACTIVO', 'FINALIZADO', 'CANCELADO');

-- CreateEnum
CREATE TYPE "Tipodeinteres" AS ENUM ('FIJO', 'VARIABLE', 'COMPUESTO');

-- CreateEnum
CREATE TYPE "TypeOfMedia" AS ENUM ('IMAGE', 'DOC');

-- CreateTable
CREATE TABLE "auth_group" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(150) NOT NULL,

    CONSTRAINT "auth_group_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "auth_group_permissions" (
    "id" SERIAL NOT NULL,
    "group_id" INTEGER NOT NULL,
    "permission_id" INTEGER NOT NULL,

    CONSTRAINT "auth_group_permissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "auth_permission" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "content_type_id" INTEGER NOT NULL,
    "codename" VARCHAR(100) NOT NULL,

    CONSTRAINT "auth_permission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "authtoken_token" (
    "key" VARCHAR(40) NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "authtoken_token_pkey" PRIMARY KEY ("key")
);

-- CreateTable
CREATE TABLE "capital_increases_capitalincrease" (
    "id" SERIAL NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "modified" TIMESTAMPTZ(6) NOT NULL,
    "max_shares" INTEGER NOT NULL,
    "min_shares" INTEGER NOT NULL,
    "deadline" DATE NOT NULL,
    "amount_per_share" DECIMAL(20,2) NOT NULL,
    "state" VARCHAR(32) NOT NULL,
    "company_id" INTEGER NOT NULL,
    "issue_premium" DECIMAL(20,2) NOT NULL,
    "new_share_capital" DECIMAL(20,2),

    CONSTRAINT "capital_increases_capitalincrease_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "companies_category" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(100) NOT NULL,

    CONSTRAINT "companies_category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "companies_company" (
    "id" SERIAL NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "modified" TIMESTAMPTZ(6) NOT NULL,
    "social_denomination" VARCHAR(100),
    "cif" VARCHAR(100),
    "constitution_date" DATE,
    "street_address" VARCHAR(200),
    "city" VARCHAR(100),
    "postal_code" VARCHAR(10),
    "state" VARCHAR(100),
    "country" VARCHAR(2),
    "logo" VARCHAR(100),
    "description" TEXT,
    "registration_data" TEXT,
    "governing_bodies" TEXT,
    "shares" INTEGER,
    "share_capital" DECIMAL(20,2),
    "par_value_per_share" DECIMAL(20,2),
    "status" VARCHAR(32) NOT NULL,
    "published" BOOLEAN NOT NULL,
    "slug" VARCHAR(50),
    "right_conditions" BOOLEAN NOT NULL,
    "right_conditions_days" INTEGER,
    "stocken_invests" BOOLEAN NOT NULL,
    "code" VARCHAR(4),
    "legal_representative_id" INTEGER,
    "governing_bodies_legal_representative_full_name" VARCHAR(100),
    "governing_bodies_legal_representative_position" VARCHAR(100),
    "governing_bodies_legal_representative_powers_date" DATE,
    "governing_bodies_notary_city" VARCHAR(100),
    "governing_bodies_notary_full_name" VARCHAR(100),
    "governing_bodies_notary_number" VARCHAR(100),
    "registration_data_date" DATE,
    "registration_data_inscription_date" DATE,
    "registration_data_inscription_number" VARCHAR(100),
    "registration_data_notary_city" VARCHAR(100),
    "registration_data_notary_full_name" VARCHAR(100),
    "registration_data_notary_number" VARCHAR(100),
    "registration_data_number" VARCHAR(100),
    "registration_data_page_number" VARCHAR(100),
    "registration_data_sheet_number" VARCHAR(100),
    "registration_data_state" VARCHAR(100),
    "registration_data_volume_number" VARCHAR(100),
    "automation_corporate_management" BOOLEAN NOT NULL,
    "capture_private_financing" BOOLEAN NOT NULL,
    "management_transparency" BOOLEAN NOT NULL,
    "otra" BOOLEAN NOT NULL,
    "otra_description" TEXT,
    "categories_id" INTEGER,
    "cod" VARCHAR(30),
    "mangopay_id" VARCHAR(32),
    "investor" BOOLEAN NOT NULL,

    CONSTRAINT "companies_company_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "companies_company_investors" (
    "id" SERIAL NOT NULL,
    "company_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "companies_company_investors_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "conversations_contact" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "subject" VARCHAR(255) NOT NULL,
    "email" VARCHAR(254) NOT NULL,
    "message" TEXT NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "conversations_contact_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "conversations_conversation" (
    "id" SERIAL NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "subject" VARCHAR(128) NOT NULL,
    "body" TEXT NOT NULL,
    "is_from_company" BOOLEAN NOT NULL,
    "company_id" INTEGER NOT NULL,
    "creator_id" INTEGER NOT NULL,
    "blockchain_link" TEXT,
    "blockchain_transaction_id" TEXT,
    "cod" VARCHAR(30),
    "transaction_hash" TEXT,

    CONSTRAINT "conversations_conversation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "conversations_conversation_documents" (
    "id" SERIAL NOT NULL,
    "conversation_id" INTEGER NOT NULL,
    "document_id" INTEGER NOT NULL,

    CONSTRAINT "conversations_conversation_documents_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "conversations_conversation_partners" (
    "id" SERIAL NOT NULL,
    "conversation_id" INTEGER NOT NULL,
    "partner_id" INTEGER NOT NULL,

    CONSTRAINT "conversations_conversation_partners_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "conversations_conversationhistory" (
    "id" SERIAL NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "modified" TIMESTAMPTZ(6) NOT NULL,
    "transaction_hash" TEXT,
    "conversation_id" INTEGER,
    "creator_id" INTEGER,
    "blockchain_link" TEXT,
    "blockchain_transaction_id" TEXT,

    CONSTRAINT "conversations_conversationhistory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "conversations_message" (
    "id" SERIAL NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "body" TEXT NOT NULL,
    "conversation_id" INTEGER NOT NULL,
    "creator_id" INTEGER NOT NULL,
    "blockchain_link" TEXT,
    "blockchain_transaction_id" TEXT,
    "transaction_hash" TEXT,
    "cod" VARCHAR(30),

    CONSTRAINT "conversations_message_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "conversations_message_documents" (
    "id" SERIAL NOT NULL,
    "message_id" INTEGER NOT NULL,
    "document_id" INTEGER NOT NULL,

    CONSTRAINT "conversations_message_documents_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "currencies_currency" (
    "code" VARCHAR(3) NOT NULL,
    "currency_asset_id" INTEGER NOT NULL,

    CONSTRAINT "currencies_currency_pkey" PRIMARY KEY ("code")
);

-- CreateTable
CREATE TABLE "django_admin_log" (
    "id" SERIAL NOT NULL,
    "action_time" TIMESTAMPTZ(6) NOT NULL,
    "object_id" TEXT,
    "object_repr" VARCHAR(200) NOT NULL,
    "action_flag" SMALLINT NOT NULL,
    "change_message" TEXT NOT NULL,
    "content_type_id" INTEGER,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "django_admin_log_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "django_content_type" (
    "id" SERIAL NOT NULL,
    "app_label" VARCHAR(100) NOT NULL,
    "model" VARCHAR(100) NOT NULL,

    CONSTRAINT "django_content_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "django_migrations" (
    "id" SERIAL NOT NULL,
    "app" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "applied" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "django_migrations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "django_session" (
    "session_key" VARCHAR(40) NOT NULL,
    "session_data" TEXT NOT NULL,
    "expire_date" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "django_session_pkey" PRIMARY KEY ("session_key")
);

-- CreateTable
CREATE TABLE "django_site" (
    "id" SERIAL NOT NULL,
    "domain" VARCHAR(100) NOT NULL,
    "name" VARCHAR(50) NOT NULL,

    CONSTRAINT "django_site_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "documents_document" (
    "id" SERIAL NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "modified" TIMESTAMPTZ(6) NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "description" TEXT NOT NULL,
    "file" VARCHAR(100) NOT NULL,
    "visibility" VARCHAR(16) NOT NULL,
    "company_id" INTEGER NOT NULL,
    "creator_id" INTEGER,
    "file_hash" TEXT,
    "stellar_transaction_hash" TEXT,
    "related_meeting_id" INTEGER,
    "related_operation_id" INTEGER,
    "type" VARCHAR(16),
    "blockchain_link" TEXT,
    "blockchain_transaction_id" TEXT,
    "cod" VARCHAR(30),
    "transaction_hash" TEXT,

    CONSTRAINT "documents_document_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "documents_document_related_users" (
    "id" SERIAL NOT NULL,
    "document_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "documents_document_related_users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "documents_historydocument" (
    "id" SERIAL NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "modified" TIMESTAMPTZ(6) NOT NULL,
    "transaction_hash" TEXT,
    "creator_id" INTEGER,
    "document_id" INTEGER,
    "blockchain_link" TEXT,
    "blockchain_transaction_id" TEXT,
    "cod" VARCHAR(30),

    CONSTRAINT "documents_historydocument_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "documents_useractiondetail" (
    "id" SERIAL NOT NULL,
    "action" VARCHAR(255) NOT NULL,
    "timestamp" TIMESTAMPTZ(6) NOT NULL,
    "details" TEXT,
    "company_id" INTEGER,
    "session_id" INTEGER NOT NULL,

    CONSTRAINT "documents_useractiondetail_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "documents_usersessionlog" (
    "id" SERIAL NOT NULL,
    "start_time" TIMESTAMPTZ(6) NOT NULL,
    "end_time" TIMESTAMPTZ(6),
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "documents_usersessionlog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "mangopay_basemangopaytransaction" (
    "id" SERIAL NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "modified" TIMESTAMPTZ(6) NOT NULL,
    "transaction_id" VARCHAR(32) NOT NULL,
    "status" VARCHAR(32) NOT NULL,
    "amount" DECIMAL(20,2) NOT NULL,
    "currency" VARCHAR(3) NOT NULL,
    "fees" DECIMAL(20,2) NOT NULL,
    "cod" VARCHAR(30) NOT NULL,

    CONSTRAINT "mangopay_basemangopaytransaction_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "mangopay_mangopaybankaccount" (
    "id" SERIAL NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "modified" TIMESTAMPTZ(6) NOT NULL,
    "bank_account_id" VARCHAR(32) NOT NULL,
    "iban" VARCHAR(100) NOT NULL,
    "is_active" BOOLEAN NOT NULL,
    "owner_name" VARCHAR(200) NOT NULL,
    "owner_street_address" VARCHAR(200) NOT NULL,
    "owner_city" VARCHAR(100) NOT NULL,
    "owner_postal_code" VARCHAR(10) NOT NULL,
    "owner_state" VARCHAR(100) NOT NULL,
    "owner_country" VARCHAR(2) NOT NULL,
    "user_id" INTEGER NOT NULL,
    "cod" VARCHAR(30) NOT NULL,

    CONSTRAINT "mangopay_mangopaybankaccount_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "mangopay_mangopaybankwiredeposit" (
    "basemangopaytransaction_ptr_id" INTEGER NOT NULL,
    "wire_reference" VARCHAR(64) NOT NULL,
    "bank_account" VARCHAR(64) NOT NULL,
    "to_user_id" INTEGER NOT NULL,

    CONSTRAINT "mangopay_mangopaybankwiredeposit_pkey" PRIMARY KEY ("basemangopaytransaction_ptr_id")
);

-- CreateTable
CREATE TABLE "mangopay_mangopaydeposit" (
    "language" VARCHAR(8) NOT NULL,
    "redirect_url" VARCHAR(200) NOT NULL,
    "return_url" VARCHAR(200) NOT NULL,
    "to_user_id" INTEGER NOT NULL,
    "basemangopaytransaction_ptr_id" INTEGER NOT NULL,

    CONSTRAINT "mangopay_mangopaypayment_pkey" PRIMARY KEY ("basemangopaytransaction_ptr_id")
);

-- CreateTable
CREATE TABLE "mangopay_mangopaykycdocument" (
    "id" SERIAL NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "modified" TIMESTAMPTZ(6) NOT NULL,
    "status" VARCHAR(32) NOT NULL,
    "type" VARCHAR(32) NOT NULL,
    "document_id" VARCHAR(32) NOT NULL,
    "user_id" INTEGER NOT NULL,
    "processed_date" TIMESTAMPTZ(6),
    "refused_reason_message" VARCHAR(256),
    "refused_reason_type" VARCHAR(64),
    "cod" VARCHAR(30) NOT NULL,

    CONSTRAINT "mangopay_mangopaykycdocument_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "mangopay_mangopaytransfer" (
    "from_user_id" INTEGER NOT NULL,
    "to_user_id" INTEGER NOT NULL,
    "basemangopaytransaction_ptr_id" INTEGER NOT NULL,
    "from_cod" VARCHAR(255),
    "to_cod" VARCHAR(255),
    "total_amount" DECIMAL(20,2),

    CONSTRAINT "mangopay_mangopaytransfer_pkey" PRIMARY KEY ("basemangopaytransaction_ptr_id")
);

-- CreateTable
CREATE TABLE "mangopay_mangopayuser" (
    "id" SERIAL NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "modified" TIMESTAMPTZ(6) NOT NULL,
    "mangopay_id" VARCHAR(32) NOT NULL,
    "user_id" INTEGER NOT NULL,
    "kyc_level" VARCHAR(32) NOT NULL,
    "cod" VARCHAR(30) NOT NULL,

    CONSTRAINT "mangopay_mangopayuser_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "mangopay_mangopaywallet" (
    "id" SERIAL NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "modified" TIMESTAMPTZ(6) NOT NULL,
    "wallet_id" VARCHAR(32) NOT NULL,
    "user_id" INTEGER,
    "amount" DECIMAL(20,2) NOT NULL,
    "cod" VARCHAR(30) NOT NULL,

    CONSTRAINT "mangopay_mangopaywallet_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "meetings_agendaitem" (
    "id" SERIAL NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "proposal" TEXT NOT NULL,
    "meeting_id" INTEGER NOT NULL,
    "proposal_agreement" TEXT,
    "approved" BOOLEAN,

    CONSTRAINT "meetings_agendaitem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "meetings_document" (
    "id" SERIAL NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "file" VARCHAR(100) NOT NULL,
    "hash" TEXT,
    "agenda_item_id" INTEGER,
    "creator_id" INTEGER,
    "stellar_transaction_hash" TEXT,
    "blockchain_link" TEXT,
    "blockchain_transaction_id" TEXT,

    CONSTRAINT "meetings_document_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "meetings_historymeetingsdocument" (
    "id" SERIAL NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "modified" TIMESTAMPTZ(6) NOT NULL,
    "transaction_hash" TEXT,
    "blockchain_transaction_id" TEXT,
    "blockchain_link" TEXT,
    "creator_id" INTEGER,
    "document_id" INTEGER,

    CONSTRAINT "meetings_historymeetingsdocument_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "meetings_meeting" (
    "id" SERIAL NOT NULL,
    "planned_date" DATE NOT NULL,
    "celebration_date" DATE,
    "time" TIME(6) NOT NULL,
    "finish" TIMESTAMPTZ(6),
    "date_of_call" DATE,
    "state" VARCHAR(32) NOT NULL,
    "type" VARCHAR(32) NOT NULL,
    "place" VARCHAR(256) NOT NULL,
    "company_id" INTEGER NOT NULL,
    "creator_id" INTEGER,
    "minutes_id" INTEGER,
    "footer" TEXT,
    "header" TEXT,
    "review_date" DATE,
    "call_id" INTEGER,

    CONSTRAINT "meetings_meeting_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "meetings_participant" (
    "id" SERIAL NOT NULL,
    "shares" INTEGER NOT NULL,
    "attendant" BOOLEAN NOT NULL,
    "vote_datetime" TIMESTAMPTZ(6),
    "meeting_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "read_call" TIMESTAMPTZ(6),
    "read_minutes" TIMESTAMPTZ(6),
    "cod" VARCHAR(10),

    CONSTRAINT "meetings_participant_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "oauth2_provider_accesstoken" (
    "id" BIGSERIAL NOT NULL,
    "token" VARCHAR(255) NOT NULL,
    "expires" TIMESTAMPTZ(6) NOT NULL,
    "scope" TEXT NOT NULL,
    "application_id" BIGINT,
    "user_id" INTEGER,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "updated" TIMESTAMPTZ(6) NOT NULL,
    "source_refresh_token_id" BIGINT,
    "id_token_id" BIGINT,

    CONSTRAINT "oauth2_provider_accesstoken_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "oauth2_provider_application" (
    "id" BIGSERIAL NOT NULL,
    "client_id" VARCHAR(100) NOT NULL,
    "redirect_uris" TEXT NOT NULL,
    "client_type" VARCHAR(32) NOT NULL,
    "authorization_grant_type" VARCHAR(32) NOT NULL,
    "client_secret" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "user_id" INTEGER,
    "skip_authorization" BOOLEAN NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "updated" TIMESTAMPTZ(6) NOT NULL,
    "algorithm" VARCHAR(5) NOT NULL,
    "post_logout_redirect_uris" TEXT NOT NULL,

    CONSTRAINT "oauth2_provider_application_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "oauth2_provider_grant" (
    "id" BIGSERIAL NOT NULL,
    "code" VARCHAR(255) NOT NULL,
    "expires" TIMESTAMPTZ(6) NOT NULL,
    "redirect_uri" TEXT NOT NULL,
    "scope" TEXT NOT NULL,
    "application_id" BIGINT NOT NULL,
    "user_id" INTEGER NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "updated" TIMESTAMPTZ(6) NOT NULL,
    "code_challenge" VARCHAR(128) NOT NULL,
    "code_challenge_method" VARCHAR(10) NOT NULL,
    "nonce" VARCHAR(255) NOT NULL,
    "claims" TEXT NOT NULL,

    CONSTRAINT "oauth2_provider_grant_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "oauth2_provider_idtoken" (
    "id" BIGSERIAL NOT NULL,
    "jti" UUID NOT NULL,
    "expires" TIMESTAMPTZ(6) NOT NULL,
    "scope" TEXT NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "updated" TIMESTAMPTZ(6) NOT NULL,
    "application_id" BIGINT,
    "user_id" INTEGER,

    CONSTRAINT "oauth2_provider_idtoken_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "oauth2_provider_refreshtoken" (
    "id" BIGSERIAL NOT NULL,
    "token" VARCHAR(255) NOT NULL,
    "access_token_id" BIGINT,
    "application_id" BIGINT NOT NULL,
    "user_id" INTEGER NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "updated" TIMESTAMPTZ(6) NOT NULL,
    "revoked" TIMESTAMPTZ(6),

    CONSTRAINT "oauth2_provider_refreshtoken_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "offers_document" (
    "id" SERIAL NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "modified" TIMESTAMPTZ(6) NOT NULL,
    "file" VARCHAR(100) NOT NULL,
    "hash" TEXT,
    "stellar_transaction_hash" TEXT,
    "proposal_id" INTEGER NOT NULL,
    "blockchain_link" TEXT,
    "blockchain_transaction_id" TEXT,

    CONSTRAINT "offers_document_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "offers_historyoffersdocument" (
    "id" SERIAL NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "modified" TIMESTAMPTZ(6) NOT NULL,
    "cod" VARCHAR(30),
    "transaction_hash" TEXT,
    "blockchain_transaction_id" TEXT,
    "blockchain_link" TEXT,
    "creator_id" INTEGER,
    "document_id" INTEGER,

    CONSTRAINT "offers_historyoffersdocument_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "offers_offer" (
    "id" SERIAL NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "modified" TIMESTAMPTZ(6) NOT NULL,
    "shares" INTEGER NOT NULL,
    "amount_per_share" DECIMAL(20,2) NOT NULL,
    "company_id" INTEGER NOT NULL,
    "user_id" INTEGER,
    "for_user_id" INTEGER,
    "is_family" BOOLEAN NOT NULL,
    "concept" VARCHAR(32) NOT NULL,
    "capital_increase_id" INTEGER,
    "is_canceled" BOOLEAN NOT NULL,
    "status" VARCHAR(32) NOT NULL,
    "cod" VARCHAR(255),

    CONSTRAINT "offers_offer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "offers_proposal" (
    "id" SERIAL NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "modified" TIMESTAMPTZ(6) NOT NULL,
    "shares" INTEGER NOT NULL,
    "amount_per_share" DECIMAL(20,2) NOT NULL,
    "state" VARCHAR(9) NOT NULL,
    "offer_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "operation_id" INTEGER,
    "payment_id" INTEGER,
    "shares_range_end" INTEGER,
    "shares_range_start" INTEGER,
    "fees" DECIMAL(20,2) NOT NULL,
    "total_amount" DECIMAL(20,2),
    "cod" VARCHAR(255),

    CONSTRAINT "offers_proposal_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "operations_operation" (
    "id" SERIAL NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "modified" TIMESTAMPTZ(6) NOT NULL,
    "type" VARCHAR(32) NOT NULL,
    "status" VARCHAR(32) NOT NULL,
    "shares" INTEGER NOT NULL,
    "amount" DECIMAL(20,2),
    "date" DATE NOT NULL,
    "concept" VARCHAR(256),
    "range_start" INTEGER,
    "range_end" INTEGER,
    "company_id" INTEGER NOT NULL,
    "from_user_id" INTEGER,
    "to_user_id" INTEGER NOT NULL,
    "from_shares_after_operation" INTEGER,
    "to_shares_after_operation" INTEGER,
    "amount_per_share" DECIMAL(20,2),
    "stellar_transaction_hash" TEXT,
    "issue_premium" DECIMAL(20,2),
    "from_cod" VARCHAR(30),
    "to_cod" VARCHAR(30),

    CONSTRAINT "operations_operation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "options_option" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "public_name" VARCHAR(255) NOT NULL,
    "type" INTEGER NOT NULL,
    "value" VARCHAR(256),
    "is_list" BOOLEAN NOT NULL,
    "file" VARCHAR(100),
    "is_public" BOOLEAN NOT NULL,
    "help_text" TEXT,

    CONSTRAINT "options_option_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "options_useroption" (
    "id" SERIAL NOT NULL,
    "public_name" VARCHAR(255) NOT NULL,
    "type" INTEGER NOT NULL,
    "value" VARCHAR(256),
    "is_list" BOOLEAN NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "user_id" INTEGER NOT NULL,
    "file" VARCHAR(100),
    "is_public" BOOLEAN NOT NULL,
    "help_text" TEXT,

    CONSTRAINT "options_useroption_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "partners_partner" (
    "id" SERIAL NOT NULL,
    "shares" INTEGER NOT NULL,
    "company_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "unit_acquisition_value" DECIMAL(20,2),
    "cod" VARCHAR(255),
    "company_cod" VARCHAR(255),
    "content_type_id" INTEGER,
    "object_id" INTEGER,
    "user_cod" VARCHAR(255),

    CONSTRAINT "partners_partner_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "payments_payment" (
    "id" SERIAL NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "modified" TIMESTAMPTZ(6) NOT NULL,
    "amount" DECIMAL(20,2) NOT NULL,
    "currency" VARCHAR(3) NOT NULL,
    "status" VARCHAR(32) NOT NULL,
    "mangopay_transaction_id" INTEGER,
    "to_user_id" INTEGER,
    "type" VARCHAR(32) NOT NULL,
    "from_user_id" INTEGER,
    "fees" DECIMAL(20,2) NOT NULL,
    "from_cod" VARCHAR(30),
    "to_cod" VARCHAR(30),

    CONSTRAINT "payments_payment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "snitch_event" (
    "id" SERIAL NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "modified" TIMESTAMPTZ(6) NOT NULL,
    "actor_object_id" INTEGER,
    "verb" VARCHAR(255),
    "trigger_object_id" INTEGER,
    "target_object_id" INTEGER,
    "notified" BOOLEAN NOT NULL,
    "actor_content_type_id" INTEGER,
    "target_content_type_id" INTEGER,
    "trigger_content_type_id" INTEGER,

    CONSTRAINT "snitch_event_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "snitch_eventtype" (
    "id" SERIAL NOT NULL,
    "verb" VARCHAR(255),
    "enabled" BOOLEAN NOT NULL,

    CONSTRAINT "snitch_eventtype_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "snitch_notification" (
    "id" SERIAL NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "modified" TIMESTAMPTZ(6) NOT NULL,
    "sent" BOOLEAN NOT NULL,
    "received" BOOLEAN NOT NULL,
    "read" BOOLEAN NOT NULL,
    "event_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "snitch_notification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "social_auth_association" (
    "id" BIGSERIAL NOT NULL,
    "server_url" VARCHAR(255) NOT NULL,
    "handle" VARCHAR(255) NOT NULL,
    "secret" VARCHAR(255) NOT NULL,
    "issued" INTEGER NOT NULL,
    "lifetime" INTEGER NOT NULL,
    "assoc_type" VARCHAR(64) NOT NULL,

    CONSTRAINT "social_auth_association_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "social_auth_code" (
    "id" BIGSERIAL NOT NULL,
    "email" VARCHAR(254) NOT NULL,
    "code" VARCHAR(32) NOT NULL,
    "verified" BOOLEAN NOT NULL,
    "timestamp" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "social_auth_code_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "social_auth_nonce" (
    "id" BIGSERIAL NOT NULL,
    "server_url" VARCHAR(255) NOT NULL,
    "timestamp" INTEGER NOT NULL,
    "salt" VARCHAR(65) NOT NULL,

    CONSTRAINT "social_auth_nonce_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "social_auth_partial" (
    "id" BIGSERIAL NOT NULL,
    "token" VARCHAR(32) NOT NULL,
    "next_step" SMALLINT NOT NULL,
    "backend" VARCHAR(32) NOT NULL,
    "timestamp" TIMESTAMPTZ(6) NOT NULL,
    "data" JSONB NOT NULL,

    CONSTRAINT "social_auth_partial_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "social_auth_usersocialauth" (
    "id" BIGSERIAL NOT NULL,
    "provider" VARCHAR(32) NOT NULL,
    "uid" VARCHAR(255) NOT NULL,
    "user_id" INTEGER NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "modified" TIMESTAMPTZ(6) NOT NULL,
    "extra_data" JSONB NOT NULL,

    CONSTRAINT "social_auth_usersocialauth_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "stellar_asset" (
    "id" SERIAL NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "modified" TIMESTAMPTZ(6) NOT NULL,
    "code" TEXT NOT NULL,
    "issuer_public_key" TEXT NOT NULL,
    "issuer_secret" TEXT NOT NULL,
    "distribution_public_key" TEXT NOT NULL,
    "distribution_secret" TEXT NOT NULL,
    "company_id" INTEGER NOT NULL,

    CONSTRAINT "stellar_asset_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "stellar_asset_trust_op_completed" (
    "id" SERIAL NOT NULL,
    "asset_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "stellar_asset_trust_op_completed_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "stellar_currencyasset" (
    "id" SERIAL NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "modified" TIMESTAMPTZ(6) NOT NULL,
    "code" TEXT NOT NULL,
    "issuer_public_key" TEXT NOT NULL,
    "issuer_secret" TEXT NOT NULL,
    "distribution_public_key" TEXT NOT NULL,
    "distribution_secret" TEXT NOT NULL,

    CONSTRAINT "stellar_currencyasset_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "stellar_currencyasset_trust_op_completed" (
    "id" SERIAL NOT NULL,
    "currencyasset_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "stellar_currencyasset_trust_op_completed_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "stellar_wallet" (
    "id" SERIAL NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "modified" TIMESTAMPTZ(6) NOT NULL,
    "public_key" TEXT,
    "secret" TEXT,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "stellar_wallet_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users_fiscalresidence" (
    "id" SERIAL NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "modified" TIMESTAMPTZ(6) NOT NULL,
    "street_address" VARCHAR(200),
    "city" VARCHAR(100),
    "postal_code" VARCHAR(10),
    "state" VARCHAR(100),
    "country" VARCHAR(2),
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "users_fiscalresidence_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users_user" (
    "id" SERIAL NOT NULL,
    "password" VARCHAR(128) NOT NULL,
    "last_login" TIMESTAMPTZ(6),
    "is_superuser" BOOLEAN NOT NULL,
    "email" VARCHAR(254) NOT NULL,
    "first_name" VARCHAR(30) NOT NULL,
    "last_name" VARCHAR(150) NOT NULL,
    "is_staff" BOOLEAN NOT NULL,
    "is_active" BOOLEAN NOT NULL,
    "date_joined" TIMESTAMPTZ(6) NOT NULL,
    "restore_password_code" VARCHAR(256),
    "restore_password_code_requested_at" TIMESTAMPTZ(6),
    "is_email_verified" BOOLEAN NOT NULL,
    "verification_code" VARCHAR(256),
    "newsletter" BOOLEAN NOT NULL,
    "two_factor" BOOLEAN NOT NULL,
    "two_factor_code" VARCHAR(10),
    "two_factor_code_created" TIMESTAMPTZ(6),
    "phone" VARCHAR(30),
    "birthday" DATE,
    "id_document_image_back" VARCHAR(100),
    "id_document_image_front" VARCHAR(100),
    "id_document_image_me" VARCHAR(100),
    "id_document_number" VARCHAR(50),
    "id_document_type" VARCHAR(10),
    "nationality" VARCHAR(2),
    "status" VARCHAR(32) NOT NULL,
    "is_blocked" BOOLEAN NOT NULL,
    "is_canceled" BOOLEAN NOT NULL,
    "deleted_date" TIMESTAMPTZ(6),
    "is_deleted" BOOLEAN NOT NULL,
    "type" VARCHAR(32) NOT NULL,
    "marital_status" VARCHAR(10),
    "profession" VARCHAR(150),
    "cod" VARCHAR(30),

    CONSTRAINT "users_user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users_user_favorited_companies" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "company_id" INTEGER NOT NULL,

    CONSTRAINT "users_user_favorited_companies_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users_user_groups" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "group_id" INTEGER NOT NULL,

    CONSTRAINT "users_user_groups_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users_user_user_permissions" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "permission_id" INTEGER NOT NULL,

    CONSTRAINT "users_user_user_permissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "votes_vote" (
    "id" SERIAL NOT NULL,
    "vote" VARCHAR(12),
    "created" TIMESTAMPTZ(6) NOT NULL,
    "agenda_item_id" INTEGER,
    "stellar_transaction_hash" TEXT,
    "cod" VARCHAR(255),
    "content_type_id" INTEGER,
    "object_id" INTEGER,

    CONSTRAINT "votes_vote_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "cuentas_participes" (
    "id" SERIAL NOT NULL,
    "creator_id" INTEGER NOT NULL,
    "nombre_del_proyecto" TEXT NOT NULL,
    "descripcion" TEXT NOT NULL,
    "cantidad_a_vender" DOUBLE PRECISION NOT NULL,
    "cantidad_restante" DOUBLE PRECISION NOT NULL,
    "ticket_minimo" DOUBLE PRECISION NOT NULL,
    "cesion" BOOLEAN NOT NULL,
    "duracion" TIMESTAMP(3) NOT NULL,
    "fecha_lanzamiento" TIMESTAMP(3) NOT NULL,
    "companyIDSeller" INTEGER NOT NULL,
    "clausulas" TEXT,
    "countMedia" INTEGER,

    CONSTRAINT "cuentas_participes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "orders" (
    "id" SERIAL NOT NULL,
    "aportacion" DOUBLE PRECISION NOT NULL,
    "documentId_first" TEXT,
    "documentId_second" TEXT,
    "signatureId" TEXT,
    "cuenta_participe_id" INTEGER NOT NULL,
    "buyerID" INTEGER,
    "sellerID" INTEGER NOT NULL,
    "bloqueo_id" INTEGER,
    "companyIdSeller" INTEGER,
    "status" "StatusOrderCtaParticipe" NOT NULL,
    "companyIdBuyer" INTEGER,
    "create_date" TIMESTAMP(3) NOT NULL,
    "complete_at" TIMESTAMP(3),
    "participacion_id" INTEGER,

    CONSTRAINT "orders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "orderNotaConvertible" (
    "id" SERIAL NOT NULL,
    "nota_convertible_id" INTEGER,
    "aportacion" DOUBLE PRECISION NOT NULL,
    "venta_nc_id" INTEGER,
    "signature_id" TEXT,
    "document_id_first" TEXT,
    "document_id_second" TEXT,
    "create_date" TIMESTAMP(3) NOT NULL,
    "complete_at" TIMESTAMP(3),
    "sellerId" INTEGER NOT NULL,
    "companyIdBuyer" INTEGER,
    "buyerId" INTEGER,
    "bloqueo_id" INTEGER,
    "status" "StatusOrderCtaParticipe" NOT NULL,

    CONSTRAINT "orderNotaConvertible_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "participacion" (
    "id" SERIAL NOT NULL,
    "cuenta_participe_id" INTEGER NOT NULL,
    "aportacion" DOUBLE PRECISION NOT NULL,
    "document_id_first" TEXT NOT NULL,
    "document_id_second" TEXT NOT NULL,
    "owner_id" INTEGER NOT NULL,
    "signature_id" TEXT NOT NULL,
    "buy_date" TIMESTAMP(3) NOT NULL,
    "cesion_is_allowed" BOOLEAN,
    "status" "StatusActivo",

    CONSTRAINT "participacion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "mangopay_basemangopaytransaction_cuenta_participe" (
    "id" SERIAL NOT NULL,
    "created" TIMESTAMPTZ(6) NOT NULL,
    "modified" TIMESTAMPTZ(6) NOT NULL,
    "transaction_id" VARCHAR(32) NOT NULL,
    "status" VARCHAR(32) NOT NULL,
    "amount" DECIMAL(20,2) NOT NULL,
    "currency" VARCHAR(3) NOT NULL,
    "fees" DECIMAL(20,2) NOT NULL,
    "cod" VARCHAR(30) NOT NULL,

    CONSTRAINT "mangopay_basemangopaytransaction_cuenta_participe_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "mangopay_mangopaytransfer_cuenta_participe" (
    "from_user_id" INTEGER NOT NULL,
    "to_user_id" INTEGER NOT NULL,
    "basemangopaytransaction_ptr_id" INTEGER NOT NULL,
    "from_cod" VARCHAR(255),
    "to_cod" VARCHAR(255),
    "total_amount" DECIMAL(20,2),
    "cuenta_participe_id" INTEGER NOT NULL,

    CONSTRAINT "mangopay_mangopaytransfer_cuenta_participe_pkey" PRIMARY KEY ("basemangopaytransaction_ptr_id")
);

-- CreateTable
CREATE TABLE "record_participaciones" (
    "id" SERIAL NOT NULL,
    "participacion_id" INTEGER NOT NULL,
    "aportacion" DOUBLE PRECISION NOT NULL,
    "old_document_id_first" TEXT NOT NULL,
    "old_document_second" TEXT NOT NULL,
    "old_signature_id" TEXT NOT NULL,
    "old_owner_id" INTEGER NOT NULL,
    "change_date" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "record_participaciones_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "venta_de_notas_convertibles" (
    "id" SERIAL NOT NULL,
    "cantidad_a_vender" DOUBLE PRECISION NOT NULL,
    "cantidad_restante" DOUBLE PRECISION NOT NULL,
    "ticket_minimo" DOUBLE PRECISION NOT NULL,
    "creador_id" INTEGER NOT NULL,
    "companyID" INTEGER NOT NULL,
    "interes_fijo" DOUBLE PRECISION,
    "interes_variable" DOUBLE PRECISION,
    "tipodeinteres" "Tipodeinteres",
    "vence_date" TIMESTAMP(3),
    "vence_cantidad" INTEGER,
    "tasa_descuento" DOUBLE PRECISION,
    "capitulacion" TEXT,
    "CAP_no_ronda" TEXT,
    "floor" TEXT,
    "fecha_devolucion" TIMESTAMP(3),
    "negociar" BOOLEAN,

    CONSTRAINT "venta_de_notas_convertibles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "nota_convertible" (
    "id" SERIAL NOT NULL,
    "valor" DOUBLE PRECISION NOT NULL,
    "venta_nc_id" INTEGER,
    "document_id_first" TEXT,
    "document_id_second" TEXT,
    "signature_id" TEXT,
    "buy_date" TIMESTAMP(3) NOT NULL,
    "interes_fijo" DOUBLE PRECISION,
    "interes_variable" DOUBLE PRECISION,
    "vence_date" TIMESTAMP(3),
    "tasa_descuento" DOUBLE PRECISION,
    "capitulacion" TEXT,
    "CAP_no_ronda" TEXT,
    "floor" TEXT,
    "fecha_devolucion" TIMESTAMP(3),
    "negociar" BOOLEAN,
    "owner_id" INTEGER NOT NULL,
    "countMedia" INTEGER,
    "status" "StatusActivo",

    CONSTRAINT "nota_convertible_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "mediaCP" (
    "id" SERIAL NOT NULL,
    "cuenta_participe_id" INTEGER NOT NULL,
    "path" TEXT NOT NULL,
    "type" "TypeOfMedia" NOT NULL,

    CONSTRAINT "mediaCP_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "mediaNC" (
    "id" SERIAL NOT NULL,
    "venta_nota_convertible_id" INTEGER NOT NULL,
    "path" TEXT NOT NULL,
    "type" "TypeOfMedia" NOT NULL,

    CONSTRAINT "mediaNC_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "auth_group_name_key" ON "auth_group"("name");

-- CreateIndex
CREATE INDEX "auth_group_name_a6ea08ec_like" ON "auth_group"("name");

-- CreateIndex
CREATE INDEX "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions"("group_id");

-- CreateIndex
CREATE INDEX "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions"("permission_id");

-- CreateIndex
CREATE UNIQUE INDEX "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions"("group_id", "permission_id");

-- CreateIndex
CREATE INDEX "auth_permission_content_type_id_2f476e4b" ON "auth_permission"("content_type_id");

-- CreateIndex
CREATE UNIQUE INDEX "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission"("content_type_id", "codename");

-- CreateIndex
CREATE UNIQUE INDEX "authtoken_token_user_id_key" ON "authtoken_token"("user_id");

-- CreateIndex
CREATE INDEX "authtoken_token_key_10f0b77e_like" ON "authtoken_token"("key");

-- CreateIndex
CREATE INDEX "capital_increases_capitalincrease_company_id_2dd84b4d" ON "capital_increases_capitalincrease"("company_id");

-- CreateIndex
CREATE UNIQUE INDEX "companies_company_slug_key" ON "companies_company"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "companies_company_code_key" ON "companies_company"("code");

-- CreateIndex
CREATE INDEX "companies_company_categories_id_b6c4c436" ON "companies_company"("categories_id");

-- CreateIndex
CREATE INDEX "companies_company_cod_2328f962" ON "companies_company"("cod");

-- CreateIndex
CREATE INDEX "companies_company_cod_2328f962_like" ON "companies_company"("cod");

-- CreateIndex
CREATE INDEX "companies_company_code_b4b3e879_like" ON "companies_company"("code");

-- CreateIndex
CREATE INDEX "companies_company_legal_representative_id_ce4dfba4" ON "companies_company"("legal_representative_id");

-- CreateIndex
CREATE INDEX "companies_company_slug_cddc66aa_like" ON "companies_company"("slug");

-- CreateIndex
CREATE INDEX "companies_company_investors_company_id_cf55bbf4" ON "companies_company_investors"("company_id");

-- CreateIndex
CREATE INDEX "companies_company_investors_user_id_3b016ef5" ON "companies_company_investors"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "companies_company_investors_company_id_user_id_cc1d17cc_uniq" ON "companies_company_investors"("company_id", "user_id");

-- CreateIndex
CREATE INDEX "conversations_conversation_company_id_122724fe" ON "conversations_conversation"("company_id");

-- CreateIndex
CREATE INDEX "conversations_conversation_creator_id_3de68382" ON "conversations_conversation"("creator_id");

-- CreateIndex
CREATE INDEX "conversations_conversation_documents_conversation_id_a520b337" ON "conversations_conversation_documents"("conversation_id");

-- CreateIndex
CREATE INDEX "conversations_conversation_documents_document_id_1105dbc0" ON "conversations_conversation_documents"("document_id");

-- CreateIndex
CREATE UNIQUE INDEX "conversations_conversati_conversation_id_document_40a8b973_uniq" ON "conversations_conversation_documents"("conversation_id", "document_id");

-- CreateIndex
CREATE INDEX "conversations_conversation_partners_conversation_id_ac6e3b4d" ON "conversations_conversation_partners"("conversation_id");

-- CreateIndex
CREATE INDEX "conversations_conversation_partners_partner_id_bc190265" ON "conversations_conversation_partners"("partner_id");

-- CreateIndex
CREATE UNIQUE INDEX "conversations_conversati_conversation_id_partner__4f8b61a3_uniq" ON "conversations_conversation_partners"("conversation_id", "partner_id");

-- CreateIndex
CREATE INDEX "conversations_conversationhistory_conversation_id_ef438669" ON "conversations_conversationhistory"("conversation_id");

-- CreateIndex
CREATE INDEX "conversations_conversationhistory_creator_id_b724cdf7" ON "conversations_conversationhistory"("creator_id");

-- CreateIndex
CREATE INDEX "conversations_message_conversation_id_f1a2d5e9" ON "conversations_message"("conversation_id");

-- CreateIndex
CREATE INDEX "conversations_message_creator_id_6247eee0" ON "conversations_message"("creator_id");

-- CreateIndex
CREATE INDEX "conversations_message_documents_document_id_bce582b0" ON "conversations_message_documents"("document_id");

-- CreateIndex
CREATE INDEX "conversations_message_documents_message_id_11f05fe2" ON "conversations_message_documents"("message_id");

-- CreateIndex
CREATE UNIQUE INDEX "conversations_message_do_message_id_document_id_bee6704f_uniq" ON "conversations_message_documents"("message_id", "document_id");

-- CreateIndex
CREATE UNIQUE INDEX "currencies_currency_currency_asset_id_key" ON "currencies_currency"("currency_asset_id");

-- CreateIndex
CREATE INDEX "currencies_currency_code_165b7e38_like" ON "currencies_currency"("code");

-- CreateIndex
CREATE INDEX "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log"("content_type_id");

-- CreateIndex
CREATE INDEX "django_admin_log_user_id_c564eba6" ON "django_admin_log"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type"("app_label", "model");

-- CreateIndex
CREATE INDEX "django_session_expire_date_a5c62663" ON "django_session"("expire_date");

-- CreateIndex
CREATE INDEX "django_session_session_key_c0390e0f_like" ON "django_session"("session_key");

-- CreateIndex
CREATE UNIQUE INDEX "django_site_domain_a2e37b91_uniq" ON "django_site"("domain");

-- CreateIndex
CREATE INDEX "django_site_domain_a2e37b91_like" ON "django_site"("domain");

-- CreateIndex
CREATE INDEX "documents_document_company_id_a2323c19" ON "documents_document"("company_id");

-- CreateIndex
CREATE INDEX "documents_document_creator_id_e53c7296" ON "documents_document"("creator_id");

-- CreateIndex
CREATE INDEX "documents_document_related_meeting_id_3655541d" ON "documents_document"("related_meeting_id");

-- CreateIndex
CREATE INDEX "documents_document_related_operation_id_f0cd3e91" ON "documents_document"("related_operation_id");

-- CreateIndex
CREATE INDEX "documents_document_related_users_document_id_b59f104d" ON "documents_document_related_users"("document_id");

-- CreateIndex
CREATE INDEX "documents_document_related_users_user_id_f5ae5d43" ON "documents_document_related_users"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "documents_document_relat_document_id_user_id_4e5fa7a9_uniq" ON "documents_document_related_users"("document_id", "user_id");

-- CreateIndex
CREATE INDEX "documents_historydocument_creator_id_5ef4a743" ON "documents_historydocument"("creator_id");

-- CreateIndex
CREATE INDEX "documents_historydocument_document_id_cee359cd" ON "documents_historydocument"("document_id");

-- CreateIndex
CREATE INDEX "documents_useractiondetail_company_id_97963439" ON "documents_useractiondetail"("company_id");

-- CreateIndex
CREATE INDEX "documents_useractiondetail_session_id_e7baf4a6" ON "documents_useractiondetail"("session_id");

-- CreateIndex
CREATE INDEX "documents_usersessionlog_user_id_72905266" ON "documents_usersessionlog"("user_id");

-- CreateIndex
CREATE INDEX "mangopay_basemangopaytransaction_cod_4a7070ab" ON "mangopay_basemangopaytransaction"("cod");

-- CreateIndex
CREATE INDEX "mangopay_basemangopaytransaction_cod_4a7070ab_like" ON "mangopay_basemangopaytransaction"("cod");

-- CreateIndex
CREATE INDEX "mangopay_mangopaybankaccount_cod_16473157" ON "mangopay_mangopaybankaccount"("cod");

-- CreateIndex
CREATE INDEX "mangopay_mangopaybankaccount_cod_16473157_like" ON "mangopay_mangopaybankaccount"("cod");

-- CreateIndex
CREATE INDEX "mangopay_mangopaybankaccount_user_id_1efeffeb" ON "mangopay_mangopaybankaccount"("user_id");

-- CreateIndex
CREATE INDEX "mangopay_mangopaybankwiredeposit_to_user_id_71a14e73" ON "mangopay_mangopaybankwiredeposit"("to_user_id");

-- CreateIndex
CREATE INDEX "mangopay_mangopaypayment_user_id_f5ba9655" ON "mangopay_mangopaydeposit"("to_user_id");

-- CreateIndex
CREATE INDEX "mangopay_mangopaykycdocument_cod_96c83ba6" ON "mangopay_mangopaykycdocument"("cod");

-- CreateIndex
CREATE INDEX "mangopay_mangopaykycdocument_cod_96c83ba6_like" ON "mangopay_mangopaykycdocument"("cod");

-- CreateIndex
CREATE INDEX "mangopay_mangopaykycdocument_user_id_8a4e361d" ON "mangopay_mangopaykycdocument"("user_id");

-- CreateIndex
CREATE INDEX "mangopay_mangopaytransfer_from_user_id_8f629f37" ON "mangopay_mangopaytransfer"("from_user_id");

-- CreateIndex
CREATE INDEX "mangopay_mangopaytransfer_to_user_id_192815a2" ON "mangopay_mangopaytransfer"("to_user_id");

-- CreateIndex
CREATE INDEX "mangopay_mangopayuser_cod_57e3bc46" ON "mangopay_mangopayuser"("cod");

-- CreateIndex
CREATE INDEX "mangopay_mangopayuser_cod_57e3bc46_like" ON "mangopay_mangopayuser"("cod");

-- CreateIndex
CREATE INDEX "mangopay_mangopayuser_user_id_16f19700" ON "mangopay_mangopayuser"("user_id");

-- CreateIndex
CREATE INDEX "mangopay_mangopaywallet_user_id_abdecccd" ON "mangopay_mangopaywallet"("user_id");

-- CreateIndex
CREATE INDEX "meetings_agendaitem_meeting_id_07815bb0" ON "meetings_agendaitem"("meeting_id");

-- CreateIndex
CREATE INDEX "meetings_document_agenda_item_id_05269058" ON "meetings_document"("agenda_item_id");

-- CreateIndex
CREATE INDEX "meetings_document_creator_id_ce7348bc" ON "meetings_document"("creator_id");

-- CreateIndex
CREATE INDEX "meetings_historymeetingsdocument_creator_id_5e09a29f" ON "meetings_historymeetingsdocument"("creator_id");

-- CreateIndex
CREATE INDEX "meetings_historymeetingsdocument_document_id_b1eb6e87" ON "meetings_historymeetingsdocument"("document_id");

-- CreateIndex
CREATE UNIQUE INDEX "meetings_meeting_minutes_id_key" ON "meetings_meeting"("minutes_id");

-- CreateIndex
CREATE UNIQUE INDEX "meetings_meeting_call_id_key" ON "meetings_meeting"("call_id");

-- CreateIndex
CREATE INDEX "meetings_meeting_company_id_15255a07" ON "meetings_meeting"("company_id");

-- CreateIndex
CREATE INDEX "meetings_meeting_creator_id_ba60be78" ON "meetings_meeting"("creator_id");

-- CreateIndex
CREATE INDEX "meetings_participant_meeting_id_4a769a34" ON "meetings_participant"("meeting_id");

-- CreateIndex
CREATE INDEX "meetings_participant_user_id_b38e7254" ON "meetings_participant"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "oauth2_provider_accesstoken_token_key" ON "oauth2_provider_accesstoken"("token");

-- CreateIndex
CREATE UNIQUE INDEX "oauth2_provider_accesstoken_source_refresh_token_id_key" ON "oauth2_provider_accesstoken"("source_refresh_token_id");

-- CreateIndex
CREATE UNIQUE INDEX "oauth2_provider_accesstoken_id_token_id_key" ON "oauth2_provider_accesstoken"("id_token_id");

-- CreateIndex
CREATE INDEX "oauth2_provider_accesstoken_application_id_b22886e1" ON "oauth2_provider_accesstoken"("application_id");

-- CreateIndex
CREATE INDEX "oauth2_provider_accesstoken_token_8af090f8_like" ON "oauth2_provider_accesstoken"("token");

-- CreateIndex
CREATE INDEX "oauth2_provider_accesstoken_user_id_6e4c9a65" ON "oauth2_provider_accesstoken"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "oauth2_provider_application_client_id_key" ON "oauth2_provider_application"("client_id");

-- CreateIndex
CREATE INDEX "oauth2_provider_application_client_id_03f0cc84_like" ON "oauth2_provider_application"("client_id");

-- CreateIndex
CREATE INDEX "oauth2_provider_application_client_secret_53133678" ON "oauth2_provider_application"("client_secret");

-- CreateIndex
CREATE INDEX "oauth2_provider_application_client_secret_53133678_like" ON "oauth2_provider_application"("client_secret");

-- CreateIndex
CREATE INDEX "oauth2_provider_application_user_id_79829054" ON "oauth2_provider_application"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "oauth2_provider_grant_code_key" ON "oauth2_provider_grant"("code");

-- CreateIndex
CREATE INDEX "oauth2_provider_grant_application_id_81923564" ON "oauth2_provider_grant"("application_id");

-- CreateIndex
CREATE INDEX "oauth2_provider_grant_code_49ab4ddf_like" ON "oauth2_provider_grant"("code");

-- CreateIndex
CREATE INDEX "oauth2_provider_grant_user_id_e8f62af8" ON "oauth2_provider_grant"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "oauth2_provider_idtoken_jti_key" ON "oauth2_provider_idtoken"("jti");

-- CreateIndex
CREATE INDEX "oauth2_provider_idtoken_application_id_08c5ff4f" ON "oauth2_provider_idtoken"("application_id");

-- CreateIndex
CREATE INDEX "oauth2_provider_idtoken_user_id_dd512b59" ON "oauth2_provider_idtoken"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "oauth2_provider_refreshtoken_access_token_id_key" ON "oauth2_provider_refreshtoken"("access_token_id");

-- CreateIndex
CREATE INDEX "oauth2_provider_refreshtoken_application_id_2d1c311b" ON "oauth2_provider_refreshtoken"("application_id");

-- CreateIndex
CREATE INDEX "oauth2_provider_refreshtoken_user_id_da837fce" ON "oauth2_provider_refreshtoken"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "oauth2_provider_refreshtoken_token_revoked_af8a5134_uniq" ON "oauth2_provider_refreshtoken"("token", "revoked");

-- CreateIndex
CREATE UNIQUE INDEX "offers_document_proposal_id_key" ON "offers_document"("proposal_id");

-- CreateIndex
CREATE INDEX "offers_historyoffersdocument_creator_id_89690ff0" ON "offers_historyoffersdocument"("creator_id");

-- CreateIndex
CREATE INDEX "offers_historyoffersdocument_document_id_c0b6e0f3" ON "offers_historyoffersdocument"("document_id");

-- CreateIndex
CREATE UNIQUE INDEX "offers_offer_capital_increase_id_key" ON "offers_offer"("capital_increase_id");

-- CreateIndex
CREATE INDEX "offers_offer_company_id_623c4621" ON "offers_offer"("company_id");

-- CreateIndex
CREATE INDEX "offers_offer_for_user_id_123defbd" ON "offers_offer"("for_user_id");

-- CreateIndex
CREATE INDEX "offers_offer_user_id_4fbc0994" ON "offers_offer"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "offers_proposal_operation_id_key" ON "offers_proposal"("operation_id");

-- CreateIndex
CREATE UNIQUE INDEX "offers_proposal_payment_id_key" ON "offers_proposal"("payment_id");

-- CreateIndex
CREATE INDEX "offers_proposal_offer_id_04f106db" ON "offers_proposal"("offer_id");

-- CreateIndex
CREATE INDEX "offers_proposal_user_id_a8d68715" ON "offers_proposal"("user_id");

-- CreateIndex
CREATE INDEX "operations_operation_company_id_a5943d84" ON "operations_operation"("company_id");

-- CreateIndex
CREATE INDEX "operations_operation_from_user_id_7fd8c572" ON "operations_operation"("from_user_id");

-- CreateIndex
CREATE INDEX "operations_operation_to_user_id_bbca8815" ON "operations_operation"("to_user_id");

-- CreateIndex
CREATE UNIQUE INDEX "options_option_name_key" ON "options_option"("name");

-- CreateIndex
CREATE INDEX "options_option_name_42a60494_like" ON "options_option"("name");

-- CreateIndex
CREATE INDEX "options_option_public_name_b9237778" ON "options_option"("public_name");

-- CreateIndex
CREATE INDEX "options_option_public_name_b9237778_like" ON "options_option"("public_name");

-- CreateIndex
CREATE INDEX "options_useroption_public_name_2eeaa9e5" ON "options_useroption"("public_name");

-- CreateIndex
CREATE INDEX "options_useroption_public_name_2eeaa9e5_like" ON "options_useroption"("public_name");

-- CreateIndex
CREATE INDEX "options_useroption_user_id_01488187" ON "options_useroption"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "options_useroption_user_id_name_2fafb39f_uniq" ON "options_useroption"("user_id", "name");

-- CreateIndex
CREATE INDEX "partners_partner_company_id_e5c5fedc" ON "partners_partner"("company_id");

-- CreateIndex
CREATE INDEX "partners_partner_content_type_id_a0059c54" ON "partners_partner"("content_type_id");

-- CreateIndex
CREATE INDEX "partners_partner_user_id_c9159f29" ON "partners_partner"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "partners_partner_cod_company_id_ea741457_uniq" ON "partners_partner"("cod", "company_id");

-- CreateIndex
CREATE UNIQUE INDEX "payments_payment_mangopay_payment_id_key" ON "payments_payment"("mangopay_transaction_id");

-- CreateIndex
CREATE INDEX "payments_payment_from_user_id_cc566b32" ON "payments_payment"("from_user_id");

-- CreateIndex
CREATE INDEX "payments_payment_user_id_f9db060a" ON "payments_payment"("to_user_id");

-- CreateIndex
CREATE INDEX "snitch_event_actor_content_type_id_2ad2cc94" ON "snitch_event"("actor_content_type_id");

-- CreateIndex
CREATE INDEX "snitch_event_target_content_type_id_06e9448e" ON "snitch_event"("target_content_type_id");

-- CreateIndex
CREATE INDEX "snitch_event_trigger_content_type_id_8b86ecfb" ON "snitch_event"("trigger_content_type_id");

-- CreateIndex
CREATE UNIQUE INDEX "snitch_eventtype_verb_key" ON "snitch_eventtype"("verb");

-- CreateIndex
CREATE INDEX "snitch_eventtype_verb_e0dbde6d_like" ON "snitch_eventtype"("verb");

-- CreateIndex
CREATE INDEX "snitch_notification_event_id_0283365f" ON "snitch_notification"("event_id");

-- CreateIndex
CREATE INDEX "snitch_notification_user_id_9f5bdce1" ON "snitch_notification"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "social_auth_association_server_url_handle_078befa2_uniq" ON "social_auth_association"("server_url", "handle");

-- CreateIndex
CREATE INDEX "social_auth_code_code_a2393167" ON "social_auth_code"("code");

-- CreateIndex
CREATE INDEX "social_auth_code_code_a2393167_like" ON "social_auth_code"("code");

-- CreateIndex
CREATE INDEX "social_auth_code_timestamp_176b341f" ON "social_auth_code"("timestamp");

-- CreateIndex
CREATE UNIQUE INDEX "social_auth_code_email_code_801b2d02_uniq" ON "social_auth_code"("email", "code");

-- CreateIndex
CREATE UNIQUE INDEX "social_auth_nonce_server_url_timestamp_salt_f6284463_uniq" ON "social_auth_nonce"("server_url", "timestamp", "salt");

-- CreateIndex
CREATE INDEX "social_auth_partial_timestamp_50f2119f" ON "social_auth_partial"("timestamp");

-- CreateIndex
CREATE INDEX "social_auth_partial_token_3017fea3" ON "social_auth_partial"("token");

-- CreateIndex
CREATE INDEX "social_auth_partial_token_3017fea3_like" ON "social_auth_partial"("token");

-- CreateIndex
CREATE INDEX "social_auth_usersocialauth_uid_796e51dc" ON "social_auth_usersocialauth"("uid");

-- CreateIndex
CREATE INDEX "social_auth_usersocialauth_uid_796e51dc_like" ON "social_auth_usersocialauth"("uid");

-- CreateIndex
CREATE INDEX "social_auth_usersocialauth_user_id_17d28448" ON "social_auth_usersocialauth"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "social_auth_usersocialauth_provider_uid_e6b5e668_uniq" ON "social_auth_usersocialauth"("provider", "uid");

-- CreateIndex
CREATE UNIQUE INDEX "stellar_asset_company_id_key" ON "stellar_asset"("company_id");

-- CreateIndex
CREATE INDEX "stellar_asset_trust_op_completed_asset_id_bd42c6f5" ON "stellar_asset_trust_op_completed"("asset_id");

-- CreateIndex
CREATE INDEX "stellar_asset_trust_op_completed_user_id_af5e299a" ON "stellar_asset_trust_op_completed"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "stellar_asset_trust_op_completed_asset_id_user_id_5068d3fb_uniq" ON "stellar_asset_trust_op_completed"("asset_id", "user_id");

-- CreateIndex
CREATE INDEX "stellar_currencyasset_trus_currencyasset_id_6ed8310e" ON "stellar_currencyasset_trust_op_completed"("currencyasset_id");

-- CreateIndex
CREATE INDEX "stellar_currencyasset_trust_op_completed_user_id_064aab92" ON "stellar_currencyasset_trust_op_completed"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "stellar_currencyasset_tr_currencyasset_id_user_id_41a7f1bb_uniq" ON "stellar_currencyasset_trust_op_completed"("currencyasset_id", "user_id");

-- CreateIndex
CREATE UNIQUE INDEX "stellar_wallet_user_id_key" ON "stellar_wallet"("user_id");

-- CreateIndex
CREATE INDEX "users_fiscalresidence_user_id_5b29aae4" ON "users_fiscalresidence"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "users_user_email_key" ON "users_user"("email");

-- CreateIndex
CREATE UNIQUE INDEX "users_user_restore_password_code_key" ON "users_user"("restore_password_code");

-- CreateIndex
CREATE UNIQUE INDEX "users_user_verification_code_key" ON "users_user"("verification_code");

-- CreateIndex
CREATE INDEX "users_user_cod_7b7c3ebf" ON "users_user"("cod");

-- CreateIndex
CREATE INDEX "users_user_cod_7b7c3ebf_like" ON "users_user"("cod");

-- CreateIndex
CREATE INDEX "users_user_email_243f6e77_like" ON "users_user"("email");

-- CreateIndex
CREATE INDEX "users_user_restore_password_code_6e6b2df8_like" ON "users_user"("restore_password_code");

-- CreateIndex
CREATE INDEX "users_user_verification_code_743ac4c1_like" ON "users_user"("verification_code");

-- CreateIndex
CREATE INDEX "users_user_favorited_companies_company_id_445a86b5" ON "users_user_favorited_companies"("company_id");

-- CreateIndex
CREATE INDEX "users_user_favorited_companies_user_id_08ed230f" ON "users_user_favorited_companies"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "users_user_favorited_companies_user_id_company_id_a9fbb7f8_uniq" ON "users_user_favorited_companies"("user_id", "company_id");

-- CreateIndex
CREATE INDEX "users_user_groups_group_id_9afc8d0e" ON "users_user_groups"("group_id");

-- CreateIndex
CREATE INDEX "users_user_groups_user_id_5f6f5a90" ON "users_user_groups"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "users_user_groups_user_id_group_id_b88eab82_uniq" ON "users_user_groups"("user_id", "group_id");

-- CreateIndex
CREATE INDEX "users_user_user_permissions_permission_id_0b93982e" ON "users_user_user_permissions"("permission_id");

-- CreateIndex
CREATE INDEX "users_user_user_permissions_user_id_20aca447" ON "users_user_user_permissions"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "users_user_user_permissions_user_id_permission_id_43338c45_uniq" ON "users_user_user_permissions"("user_id", "permission_id");

-- CreateIndex
CREATE INDEX "votes_vote_agenda_item_id_2274f311" ON "votes_vote"("agenda_item_id");

-- CreateIndex
CREATE INDEX "votes_vote_content_type_id_c8375fe1" ON "votes_vote"("content_type_id");

-- CreateIndex
CREATE UNIQUE INDEX "votes_vote_agenda_item_id_content_t_3114f042_uniq" ON "votes_vote"("agenda_item_id", "content_type_id", "object_id");

-- AddForeignKey
ALTER TABLE "auth_group_permissions" ADD CONSTRAINT "auth_group_permissio_permission_id_84c5c92e_fk_auth_perm" FOREIGN KEY ("permission_id") REFERENCES "auth_permission"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "auth_group_permissions" ADD CONSTRAINT "auth_group_permissions_group_id_b120cbf9_fk_auth_group_id" FOREIGN KEY ("group_id") REFERENCES "auth_group"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "auth_permission" ADD CONSTRAINT "auth_permission_content_type_id_2f476e4b_fk_django_co" FOREIGN KEY ("content_type_id") REFERENCES "django_content_type"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "authtoken_token" ADD CONSTRAINT "authtoken_token_user_id_35299eff_fk_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "capital_increases_capitalincrease" ADD CONSTRAINT "capital_increases_ca_company_id_2dd84b4d_fk_companies" FOREIGN KEY ("company_id") REFERENCES "companies_company"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "companies_company" ADD CONSTRAINT "companies_company_categories_id_b6c4c436_fk_companies" FOREIGN KEY ("categories_id") REFERENCES "companies_category"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "companies_company" ADD CONSTRAINT "companies_company_legal_representative_ce4dfba4_fk_users_use" FOREIGN KEY ("legal_representative_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "companies_company_investors" ADD CONSTRAINT "companies_company_in_company_id_cf55bbf4_fk_companies" FOREIGN KEY ("company_id") REFERENCES "companies_company"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "companies_company_investors" ADD CONSTRAINT "companies_company_investors_user_id_3b016ef5_fk_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "conversations_conversation" ADD CONSTRAINT "conversations_conver_company_id_122724fe_fk_companies" FOREIGN KEY ("company_id") REFERENCES "companies_company"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "conversations_conversation" ADD CONSTRAINT "conversations_conversation_creator_id_3de68382_fk_users_user_id" FOREIGN KEY ("creator_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "conversations_conversation_documents" ADD CONSTRAINT "conversations_conver_conversation_id_a520b337_fk_conversat" FOREIGN KEY ("conversation_id") REFERENCES "conversations_conversation"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "conversations_conversation_documents" ADD CONSTRAINT "conversations_conver_document_id_1105dbc0_fk_documents" FOREIGN KEY ("document_id") REFERENCES "documents_document"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "conversations_conversation_partners" ADD CONSTRAINT "conversations_conver_conversation_id_ac6e3b4d_fk_conversat" FOREIGN KEY ("conversation_id") REFERENCES "conversations_conversation"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "conversations_conversation_partners" ADD CONSTRAINT "conversations_conver_partner_id_bc190265_fk_partners_" FOREIGN KEY ("partner_id") REFERENCES "partners_partner"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "conversations_conversationhistory" ADD CONSTRAINT "conversations_conver_conversation_id_ef438669_fk_conversat" FOREIGN KEY ("conversation_id") REFERENCES "conversations_conversation"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "conversations_conversationhistory" ADD CONSTRAINT "conversations_conver_creator_id_b724cdf7_fk_users_use" FOREIGN KEY ("creator_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "conversations_message" ADD CONSTRAINT "conversations_messag_conversation_id_f1a2d5e9_fk_conversat" FOREIGN KEY ("conversation_id") REFERENCES "conversations_conversation"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "conversations_message" ADD CONSTRAINT "conversations_message_creator_id_6247eee0_fk_users_user_id" FOREIGN KEY ("creator_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "conversations_message_documents" ADD CONSTRAINT "conversations_messag_document_id_bce582b0_fk_documents" FOREIGN KEY ("document_id") REFERENCES "documents_document"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "conversations_message_documents" ADD CONSTRAINT "conversations_messag_message_id_11f05fe2_fk_conversat" FOREIGN KEY ("message_id") REFERENCES "conversations_message"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "currencies_currency" ADD CONSTRAINT "currencies_currency_currency_asset_id_13b2b800_fk_stellar_c" FOREIGN KEY ("currency_asset_id") REFERENCES "stellar_currencyasset"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "django_admin_log" ADD CONSTRAINT "django_admin_log_content_type_id_c4bce8eb_fk_django_co" FOREIGN KEY ("content_type_id") REFERENCES "django_content_type"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "django_admin_log" ADD CONSTRAINT "django_admin_log_user_id_c564eba6_fk_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "documents_document" ADD CONSTRAINT "documents_document_company_id_a2323c19_fk_companies_company_id" FOREIGN KEY ("company_id") REFERENCES "companies_company"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "documents_document" ADD CONSTRAINT "documents_document_creator_id_e53c7296_fk_users_user_id" FOREIGN KEY ("creator_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "documents_document" ADD CONSTRAINT "documents_document_related_meeting_id_3655541d_fk_meetings_" FOREIGN KEY ("related_meeting_id") REFERENCES "meetings_meeting"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "documents_document" ADD CONSTRAINT "documents_document_related_operation_id_f0cd3e91_fk_operation" FOREIGN KEY ("related_operation_id") REFERENCES "operations_operation"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "documents_document_related_users" ADD CONSTRAINT "documents_document_r_document_id_b59f104d_fk_documents" FOREIGN KEY ("document_id") REFERENCES "documents_document"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "documents_document_related_users" ADD CONSTRAINT "documents_document_r_user_id_f5ae5d43_fk_users_use" FOREIGN KEY ("user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "documents_historydocument" ADD CONSTRAINT "documents_historydoc_document_id_cee359cd_fk_documents" FOREIGN KEY ("document_id") REFERENCES "documents_document"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "documents_historydocument" ADD CONSTRAINT "documents_historydocument_creator_id_5ef4a743_fk_users_user_id" FOREIGN KEY ("creator_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "documents_useractiondetail" ADD CONSTRAINT "documents_useraction_company_id_97963439_fk_companies" FOREIGN KEY ("company_id") REFERENCES "companies_company"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "documents_useractiondetail" ADD CONSTRAINT "documents_useraction_session_id_e7baf4a6_fk_documents" FOREIGN KEY ("session_id") REFERENCES "documents_usersessionlog"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "documents_usersessionlog" ADD CONSTRAINT "documents_usersessionlog_user_id_72905266_fk_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "mangopay_mangopaybankaccount" ADD CONSTRAINT "mangopay_mangopaybankaccount_user_id_1efeffeb_fk_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "mangopay_mangopaybankwiredeposit" ADD CONSTRAINT "mangopay_mangopayban_basemangopaytransact_8f335080_fk_mangopay_" FOREIGN KEY ("basemangopaytransaction_ptr_id") REFERENCES "mangopay_basemangopaytransaction"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "mangopay_mangopaybankwiredeposit" ADD CONSTRAINT "mangopay_mangopayban_to_user_id_71a14e73_fk_users_use" FOREIGN KEY ("to_user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "mangopay_mangopaydeposit" ADD CONSTRAINT "mangopay_mangopaypay_basemangopaytransact_cd59d58a_fk_mangopay_" FOREIGN KEY ("basemangopaytransaction_ptr_id") REFERENCES "mangopay_basemangopaytransaction"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "mangopay_mangopaydeposit" ADD CONSTRAINT "mangopay_mangopaypayment_to_user_id_b1ab7f6c_fk_users_user_id" FOREIGN KEY ("to_user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "mangopay_mangopaykycdocument" ADD CONSTRAINT "mangopay_mangopaykycdocument_user_id_8a4e361d_fk_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "mangopay_mangopaytransfer" ADD CONSTRAINT "mangopay_mangopaytra_basemangopaytransact_d76323ba_fk_mangopay_" FOREIGN KEY ("basemangopaytransaction_ptr_id") REFERENCES "mangopay_basemangopaytransaction"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "mangopay_mangopaytransfer" ADD CONSTRAINT "mangopay_mangopaytra_from_user_id_8f629f37_fk_users_use" FOREIGN KEY ("from_user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "mangopay_mangopaytransfer" ADD CONSTRAINT "mangopay_mangopaytransfer_to_user_id_192815a2_fk_users_user_id" FOREIGN KEY ("to_user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "mangopay_mangopayuser" ADD CONSTRAINT "mangopay_mangopayuser_user_id_16f19700_fk_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "mangopay_mangopaywallet" ADD CONSTRAINT "mangopay_mangopaywallet_user_id_abdecccd_fk_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "meetings_agendaitem" ADD CONSTRAINT "meetings_agendaitem_meeting_id_07815bb0_fk_meetings_meeting_id" FOREIGN KEY ("meeting_id") REFERENCES "meetings_meeting"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "meetings_document" ADD CONSTRAINT "meetings_document_agenda_item_id_05269058_fk_meetings_" FOREIGN KEY ("agenda_item_id") REFERENCES "meetings_agendaitem"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "meetings_document" ADD CONSTRAINT "meetings_document_creator_id_ce7348bc_fk_users_user_id" FOREIGN KEY ("creator_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "meetings_historymeetingsdocument" ADD CONSTRAINT "meetings_historymeet_creator_id_5e09a29f_fk_users_use" FOREIGN KEY ("creator_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "meetings_historymeetingsdocument" ADD CONSTRAINT "meetings_historymeet_document_id_b1eb6e87_fk_meetings_" FOREIGN KEY ("document_id") REFERENCES "meetings_document"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "meetings_meeting" ADD CONSTRAINT "meetings_meeting_call_id_195a944a_fk_meetings_document_id" FOREIGN KEY ("call_id") REFERENCES "meetings_document"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "meetings_meeting" ADD CONSTRAINT "meetings_meeting_company_id_15255a07_fk_companies_company_id" FOREIGN KEY ("company_id") REFERENCES "companies_company"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "meetings_meeting" ADD CONSTRAINT "meetings_meeting_creator_id_ba60be78_fk_users_user_id" FOREIGN KEY ("creator_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "meetings_meeting" ADD CONSTRAINT "meetings_meeting_minutes_id_f772076b_fk_meetings_document_id" FOREIGN KEY ("minutes_id") REFERENCES "meetings_document"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "meetings_participant" ADD CONSTRAINT "meetings_participant_meeting_id_4a769a34_fk_meetings_meeting_id" FOREIGN KEY ("meeting_id") REFERENCES "meetings_meeting"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "meetings_participant" ADD CONSTRAINT "meetings_participant_user_id_b38e7254_fk_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "oauth2_provider_accesstoken" ADD CONSTRAINT "oauth2_provider_acce_application_id_b22886e1_fk_oauth2_pr" FOREIGN KEY ("application_id") REFERENCES "oauth2_provider_application"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "oauth2_provider_accesstoken" ADD CONSTRAINT "oauth2_provider_acce_id_token_id_85db651b_fk_oauth2_pr" FOREIGN KEY ("id_token_id") REFERENCES "oauth2_provider_idtoken"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "oauth2_provider_accesstoken" ADD CONSTRAINT "oauth2_provider_acce_source_refresh_token_e66fbc72_fk_oauth2_pr" FOREIGN KEY ("source_refresh_token_id") REFERENCES "oauth2_provider_refreshtoken"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "oauth2_provider_accesstoken" ADD CONSTRAINT "oauth2_provider_accesstoken_user_id_6e4c9a65_fk_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "oauth2_provider_application" ADD CONSTRAINT "oauth2_provider_application_user_id_79829054_fk_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "oauth2_provider_grant" ADD CONSTRAINT "oauth2_provider_gran_application_id_81923564_fk_oauth2_pr" FOREIGN KEY ("application_id") REFERENCES "oauth2_provider_application"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "oauth2_provider_grant" ADD CONSTRAINT "oauth2_provider_grant_user_id_e8f62af8_fk_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "oauth2_provider_idtoken" ADD CONSTRAINT "oauth2_provider_idto_application_id_08c5ff4f_fk_oauth2_pr" FOREIGN KEY ("application_id") REFERENCES "oauth2_provider_application"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "oauth2_provider_idtoken" ADD CONSTRAINT "oauth2_provider_idtoken_user_id_dd512b59_fk_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "oauth2_provider_refreshtoken" ADD CONSTRAINT "oauth2_provider_refr_access_token_id_775e84e8_fk_oauth2_pr" FOREIGN KEY ("access_token_id") REFERENCES "oauth2_provider_accesstoken"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "oauth2_provider_refreshtoken" ADD CONSTRAINT "oauth2_provider_refr_application_id_2d1c311b_fk_oauth2_pr" FOREIGN KEY ("application_id") REFERENCES "oauth2_provider_application"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "oauth2_provider_refreshtoken" ADD CONSTRAINT "oauth2_provider_refreshtoken_user_id_da837fce_fk_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "offers_document" ADD CONSTRAINT "offers_document_proposal_id_9c16af73_fk_offers_proposal_id" FOREIGN KEY ("proposal_id") REFERENCES "offers_proposal"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "offers_historyoffersdocument" ADD CONSTRAINT "offers_historyoffers_creator_id_89690ff0_fk_users_use" FOREIGN KEY ("creator_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "offers_historyoffersdocument" ADD CONSTRAINT "offers_historyoffers_document_id_c0b6e0f3_fk_offers_do" FOREIGN KEY ("document_id") REFERENCES "offers_document"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "offers_offer" ADD CONSTRAINT "offers_offer_capital_increase_id_64fa82ed_fk_capital_i" FOREIGN KEY ("capital_increase_id") REFERENCES "capital_increases_capitalincrease"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "offers_offer" ADD CONSTRAINT "offers_offer_company_id_623c4621_fk_companies_company_id" FOREIGN KEY ("company_id") REFERENCES "companies_company"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "offers_offer" ADD CONSTRAINT "offers_offer_for_user_id_123defbd_fk_users_user_id" FOREIGN KEY ("for_user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "offers_offer" ADD CONSTRAINT "offers_offer_user_id_4fbc0994_fk_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "offers_proposal" ADD CONSTRAINT "offers_proposal_offer_id_04f106db_fk_offers_offer_id" FOREIGN KEY ("offer_id") REFERENCES "offers_offer"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "offers_proposal" ADD CONSTRAINT "offers_proposal_operation_id_f4cb3598_fk_operation" FOREIGN KEY ("operation_id") REFERENCES "operations_operation"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "offers_proposal" ADD CONSTRAINT "offers_proposal_payment_id_71ec353a_fk_payments_payment_id" FOREIGN KEY ("payment_id") REFERENCES "payments_payment"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "offers_proposal" ADD CONSTRAINT "offers_proposal_user_id_a8d68715_fk_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "operations_operation" ADD CONSTRAINT "operations_operation_company_id_a5943d84_fk_companies" FOREIGN KEY ("company_id") REFERENCES "companies_company"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "operations_operation" ADD CONSTRAINT "operations_operation_from_user_id_7fd8c572_fk_users_user_id" FOREIGN KEY ("from_user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "operations_operation" ADD CONSTRAINT "operations_operation_to_user_id_bbca8815_fk_users_user_id" FOREIGN KEY ("to_user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "options_useroption" ADD CONSTRAINT "options_useroption_user_id_01488187_fk_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "partners_partner" ADD CONSTRAINT "partners_partner_company_id_e5c5fedc_fk_companies_company_id" FOREIGN KEY ("company_id") REFERENCES "companies_company"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "partners_partner" ADD CONSTRAINT "partners_partner_content_type_id_a0059c54_fk_django_co" FOREIGN KEY ("content_type_id") REFERENCES "django_content_type"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "partners_partner" ADD CONSTRAINT "partners_partner_user_id_c9159f29_fk_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "payments_payment" ADD CONSTRAINT "payments_payment_from_user_id_cc566b32_fk_users_user_id" FOREIGN KEY ("from_user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "payments_payment" ADD CONSTRAINT "payments_payment_to_user_id_7dfa9b08_fk_users_user_id" FOREIGN KEY ("to_user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "snitch_event" ADD CONSTRAINT "snitch_event_actor_content_type_i_2ad2cc94_fk_django_co" FOREIGN KEY ("actor_content_type_id") REFERENCES "django_content_type"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "snitch_event" ADD CONSTRAINT "snitch_event_target_content_type__06e9448e_fk_django_co" FOREIGN KEY ("target_content_type_id") REFERENCES "django_content_type"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "snitch_event" ADD CONSTRAINT "snitch_event_trigger_content_type_8b86ecfb_fk_django_co" FOREIGN KEY ("trigger_content_type_id") REFERENCES "django_content_type"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "snitch_notification" ADD CONSTRAINT "snitch_notification_event_id_0283365f_fk_snitch_event_id" FOREIGN KEY ("event_id") REFERENCES "snitch_event"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "snitch_notification" ADD CONSTRAINT "snitch_notification_user_id_9f5bdce1_fk_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "social_auth_usersocialauth" ADD CONSTRAINT "social_auth_usersocialauth_user_id_17d28448_fk_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "stellar_asset" ADD CONSTRAINT "stellar_asset_company_id_abb22de8_fk_companies_company_id" FOREIGN KEY ("company_id") REFERENCES "companies_company"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "stellar_asset_trust_op_completed" ADD CONSTRAINT "stellar_asset_trust__asset_id_bd42c6f5_fk_stellar_a" FOREIGN KEY ("asset_id") REFERENCES "stellar_asset"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "stellar_asset_trust_op_completed" ADD CONSTRAINT "stellar_asset_trust__user_id_af5e299a_fk_users_use" FOREIGN KEY ("user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "stellar_currencyasset_trust_op_completed" ADD CONSTRAINT "stellar_currencyasse_currencyasset_id_6ed8310e_fk_stellar_c" FOREIGN KEY ("currencyasset_id") REFERENCES "stellar_currencyasset"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "stellar_currencyasset_trust_op_completed" ADD CONSTRAINT "stellar_currencyasse_user_id_064aab92_fk_users_use" FOREIGN KEY ("user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "stellar_wallet" ADD CONSTRAINT "stellar_wallet_user_id_ee8eb8e3_fk_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "users_fiscalresidence" ADD CONSTRAINT "users_fiscalresidence_user_id_5b29aae4_fk_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "users_user_favorited_companies" ADD CONSTRAINT "users_user_favorited_company_id_445a86b5_fk_companies" FOREIGN KEY ("company_id") REFERENCES "companies_company"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "users_user_favorited_companies" ADD CONSTRAINT "users_user_favorited_user_id_08ed230f_fk_users_use" FOREIGN KEY ("user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "users_user_groups" ADD CONSTRAINT "users_user_groups_group_id_9afc8d0e_fk_auth_group_id" FOREIGN KEY ("group_id") REFERENCES "auth_group"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "users_user_groups" ADD CONSTRAINT "users_user_groups_user_id_5f6f5a90_fk_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "users_user_user_permissions" ADD CONSTRAINT "users_user_user_perm_permission_id_0b93982e_fk_auth_perm" FOREIGN KEY ("permission_id") REFERENCES "auth_permission"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "users_user_user_permissions" ADD CONSTRAINT "users_user_user_permissions_user_id_20aca447_fk_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "votes_vote" ADD CONSTRAINT "votes_vote_agenda_item_id_2274f311_fk_meetings_agendaitem_id" FOREIGN KEY ("agenda_item_id") REFERENCES "meetings_agendaitem"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "votes_vote" ADD CONSTRAINT "votes_vote_content_type_id_c8375fe1_fk_django_content_type_id" FOREIGN KEY ("content_type_id") REFERENCES "django_content_type"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "cuentas_participes" ADD CONSTRAINT "cuentas_participes_creator_id_fkey" FOREIGN KEY ("creator_id") REFERENCES "users_user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "participacion" ADD CONSTRAINT "participacion_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "users_user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "participacion" ADD CONSTRAINT "participacion_cuenta_participe_id_fkey" FOREIGN KEY ("cuenta_participe_id") REFERENCES "cuentas_participes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mangopay_mangopaytransfer_cuenta_participe" ADD CONSTRAINT "mangopay_mangopaytransfer_cuenta_participe_cuenta_particip_fkey" FOREIGN KEY ("cuenta_participe_id") REFERENCES "cuentas_participes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mangopay_mangopaytransfer_cuenta_participe" ADD CONSTRAINT "mangopay_mangopaytra_basemangopaytransact_d76323ba_fk_mangopay_" FOREIGN KEY ("basemangopaytransaction_ptr_id") REFERENCES "mangopay_basemangopaytransaction_cuenta_participe"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "record_participaciones" ADD CONSTRAINT "record_participaciones_participacion_id_fkey" FOREIGN KEY ("participacion_id") REFERENCES "participacion"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "venta_de_notas_convertibles" ADD CONSTRAINT "venta_de_notas_convertibles_creador_id_fkey" FOREIGN KEY ("creador_id") REFERENCES "users_user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "nota_convertible" ADD CONSTRAINT "nota_convertible_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "users_user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mediaCP" ADD CONSTRAINT "mediaCP_cuenta_participe_id_fkey" FOREIGN KEY ("cuenta_participe_id") REFERENCES "cuentas_participes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mediaNC" ADD CONSTRAINT "mediaNC_venta_nota_convertible_id_fkey" FOREIGN KEY ("venta_nota_convertible_id") REFERENCES "venta_de_notas_convertibles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
