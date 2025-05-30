PGDMP  5    1                }            medical    15.8    17.0 N    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            �           1262    24647    medical    DATABASE     �   CREATE DATABASE medical WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE medical;
                     login    false            }           1247    25238    Day    TYPE     �   CREATE TYPE public."Day" AS ENUM (
    'MONDAY',
    'TUESDAY',
    'WEDNESDAY',
    'THURSDAY',
    'FRIDAY',
    'SATURDAY',
    'SUNDAY'
);
    DROP TYPE public."Day";
       public               login    false            z           1247    25210 
   Department    TYPE     #  CREATE TYPE public."Department" AS ENUM (
    'COMPUTER_SCIENCE',
    'ELECTRICAL',
    'MECHANICAL',
    'MATHEMATICS_COMPUTING',
    'CHEMICAL',
    'CIVIL',
    'METALLURGY',
    'ENGINEERING_PHYSICS',
    'PHYSICS',
    'CHEMISTRY',
    'BIOLOGY',
    'MATHEMATICS',
    'HUMANITIES'
);
    DROP TYPE public."Department";
       public               login    false            �           1247    25282    DoctorDepartment    TYPE     u   CREATE TYPE public."DoctorDepartment" AS ENUM (
    'AYURVEDIC',
    'GYNECOLOGY',
    'HOMEOPATHY',
    'OTHERS'
);
 %   DROP TYPE public."DoctorDepartment";
       public               login    false            b           1247    25090    Gender    TYPE     B   CREATE TYPE public."Gender" AS ENUM (
    'MALE',
    'FEMALE'
);
    DROP TYPE public."Gender";
       public               login    false            _           1247    25080    PatientCategory    TYPE     k   CREATE TYPE public."PatientCategory" AS ENUM (
    'STUDENT',
    'FACULTY',
    'STAFF',
    'VISITOR'
);
 $   DROP TYPE public."PatientCategory";
       public               login    false            �           1247    25262    Program    TYPE     a   CREATE TYPE public."Program" AS ENUM (
    'BTECH',
    'MTECH',
    'PHD',
    'DUAL_DEGREE'
);
    DROP TYPE public."Program";
       public               login    false            e           1247    25096    Role    TYPE     G   CREATE TYPE public."Role" AS ENUM (
    'DOCTOR',
    'PARAMEDICAL'
);
    DROP TYPE public."Role";
       public               login    false            �           1247    25254    Shift    TYPE     T   CREATE TYPE public."Shift" AS ENUM (
    'MORNING',
    'AFTERNOON',
    'NIGHT'
);
    DROP TYPE public."Shift";
       public               login    false            �           1247    25376    Status    TYPE     F   CREATE TYPE public."Status" AS ENUM (
    'ACTIVE',
    'INACTIVE'
);
    DROP TYPE public."Status";
       public               login    false            �           1247    25272    UserRole    TYPE     g   CREATE TYPE public."UserRole" AS ENUM (
    'DOCTOR',
    'PATIENT',
    'ADMIN',
    'PARAMEDICAL'
);
    DROP TYPE public."UserRole";
       public               login    false            �            1259    25330    Verification    TABLE     �   CREATE TABLE public."Verification" (
    id text NOT NULL,
    email text NOT NULL,
    otp text NOT NULL,
    "expiryTime" timestamp(3) without time zone NOT NULL
);
 "   DROP TABLE public."Verification";
       public         heap r       login    false            �            1259    25015    _prisma_migrations    TABLE     �  CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);
 &   DROP TABLE public._prisma_migrations;
       public         heap r       login    false            �            1259    25129    category    TABLE     �   CREATE TABLE public.category (
    id text NOT NULL,
    "categoryName" text NOT NULL,
    "strengthType" text NOT NULL,
    status public."Status" DEFAULT 'ACTIVE'::public."Status" NOT NULL
);
    DROP TABLE public.category;
       public         heap r       login    false    923    923            �            1259    25143    checkup    TABLE     �  CREATE TABLE public.checkup (
    id text NOT NULL,
    "patientId" text NOT NULL,
    temperature double precision,
    date timestamp(3) without time zone NOT NULL,
    "bloodPressure" text,
    symptoms text,
    "doctorId" text,
    "staffId" text NOT NULL,
    diagnosis text NOT NULL,
    "pulseRate" integer,
    "spO2" double precision,
    "referredDoctor" text,
    "referredHospital" text
);
    DROP TABLE public.checkup;
       public         heap r       login    false            �            1259    25357    checkupMedicine    TABLE     �   CREATE TABLE public."checkupMedicine" (
    id text NOT NULL,
    "medicineId" text NOT NULL,
    dosage text,
    "checkupId" text NOT NULL,
    quantity integer NOT NULL
);
 %   DROP TABLE public."checkupMedicine";
       public         heap r       login    false            �            1259    25108    medicine    TABLE     �   CREATE TABLE public.medicine (
    id text NOT NULL,
    "brandName" text NOT NULL,
    "saltName" text NOT NULL,
    "categoryId" text NOT NULL,
    status public."Status" DEFAULT 'ACTIVE'::public."Status" NOT NULL
);
    DROP TABLE public.medicine;
       public         heap r       login    false    923    923            �            1259    25136    patient    TABLE     �  CREATE TABLE public.patient (
    id text NOT NULL,
    name text NOT NULL,
    age integer NOT NULL,
    email text NOT NULL,
    "bloodGroup" text NOT NULL,
    "fatherOrSpouseName" text,
    category public."PatientCategory" NOT NULL,
    gender public."Gender" NOT NULL,
    allergy text,
    department public."Department",
    program public."Program",
    status public."Status" DEFAULT 'ACTIVE'::public."Status" NOT NULL
);
    DROP TABLE public.patient;
       public         heap r       login    false    923    863    899    923    890    866            �            1259    25061    purchase    TABLE     !  CREATE TABLE public.purchase (
    id text NOT NULL,
    "batchNo" bigint NOT NULL,
    "expiryDate" timestamp(3) without time zone NOT NULL,
    "medicineId" text NOT NULL,
    "mfgDate" timestamp(3) without time zone,
    "purchaseListId" text NOT NULL,
    quantity integer NOT NULL
);
    DROP TABLE public.purchase;
       public         heap r       login    false            �            1259    25122    purchaseList    TABLE     �   CREATE TABLE public."purchaseList" (
    id text NOT NULL,
    "supplierId" text NOT NULL,
    "purchaseDate" timestamp(3) without time zone NOT NULL,
    "Details" text,
    "invoiceNo" bigint NOT NULL
);
 "   DROP TABLE public."purchaseList";
       public         heap r       login    false            �            1259    25339    requests    TABLE     �   CREATE TABLE public.requests (
    id text NOT NULL,
    email text NOT NULL,
    name text NOT NULL,
    role public."UserRole" NOT NULL
);
    DROP TABLE public.requests;
       public         heap r       login    false    902            �            1259    25317    schedule    TABLE     �   CREATE TABLE public.schedule (
    id text NOT NULL,
    "staffId" text NOT NULL,
    shift public."Shift" NOT NULL,
    day public."Day" NOT NULL
);
    DROP TABLE public.schedule;
       public         heap r       login    false    896    893            �            1259    25047    staff    TABLE     5  CREATE TABLE public.staff (
    id text NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    role public."Role" NOT NULL,
    gender public."Gender" NOT NULL,
    department text,
    "mobileNumber" text,
    status public."Status" DEFAULT 'ACTIVE'::public."Status" NOT NULL,
    speciality text
);
    DROP TABLE public.staff;
       public         heap r       login    false    923    923    866    869            �            1259    25054    stock    TABLE     �   CREATE TABLE public.stock (
    id text NOT NULL,
    "medicineId" text NOT NULL,
    "inQuantity" integer NOT NULL,
    "outQuantity" integer NOT NULL,
    stock integer NOT NULL
);
    DROP TABLE public.stock;
       public         heap r       login    false            �            1259    25115    supplier    TABLE     "  CREATE TABLE public.supplier (
    id text NOT NULL,
    name text NOT NULL,
    address text NOT NULL,
    city text,
    state text NOT NULL,
    "mobileNumber" text NOT NULL,
    email text,
    "pinCode" integer,
    status public."Status" DEFAULT 'ACTIVE'::public."Status" NOT NULL
);
    DROP TABLE public.supplier;
       public         heap r       login    false    923    923            �            1259    25310    user    TABLE     �   CREATE TABLE public."user" (
    id text NOT NULL,
    email text NOT NULL,
    role public."UserRole" NOT NULL,
    name text NOT NULL,
    status public."Status" DEFAULT 'ACTIVE'::public."Status" NOT NULL
);
    DROP TABLE public."user";
       public         heap r       login    false    923    923    902            �          0    25330    Verification 
   TABLE DATA           F   COPY public."Verification" (id, email, otp, "expiryTime") FROM stdin;
    public               login    false    226   �c       �          0    25015    _prisma_migrations 
   TABLE DATA           �   COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
    public               login    false    214   �c       �          0    25129    category 
   TABLE DATA           N   COPY public.category (id, "categoryName", "strengthType", status) FROM stdin;
    public               login    false    221   �k       �          0    25143    checkup 
   TABLE DATA           �   COPY public.checkup (id, "patientId", temperature, date, "bloodPressure", symptoms, "doctorId", "staffId", diagnosis, "pulseRate", "spO2", "referredDoctor", "referredHospital") FROM stdin;
    public               login    false    223   �l       �          0    25357    checkupMedicine 
   TABLE DATA           \   COPY public."checkupMedicine" (id, "medicineId", dosage, "checkupId", quantity) FROM stdin;
    public               login    false    228   �o       �          0    25108    medicine 
   TABLE DATA           U   COPY public.medicine (id, "brandName", "saltName", "categoryId", status) FROM stdin;
    public               login    false    218   �q       �          0    25136    patient 
   TABLE DATA           �   COPY public.patient (id, name, age, email, "bloodGroup", "fatherOrSpouseName", category, gender, allergy, department, program, status) FROM stdin;
    public               login    false    222   �s       �          0    25061    purchase 
   TABLE DATA           t   COPY public.purchase (id, "batchNo", "expiryDate", "medicineId", "mfgDate", "purchaseListId", quantity) FROM stdin;
    public               login    false    217   �u       �          0    25122    purchaseList 
   TABLE DATA           b   COPY public."purchaseList" (id, "supplierId", "purchaseDate", "Details", "invoiceNo") FROM stdin;
    public               login    false    220   nv       �          0    25339    requests 
   TABLE DATA           9   COPY public.requests (id, email, name, role) FROM stdin;
    public               login    false    227   w       �          0    25317    schedule 
   TABLE DATA           =   COPY public.schedule (id, "staffId", shift, day) FROM stdin;
    public               login    false    225   )w       �          0    25047    staff 
   TABLE DATA           n   COPY public.staff (id, name, email, role, gender, department, "mobileNumber", status, speciality) FROM stdin;
    public               login    false    215   Lx       �          0    25054    stock 
   TABLE DATA           U   COPY public.stock (id, "medicineId", "inQuantity", "outQuantity", stock) FROM stdin;
    public               login    false    216   fy       �          0    25115    supplier 
   TABLE DATA           l   COPY public.supplier (id, name, address, city, state, "mobileNumber", email, "pinCode", status) FROM stdin;
    public               login    false    219   Tz       �          0    25310    user 
   TABLE DATA           ?   COPY public."user" (id, email, role, name, status) FROM stdin;
    public               login    false    224   F{       �           2606    25336    Verification Verification_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."Verification"
    ADD CONSTRAINT "Verification_pkey" PRIMARY KEY (id);
 L   ALTER TABLE ONLY public."Verification" DROP CONSTRAINT "Verification_pkey";
       public                 login    false    226            �           2606    25023 *   _prisma_migrations _prisma_migrations_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public._prisma_migrations DROP CONSTRAINT _prisma_migrations_pkey;
       public                 login    false    214            �           2606    25135    category category_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.category DROP CONSTRAINT category_pkey;
       public                 login    false    221            �           2606    25363 $   checkupMedicine checkupMedicine_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public."checkupMedicine"
    ADD CONSTRAINT "checkupMedicine_pkey" PRIMARY KEY (id);
 R   ALTER TABLE ONLY public."checkupMedicine" DROP CONSTRAINT "checkupMedicine_pkey";
       public                 login    false    228            �           2606    25149    checkup checkup_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.checkup
    ADD CONSTRAINT checkup_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.checkup DROP CONSTRAINT checkup_pkey;
       public                 login    false    223            �           2606    25114    medicine medicine_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.medicine
    ADD CONSTRAINT medicine_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.medicine DROP CONSTRAINT medicine_pkey;
       public                 login    false    218            �           2606    25142    patient patient_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.patient DROP CONSTRAINT patient_pkey;
       public                 login    false    222            �           2606    25128    purchaseList purchaseList_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."purchaseList"
    ADD CONSTRAINT "purchaseList_pkey" PRIMARY KEY (id);
 L   ALTER TABLE ONLY public."purchaseList" DROP CONSTRAINT "purchaseList_pkey";
       public                 login    false    220            �           2606    25067    purchase purchase_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT purchase_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.purchase DROP CONSTRAINT purchase_pkey;
       public                 login    false    217            �           2606    25345    requests requests_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.requests
    ADD CONSTRAINT requests_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.requests DROP CONSTRAINT requests_pkey;
       public                 login    false    227            �           2606    25323    schedule schedule_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.schedule DROP CONSTRAINT schedule_pkey;
       public                 login    false    225            �           2606    25053    staff staff_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.staff DROP CONSTRAINT staff_pkey;
       public                 login    false    215            �           2606    25060    stock stock_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.stock
    ADD CONSTRAINT stock_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.stock DROP CONSTRAINT stock_pkey;
       public                 login    false    216            �           2606    25121    supplier supplier_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT supplier_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.supplier DROP CONSTRAINT supplier_pkey;
       public                 login    false    219            �           2606    25316    user user_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public."user" DROP CONSTRAINT user_pkey;
       public                 login    false    224            �           1259    25338    Verification_email_key    INDEX     [   CREATE UNIQUE INDEX "Verification_email_key" ON public."Verification" USING btree (email);
 ,   DROP INDEX public."Verification_email_key";
       public                 login    false    226            �           1259    25156    patient_email_key    INDEX     M   CREATE UNIQUE INDEX patient_email_key ON public.patient USING btree (email);
 %   DROP INDEX public.patient_email_key;
       public                 login    false    222            �           1259    25374    purchaseList_invoiceNo_key    INDEX     e   CREATE UNIQUE INDEX "purchaseList_invoiceNo_key" ON public."purchaseList" USING btree ("invoiceNo");
 0   DROP INDEX public."purchaseList_invoiceNo_key";
       public                 login    false    220            �           1259    25347    purchase_batchNo_key    INDEX     W   CREATE UNIQUE INDEX "purchase_batchNo_key" ON public.purchase USING btree ("batchNo");
 *   DROP INDEX public."purchase_batchNo_key";
       public                 login    false    217            �           1259    25346    requests_email_key    INDEX     O   CREATE UNIQUE INDEX requests_email_key ON public.requests USING btree (email);
 &   DROP INDEX public.requests_email_key;
       public                 login    false    227            �           1259    25068    staff_email_key    INDEX     I   CREATE UNIQUE INDEX staff_email_key ON public.staff USING btree (email);
 #   DROP INDEX public.staff_email_key;
       public                 login    false    215            �           1259    25388    supplier_mobileNumber_key    INDEX     a   CREATE UNIQUE INDEX "supplier_mobileNumber_key" ON public.supplier USING btree ("mobileNumber");
 /   DROP INDEX public."supplier_mobileNumber_key";
       public                 login    false    219            �           1259    25329    user_email_key    INDEX     I   CREATE UNIQUE INDEX user_email_key ON public."user" USING btree (email);
 "   DROP INDEX public.user_email_key;
       public                 login    false    224            �           2606    25369 .   checkupMedicine checkupMedicine_checkupId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."checkupMedicine"
    ADD CONSTRAINT "checkupMedicine_checkupId_fkey" FOREIGN KEY ("checkupId") REFERENCES public.checkup(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 \   ALTER TABLE ONLY public."checkupMedicine" DROP CONSTRAINT "checkupMedicine_checkupId_fkey";
       public               login    false    223    3290    228            �           2606    25364 /   checkupMedicine checkupMedicine_medicineId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."checkupMedicine"
    ADD CONSTRAINT "checkupMedicine_medicineId_fkey" FOREIGN KEY ("medicineId") REFERENCES public.medicine(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 ]   ALTER TABLE ONLY public."checkupMedicine" DROP CONSTRAINT "checkupMedicine_medicineId_fkey";
       public               login    false    228    218    3277            �           2606    25189    checkup checkup_doctorId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.checkup
    ADD CONSTRAINT "checkup_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES public.staff(id) ON UPDATE CASCADE ON DELETE SET NULL;
 I   ALTER TABLE ONLY public.checkup DROP CONSTRAINT "checkup_doctorId_fkey";
       public               login    false    215    3270    223            �           2606    25184    checkup checkup_patientId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.checkup
    ADD CONSTRAINT "checkup_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public.patient(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 J   ALTER TABLE ONLY public.checkup DROP CONSTRAINT "checkup_patientId_fkey";
       public               login    false    223    222    3288            �           2606    25194    checkup checkup_staffId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.checkup
    ADD CONSTRAINT "checkup_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public.staff(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 H   ALTER TABLE ONLY public.checkup DROP CONSTRAINT "checkup_staffId_fkey";
       public               login    false    3270    223    215            �           2606    25159 !   medicine medicine_categoryId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.medicine
    ADD CONSTRAINT "medicine_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES public.category(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 M   ALTER TABLE ONLY public.medicine DROP CONSTRAINT "medicine_categoryId_fkey";
       public               login    false    218    221    3285            �           2606    25169 )   purchaseList purchaseList_supplierId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."purchaseList"
    ADD CONSTRAINT "purchaseList_supplierId_fkey" FOREIGN KEY ("supplierId") REFERENCES public.supplier(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 W   ALTER TABLE ONLY public."purchaseList" DROP CONSTRAINT "purchaseList_supplierId_fkey";
       public               login    false    219    3280    220            �           2606    25174 !   purchase purchase_medicineId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT "purchase_medicineId_fkey" FOREIGN KEY ("medicineId") REFERENCES public.medicine(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 M   ALTER TABLE ONLY public.purchase DROP CONSTRAINT "purchase_medicineId_fkey";
       public               login    false    218    217    3277            �           2606    25179 %   purchase purchase_purchaseListId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT "purchase_purchaseListId_fkey" FOREIGN KEY ("purchaseListId") REFERENCES public."purchaseList"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 Q   ALTER TABLE ONLY public.purchase DROP CONSTRAINT "purchase_purchaseListId_fkey";
       public               login    false    217    220    3283            �           2606    25324    schedule schedule_staffId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT "schedule_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public.staff(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 J   ALTER TABLE ONLY public.schedule DROP CONSTRAINT "schedule_staffId_fkey";
       public               login    false    225    215    3270            �           2606    25164    stock stock_medicineId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.stock
    ADD CONSTRAINT "stock_medicineId_fkey" FOREIGN KEY ("medicineId") REFERENCES public.medicine(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 G   ALTER TABLE ONLY public.stock DROP CONSTRAINT "stock_medicineId_fkey";
       public               login    false    216    218    3277            �      x������ � �      �   �  x��W�R\9|nžoȡ*�t�G�LDGIU��XhXh���<�i0�a&�7܇�R���K�\�
M��l��V|�:�Jy�9���h͈g꽤n����\#�ٲ\hU��:���*��EV�qd	��?H�}��e���Q���}�c��:I�������w��k���w������$�5x,�A�C��ekQG��ˮ��<N�3E�2���7����RG7�be� dF}�x����̓�����q��W3������1�����W� �u��'du����F�@&#�Z+���2js���JS�i-1�1���m-��yF�dj�}�Zw�F�UJO���� ��A�Q�.�i�3Yz*gf*.=C[��<b�;��,��gL�wm�ҋ�l-���YՔ�T�S*-�,MR�eZ�x�CǌDo����Kf���"���p��3z��o���Iw��N�������Ú��y��?C͹wNQ���s$[If�3uEJ1���ȭ��J���4���� ��B%��]��qz��ݭ�|�p�Ox��6�*�<�j�K0�&w-�a�I|
�:d�(I�i�d��m<��!��{(EhN)^�zg�Z̯�(3����˫��hz<�_z:\o����r}s������mܸ>��yQÑ�����'ȋ�¹yq�XٵQ��Rl?���J���c�6��k�\r�䍠�m�(F�no�q��c�呼K�ޏ�+���x:��\�����	�T�YmޗO��e�|�`5�@c1w`ι���6�g�X0zbU�2�t�T�p���E�S�9~� i��+����@�N�{=���w}������t�=����H��3 "��X��aI<%�q7��#�$�qK���8�l\������r�h��S��{L�ZZ�`�{284���.�w������'9�PA`8\FqH�����F�;dU+�ؚ	��&��,l�,�2r�Hs��r��f������I*��J"Ad�G�ܟ~\��j�����K����Ƥ�v��a�e\�=��4�Y���.Ȇ5a�M����}�`&�H��䱮�Ff��7�k����fP�J���s
��&o�{�'HkP���5E6O�+��$M�$��]�����L�]z^��a�\*�)+a�xt\��y8e	E����F���oD"��.�P|�R�)�	=���z�j�L���}�֭p��b�kjh^����%o�+�T��4�t�+�*��cR+��0(��j#[�k��b���� /1�+���y���5h���6&JPo	8	"��m�SQM0[�h���P!J��b�Y+z(W8i���P6є�B^5���Ҩ�Lb�/#�\ /��ݵ����i~���~�h�mIhmՀ��f�f=�"<��p@�3#1#^Y`�[��+�1�1t��gB(��n�PS�4{��IE/��4�3_�`
�!IE�g���ɂMd@�f�
R3��+�z�(>I�P*g��㰣"�PDF�M�3��j�]j>g/<�}� (�TflhR7G&�����k��DMT�5$UA-[e�Qm;΀�w�z�����hm����u��b����5L���Ru$Z�i^�E�QD��F���k-Ða��Ϸ����f����R��dH�809�.p�~5�>b��D�����:E��df��b�yՈ���ѹ��آ���"b��w��:�:I�"������;˃_؇#���l�1�*#z�p�i�B�!A�cB3�]CW,0�T����1�>��fQ��)�ڂ�%r̡6�3'3��W���b�lP�C�W�p៣�#;��+��8�2"�X@�u k�V7١;`�I`�+�f��k���ؖj�2��D�A�0{����X>�2�T��=%�6H��h���yЋ���}�[�͍�?S�;��Ha���Z��� ��m��8�} b��E�Y|A�l{u���Glw�������:��3�6�`����˗/�.���      �   �   x�u�1k�0F�����EV9S��iL�.�tId�HJ!���Ph]����=�y�&���~bLПa����K�8����2�	��3�#fLl������IO.˺�)]#����p���#��6d'�ft.�����.@]�Ô1w��F=�����}���dmcy�Kc[Q�y��b^�jVK)�<UV���v�V;8Gݧ��(�/�Mi�      �     x���Mo7���_�? ���(Js �^Z���>kM6��i�__�ڨ��������އ/?�z�N�J)��&�6���>�q.�%:�$��ѯ�W���%y�n|wo�7���n��e��+6y"���E��>0��Zi*&%�ͽ2��;�L6M�j��ۻ���ߩlB�}�՞�[�ɵYg�8�Bҧ�A��d�)�C�z��L�E>�|q�����|sw*�7�vz���5ͬ� s�@:!qT����D̙��~�{|�i�v�=}r���Kzƨ=�����-�X �@fD?K��>L�o,�5�UdI�f�n����]�͡�H|��<z�d�q�B�Ig�1LxN�F��j�^Y�Hk�+�"���.���6;�@�1p��A
�j,��B�f��4%�v���w���zZ��Ɩ�+�q)t{�NF���]�[}6�������LA��H4����±ep���a��S;���������F����7,<c�PK�\:��3j�
����wH6ψ&1ڟ��yC*�j���uGl&���~��@b���h(��q%]��BQ�ɰ�O6�\? E��8�����`�N8�N����z@>bZ�Ò}�>YC^����Z�kQIYP�yb(^l=��pm�.ḓY�>�E�#ٸ*h&bJ}4���mFJۼ
1_l����|�xō���﯏�#.ɥ��z�0E���#�fc�;o0���w�e�uM�U&.�)q۳K����Kyў$�Ol��ڡ�V[t-���l��"-㸒m��y%rW��C��������/U�4      �   �  x�-�˱�0E�v/d@��H*x���'YzFs.�㴬5Ia$���0j��z~#�C�D.���^r���a9��|�ͨ2�t���{��28�*���?����-�$�
�(`Z�p\߭��.���iO����'��M"/���!��겲8�h4�(l9	�j6�?}}r�U��*����18V�?�zh>�$ُ֬�Z������ڃ��'�.�l7Ty����h��ͱ?�>����Y+�íOH�ʲ����{�S$�Pn�T��sْ��\���;�8�:C�{i_�d��A�������1��C�3�T��`v��1�+��S�UtQE�3!V�ܤ�Y��v_��F��	���{�P��ځ6T]Ŷ:���~������%3Q/�>�j�m�٣g�'敽���Q?��5��;Vާ��?/6�v'ߋ�3�Zd����x���H�x�~�'�uM�',��#�I����؋zh�?����J�
      �     x�uTM��0=O~���o��]�i��jO�8�Y,�l�
����f����yo���(��D4�ܒ^I� 5v|�Ƨ�������1�����VP��"��R�����u�d4��`^� a
�U�N�~�^��� ��ib��(�#��Ү�_Y�N*-�"I�$�o�mɰ��,1FL�'g�\��y�jݠ���ڌB���ffi�t�hN��C#|�.��.�oO[�A]f:S�P���Qy��8�/R���km��B���%/.�o�pp����X���K�\A���O���@k�S��R�d��_�n�|=7��9Ǎ���;K^��O��?G��~�|�da#��{o��Y�`~�ޟ���TΨd!�,6Yi4�:�\��
�k#QAm�~%ƒ��BA�I�F�#I��L���$�,��;h����gd�
ӕxH������r���ˢ�l�>�s��%UX��+�r��2!U#����㠌0�2V���Bʪ$����a�YQ�h���>�v���lr�      �   �  x����n�0���U����#�a@�*�R�J�}ma TL�y�qB����"�q��c�A�� $Fp8�)�G�ٟ��_ƿ��=dx:�	��y�o����,�E����a�ԏ��j^���L�����j�O���EN#0��8X���9Jü.9�]���%��3�͵�����Y�ڎ�	��֦��׫���N?���ZZf �$*�Fp2h�ԩ�FY��k�O����=��������~��D���A��rhXԌ3��@���n��#>D2-���y&��S�^�U�8��y��bT*�J�1�(D �EZyY`�J��R�JLπYC:��b��M�f4,"OW�%)���z	A)���3���/Z��N>2,��k�˔W����Q�qF��9��:@4��@�U�H�]7@�:�G�?{h1\ӻ������z)�1�5�� ����L%�
SCN�[xg"���x�Y��kqUJ-M������mh/�h4��B�f      �   �   x�M��M1����*h`��k�6=�/I������{���b�X�z�#�Qi��U���&�C(^�|#?�w|��7��M���j�R�ж9oaO���:"�H���1��Wuq����?��?ޞ����W�I�]ݠf��4x��f)���~��7Q(8p      �   �   x�]ι1D�X����)�.�l����pb����4����@��us܌-�ʎ�C2`tqP[C`۲�-��F6@���r�a���[�f77��4�ك�R<��я �������f��&��п��Yk� f.�      �      x������ � �      �     x���=n�0��پ�"Ei�ߡ�8(
t%��G���\�{3u��;d�T�B�X��Bќ��2i1����
��M!ױ��<�_�岜���~9����9��N�AC�@�$������W��ٻ�vX��u�����c.���m@����#D�H�i����}��]Bu�`�c�R��� ���OQ��#�hy�k ���s¤���E�������ӈ�<2I���`����O����t��ab�."CHNF�:V[��(�˭�W��˃�z���d6��      �   
  x����j�0���S��h��V��$��:�P(���6Iq�>ݴ�
���i��Ğ8GHA+.��2XI�pA�^��pyJ*�.���0\�ױ�Nb����Nl�u+�ݦ���~�(����W�*�QF:�t���h
��QE[n��1oarKR�����:��b��M�X͛�mB����kM��GL�}A��x2,��=Z#N�8\÷�h��F
c�U,�]�-�.�B@e�a�K����iH�7�}����xT��e��������n�      �   �   x�=�An�0��c
I���{�k���r��0���)�1�Av([��7b���B#��=Z�����[6.*�@�4��	�n���I��]��t��7p+7�O���w��y����chg�,�X*�)HL`�ޠY�ILK�)�q�K1�������Dt����B�v�*`�jk�Z��8�ho�Qh�,�]Q,����g�Qf�>n�d����\�?�u���N�      �   �   x�m��j�0���S��`Yvb�2����v�l�qi���￤]�!��>��g+��NY�D�Ie���6dB�%�P�e]μ>��󑥆8�ʁ��#@Cֵ�z_��S�	�j��_��>^��$<�2]��&3(�&�R6�ܡw����u.����#��uY��7g��&�%E�t�U"��D���QyI��Z֭ K�S�s��M����޳�S�?Ѓ��TU�M^x      �   �  x�u��r1���S����7��L�t2LO�ȶ\��%Ch��5�eH�V����'m��x���O|<2M�n�~��w��k���׫��I􄚊�7E9$`��+���Dn�{�}��W���);R��<z�l�I *��Bf
6�J�A��^c�������rh9��p���W:��_Y<����o~�5��`��j���N:61'Ʉ�j�}�|���QN	- ڮ����$$�e*�p�f����φ��+���Q�������@� ���]0I�s?��c%���2o�H*F�E+H�O����I��#4Pq�Y�|�12S���EIj?���)�H�\�ʩ@�\�qd%��^��r
UK�<��|���/��b��z��!���"����f��B�����#�s6�.�1�52RMaː����L�"G9Lϱ��
:gF�>/ҁwV+t��S�K�������/w�     