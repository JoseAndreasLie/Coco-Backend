--
-- PostgreSQL database dump
--

-- Dumped from database version 15.13 (Homebrew)
-- Dumped by pg_dump version 15.13 (Homebrew)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: SequelizeMeta; Type: TABLE; Schema: public; Owner: ubuntu
--

CREATE TABLE public."SequelizeMeta" (
    name character varying(255) NOT NULL
);


ALTER TABLE public."SequelizeMeta" OWNER TO ubuntu;

--
-- Name: accessories; Type: TABLE; Schema: public; Owner: ubuntu
--

CREATE TABLE public.accessories (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone
);


ALTER TABLE public.accessories OWNER TO ubuntu;

--
-- Name: accessories_id_seq; Type: SEQUENCE; Schema: public; Owner: ubuntu
--

CREATE SEQUENCE public.accessories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accessories_id_seq OWNER TO ubuntu;

--
-- Name: accessories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ubuntu
--

ALTER SEQUENCE public.accessories_id_seq OWNED BY public.accessories.id;


--
-- Name: activities; Type: TABLE; Schema: public; Owner: ubuntu
--

CREATE TABLE public.activities (
    id integer NOT NULL,
    title character varying(255),
    description text,
    category_id integer,
    destination_id integer,
    duration_minutes integer,
    pricing numeric,
    accessory_ids integer[],
    cancelable text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone
);


ALTER TABLE public.activities OWNER TO ubuntu;

--
-- Name: activities_id_seq; Type: SEQUENCE; Schema: public; Owner: ubuntu
--

CREATE SEQUENCE public.activities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activities_id_seq OWNER TO ubuntu;

--
-- Name: activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ubuntu
--

ALTER SEQUENCE public.activities_id_seq OWNED BY public.activities.id;


--
-- Name: activity_accessories; Type: TABLE; Schema: public; Owner: ubuntu
--

CREATE TABLE public.activity_accessories (
    id integer NOT NULL,
    activity_id integer,
    accessory_id integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone
);


ALTER TABLE public.activity_accessories OWNER TO ubuntu;

--
-- Name: activity_accessories_id_seq; Type: SEQUENCE; Schema: public; Owner: ubuntu
--

CREATE SEQUENCE public.activity_accessories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activity_accessories_id_seq OWNER TO ubuntu;

--
-- Name: activity_accessories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ubuntu
--

ALTER SEQUENCE public.activity_accessories_id_seq OWNED BY public.activity_accessories.id;


--
-- Name: activity_availabilities; Type: TABLE; Schema: public; Owner: ubuntu
--

CREATE TABLE public.activity_availabilities (
    id integer NOT NULL,
    activity_package_id integer,
    date timestamp with time zone,
    start_time time without time zone,
    end_time time without time zone,
    available_slots integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone
);


ALTER TABLE public.activity_availabilities OWNER TO ubuntu;

--
-- Name: activity_availabilities_id_seq; Type: SEQUENCE; Schema: public; Owner: ubuntu
--

CREATE SEQUENCE public.activity_availabilities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activity_availabilities_id_seq OWNER TO ubuntu;

--
-- Name: activity_availabilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ubuntu
--

ALTER SEQUENCE public.activity_availabilities_id_seq OWNED BY public.activity_availabilities.id;


--
-- Name: activity_images; Type: TABLE; Schema: public; Owner: ubuntu
--

CREATE TABLE public.activity_images (
    id integer NOT NULL,
    activity_id integer,
    image_url character varying(255),
    image_type character varying(255),
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone
);


ALTER TABLE public.activity_images OWNER TO ubuntu;

--
-- Name: activity_images_id_seq; Type: SEQUENCE; Schema: public; Owner: ubuntu
--

CREATE SEQUENCE public.activity_images_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activity_images_id_seq OWNER TO ubuntu;

--
-- Name: activity_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ubuntu
--

ALTER SEQUENCE public.activity_images_id_seq OWNED BY public.activity_images.id;


--
-- Name: activity_packages; Type: TABLE; Schema: public; Owner: ubuntu
--

CREATE TABLE public.activity_packages (
    id integer NOT NULL,
    activity_id integer,
    name character varying(255),
    description text,
    price_per_person numeric,
    min_participants integer,
    max_participants integer,
    start_time time without time zone,
    end_time time without time zone,
    host_id integer,
    address character varying(255),
    image_url character varying(255),
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    activity_package_id integer,
    notice text
);


ALTER TABLE public.activity_packages OWNER TO ubuntu;

--
-- Name: activity_packages_id_seq; Type: SEQUENCE; Schema: public; Owner: ubuntu
--

CREATE SEQUENCE public.activity_packages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activity_packages_id_seq OWNER TO ubuntu;

--
-- Name: activity_packages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ubuntu
--

ALTER SEQUENCE public.activity_packages_id_seq OWNED BY public.activity_packages.id;


--
-- Name: bookings; Type: TABLE; Schema: public; Owner: ubuntu
--

CREATE TABLE public.bookings (
    id integer NOT NULL,
    user_id uuid,
    availability_id integer,
    participants integer,
    total_price numeric,
    status character varying(255),
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    activity_package_id integer,
    date timestamp with time zone,
    planner_id uuid
);


ALTER TABLE public.bookings OWNER TO ubuntu;

--
-- Name: bookings_id_seq; Type: SEQUENCE; Schema: public; Owner: ubuntu
--

CREATE SEQUENCE public.bookings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bookings_id_seq OWNER TO ubuntu;

--
-- Name: bookings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ubuntu
--

ALTER SEQUENCE public.bookings_id_seq OWNED BY public.bookings.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: ubuntu
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(255),
    description text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone
);


ALTER TABLE public.categories OWNER TO ubuntu;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: ubuntu
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO ubuntu;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ubuntu
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: destinations; Type: TABLE; Schema: public; Owner: ubuntu
--

CREATE TABLE public.destinations (
    id integer NOT NULL,
    name character varying(255),
    description text,
    image_url character varying(255),
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    longitude numeric,
    latitude numeric
);


ALTER TABLE public.destinations OWNER TO ubuntu;

--
-- Name: destinations_id_seq; Type: SEQUENCE; Schema: public; Owner: ubuntu
--

CREATE SEQUENCE public.destinations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.destinations_id_seq OWNER TO ubuntu;

--
-- Name: destinations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ubuntu
--

ALTER SEQUENCE public.destinations_id_seq OWNED BY public.destinations.id;


--
-- Name: groups; Type: TABLE; Schema: public; Owner: ubuntu
--

CREATE TABLE public.groups (
    id integer NOT NULL,
    name character varying(255),
    description text,
    session character varying(255),
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone
);


ALTER TABLE public.groups OWNER TO ubuntu;

--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: ubuntu
--

CREATE SEQUENCE public.groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.groups_id_seq OWNER TO ubuntu;

--
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ubuntu
--

ALTER SEQUENCE public.groups_id_seq OWNED BY public.groups.id;


--
-- Name: hosts; Type: TABLE; Schema: public; Owner: ubuntu
--

CREATE TABLE public.hosts (
    id integer NOT NULL,
    name character varying(255),
    bio character varying(255),
    profile_image_url character varying(255),
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    contact character varying(255)
);


ALTER TABLE public.hosts OWNER TO ubuntu;

--
-- Name: hosts_id_seq; Type: SEQUENCE; Schema: public; Owner: ubuntu
--

CREATE SEQUENCE public.hosts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hosts_id_seq OWNER TO ubuntu;

--
-- Name: hosts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ubuntu
--

ALTER SEQUENCE public.hosts_id_seq OWNED BY public.hosts.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: ubuntu
--

CREATE TABLE public.payments (
    id integer NOT NULL,
    booking_id integer,
    group_id integer,
    payment_method character varying(255),
    billing_address character varying(255),
    amount numeric,
    tax numeric,
    total numeric,
    status character varying(255),
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone
);


ALTER TABLE public.payments OWNER TO ubuntu;

--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: ubuntu
--

CREATE SEQUENCE public.payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payments_id_seq OWNER TO ubuntu;

--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ubuntu
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: ubuntu
--

CREATE TABLE public.reviews (
    id integer NOT NULL,
    activity_id integer,
    user_id uuid,
    group_id integer,
    rating integer,
    comment text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone
);


ALTER TABLE public.reviews OWNER TO ubuntu;

--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: ubuntu
--

CREATE SEQUENCE public.reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reviews_id_seq OWNER TO ubuntu;

--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ubuntu
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: tokens; Type: TABLE; Schema: public; Owner: ubuntu
--

CREATE TABLE public.tokens (
    id integer NOT NULL,
    token character varying(255),
    user_uuid uuid,
    type character varying(255),
    expires timestamp with time zone,
    blacklisted boolean,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.tokens OWNER TO ubuntu;

--
-- Name: tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: ubuntu
--

CREATE SEQUENCE public.tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tokens_id_seq OWNER TO ubuntu;

--
-- Name: tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ubuntu
--

ALTER SEQUENCE public.tokens_id_seq OWNED BY public.tokens.id;


--
-- Name: user_bookings; Type: TABLE; Schema: public; Owner: ubuntu
--

CREATE TABLE public.user_bookings (
    id integer NOT NULL,
    user_id uuid,
    booking_id integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    planner_id uuid,
    status character varying(255),
    email character varying(255)
);


ALTER TABLE public.user_bookings OWNER TO ubuntu;

--
-- Name: user_bookings_id_seq; Type: SEQUENCE; Schema: public; Owner: ubuntu
--

CREATE SEQUENCE public.user_bookings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_bookings_id_seq OWNER TO ubuntu;

--
-- Name: user_bookings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ubuntu
--

ALTER SEQUENCE public.user_bookings_id_seq OWNED BY public.user_bookings.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: ubuntu
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    group_id integer,
    name character varying(255),
    email character varying(255),
    password_hash character varying(255),
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone
);


ALTER TABLE public.users OWNER TO ubuntu;

--
-- Name: accessories id; Type: DEFAULT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.accessories ALTER COLUMN id SET DEFAULT nextval('public.accessories_id_seq'::regclass);


--
-- Name: activities id; Type: DEFAULT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.activities ALTER COLUMN id SET DEFAULT nextval('public.activities_id_seq'::regclass);


--
-- Name: activity_accessories id; Type: DEFAULT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.activity_accessories ALTER COLUMN id SET DEFAULT nextval('public.activity_accessories_id_seq'::regclass);


--
-- Name: activity_availabilities id; Type: DEFAULT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.activity_availabilities ALTER COLUMN id SET DEFAULT nextval('public.activity_availabilities_id_seq'::regclass);


--
-- Name: activity_images id; Type: DEFAULT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.activity_images ALTER COLUMN id SET DEFAULT nextval('public.activity_images_id_seq'::regclass);


--
-- Name: activity_packages id; Type: DEFAULT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.activity_packages ALTER COLUMN id SET DEFAULT nextval('public.activity_packages_id_seq'::regclass);


--
-- Name: bookings id; Type: DEFAULT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.bookings ALTER COLUMN id SET DEFAULT nextval('public.bookings_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: destinations id; Type: DEFAULT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.destinations ALTER COLUMN id SET DEFAULT nextval('public.destinations_id_seq'::regclass);


--
-- Name: groups id; Type: DEFAULT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.groups ALTER COLUMN id SET DEFAULT nextval('public.groups_id_seq'::regclass);


--
-- Name: hosts id; Type: DEFAULT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.hosts ALTER COLUMN id SET DEFAULT nextval('public.hosts_id_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Name: tokens id; Type: DEFAULT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.tokens ALTER COLUMN id SET DEFAULT nextval('public.tokens_id_seq'::regclass);


--
-- Name: user_bookings id; Type: DEFAULT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.user_bookings ALTER COLUMN id SET DEFAULT nextval('public.user_bookings_id_seq'::regclass);


--
-- Data for Name: SequelizeMeta; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY public."SequelizeMeta" (name) FROM stdin;
20211014113830-create-token.js
20250716040801-create-destinations.js
20250716042252-create-hosts.js
20250716043059-create-categories.js
20250814101912-create-groups.js
20250814113199-create-users.js
20250815003418-create-accessories.js
20250815004238-create-activities.js
20250815004239-create-reviews.js
20250815004508-create-activity-accessories.js
20250815004836-create-activity-packages.js
20250815130132-create-activity-availability.js
20250815130845-create-activity-images.js
20250816113200-create-bookings.js
20250816113201-create-payments.js
20250816113202-create-user-bookings.js
20250820012959-add-email-and-status-on-user-bookings.js
20250820023012-add-date-and-activity-package-id-to-booking.js
20250820031020-remove-role-and-add-planner-id-to-user-bookings.js
20250820081737-add-contact-to-hosts-and-notice-to-activity-packages.js
20250820081738-add-contact-to-hosts-and-notice-to-activity-packages.js
20250820081739-add-contact-to-hosts-and-notice-to-activity-packages.js
20250820084517-add-contact-to-hosts-and-notice-to-activity-packages.js
20250820084519-add-contact-to-hosts-and-notice-to-activity-packages.js
20250822005610-add-longitude-latitude-to-destinations.js
\.


--
-- Data for Name: accessories; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY public.accessories (id, name, created_at, updated_at, deleted_at) FROM stdin;
1	Snorkeling Gear	2025-07-02 03:57:23.496523+07	\N	\N
2	Certified Guide	2025-07-02 03:57:23.496523+07	\N	\N
3	Bottled Water	2025-07-02 03:57:23.496523+07	\N	\N
4	Free Meal	2025-07-02 03:57:23.496523+07	\N	\N
5	Life Jacket	2025-07-02 03:57:23.496523+07	\N	\N
6	Underwater Camera	2025-07-02 03:57:23.496523+07	\N	\N
\.


--
-- Data for Name: activities; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY public.activities (id, title, description, category_id, destination_id, duration_minutes, pricing, accessory_ids, cancelable, created_at, updated_at, deleted_at) FROM stdin;
1	Snorkeling in Piaynemo	Explore the beauty of the karst island clusters and shallow marine gardens in Piaynemo, Raja Ampat.	1	1	240	500000.00	{2,3,1,5,4,6}	Cancel your booking and receive the full value as a travel credit to use on any future activity with us.\n\nTravel Credit: If you cancel your booking at least 72 hours before the start time, you will receive a travel credit voucher for 100% of the amount paid.\n\nVoucher Validity: The travel credit is valid for 12 months from the date of your original booking.\n\nNo Refund: This booking is not eligible for a cash refund. All cancellations will be compensated with a travel credit only.\n\nCancellations within 72 hours: Cancellations made less than 72 hours before the activity are not eligible for travel credit.	2025-07-03 04:24:13.506686+07	\N	\N
2	Gili Trawangan Coral Reef Exploration	Swim with turtles and enjoy the colorful coral reefs at the best snorkeling spots on Gili Trawangan.	1	3	180	150000.00	{2,3,1,5}	Cancel your booking and receive the full value as a travel credit to use on any future activity with us.\n\nTravel Credit: If you cancel your booking at least 72 hours before the start time, you will receive a travel credit voucher for 100% of the amount paid.\n\nVoucher Validity: The travel credit is valid for 12 months from the date of your original booking.\n\nNo Refund: This booking is not eligible for a cash refund. All cancellations will be compensated with a travel credit only.\n\nCancellations within 72 hours: Cancellations made less than 72 hours before the activity are not eligible for travel credit.	2025-07-03 04:24:13.506686+07	\N	\N
3	Karimunjawa Snorkeling Safari	A snorkeling adventure visiting several exotic islands like Cemara Besar Island and Tanjung Gelam.	1	4	300	250000.00	{2,3,1,5,4}	Cancel your booking and receive the full value as a travel credit to use on any future activity with us.\n\nTravel Credit: If you cancel your booking at least 72 hours before the start time, you will receive a travel credit voucher for 100% of the amount paid.\n\nVoucher Validity: The travel credit is valid for 12 months from the date of your original booking.\n\nNo Refund: This booking is not eligible for a cash refund. All cancellations will be compensated with a travel credit only.\n\nCancellations within 72 hours: Cancellations made less than 72 hours before the activity are not eligible for travel credit.	2025-07-03 04:24:13.506686+07	\N	\N
4	The Underwater Charm of Bunaken	Witness the amazing vertical coral walls in Bunaken National Park, home to thousands of marine species.	1	5	240	450000.00	{2,3,1,5,6}	Cancel your booking and receive the full value as a travel credit to use on any future activity with us.\n\nTravel Credit: If you cancel your booking at least 72 hours before the start time, you will receive a travel credit voucher for 100% of the amount paid.\n\nVoucher Validity: The travel credit is valid for 12 months from the date of your original booking.\n\nNo Refund: This booking is not eligible for a cash refund. All cancellations will be compensated with a travel credit only.\n\nCancellations within 72 hours: Cancellations made less than 72 hours before the activity are not eligible for travel credit.	2025-07-03 04:24:13.506686+07	\N	\N
5	Swimming with Manta Rays in Nusa Penida	An unforgettable experience swimming with graceful giant manta rays at Manta Point.	1	7	210	350000.00	{2,3,1,5,6}	Cancel your booking and receive the full value as a travel credit to use on any future activity with us.\n\nTravel Credit: If you cancel your booking at least 72 hours before the start time, you will receive a travel credit voucher for 100% of the amount paid.\n\nVoucher Validity: The travel credit is valid for 12 months from the date of your original booking.\n\nNo Refund: This booking is not eligible for a cash refund. All cancellations will be compensated with a travel credit only.\n\nCancellations within 72 hours: Cancellations made less than 72 hours before the activity are not eligible for travel credit.	2025-07-03 04:24:13.506686+07	\N	\N
6	Pari Island Snorkeling Tour	A short getaway from Jakarta to enjoy the white sandy beaches and clear waters of the Thousand Islands.	1	14	360	350000.00	{2,3,1,5}	This policy is designed for travelers whose plans might shift. While bookings are non-refundable, we offer the flexibility to change your date.\n\nFree Rescheduling: You may reschedule your activity for a different date or time free of charge, provided you make the request at least 48 hours before the original start time. Rescheduling is subject to availability.\n\nNon-Refundable: All bookings are non-refundable. If you choose to cancel instead of reschedule, no refund will be provided.\n\nChanges within 48 hours: Rescheduling requests made less than 48 hours before the activity start time cannot be accommodated.	2025-07-03 04:24:13.506686+07	\N	\N
7	Pink Beach Snorkeling Adventure	Enjoy the unique pink sand beach while exploring its underwater life in Komodo National Park.	1	2	240	950000.00	{2,3,1,5,4}	This policy is designed for travelers whose plans might shift. While bookings are non-refundable, we offer the flexibility to change your date.\n\nFree Rescheduling: You may reschedule your activity for a different date or time free of charge, provided you make the request at least 48 hours before the original start time. Rescheduling is subject to availability.\n\nNon-Refundable: All bookings are non-refundable. If you choose to cancel instead of reschedule, no refund will be provided.\n\nChanges within 48 hours: Rescheduling requests made less than 48 hours before the activity start time cannot be accommodated.	2025-07-03 04:24:13.506686+07	\N	\N
8	Scuba Diving in Komodo National Park	Dive in one of the world''s best dive sites, encountering Komodo dragons, manta rays, and sharks.	2	2	480	1800000.00	{2,3,1,5,4,6}	This policy is designed for travelers whose plans might shift. While bookings are non-refundable, we offer the flexibility to change your date.\n\nFree Rescheduling: You may reschedule your activity for a different date or time free of charge, provided you make the request at least 48 hours before the original start time. Rescheduling is subject to availability.\n\nNon-Refundable: All bookings are non-refundable. If you choose to cancel instead of reschedule, no refund will be provided.\n\nChanges within 48 hours: Rescheduling requests made less than 48 hours before the activity start time cannot be accommodated.	2025-07-03 04:24:13.506686+07	\N	\N
9	Wakatobi Deep Dive Experience	Explore the richest marine biodiversity in the world at the heart of the Coral Triangle.	2	6	420	1500000.00	{2,3,1,5,6}	This policy is designed for travelers whose plans might shift. While bookings are non-refundable, we offer the flexibility to change your date.\n\nFree Rescheduling: You may reschedule your activity for a different date or time free of charge, provided you make the request at least 48 hours before the original start time. Rescheduling is subject to availability.\n\nNon-Refundable: All bookings are non-refundable. If you choose to cancel instead of reschedule, no refund will be provided.\n\nChanges within 48 hours: Rescheduling requests made less than 48 hours before the activity start time cannot be accommodated.	2025-07-03 04:24:13.506686+07	\N	\N
10	Diving the USAT Liberty Wreck, Tulamben	One of the best wreck diving spots in the world. Explore a US army transport ship that is now a marine paradise.	2	8	120	650000.00	{2,3,1,5,6}	This policy is designed for travelers whose plans might shift. While bookings are non-refundable, we offer the flexibility to change your date.\n\nFree Rescheduling: You may reschedule your activity for a different date or time free of charge, provided you make the request at least 48 hours before the original start time. Rescheduling is subject to availability.\n\nNon-Refundable: All bookings are non-refundable. If you choose to cancel instead of reschedule, no refund will be provided.\n\nChanges within 48 hours: Rescheduling requests made less than 48 hours before the activity start time cannot be accommodated.	2025-07-03 04:24:13.506686+07	\N	\N
11	Diving at Kilometer Zero, Sabang	Experience the thrill of diving at the westernmost tip of Indonesia with challenging currents and amazing views.	2	9	180	500000.00	{2,3,1,5}	Due to the high demand and limited capacity for this activity, all bookings are final and non-refundable. Please ensure your travel dates are confirmed before booking.\n\nAll purchases are final. No refunds will be issued for cancellations or no-shows for any reason.\n\nThis policy is in place to ensure our hosts can secure equipment and personnel for a guaranteed number of participants.\n\nIn the rare event that the host must cancel the tour (e.g., extreme weather), you will be offered a full refund or the option to reschedule for a future date.	2025-07-03 04:24:13.506686+07	\N	\N
12	Raja Ampat Liveaboard Diving	A multi-day diving adventure exploring the best spots in Raja Ampat by boat.	2	1	4320	8000000.00	{2,3,1,5,4,6}	Due to the high demand and limited capacity for this activity, all bookings are final and non-refundable. Please ensure your travel dates are confirmed before booking.\n\nAll purchases are final. No refunds will be issued for cancellations or no-shows for any reason.\n\nThis policy is in place to ensure our hosts can secure equipment and personnel for a guaranteed number of participants.\n\nIn the rare event that the host must cancel the tour (e.g., extreme weather), you will be offered a full refund or the option to reschedule for a future date.	2025-07-03 04:24:13.506686+07	\N	\N
13	Advanced Open Water in Gili Trawangan	Upgrade your diving skills with an Advanced Open Water course in the clear waters of Gili.	2	3	2880	4200000.00	{2,3,1,5}	Due to the high demand and limited capacity for this activity, all bookings are final and non-refundable. Please ensure your travel dates are confirmed before booking.\n\nAll purchases are final. No refunds will be issued for cancellations or no-shows for any reason.\n\nThis policy is in place to ensure our hosts can secure equipment and personnel for a guaranteed number of participants.\n\nIn the rare event that the host must cancel the tour (e.g., extreme weather), you will be offered a full refund or the option to reschedule for a future date.	2025-07-03 04:24:13.506686+07	\N	\N
14	Wall Diving in Bunaken National Park	A thrilling experience diving along steep and deep coral walls.	2	5	150	1100000.00	{2,3,1,5}	Due to the high demand and limited capacity for this activity, all bookings are final and non-refundable. Please ensure your travel dates are confirmed before booking.\n\nAll purchases are final. No refunds will be issued for cancellations or no-shows for any reason.\n\nThis policy is in place to ensure our hosts can secure equipment and personnel for a guaranteed number of participants.\n\nIn the rare event that the host must cancel the tour (e.g., extreme weather), you will be offered a full refund or the option to reschedule for a future date.	2025-07-03 04:24:13.506686+07	\N	\N
15	Mount Bromo Sunrise Tour	An iconic jeep tour to witness the magical sunrise with the backdrop of Mt. Bromo, Batok, and Semeru.	3	10	720	550000.00	{2,3,4}	Due to the high demand and limited capacity for this activity, all bookings are final and non-refundable. Please ensure your travel dates are confirmed before booking.\n\nAll purchases are final. No refunds will be issued for cancellations or no-shows for any reason.\n\nThis policy is in place to ensure our hosts can secure equipment and personnel for a guaranteed number of participants.\n\nIn the rare event that the host must cancel the tour (e.g., extreme weather), you will be offered a full refund or the option to reschedule for a future date.	2025-07-03 04:24:13.506686+07	\N	\N
16	Ubud Rice Terraces & Luwak Coffee Tour	Explore the green Tegalalang rice terraces and learn the process of making the world''s most expensive coffee.	3	11	240	300000.00	{2,3}	Life is unpredictable, and we understand that plans can change. This activity offers a flexible cancellation policy to give you peace of mind.\n\nFull Refund: You are eligible for a 100% refund if you cancel your booking at least 24 hours before the scheduled start time of the activity.\n\nCancellations within 24 hours: If you cancel less than 24 hours before the activity''s start time, the amount you paid will not be refunded.\n\nNo-Shows: No-shows will be considered a last-minute cancellation and are not eligible for a refund.\n\nChanges: Any changes to your booking must be made at least 24 hours before the start time.	2025-07-03 04:24:13.506686+07	\N	\N
17	Prambanan & Borobudur Temple Exploration	Visit two UNESCO World Heritage sites in one day, masterpieces of Hindu and Buddhist architecture.	3	12	480	450000.00	{2,3,4}	Life is unpredictable, and we understand that plans can change. This activity offers a flexible cancellation policy to give you peace of mind.\n\nFull Refund: You are eligible for a 100% refund if you cancel your booking at least 24 hours before the scheduled start time of the activity.\n\nCancellations within 24 hours: If you cancel less than 24 hours before the activity''s start time, the amount you paid will not be refunded.\n\nNo-Shows: No-shows will be considered a last-minute cancellation and are not eligible for a refund.\n\nChanges: Any changes to your booking must be made at least 24 hours before the start time.	2025-07-03 04:24:13.506686+07	\N	\N
18	Ijen Crater & Blue Fire Hike	A nighttime trek to witness the rare blue fire phenomenon and the stunning acidic crater lake.	3	13	600	400000.00	{2,3,4}	Life is unpredictable, and we understand that plans can change. This activity offers a flexible cancellation policy to give you peace of mind.\n\nFull Refund: You are eligible for a 100% refund if you cancel your booking at least 24 hours before the scheduled start time of the activity.\n\nCancellations within 24 hours: If you cancel less than 24 hours before the activity''s start time, the amount you paid will not be refunded.\n\nNo-Shows: No-shows will be considered a last-minute cancellation and are not eligible for a refund.\n\nChanges: Any changes to your booking must be made at least 24 hours before the start time.	2025-07-03 04:24:13.506686+07	\N	\N
19	Komodo Dragon Trek on Rinca Island	Walk in the native habitat of the world''s largest prehistoric lizard, accompanied by an experienced ranger.	3	2	180	250000.00	{2,3}	Life is unpredictable, and we understand that plans can change. This activity offers a flexible cancellation policy to give you peace of mind.\n\nFull Refund: You are eligible for a 100% refund if you cancel your booking at least 24 hours before the scheduled start time of the activity.\n\nCancellations within 24 hours: If you cancel less than 24 hours before the activity''s start time, the amount you paid will not be refunded.\n\nNo-Shows: No-shows will be considered a last-minute cancellation and are not eligible for a refund.\n\nChanges: Any changes to your booking must be made at least 24 hours before the start time.	2025-07-03 04:24:13.506686+07	\N	\N
20	Yogyakarta Culture and Culinary Tour	Explore the Sultan''s Palace, Water Castle, and taste local culinary delights like Gudeg and Kopi Joss.	3	12	360	250000.00	{2,3}	Life is unpredictable, and we understand that plans can change. This activity offers a flexible cancellation policy to give you peace of mind.\n\nFull Refund: You are eligible for a 100% refund if you cancel your booking at least 24 hours before the scheduled start time of the activity.\n\nCancellations within 24 hours: If you cancel less than 24 hours before the activity''s start time, the amount you paid will not be refunded.\n\nNo-Shows: No-shows will be considered a last-minute cancellation and are not eligible for a refund.\n\nChanges: Any changes to your booking must be made at least 24 hours before the start time.	2025-07-03 04:24:13.506686+07	\N	\N
\.


--
-- Data for Name: activity_accessories; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY public.activity_accessories (id, activity_id, accessory_id, created_at, updated_at, deleted_at) FROM stdin;
20	1	2	2025-07-03 04:39:43.218345+07	\N	\N
21	1	3	2025-07-03 04:39:43.218345+07	\N	\N
22	2	2	2025-07-03 04:39:43.218345+07	\N	\N
23	2	3	2025-07-03 04:39:43.218345+07	\N	\N
24	3	2	2025-07-03 04:39:43.218345+07	\N	\N
25	3	3	2025-07-03 04:39:43.218345+07	\N	\N
26	4	2	2025-07-03 04:39:43.218345+07	\N	\N
27	4	3	2025-07-03 04:39:43.218345+07	\N	\N
28	5	2	2025-07-03 04:39:43.218345+07	\N	\N
29	5	3	2025-07-03 04:39:43.218345+07	\N	\N
30	6	2	2025-07-03 04:39:43.218345+07	\N	\N
31	6	3	2025-07-03 04:39:43.218345+07	\N	\N
32	7	2	2025-07-03 04:39:43.218345+07	\N	\N
33	7	3	2025-07-03 04:39:43.218345+07	\N	\N
34	8	2	2025-07-03 04:39:43.218345+07	\N	\N
35	8	3	2025-07-03 04:39:43.218345+07	\N	\N
36	9	2	2025-07-03 04:39:43.218345+07	\N	\N
37	9	3	2025-07-03 04:39:43.218345+07	\N	\N
38	10	2	2025-07-03 04:39:43.218345+07	\N	\N
39	10	3	2025-07-03 04:39:43.218345+07	\N	\N
40	11	2	2025-07-03 04:39:43.218345+07	\N	\N
41	11	3	2025-07-03 04:39:43.218345+07	\N	\N
42	12	2	2025-07-03 04:39:43.218345+07	\N	\N
43	12	3	2025-07-03 04:39:43.218345+07	\N	\N
44	13	2	2025-07-03 04:39:43.218345+07	\N	\N
45	13	3	2025-07-03 04:39:43.218345+07	\N	\N
46	14	2	2025-07-03 04:39:43.218345+07	\N	\N
47	14	3	2025-07-03 04:39:43.218345+07	\N	\N
48	15	2	2025-07-03 04:39:43.218345+07	\N	\N
49	15	3	2025-07-03 04:39:43.218345+07	\N	\N
50	16	2	2025-07-03 04:39:43.218345+07	\N	\N
51	16	3	2025-07-03 04:39:43.218345+07	\N	\N
52	17	2	2025-07-03 04:39:43.218345+07	\N	\N
53	17	3	2025-07-03 04:39:43.218345+07	\N	\N
54	18	2	2025-07-03 04:39:43.218345+07	\N	\N
55	18	3	2025-07-03 04:39:43.218345+07	\N	\N
56	19	2	2025-07-03 04:39:43.218345+07	\N	\N
57	19	3	2025-07-03 04:39:43.218345+07	\N	\N
58	20	2	2025-07-03 04:39:43.218345+07	\N	\N
59	20	3	2025-07-03 04:39:43.218345+07	\N	\N
60	1	1	2025-07-03 04:39:43.218345+07	\N	\N
61	2	1	2025-07-03 04:39:43.218345+07	\N	\N
62	3	1	2025-07-03 04:39:43.218345+07	\N	\N
63	4	1	2025-07-03 04:39:43.218345+07	\N	\N
64	5	1	2025-07-03 04:39:43.218345+07	\N	\N
65	6	1	2025-07-03 04:39:43.218345+07	\N	\N
66	7	1	2025-07-03 04:39:43.218345+07	\N	\N
67	8	1	2025-07-03 04:39:43.218345+07	\N	\N
68	9	1	2025-07-03 04:39:43.218345+07	\N	\N
69	10	1	2025-07-03 04:39:43.218345+07	\N	\N
70	11	1	2025-07-03 04:39:43.218345+07	\N	\N
71	12	1	2025-07-03 04:39:43.218345+07	\N	\N
72	13	1	2025-07-03 04:39:43.218345+07	\N	\N
73	14	1	2025-07-03 04:39:43.218345+07	\N	\N
74	1	5	2025-07-03 04:39:43.218345+07	\N	\N
75	2	5	2025-07-03 04:39:43.218345+07	\N	\N
76	3	5	2025-07-03 04:39:43.218345+07	\N	\N
77	4	5	2025-07-03 04:39:43.218345+07	\N	\N
78	5	5	2025-07-03 04:39:43.218345+07	\N	\N
79	6	5	2025-07-03 04:39:43.218345+07	\N	\N
80	7	5	2025-07-03 04:39:43.218345+07	\N	\N
81	8	5	2025-07-03 04:39:43.218345+07	\N	\N
82	9	5	2025-07-03 04:39:43.218345+07	\N	\N
83	10	5	2025-07-03 04:39:43.218345+07	\N	\N
84	11	5	2025-07-03 04:39:43.218345+07	\N	\N
85	12	5	2025-07-03 04:39:43.218345+07	\N	\N
86	13	5	2025-07-03 04:39:43.218345+07	\N	\N
87	14	5	2025-07-03 04:39:43.218345+07	\N	\N
88	1	4	2025-07-03 04:39:43.218345+07	\N	\N
89	3	4	2025-07-03 04:39:43.218345+07	\N	\N
90	7	4	2025-07-03 04:39:43.218345+07	\N	\N
91	8	4	2025-07-03 04:39:43.218345+07	\N	\N
92	12	4	2025-07-03 04:39:43.218345+07	\N	\N
93	15	4	2025-07-03 04:39:43.218345+07	\N	\N
94	17	4	2025-07-03 04:39:43.218345+07	\N	\N
95	18	4	2025-07-03 04:39:43.218345+07	\N	\N
96	1	6	2025-07-03 04:39:43.218345+07	\N	\N
97	4	6	2025-07-03 04:39:43.218345+07	\N	\N
98	5	6	2025-07-03 04:39:43.218345+07	\N	\N
99	8	6	2025-07-03 04:39:43.218345+07	\N	\N
100	9	6	2025-07-03 04:39:43.218345+07	\N	\N
101	10	6	2025-07-03 04:39:43.218345+07	\N	\N
102	12	6	2025-07-03 04:39:43.218345+07	\N	\N
\.


--
-- Data for Name: activity_availabilities; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY public.activity_availabilities (id, activity_package_id, date, start_time, end_time, available_slots, created_at, updated_at, deleted_at) FROM stdin;
1	1	2024-08-25 07:00:00+07	09:00:00	16:00:00	10	2025-08-19 15:42:33.694606+07	2025-08-19 15:42:33.694606+07	\N
2	2	2024-08-26 07:00:00+07	09:00:00	16:00:00	4	2025-08-19 15:42:33.694606+07	2025-08-19 15:42:33.694606+07	\N
3	3	2024-08-27 07:00:00+07	10:00:00	15:00:00	15	2025-08-19 15:42:33.694606+07	2025-08-19 15:42:33.694606+07	\N
4	5	2024-08-28 07:00:00+07	08:30:00	16:30:00	12	2025-08-19 15:42:33.694606+07	2025-08-19 15:42:33.694606+07	\N
\.


--
-- Data for Name: activity_images; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY public.activity_images (id, activity_id, image_url, image_type, created_at, updated_at, deleted_at) FROM stdin;
81	1	https://doyanjalan.co.id/wp-content/uploads/2023/08/Sawendarek.jpg	thumbnail	\N	\N	\N
82	1	https://ik.imagekit.io/pandooin/tr:pr-true/production/images/itinerary/short-escape-to-piaynemo-1d/5KHwicdVy2htzZGEovPzdTh00hVenhbUL1BI3Rac.jpg	banner	\N	\N	\N
83	1	https://ik.imagekit.io/pandooin/tr:pr-true/production/images/itinerary/short-escape-to-piaynemo-1d/qcV9wjPSY77rSDLORqbek6js9hQlPjcynzxKhTnb.jpg	gallery	\N	\N	\N
84	1	https://www.komodoluxury.com/wp-content/uploads/2024/07/somewhere-wayag.webp	gallery	\N	\N	\N
85	2	https://instantkarmamag.com/wp-content/uploads/2022/05/halik-reef.jpg	thumbnail	\N	\N	\N
86	2	https://resurfacetoreality.com/wp-content/uploads/2022/12/img_3054.jpg	banner	\N	\N	\N
87	2	https://www.gilibookings.com/uploads/content/Activities/Manta%20Dive%20Gili%20T/diving-manta-gili-t.jpg	gallery	\N	\N	\N
88	2	https://manta-dive.com/assets/HomepageSlider/OpenWater_Dive_Course_Underwater__FocusFillWyIwLjAwIiwiMC4wMCIsMTkyMCwxMDgwXQ.jpg	gallery	\N	\N	\N
89	3	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtgk1Sc68K4DnZcOBsfWATALNyEE6KuzrS1w&s	thumbnail	\N	\N	\N
90	3	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtgk1Sc68K4DnZcOBsfWATALNyEE6KuzrS1w&s	banner	\N	\N	\N
91	3	https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjsIchtfSftdzsvGioxAJzmGdy2gKFxQyMDE0LH-bGu4AumcGmj67oGH3E_titpph5aEDMyNcABG2L1UvqJsdVltT68kWi66LITZpjNiJ91h9wzOUmdhTb_m6DE-ODgci3ZNjKSgedU2dJ5/s590/Paket+Snorkeling+Karimunjawa.jpg	gallery	\N	\N	\N
92	3	https://www.uwphotographyguide.com/images/schooling_fusiliers.jpg	gallery	\N	\N	\N
93	4	https://www.uwphotographyguide.com/images/schooling_fusiliers.jpg	thumbnail	\N	\N	\N
94	4	https://indonesiawaterportal.com/storage/2018/03/underwater-beauty-of-bunaken-2.jpg	banner	\N	\N	\N
95	4	https://bobobox.com/blog/wp-content//uploads/2024/12/menyelam-di-bunaken-jpg.webp	gallery	\N	\N	\N
96	4	https://assets.promediateknologi.id/crop/0x0:0x0/0x0/webp/photo/p3/22/2024/07/26/324528461-2454815409.jpg	gallery	\N	\N	\N
97	5	https://media.tacdn.com/media/attractions-splice-spp-674x446/0a/b3/18/0e.jpg	thumbnail	\N	\N	\N
98	5	https://cdn.getyourguide.com/img/tour/c12cff8f020d1472.jpeg/148.jpg	banner	\N	\N	\N
99	5	https://www.tourbalidriver.com/wp-content/uploads/2025/05/pari-manta-nus-alembongan.jpg	gallery	\N	\N	\N
100	5	https://nusapenidaislands.com/wp-content/uploads/2018/05/manta-point-24.jpg	gallery	\N	\N	\N
101	6	https://melampa.com/wp-content/uploads/2018/04/Snorkelling-in-Tidung-island.jpg	thumbnail	\N	\N	\N
102	6	https://s-light.tiket.photos/t/01E25EBZS3W0FY9GTG6C42E1SE/rsfit19201280gsm/events/2021/02/08/063b5d6a-b1f6-400e-92cb-df5c85afc6cb-1612766279678-aaaddd03813bcacb102a69b55039d442.jpg	banner	\N	\N	\N
103	6	https://media-cdn.tripadvisor.com/media/photo-s/0b/6a/0a/df/snorkling.jpg	gallery	\N	\N	\N
104	6	https://inionline.id/wp-content/uploads/2017/09/promo-diskon-pulau-pari-mar20163.jpg	gallery	\N	\N	\N
105	7	https://media-cdn.tripadvisor.com/media/attractions-splice-spp-674x446/07/a4/fa/39.jpg	thumbnail	\N	\N	\N
106	7	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqN7tUGCKPWFBF0fW3hia9LaXkAh40ltotkA&s	banner	\N	\N	\N
107	7	https://lomboknavigasi.com/wp-content/uploads/2025/01/WhatsApp-Image-2025-01-30-at-17.31.06.jpeg	gallery	\N	\N	\N
108	7	https://veronikasadventure.com/wp-content/uploads/lombok-pink-beach-full-day-private-tour-gopro-included.jpg	gallery	\N	\N	\N
109	8	https://www.scubajunkiekomodo.com/wp-content/uploads/2021/05/diver-komodo.jpg	thumbnail	\N	\N	\N
110	8	https://mantarheidivecenter.files.wordpress.com/2018/07/20170726-20170726-2h4a6488.jpg?w=1000	banner	\N	\N	\N
111	8	https://www.komodoluxury.com/wp-content/uploads/2024/09/36_11zon_11zon.webp	gallery	\N	\N	\N
112	8	https://helloflores.com/wp-content/uploads/2019/10/whales_tonga_cover.jpg	gallery	\N	\N	\N
113	9	https://blog.wakatobi.com/wp-content/uploads/2025/03/R4A6547.jpg	thumbnail	\N	\N	\N
114	9	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3wHKzaX1DaiNY9JNOR7n91FhXNAOE-tR7lA&s	banner	\N	\N	\N
115	9	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0a89sOYDXQID-AD9XQ3C5fLo17wtYuQLM2A&s	gallery	\N	\N	\N
116	9	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3euUYlO0S9e7qi03EAIP1JoqIPEp7zxuwJQ&s	gallery	\N	\N	\N
117	10	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBkzdWdu7rpEV6xiSnUpkU5kvxh60zdowqrQ&s	thumbnail	\N	\N	\N
118	10	https://letsdivetulamben.com/wp-content/uploads/2023/03/Scuba-diving-Tulamben-Bali-giant-frog-fish.jpg	banner	\N	\N	\N
119	10	https://www.korinatour.co.id/wp-content/uploads/2018/11/coverimage-24.jpg	gallery	\N	\N	\N
120	10	https://www.uwphotographyguide.com/sites/default/files/20190414%20-%20Sea%20Fans%20(1%20of%201).jpg	gallery	\N	\N	\N
121	11	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaIF68V2f1TiCzFToCncrL5jvt5Y_ACNDKZg&s	thumbnail	\N	\N	\N
122	11	https://www.tenggol.com.my/wp-content/uploads/2024/04/DivingPackage-1.jpeg	banner	\N	\N	\N
123	11	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRyhfawwwzw-_CUA7AePvdwg2upMhxP-NAfSA&s	gallery	\N	\N	\N
124	11	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoDxnsP7xM_H0rivPitArK6cCfEMBZ5rXwlA&s	gallery	\N	\N	\N
125	12	https://images.squarespace-cdn.com/content/v1/6066d19a14d0a6623468837a/cf96b30e-ade7-4ae0-8442-36a3a4f8dfcc/Jaya-Raja-Ampat-Liveaboard-Indonesia.jpg	thumbnail	\N	\N	\N
126	12	https://img.liveaboard.com/picture_library/boat/5510/mv-raja-ampat-explorer-2.jpg?tr=w-1200,h-628,f-jpeg	banner	\N	\N	\N
127	12	https://images.squarespace-cdn.com/content/v1/6066d19a14d0a6623468837a/b36800e9-eb85-43ee-b2f5-37aea20c1ecb/Raja-Ampat-Liveaboard.jpg?format=2500w	gallery	\N	\N	\N
128	12	https://res.cloudinary.com/zublu/image/fetch/f_webp,w_1200,q_auto/https://www.zubludiving.com/images/Articles/Raja-Ampat-Liveaboard-Diving/Raja-Ampat-Liveaboard-Diving-Banner.jpg	gallery	\N	\N	\N
129	13	https://www.dsmdive.com/wp-content/uploads/2020/07/OW12.jpg	thumbnail	\N	\N	\N
130	13	https://manta-dive.com/assets/Divers-and-marine-life/reef-dive-gili-trawangan__FocusFillWyIwLjAwIiwiMC4wMCIsMTkyMCwxMDgwXQ.jpg	banner	\N	\N	\N
131	13	https://hikingrinjani.com/wp-content/uploads/2018/04/3-gili.jpg	gallery	\N	\N	\N
132	13	https://www.trawangandive.com/wp-content/uploads/2020/05/five-best-reasons-to-do-your-open-water-course-on-gili-trawangan-1024x683.jpg	gallery	\N	\N	\N
133	14	https://north-sulawesi.com/wp-content/uploads/2023/10/Divers-with-squid.jpg	thumbnail	\N	\N	\N
134	14	https://b2813297.smushcdn.com/2813297/wp-content/uploads/2023/06/FB-Dive-Bunaken_3.jpg?lossy=1&strip=0&webp=1	banner	\N	\N	\N
135	14	https://reefbuilders.com/wp-content/uploads/rd/2017/10/Bunaken-Wall-Dive-2-e1507921472588.jpg	gallery	\N	\N	\N
136	14	https://preview.redd.it/2l2wa19ituo21.jpg?width=1080&crop=smart&auto=webp&s=4aa2dec4580864397147bb3d59750c53bdf6c435	gallery	\N	\N	\N
137	15	https://media-cdn.tripadvisor.com/media/attractions-splice-spp-674x446/09/1d/c1/2b.jpg	thumbnail	\N	\N	\N
138	15	https://s-light.tiket.photos/t/01E25EBZS3W0FY9GTG6C42E1SE/rsfit19201280gsm/events/2021/08/24/32c5bcbb-5daf-4150-afef-56c5cf3b2494-1629782419086-fe8a98ba74b5385665e2fa98c7521d61.jpg	banner	\N	\N	\N
139	15	https://static1.squarespace.com/static/56dfd5cc9f7266ed7f04b64d/5e84805ca5dfdd3303ef58c4/5e8486132a95fb626aebd030/1585743459776/?format=1500w	gallery	\N	\N	\N
140	15	https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg7-F1FFcUbLfuyRgOxYQ5zpKGME0XqE_C7HnXjn1vlTrNk_5ubKCSsJ4iIn0bDlN9WtvrPvc9aVFt5kyXirDlPGUv2cQEr16DAcPKdP0cY7GPqHmU2I20-NH9fT2yWL25ckpPsO1r5tMM3/s1600/Mount+Bromo+Sunrise+tour+from+Probolinggo.jpg	gallery	\N	\N	\N
141	16	https://d3uyff779abz3k.cloudfront.net/-baliriceterrace-/image/Ceking-Rice-Terrace-Bali.jpeg	thumbnail	\N	\N	\N
142	16	https://theworldtravelguy.com/wp-content/uploads/2020/05/DJI_0910-3.jpg	banner	\N	\N	\N
143	16	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFcl-afXpOnKVuZPzytekwjkEJLybD4xt3Gw&s	gallery	\N	\N	\N
144	16	https://www.baliholidaysecrets.com/wp-content/uploads/2025/01/Best-Rice-Terraces-in-Bali-Tegalalang-Rice-Terraces-e1736034220573.jpg	gallery	\N	\N	\N
145	17	https://whc.unesco.org/uploads/thumbs/site_0642_0001-750-750-20151104153312.jpg	thumbnail	\N	\N	\N
146	17	https://a.travel-assets.com/findyours-php/viewfinder/images/res70/210000/210304-Prambanan-Temple.jpg	banner	\N	\N	\N
147	17	https://pramukadiy.or.id/assets/uploads/2017/11/prambanan-temple.jpg	gallery	\N	\N	\N
148	17	https://media.tacdn.com/media/attractions-splice-spp-674x446/0e/c9/1b/4b.jpg	gallery	\N	\N	\N
149	18	https://cdn.getyourguide.com/img/tour/5eef3a7f0b6a0.jpeg/155.jpg	thumbnail	\N	\N	\N
150	18	https://theroamingshoes.com/wp-content/uploads/2024/07/IMG_1693.jpg	banner	\N	\N	\N
151	18	https://images.squarespace-cdn.com/content/v1/562fe3aae4b0a3fef65d3577/1467358214436-JKXDY61CDWI1CV8YJPU3/image-asset.jpeg	gallery	\N	\N	\N
152	18	https://javaadventuretrail.com/wp-content/uploads/2018/12/best-time-to-visit-ijen-crater-1024x768.jpg	gallery	\N	\N	\N
153	19	https://helloflores.com/wp-content/uploads/2019/10/Padar.jpg	thumbnail	\N	\N	\N
154	19	https://komodotrekker.com/wp-content/uploads/2019/02/Silversea-cruise-Dec-2018-1024x686.jpg	banner	\N	\N	\N
155	19	https://ekaputrawisata.com/wp-content/uploads/2025/04/More-Adventurous-Trekking-Routes.webp	gallery	\N	\N	\N
156	19	https://yachtsourcing.com/wp-content/uploads/c2d99dc4ba0099c93795b32.jpeg	gallery	\N	\N	\N
157	20	https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1a/57/7e/f2/caption.jpg?w=500&h=400&s=1	thumbnail	\N	\N	\N
158	20	https://www.agoda.com/wp-content/uploads/2024/02/shutterstock_1843678543-1.jpg	banner	\N	\N	\N
159	20	https://media.tacdn.com/media/attractions-splice-spp-674x446/06/70/5b/1b.jpg	gallery	\N	\N	\N
160	20	https://s-light.tiket.photos/t/01E25EBZS3W0FY9GTG6C42E1SE/rsfit800600gsm/eventThirdParty/2024/11/07/58685592-5cf5-4664-94ed-8bd19152abe4-1730960131620-1f942eef2d6ac184ea9605bd64ff19ae.jpg	gallery	\N	\N	\N
\.


--
-- Data for Name: activity_packages; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY public.activity_packages (id, activity_id, name, description, price_per_person, min_participants, max_participants, start_time, end_time, host_id, address, image_url, created_at, updated_at, deleted_at, activity_package_id, notice) FROM stdin;
3	2	Public Trip	Snorkeling at the 3 Gili Islands (Trawangan, Meno, Air) with a glass bottom boat.	150000.00	1	20	10:00:00	15:00:00	4	Public Harbour, Gili Trawangan, Lombok Utara, NTB	https://dynamic-media-cdn.tripadvisor.com/media/photo-o/26/60/e9/51/underwater-statue.jpg?w=1200&h=-1&s=1	\N	\N	\N	\N	\N
4	2	Private Charter	Rent a private boat for a full day to snorkel at your own pace at the best spots.	800000.00	1	8	09:30:00	16:00:00	1	Public Harbour, Gili Trawangan, Lombok Utara, NTB	https://www.komodoluxury.com/wp-content/uploads/2024/02/21e0c704-187b-488c-8e8c-038c2fbf7114_11zon.webp	\N	\N	\N	\N	\N
5	3	1 Day Tour	Includes boat, snorkeling gear, grilled fish lunch, and documentation.	250000.00	5	15	08:30:00	16:30:00	4	Pelabuhan Kartini, Jepara, Jawa Tengah (Meeting point for ferry crossing)	https://dynamic-media-cdn.tripadvisor.com/media/photo-o/07/c3/f7/53/sea-adventure-excursions.jpg?w=1200&h=900&s=1	\N	\N	\N	\N	\N
6	3	2-Day 1-Night Package	Includes accommodation, 2 days of sea tours, and all facilities.	750000.00	4	12	08:00:00	17:00:00	4	Pelabuhan Kartini, Jepara, Jawa Tengah (Meeting point for ferry crossing)	https://dynamic-media-cdn.tripadvisor.com/media/photo-o/07/c3/f7/53/sea-adventure-excursions.jpg?w=1200&h=900&s=1	\N	\N	\N	\N	\N
7	4	Bunaken Snorkeling Package	Explore 2 of the best spots in Bunaken National Park.	450000.00	2	10	09:00:00	15:00:00	1	Pelabuhan Calaca, Manado, Sulawesi Utara	https://torch.id/cdn/shop/articles/Artikel_172_-_Preview.webp?v=1713774282	\N	\N	\N	\N	\N
8	4	Snorkeling & Photography	A special package with a professional underwater photographer.	900000.00	2	6	09:00:00	15:00:00	3	Pelabuhan Calaca, Manado, Sulawesi Utara	https://res.cloudinary.com/manawa/image/upload/f_auto,c_limit,w_3840,q_auto/articles/most-beautiful-spots-for-your-first-scuba-dive/61396758347_kwukov	\N	\N	\N	\N	\N
9	5	Manta Ray Trip	Focuses on snorkeling at Manta Point and Manta Bay.	350000.00	2	12	08:30:00	13:00:00	3	Pelabuhan Toyapakeh, Nusa Penida, Bali	https://picsum.photos/seed/pkg-manta-trip/800/600	\N	\N	\N	\N	\N
10	5	West Penida Snorkeling Combo	Snorkeling at Manta Bay, Gamat Bay, and Crystal Bay.	450000.00	2	12	08:30:00	16:00:00	1	Pelabuhan Toyapakeh, Nusa Penida, Bali	https://picsum.photos/seed/pkg-penida-combo/800/600	\N	\N	\N	\N	\N
11	6	One Day Trip	Depart in the morning, return in the evening from Muara Angke, all facilities included.	350000.00	10	30	07:00:00	18:00:00	4	Dermaga Marina Ancol atau Pelabuhan Muara Angke, Jakarta Utara	https://picsum.photos/seed/pkg-oneday-pari/800/600	\N	\N	\N	\N	\N
12	6	Overnight Package	A 2D1N package including an air-conditioned homestay and a BBQ night.	600000.00	8	20	07:00:00	15:00:00	4	Dermaga Marina Ancol atau Pelabuhan Muara Angke, Jakarta Utara	https://picsum.photos/seed/pkg-overnight-pari/800/600	\N	\N	\N	\N	\N
13	7	Speedboat Trip	A fast tour by speedboat visiting Padar Island, Komodo Island, and Pink Beach.	1300000.00	1	12	06:00:00	17:00:00	1	Pelabuhan Labuan Bajo, Manggarai Barat, NTT	https://picsum.photos/seed/pkg-speedboat-komodo/800/600	\N	\N	\N	\N	\N
14	7	Phinisi Slow Sailing	A relaxed tour on a phinisi boat, allowing more time for snorkeling.	950000.00	4	15	07:00:00	17:00:00	3	Pelabuhan Labuan Bajo, Manggarai Barat, NTT	https://picsum.photos/seed/pkg-phinisi-komodo/800/600	\N	\N	\N	\N	\N
15	8	Daily Dive Trip (3 Dives)	Dive at 3 different spots in one day, for certified divers.	1800000.00	1	8	07:30:00	16:30:00	3	Pelabuhan Labuan Bajo, Manggarai Barat, NTT	https://picsum.photos/seed/pkg-daily-dive-komodo/800/600	\N	\N	\N	\N	\N
16	8	Komodo Liveaboard (3D2N)	The ultimate diving experience by staying on the boat.	7500000.00	4	12	10:00:00	15:00:00	3	Pelabuhan Labuan Bajo, Manggarai Barat, NTT	https://picsum.photos/seed/pkg-liveaboard-komodo/800/600	\N	\N	\N	\N	\N
17	9	Resort Dive Package	A dive package including a stay at a Wakatobi dive resort.	4000000.00	2	6	08:00:00	16:00:00	1	Bandara Matahora atau Pelabuhan Wanci, Pulau Wangi-Wangi, Wakatobi	https://picsum.photos/seed/pkg-resort-wakatobi/800/600	\N	\N	\N	\N	\N
18	9	Fun Dives	For certified divers, 2 dives per day.	1500000.00	1	8	08:30:00	14:00:00	3	Bandara Matahora atau Pelabuhan Wanci, Pulau Wangi-Wangi, Wakatobi	https://picsum.photos/seed/pkg-fun-dive-wakatobi/800/600	\N	\N	\N	\N	\N
19	10	Liberty Wreck Shore Dive	2 shore dives at the USAT Liberty shipwreck.	900000.00	1	6	09:00:00	13:00:00	1	Meeting Point at Liberty Dive Resort, Tulamben, Karangasem, Bali	https://picsum.photos/seed/pkg-wreck-dive/800/600	\N	\N	\N	\N	\N
20	10	Night Dive	Experience the shipwreck differently by diving at night.	650000.00	2	6	18:30:00	20:30:00	1	Meeting Point at Liberty Dive Resort, Tulamben, Karangasem, Bali	https://picsum.photos/seed/pkg-night-dive/800/600	\N	\N	\N	\N	\N
21	11	Weh Island Fun Dives	Dive around Rubiah Island, rich with marine life.	500000.00	1	8	09:30:00	15:00:00	3	Pelabuhan Balohan, Sabang, Pulau Weh, Aceh	https://picsum.photos/seed/pkg-fun-dive-weh/800/600	\N	\N	\N	\N	\N
22	11	Deep Dive Special	Explore the Canyon and other deep dive spots.	700000.00	2	6	10:00:00	13:00:00	3	Pelabuhan Balohan, Sabang, Pulau Weh, Aceh	https://picsum.photos/seed/pkg-deep-dive-weh/800/600	\N	\N	\N	\N	\N
23	12	Standard Cabin	A 4D3N Liveaboard with a standard fan-cooled cabin.	9500000.00	6	12	11:00:00	14:00:00	1	Pelabuhan Waisai, Raja Ampat, Papua Barat	https://picsum.photos/seed/pkg-liveaboard-standard/800/600	\N	\N	\N	\N	\N
24	12	Master Cabin AC	A 4D3N Liveaboard with an air-conditioned master cabin and private bathroom.	15000000.00	2	8	11:00:00	14:00:00	3	Pelabuhan Waisai, Raja Ampat, Papua Barat	https://picsum.photos/seed/pkg-liveaboard-master/800/600	\N	\N	\N	\N	\N
25	13	PADI AOW Course	A 2-3 day course to get your Advanced Open Water certification.	4500000.00	1	4	09:00:00	16:00:00	1	Public Harbour, Gili Trawangan, Lombok Utara, NTB	https://picsum.photos/seed/pkg-padi-course/800/600	\N	\N	\N	\N	\N
26	13	SSI AOW Course	An Advanced course option from SSI, usually slightly cheaper.	4200000.00	1	4	09:00:00	16:00:00	3	Public Harbour, Gili Trawangan, Lombok Utara, NTB	https://picsum.photos/seed/pkg-ssi-course/800/600	\N	\N	\N	\N	\N
27	14	Boat Dive (2 Dives)	Dive at 2 of the best wall diving spots like Lekuan I and II.	1100000.00	1	8	08:30:00	14:00:00	1	Pelabuhan Calaca, Manado, Sulawesi Utara	https://picsum.photos/seed/pkg-wall-dive/800/600	\N	\N	\N	\N	\N
28	14	Photography Dive	A slower-paced dive focused on getting great shots for photographers.	1500000.00	1	4	08:30:00	15:00:00	3	Pelabuhan Calaca, Manado, Sulawesi Utara	https://picsum.photos/seed/pkg-photo-dive-wall/800/600	\N	\N	\N	\N	\N
2	1	Private Package	Exclusive tour with a private boat and a dedicated guide for your group.	1200000.00	2	6	09:00:00	16:00:00	3	Pelabuhan Waisai, Raja Ampat, Papua Barat	https://www.komodoluxury.com/wp-content/uploads/2024/03/IMG_4621_11zon_11zon.webp	\N	\N	\N	\N	\N
29	15	Midnight Tour	Depart at midnight from Malang/Surabaya, includes jeep and entrance tickets.	550000.00	2	6	00:30:00	12:00:00	2	Area Parkir Jeep Cemoro Lawang, Ngadisari, Probolinggo, Jawa Timur	https://picsum.photos/seed/pkg-bromo-jeep-group/800/600	\N	\N	\N	\N	\N
30	15	Private Jeep Charter	Rent a full jeep for your group for more flexibility.	1800000.00	1	6	01:00:00	11:00:00	5	Area Parkir Jeep Cemoro Lawang, Ngadisari, Probolinggo, Jawa Timur	https://picsum.photos/seed/pkg-bromo-jeep-private/800/600	\N	\N	\N	\N	\N
31	16	Half Day Tour	Visit the Tegalalang rice terraces and a coffee plantation.	300000.00	2	6	09:00:00	14:00:00	2	Meeting Point at Ubud Palace, Jl. Raya Ubud No.8, Ubud, Gianyar, Bali	https://picsum.photos/seed/pkg-ubud-half/800/600	\N	\N	\N	\N	\N
32	16	Full Day Ubud Explorer	Also includes the Monkey Forest, Tirta Empul temple, and lunch.	600000.00	2	6	09:00:00	17:00:00	2	Meeting Point at Ubud Palace, Jl. Raya Ubud No.8, Ubud, Gianyar, Bali	https://picsum.photos/seed/pkg-ubud-full/800/600	\N	\N	\N	\N	\N
33	17	Sunrise Borobudur & Prambanan	Witness the sunrise at Borobudur then continue to Prambanan temple.	750000.00	2	5	04:00:00	15:00:00	5	Titik Nol Kilometer Yogyakarta (Near Central Post Office), Yogyakarta	https://picsum.photos/seed/pkg-temple-sunrise/800/600	\N	\N	\N	\N	\N
34	17	Regular Temple Tour	A relaxed tour visiting both temples during the daytime.	450000.00	2	5	08:00:00	16:00:00	2	Titik Nol Kilometer Yogyakarta (Near Central Post Office), Yogyakarta	https://picsum.photos/seed/pkg-temple-regular/800/600	\N	\N	\N	\N	\N
35	18	Blue Fire Tour	Includes guide, gas mask, and transportation from Banyuwangi.	400000.00	2	10	00:00:00	09:00:00	5	Pos Paltuding (Gerbang Masuk Kawah Ijen), Banyuwangi, Jawa Timur	https://picsum.photos/seed/pkg-ijen-blue-fire/800/600	\N	\N	\N	\N	\N
36	18	All-in from Surabaya	A complete 2D1N package including transport from Surabaya and accommodation.	1500000.00	4	8	19:00:00	12:00:00	5	Pos Paltuding (Gerbang Masuk Kawah Ijen), Banyuwangi, Jawa Timur	https://picsum.photos/seed/pkg-ijen-all-in/800/600	\N	\N	\N	\N	\N
37	19	Rinca Island Trek	A short trek (1 hour) on Rinca Island.	250000.00	2	8	09:00:00	12:00:00	2	Pelabuhan Labuan Bajo, Manggarai Barat, NTT	https://picsum.photos/seed/pkg-komodo-short-trek/800/600	\N	\N	\N	\N	\N
38	19	Komodo Island Medium Trek	A longer trek (2-3 hours) on Komodo Island for a greater chance of encountering wildlife.	400000.00	2	8	08:30:00	13:00:00	5	Pelabuhan Labuan Bajo, Manggarai Barat, NTT	https://picsum.photos/seed/pkg-komodo-long-trek/800/600	\N	\N	\N	\N	\N
39	20	City Tour	A 6-hour tour visiting the Sultans Palace, Water Castle, and a Batik center.	350000.00	2	5	09:00:00	15:00:00	2	Titik Nol Kilometer Yogyakarta (Near Central Post Office), Yogyakarta	https://picsum.photos/seed/pkg-yogya-city/800/600	\N	\N	\N	\N	\N
40	20	Street Food Night Tour	Explore the legendary nightlife and street food of Yogyakarta.	250000.00	2	8	18:00:00	22:00:00	2	Titik Nol Kilometer Yogyakarta (Near Central Post Office), Yogyakarta	https://picsum.photos/seed/pkg-yogya-food/800/600	\N	\N	\N	\N	\N
41	1	Family Fun Snorkel	A shorter, relaxed snorkeling trip perfect for families with children, focusing on calm and shallow spots.	500000.00	2	8	10:00:00	14:00:00	4	Pelabuhan Waisai, Raja Ampat, Papua Barat	https://www.komodoluxury.com/wp-content/uploads/2024/02/21e0c704-187b-488c-8e8c-038c2fbf7114_11zon.webp	\N	\N	\N	\N	\N
42	2	Sunset Snorkel & BBQ	An afternoon snorkeling trip to Turtle Point, followed by a fresh seafood BBQ on the beach as the sun sets.	350000.00	4	12	15:00:00	19:00:00	4	Public Harbour, Gili Trawangan, Lombok Utara, NTB	https://dynamic-media-cdn.tripadvisor.com/media/photo-o/26/60/e9/51/underwater-statue.jpg?w=1200&h=-1&s=1	\N	\N	\N	\N	\N
43	2	Gili Meno Underwater Statues Trip	A dedicated trip to the famous underwater statues at Gili Meno for incredible photo opportunities.	200000.00	2	15	11:00:00	14:00:00	1	Public Harbour, Gili Trawangan, Lombok Utara, NTB	https://media-cdn.tripadvisor.com/media/attractions-splice-spp-674x446/0b/ea/a8/85.jpg	\N	\N	\N	\N	\N
44	3	Island Camping & Snorkel (3D2N)	An adventurous 3-day, 2-night trip including island hopping, snorkeling, and camping on a remote island.	1200000.00	6	12	08:00:00	16:00:00	5	Pelabuhan Kartini, Jepara, Jawa Tengah (Meeting point for ferry crossing)	https://dynamic-media-cdn.tripadvisor.com/media/photo-o/07/c3/f7/53/sea-adventure-excursions.jpg?w=1200&h=900&s=1	\N	\N	\N	\N	\N
45	4	Discovery Scuba Dive	Not certified? No problem. Try scuba diving for the first time with a professional PADI instructor in the calm waters of Bunaken.	950000.00	1	4	10:00:00	13:00:00	3	Pelabuhan Calaca, Manado, Sulawesi Utara	https://res.cloudinary.com/manawa/image/upload/f_auto,c_limit,w_3840,q_auto/articles/most-beautiful-spots-for-your-first-scuba-dive/61396758347_kwukov	\N	\N	\N	\N	\N
46	5	East & West Penida Full Day Tour	A comprehensive tour covering the best of both sides of Nusa Penida, including Kelingking Beach, Diamond Beach, and snorkeling spots.	850000.00	2	6	08:00:00	17:00:00	4	Pelabuhan Toyapakeh, Nusa Penida, Bali	https://picsum.photos/seed/pkg-east-west-penida/800/600	\N	\N	\N	\N	\N
47	8	PADI Open Water Course	Get your PADI Open Water certification in 3-4 days in the world-class diving environment of Komodo National Park.	6500000.00	1	4	08:00:00	17:00:00	3	Pelabuhan Labuan Bajo, Manggarai Barat, NTT	https://picsum.photos/seed/pkg-padi-owc/800/600	\N	\N	\N	\N	\N
48	10	Sunrise Wreck Dive	Be the first in the water with an early morning dive at the Liberty Wreck, enjoying serene conditions and seeing nocturnal creatures retreat.	700000.00	2	6	06:00:00	08:00:00	3	Meeting Point at Liberty Dive Resort, Tulamben, Karangasem, Bali	https://picsum.photos/seed/pkg-sunrise-wreck/800/600	\N	\N	\N	\N	\N
49	12	Budget Liveaboard (Dorm)	Explore Raja Ampat on a budget-friendly liveaboard with shared dormitory-style cabins.	8000000.00	8	16	11:00:00	14:00:00	1	Pelabuhan Waisai, Raja Ampat, Papua Barat	https://picsum.photos/seed/pkg-liveaboard-dorm/800/600	\N	\N	\N	\N	\N
50	12	Luxury Liveaboard (Private Suite)	Experience Raja Ampat in ultimate comfort on a luxury phinisi with a private suite and gourmet meals.	25000000.00	2	6	11:00:00	14:00:00	1	Pelabuhan Waisai, Raja Ampat, Papua Barat	https://picsum.photos/seed/pkg-liveaboard-luxury/800/600	\N	\N	\N	\N	\N
51	15	Bromo Milky Way & Sunrise Tour	A special tour for photographers, starting earlier to capture the Milky Way over the volcanoes before the classic sunrise.	800000.00	2	5	22:00:00	12:00:00	2	Area Parkir Jeep Cemoro Lawang, Ngadisari, Probolgo, Jawa Timur	https://picsum.photos/seed/pkg-bromo-milkyway/800/600	\N	\N	\N	\N	\N
52	15	Bromo Horse Riding Experience	Explore the Sea of Sand on horseback after sunrise, riding up to the foot of the Bromo crater.	700000.00	2	6	06:00:00	10:00:00	5	Area Parkir Jeep Cemoro Lawang, Ngadisari, Probolgo, Jawa Timur	https://picsum.photos/seed/pkg-bromo-horse/800/600	\N	\N	\N	\N	\N
53	16	Spiritual Cleansing & Rice Paddy Walk	Combine a scenic walk through the rice paddies with a visit to the Tirta Empul temple for a traditional water purification ritual.	550000.00	1	5	08:00:00	13:00:00	2	Meeting Point at Ubud Palace, Jl. Raya Ubud No.8, Ubud, Gianyar, Bali	https://picsum.photos/seed/pkg-ubud-spiritual/800/600	\N	\N	\N	\N	\N
54	17	Village Cycling & Temple Tour	A unique tour combining a visit to Borobudur with a leisurely cycle through the local villages to see traditional life.	650000.00	2	8	07:00:00	16:00:00	5	Titik Nol Kilometer Yogyakarta (Near Central Post Office), Yogyakarta	https://picsum.photos/seed/pkg-temple-cycling/800/600	\N	\N	\N	\N	\N
55	18	Ijen & Baluran National Park Combo	A 2-day tour that combines the Ijen Blue Fire hike with a wildlife safari in Baluran National Park, the "Africa of Java".	1800000.00	2	6	23:00:00	15:00:00	5	Pos Paltuding (Gerbang Masuk Kawah Ijen), Banyuwangi, Jawa Timur	https://picsum.photos/seed/pkg-ijen-baluran/800/600	\N	\N	\N	\N	\N
56	19	Wildlife Photography Trek	A specialized, longer trek with a private ranger focused on finding the best opportunities to photograph Komodo dragons and other wildlife.	750000.00	1	4	08:00:00	14:00:00	2	Pelabuhan Labuan Bajo, Manggarai Barat, NTT	https://picsum.photos/seed/pkg-komodo-photo-trek/800/600	\N	\N	\N	\N	\N
57	20	Batik Making & Silver Smithing Workshop	An immersive cultural experience where you learn to create your own Batik and silver jewelry from local artisans.	450000.00	1	6	09:00:00	15:00:00	2	Titik Nol Kilometer Yogyakarta (Near Central Post Office), Yogyakarta	https://picsum.photos/seed/pkg-yogya-workshop/800/600	\N	\N	\N	\N	\N
58	1	Family Fun Snorkel	A shorter, relaxed snorkeling trip perfect for families with children, focusing on calm and shallow spots.	500000.00	2	8	10:00:00	14:00:00	4	Pelabuhan Waisai, Raja Ampat, Papua Barat	https://www.komodoluxury.com/wp-content/uploads/2024/02/21e0c704-187b-488c-8e8c-038c2fbf7114_11zon.webp	\N	\N	\N	\N	\N
59	2	Sunset Snorkel & BBQ	An afternoon snorkeling trip to Turtle Point, followed by a fresh seafood BBQ on the beach as the sun sets.	350000.00	4	12	15:00:00	19:00:00	4	Public Harbour, Gili Trawangan, Lombok Utara, NTB	https://www.komodoluxury.com/wp-content/uploads/2024/02/21e0c704-187b-488c-8e8c-038c2fbf7114_11zon.webp	\N	\N	\N	\N	\N
60	2	Gili Meno Underwater Statues Trip	A dedicated trip to the famous underwater statues at Gili Meno for incredible photo opportunities.	200000.00	2	15	11:00:00	14:00:00	1	Public Harbour, Gili Trawangan, Lombok Utara, NTB	https://dynamic-media-cdn.tripadvisor.com/media/photo-o/26/60/e9/51/underwater-statue.jpg?w=1200&h=-1&s=1	\N	\N	\N	\N	\N
61	3	Island Camping & Snorkel (3D2N)	An adventurous 3-day, 2-night trip including island hopping, snorkeling, and camping on a remote island.	1200000.00	6	12	08:00:00	16:00:00	5	Pelabuhan Kartini, Jepara, Jawa Tengah (Meeting point for ferry crossing)	https://dynamic-media-cdn.tripadvisor.com/media/photo-o/07/c3/f7/53/sea-adventure-excursions.jpg?w=1200&h=900&s=1	\N	\N	\N	\N	\N
62	4	Discovery Scuba Dive	Not certified? No problem. Try scuba diving for the first time with a professional PADI instructor in the calm waters of Bunaken.	950000.00	1	4	10:00:00	13:00:00	3	Pelabuhan Calaca, Manado, Sulawesi Utara	https://res.cloudinary.com/manawa/image/upload/f_auto,c_limit,w_3840,q_auto/articles/most-beautiful-spots-for-your-first-scuba-dive/61396758347_kwukov	\N	\N	\N	\N	\N
63	5	East & West Penida Full Day Tour	A comprehensive tour covering the best of both sides of Nusa Penida, including Kelingking Beach, Diamond Beach, and snorkeling spots.	850000.00	2	6	08:00:00	17:00:00	4	Pelabuhan Toyapakeh, Nusa Penida, Bali	https://picsum.photos/seed/pkg-east-west-penida/800/600	\N	\N	\N	\N	\N
64	8	PADI Open Water Course	Get your PADI Open Water certification in 3-4 days in the world-class diving environment of Komodo National Park.	6500000.00	1	4	08:00:00	17:00:00	3	Pelabuhan Labuan Bajo, Manggarai Barat, NTT	https://picsum.photos/seed/pkg-padi-owc/800/600	\N	\N	\N	\N	\N
65	10	Sunrise Wreck Dive	Be the first in the water with an early morning dive at the Liberty Wreck, enjoying serene conditions and seeing nocturnal creatures retreat.	700000.00	2	6	06:00:00	08:00:00	3	Meeting Point at Liberty Dive Resort, Tulamben, Karangasem, Bali	https://picsum.photos/seed/pkg-sunrise-wreck/800/600	\N	\N	\N	\N	\N
66	12	Budget Liveaboard (Dorm)	Explore Raja Ampat on a budget-friendly liveaboard with shared dormitory-style cabins.	8000000.00	8	16	11:00:00	14:00:00	1	Pelabuhan Waisai, Raja Ampat, Papua Barat	https://picsum.photos/seed/pkg-liveaboard-dorm/800/600	\N	\N	\N	\N	\N
67	12	Luxury Liveaboard (Private Suite)	Experience Raja Ampat in ultimate comfort on a luxury phinisi with a private suite and gourmet meals.	25000000.00	2	6	11:00:00	14:00:00	1	Pelabuhan Waisai, Raja Ampat, Papua Barat	https://picsum.photos/seed/pkg-liveaboard-luxury/800/600	\N	\N	\N	\N	\N
68	15	Bromo Milky Way & Sunrise Tour	A special tour for photographers, starting earlier to capture the Milky Way over the volcanoes before the classic sunrise.	800000.00	2	5	22:00:00	12:00:00	2	Area Parkir Jeep Cemoro Lawang, Ngadisari, Probolinggo, Jawa Timur	https://picsum.photos/seed/pkg-bromo-milkyway/800/600	\N	\N	\N	\N	\N
69	15	Bromo Horse Riding Experience	Explore the Sea of Sand on horseback after sunrise, riding up to the foot of the Bromo crater.	700000.00	2	6	06:00:00	10:00:00	5	Area Parkir Jeep Cemoro Lawang, Ngadisari, Probolinggo, Jawa Timur	https://picsum.photos/seed/pkg-bromo-horse/800/600	\N	\N	\N	\N	\N
70	16	Spiritual Cleansing & Rice Paddy Walk	Combine a scenic walk through the rice paddies with a visit to the Tirta Empul temple for a traditional water purification ritual.	550000.00	1	5	08:00:00	13:00:00	2	Meeting Point at Ubud Palace, Jl. Raya Ubud No.8, Ubud, Gianyar, Bali	https://picsum.photos/seed/pkg-ubud-spiritual/800/600	\N	\N	\N	\N	\N
71	17	Village Cycling & Temple Tour	A unique tour combining a visit to Borobudur with a leisurely cycle through the local villages to see traditional life.	650000.00	2	8	07:00:00	16:00:00	5	Titik Nol Kilometer Yogyakarta (Near Central Post Office), Yogyakarta	https://picsum.photos/seed/pkg-temple-cycling/800/600	\N	\N	\N	\N	\N
72	18	Ijen & Baluran National Park Combo	A 2-day tour that combines the Ijen Blue Fire hike with a wildlife safari in Baluran National Park, the "Africa of Java".	1800000.00	2	6	23:00:00	15:00:00	5	Pos Paltuding (Gerbang Masuk Kawah Ijen), Banyuwangi, Jawa Timur	https://picsum.photos/seed/pkg-ijen-baluran/800/600	\N	\N	\N	\N	\N
73	19	Wildlife Photography Trek	A specialized, longer trek with a private ranger focused on finding the best opportunities to photograph Komodo dragons and other wildlife.	750000.00	1	4	08:00:00	14:00:00	2	Pelabuhan Labuan Bajo, Manggarai Barat, NTT	https://picsum.photos/seed/pkg-komodo-photo-trek/800/600	\N	\N	\N	\N	\N
74	20	Batik Making & Silver Smithing Workshop	An immersive cultural experience where you learn to create your own Batik and silver jewelry from local artisans.	450000.00	1	6	09:00:00	15:00:00	2	Titik Nol Kilometer Yogyakarta (Near Central Post Office), Yogyakarta	https://picsum.photos/seed/pkg-yogya-workshop/800/600	\N	\N	\N	\N	\N
76	2	Family Fun Snorkel	A shorter, relaxed snorkeling trip perfect for families with children, focusing on calm and shallow spots.	500000.00	2	8	10:00:00	14:00:00	4	Pelabuhan Waisai, Raja Ampat, Papua Barat	https://dynamic-media-cdn.tripadvisor.com/media/photo-o/26/60/e9/51/underwater-statue.jpg?w=1200&h=-1&s=1	\N	\N	\N	\N	\N
77	2	Family Fun Snorkel	A shorter, relaxed snorkeling trip perfect for families with children, focusing on calm and shallow spots.	500000.00	2	8	10:00:00	14:00:00	4	Pelabuhan Waisai, Raja Ampat, Papua Barat	https://www.komodoluxury.com/wp-content/uploads/2024/02/21e0c704-187b-488c-8e8c-038c2fbf7114_11zon.webp	\N	\N	\N	\N	\N
78	2	Family Fun Snorkel	A shorter, relaxed snorkeling trip perfect for families with children, focusing on calm and shallow spots.	500000.00	2	8	10:00:00	14:00:00	4	Pelabuhan Waisai, Raja Ampat, Papua Barat	https://www.komodoluxury.com/wp-content/uploads/2024/02/21e0c704-187b-488c-8e8c-038c2fbf7114_11zon.webp	\N	\N	\N	\N	\N
1	1	Group Package	Snorkeling tour with other groups, includes gear and lunch.	650000.00	4	15	09:00:00	16:00:00	1	Pelabuhan Waisai, Raja Ampat, Papua Barat	https://www.komodoluxury.com/wp-content/uploads/2024/02/21e0c704-187b-488c-8e8c-038c2fbf7114_11zon.webp	\N	\N	\N	\N	\N
\.


--
-- Data for Name: bookings; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY public.bookings (id, user_id, availability_id, participants, total_price, status, created_at, updated_at, deleted_at, activity_package_id, date, planner_id) FROM stdin;
1	580f3947-aa08-417e-9fa5-56ff80cc0689	1	6	3900000.00	Pending	2025-08-19 15:42:33.699075+07	2025-08-19 15:42:33.699075+07	\N	1	2024-08-25 07:00:00+07	\N
2	690a1189-d9ef-4341-9cd0-b6448972a5a1	3	2	300000.00	Confirmed	2025-08-19 15:42:33.699075+07	2025-08-19 15:42:33.699075+07	\N	3	2024-08-27 07:00:00+07	\N
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY public.categories (id, name, description, created_at, updated_at, deleted_at) FROM stdin;
1	Snorkeling	Enjoy exploring shallow reefs and marine life	\N	\N	\N
2	Diving	Go deep to experience wrecks and coral walls	\N	\N	\N
3	Land Exploration	Discover hidden trails and local culture	\N	\N	\N
\.


--
-- Data for Name: destinations; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY public.destinations (id, name, description, image_url, created_at, updated_at, deleted_at, longitude, latitude) FROM stdin;
4	Karimunjawa, Central Java	A chain of 27 islands off the coast of Central Java, a marine national park perfect for island hopping and snorkeling.	https://picsum.photos/seed/dest-karimunjawa/800/600	2025-08-19 19:10:35.868933+07	2025-08-19 19:10:35.868933+07	\N	-5.85	110.45
5	Bunaken, North Sulawesi	A marine park at the heart of the Coral Triangle, featuring spectacular, deep coral walls teeming with fish.	https://picsum.photos/seed/dest-bunaken/800/600	2025-08-19 19:10:35.868933+07	2025-08-19 19:10:35.868933+07	\N	1.65	124.80
6	Wakatobi, Southeast Sulawesi	A world-class diving destination offering some of the most pristine and species-rich reefs on the planet.	https://picsum.photos/seed/dest-wakatobi/800/600	2025-08-19 19:10:35.868933+07	2025-08-19 19:10:35.868933+07	\N	-5.30	123.55
1	Raja Ampat, West Papua	An archipelago of over 1,500 islands, famous for its world-class coral reef biodiversity and pristine marine life.	https://picsum.photos/seed/dest-raja-ampat/800/600	2025-08-19 19:10:35.868933+07	2025-08-19 19:10:35.868933+07	\N	-0.50	130.70
2	Komodo National Park, NTT	A UNESCO World Heritage site, home to the iconic Komodo dragon and offering dramatic landscapes and vibrant dive sites.	https://picsum.photos/seed/dest-komodo/800/600	2025-08-19 19:10:35.868933+07	2025-08-19 19:10:35.868933+07	\N	-8.60	119.50
3	Gili Trawangan, Bali	The largest of the three Gili Islands, known for its vibrant nightlife, beautiful beaches, and excellent snorkeling with sea turtles.	https://picsum.photos/seed/dest-gili-t/800/600	2025-08-19 19:10:35.868933+07	2025-08-19 19:10:35.868933+07	\N	-8.35	116.05
7	Nusa Penida, Bali	A rugged island southeast of Bali, famous for its dramatic coastal cliffs and opportunities to swim with manta rays.	https://picsum.photos/seed/dest-nusa-penida/800/600	2025-08-19 19:10:35.868933+07	2025-08-19 19:10:35.868933+07	\N	-8.72	115.55
8	Tulamben, Bali	A small fishing village on the northeast coast of Bali, renowned for the USAT Liberty shipwreck, a world-famous dive site.	https://picsum.photos/seed/dest-tulamben/800/600	2025-08-19 19:10:35.868933+07	2025-08-19 19:10:35.868933+07	\N	-8.27	115.60
9	Weh Island, Aceh	Located at the northernmost tip of Sumatra, offering a more off-the-beaten-path diving experience with healthy reefs and strong currents.	https://picsum.photos/seed/dest-weh-island/800/600	2025-08-19 19:10:35.868933+07	2025-08-19 19:10:35.868933+07	\N	5.90	95.30
10	Mount Bromo, East Java	An active volcano set in a dramatic sea of sand, famous for its breathtaking sunrise views over a otherworldly landscape.	https://picsum.photos/seed/dest-mount-bromo/800/600	2025-08-19 19:10:35.868933+07	2025-08-19 19:10:35.868933+07	\N	-7.94	112.95
11	Ubud, Bali	Known as the cultural heart of Bali, offering lush green rice paddies, traditional crafts, and a serene, spiritual atmosphere.	https://picsum.photos/seed/dest-ubud/800/600	2025-08-19 19:10:35.868933+07	2025-08-19 19:10:35.868933+07	\N	-8.51	115.27
12	Yogyakarta, DI Yogyakarta	The cultural soul of Java, home to ancient temples like Borobudur and Prambanan, as well as rich Javanese arts.	https://picsum.photos/seed/dest-yogyakarta/800/600	2025-08-19 19:10:35.868933+07	2025-08-19 19:10:35.868933+07	\N	-7.80	110.37
13	Ijen Crater, East Java	A unique volcano featuring the world''s largest acidic crater lake and the mesmerizing "blue fire" phenomenon.	https://picsum.photos/seed/dest-ijen-crater/800/600	2025-08-19 19:10:35.868933+07	2025-08-19 19:10:35.868933+07	\N	-8.06	114.24
14	Thousand Islands, Jakarta	A chain of islands just off the coast of Jakarta, providing a quick tropical getaway for snorkeling and beach relaxation.	https://picsum.photos/seed/dest-thousand-islands/800/600	2025-08-19 19:10:35.868933+07	2025-08-19 19:10:35.868933+07	\N	-5.60	106.55
\.


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY public.groups (id, name, description, session, created_at, updated_at, deleted_at) FROM stdin;
1	General Users	Default group for regular users	session_2024	2025-08-19 15:42:33.683402+07	2025-08-19 15:42:33.683402+07	\N
2	Premium Users	Premium group with special privileges	session_2024	2025-08-19 15:42:33.683402+07	2025-08-19 15:42:33.683402+07	\N
\.


--
-- Data for Name: hosts; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY public.hosts (id, name, bio, profile_image_url, created_at, updated_at, deleted_at, contact) FROM stdin;
3	Indo Dive Pro	A PADI 5-star dive center with a team of certified divemasters and instructors specializing in Indonesia''s top dive sites.	https://picsum.photos/seed/indodive-logo/400/400	\N	\N	\N	\N
4	Bali Eco Ventures	A sustainable tour company based in Bali, committed to eco-friendly practices and authentic snorkeling experiences.	https://picsum.photos/seed/balieco-logo/400/400	\N	\N	\N	\N
5	Nusantara Adventures	A leading tour operator offering diverse adventures across the Indonesian archipelago, from mountain peaks to pristine reefs.	https://picsum.photos/seed/nusantara-logo/400/400	\N	\N	\N	\N
1	Oceanic Odyssey	Experts in marine safaris and liveaboard trips, guiding you to the best snorkeling and diving spots like Komodo and Raja Ampat.	https://picsum.photos/seed/oceanic-logo/400/400	\N	\N	\N	\N
2	Java Land Treks	Specialists in overland tours and volcano trekking on the island of Java, from Bromo to Ijen.	https://picsum.photos/seed/javaland-logo/400/400	\N	\N	\N	\N
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY public.payments (id, booking_id, group_id, payment_method, billing_address, amount, tax, total, status, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY public.reviews (id, activity_id, user_id, group_id, rating, comment, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: tokens; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY public.tokens (id, token, user_uuid, type, expires, blacklisted, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: user_bookings; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY public.user_bookings (id, user_id, booking_id, created_at, updated_at, deleted_at, planner_id, status, email) FROM stdin;
1	580f3947-aa08-417e-9fa5-56ff80cc0689	1	2025-08-19 15:42:33.707622+07	2025-08-19 15:42:33.707622+07	\N	580f3947-aa08-417e-9fa5-56ff80cc0689	Pending	john.doe@example.com
2	690a1189-d9ef-4341-9cd0-b6448972a5a1	2	2025-08-19 15:42:33.707622+07	2025-08-19 15:42:33.707622+07	\N	690a1189-d9ef-4341-9cd0-b6448972a5a1	Confirmed	jane.smith@example.com
3	690a1189-d9ef-4341-9cd0-b6448972a5a1	1	2025-08-19 15:42:33.707+07	2025-08-19 15:42:33.707+07	\N	580f3947-aa08-417e-9fa5-56ff80cc0689	Pending	jane.smith@example.com
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY public.users (id, group_id, name, email, password_hash, created_at, updated_at, deleted_at) FROM stdin;
580f3947-aa08-417e-9fa5-56ff80cc0689	1	John Doe	john.doe@example.com	$2a$08$QOAvTx3JXozDfT02QjR1U.Q84zkGw29.8msRTzaEjV/5C2LHgOEVS	2025-08-19 15:42:33.690889+07	2025-08-19 15:42:33.690889+07	\N
690a1189-d9ef-4341-9cd0-b6448972a5a1	2	Jane Smith	jane.smith@example.com	$2a$08$QOAvTx3JXozDfT02QjR1U.Q84zkGw29.8msRTzaEjV/5C2LHgOEVS	2025-08-19 15:42:33.690889+07	2025-08-19 15:42:33.690889+07	\N
\.


--
-- Name: accessories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('public.accessories_id_seq', 1, false);


--
-- Name: activities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('public.activities_id_seq', 1, false);


--
-- Name: activity_accessories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('public.activity_accessories_id_seq', 1, false);


--
-- Name: activity_availabilities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('public.activity_availabilities_id_seq', 1, false);


--
-- Name: activity_images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('public.activity_images_id_seq', 1, false);


--
-- Name: activity_packages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('public.activity_packages_id_seq', 1, false);


--
-- Name: bookings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('public.bookings_id_seq', 1, false);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('public.categories_id_seq', 1, false);


--
-- Name: destinations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('public.destinations_id_seq', 1, false);


--
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('public.groups_id_seq', 1, false);


--
-- Name: hosts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('public.hosts_id_seq', 1, false);


--
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('public.payments_id_seq', 1, false);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('public.reviews_id_seq', 1, false);


--
-- Name: tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('public.tokens_id_seq', 1, false);


--
-- Name: user_bookings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubuntu
--

SELECT pg_catalog.setval('public.user_bookings_id_seq', 2, true);


--
-- Name: SequelizeMeta SequelizeMeta_pkey; Type: CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public."SequelizeMeta"
    ADD CONSTRAINT "SequelizeMeta_pkey" PRIMARY KEY (name);


--
-- Name: accessories accessories_pkey; Type: CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.accessories
    ADD CONSTRAINT accessories_pkey PRIMARY KEY (id);


--
-- Name: activities activities_pkey; Type: CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_pkey PRIMARY KEY (id);


--
-- Name: activity_accessories activity_accessories_pkey; Type: CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.activity_accessories
    ADD CONSTRAINT activity_accessories_pkey PRIMARY KEY (id);


--
-- Name: activity_availabilities activity_availabilities_pkey; Type: CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.activity_availabilities
    ADD CONSTRAINT activity_availabilities_pkey PRIMARY KEY (id);


--
-- Name: activity_images activity_images_pkey; Type: CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.activity_images
    ADD CONSTRAINT activity_images_pkey PRIMARY KEY (id);


--
-- Name: activity_packages activity_packages_pkey; Type: CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.activity_packages
    ADD CONSTRAINT activity_packages_pkey PRIMARY KEY (id);


--
-- Name: bookings bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: destinations destinations_pkey; Type: CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.destinations
    ADD CONSTRAINT destinations_pkey PRIMARY KEY (id);


--
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: hosts hosts_pkey; Type: CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.hosts
    ADD CONSTRAINT hosts_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: tokens tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_pkey PRIMARY KEY (id);


--
-- Name: user_bookings user_bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.user_bookings
    ADD CONSTRAINT user_bookings_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: activities activities_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: activities activities_destination_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_destination_id_fkey FOREIGN KEY (destination_id) REFERENCES public.destinations(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: activity_accessories activity_accessories_accessory_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.activity_accessories
    ADD CONSTRAINT activity_accessories_accessory_id_fkey FOREIGN KEY (accessory_id) REFERENCES public.accessories(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: activity_accessories activity_accessories_activity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.activity_accessories
    ADD CONSTRAINT activity_accessories_activity_id_fkey FOREIGN KEY (activity_id) REFERENCES public.activities(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: activity_availabilities activity_availabilities_activity_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.activity_availabilities
    ADD CONSTRAINT activity_availabilities_activity_package_id_fkey FOREIGN KEY (activity_package_id) REFERENCES public.activity_packages(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: activity_availabilities activity_availabilities_activity_package_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.activity_availabilities
    ADD CONSTRAINT activity_availabilities_activity_package_id_fkey1 FOREIGN KEY (activity_package_id) REFERENCES public.activities(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: activity_images activity_images_activity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.activity_images
    ADD CONSTRAINT activity_images_activity_id_fkey FOREIGN KEY (activity_id) REFERENCES public.activities(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: activity_packages activity_packages_activity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.activity_packages
    ADD CONSTRAINT activity_packages_activity_id_fkey FOREIGN KEY (activity_id) REFERENCES public.activities(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: activity_packages activity_packages_activity_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.activity_packages
    ADD CONSTRAINT activity_packages_activity_package_id_fkey FOREIGN KEY (activity_package_id) REFERENCES public.bookings(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: activity_packages activity_packages_host_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.activity_packages
    ADD CONSTRAINT activity_packages_host_id_fkey FOREIGN KEY (host_id) REFERENCES public.hosts(id) ON UPDATE CASCADE;


--
-- Name: bookings bookings_activity_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_activity_package_id_fkey FOREIGN KEY (activity_package_id) REFERENCES public.activity_packages(id) ON UPDATE CASCADE;


--
-- Name: bookings bookings_availability_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_availability_id_fkey FOREIGN KEY (availability_id) REFERENCES public.activity_availabilities(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: bookings bookings_planner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_planner_id_fkey FOREIGN KEY (planner_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: bookings bookings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: payments payments_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.bookings(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: payments payments_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.groups(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: reviews reviews_activity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_activity_id_fkey FOREIGN KEY (activity_id) REFERENCES public.activities(id);


--
-- Name: reviews reviews_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.groups(id);


--
-- Name: reviews reviews_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: user_bookings user_bookings_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.user_bookings
    ADD CONSTRAINT user_bookings_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.bookings(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_bookings user_bookings_planner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.user_bookings
    ADD CONSTRAINT user_bookings_planner_id_fkey FOREIGN KEY (planner_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_bookings user_bookings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.user_bookings
    ADD CONSTRAINT user_bookings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users users_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubuntu
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.groups(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

