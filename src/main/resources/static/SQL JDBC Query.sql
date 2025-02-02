create table users(username varchar(50) not null primary key,password varchar(500) not null,enabled boolean not null);
create table authorities (username varchar(50) not null,authority varchar(50) not null,constraint fk_authorities_users foreign key(username) references users(username));
create unique index ix_auth_username on authorities (username,authority);

CREATE TABLE customer (
  id int GENERATED ALWAYS AS IDENTITY,
  email varchar(45) NOT NULL,
  pwd varchar(200) NOT NULL,
  role varchar(45) NOT NULL,
  PRIMARY KEY (id)
);


INSERT  INTO customer (email, pwd, role) VALUES ('happy@example.com', '{noop}EazyBytes@12345', 'read');
INSERT  INTO customer (email, pwd, role) VALUES ('admin@example.com', '{bcrypt}$2a$12$88.f6upbBvy0okEa7OfHFuorV29qeK.sVbB9VQ6J6dWM1bW6Qef8m', 'admin');



starting from section 8

drop table customer;

CREATE TABLE customer (
    customer_id int NOT NULL GENERATED ALWAYS AS IDENTITY,
    name varchar(100) NOT NULL,
    email varchar(100) NOT NULL,
    mobile_number varchar(20) NOT NULL,
    pwd varchar(500) NOT NULL,
    role varchar(100) NOT NULL,
    create_dt date DEFAULT NULL,
    PRIMARY KEY (customer_id)
);

INSERT INTO customer (name,email,mobile_number, pwd, role,create_dt)
 VALUES ('Happy','happy@example.com','5334122365', '{bcrypt}$2a$12$88.f6upbBvy0okEa7OfHFuorV29qeK.sVbB9VQ6J6dWM1bW6Qef8m', 'admin',CURRENT_DATE);

 CREATE TABLE accounts (
   	customer_id int NOT NULL,
    account_number int NOT NULL,
   	account_type varchar(100) NOT NULL,
   	branch_address varchar(200) NOT NULL,
   	create_dt date DEFAULT NULL,
   	PRIMARY KEY (account_number),
   	CONSTRAINT customer_ibfk_1 FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE CASCADE
 );

 INSERT INTO accounts (customer_id, account_number, account_type, branch_address, create_dt)
  VALUES (1, 1865764534, 'Savings', '123 Main Street, New York', CURRENT_DATE);


CREATE TABLE account_transactions (
  transaction_id varchar(200) NOT NULL,
  account_number int NOT NULL,
  customer_id int NOT NULL,
  transaction_dt date NOT NULL,
  transaction_summary varchar(200) NOT NULL,
  transaction_type varchar(100) NOT NULL,
  transaction_amt int NOT NULL,
  closing_balance int NOT NULL,
  create_dt date DEFAULT NULL,
  PRIMARY KEY (transaction_id),
  CONSTRAINT accounts_ibfk_2 FOREIGN KEY (account_number) REFERENCES accounts (account_number) ON DELETE CASCADE,
  CONSTRAINT acct_user_ibfk_1 FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE CASCADE
);


INSERT INTO account_transactions (transaction_id, account_number, customer_id, transaction_dt, transaction_summary, transaction_type,transaction_amt,
closing_balance, create_dt)  VALUES ('6d9580bc-7a26-421e-8973-0b1af7f37ee7', 1865764534, 1, CURRENT_DATE - INTERVAL '7 DAY', 'Coffee Shop', 'Withdrawal', 30,34500, CURRENT_DATE-INTERVAL '7 DAY');

INSERT INTO account_transactions (transaction_id, account_number, customer_id, transaction_dt, transaction_summary, transaction_type,transaction_amt,
closing_balance, create_dt)   VALUES ('448f9753-f931-41df-9af8-6dc7ab5a88b2', 1865764534, 1, CURRENT_DATE - INTERVAL '6 DAY', 'Uber', 'Withdrawal', 100,34400,CURRENT_DATE - INTERVAL '6 DAY');

INSERT INTO account_transactions (transaction_id, account_number, customer_id, transaction_dt, transaction_summary, transaction_type,transaction_amt,
closing_balance, create_dt)   VALUES ('dae62233-1fcc-43f7-8c2e-9613652ec2b2', 1865764534, 1, CURRENT_DATE - INTERVAL '5 DAY', 'Self Deposit', 'Deposit', 500,34900,CURRENT_DATE - INTERVAL '5 DAY');

INSERT INTO account_transactions (transaction_id, account_number, customer_id, transaction_dt, transaction_summary, transaction_type,transaction_amt,
closing_balance, create_dt)   VALUES ('406d848a-89ca-49a0-8aa6-d503f631ad83', 1865764534, 1, CURRENT_DATE - INTERVAL '4 DAY', 'Ebay', 'Withdrawal', 600,34300,CURRENT_DATE - INTERVAL '4 DAY');

INSERT INTO account_transactions (transaction_id, account_number, customer_id, transaction_dt, transaction_summary, transaction_type,transaction_amt,
closing_balance, create_dt)   VALUES ('4500e848-3d0b-45eb-b97d-e5ec1f683a58', 1865764534, 1, CURRENT_DATE - INTERVAL '2 DAY', 'OnlineTransfer', 'Deposit', 700,35000,CURRENT_DATE - INTERVAL '2 DAY');

INSERT INTO account_transactions (transaction_id, account_number, customer_id, transaction_dt, transaction_summary, transaction_type,transaction_amt,
closing_balance, create_dt)  VALUES ('54e34413-91eb-49a4-acf4-e765f06ecd8c', 1865764534, 1, CURRENT_DATE - INTERVAL '1 DAY', 'Amazon.com', 'Withdrawal', 100,34900,CURRENT_DATE - INTERVAL '1 DAY');


CREATE TABLE loans (
  loan_number int NOT NULL GENERATED ALWAYS AS IDENTITY,
  customer_id int NOT NULL,
  start_dt date NOT NULL,
  loan_type varchar(100) NOT NULL,
  total_loan int NOT NULL,
  amount_paid int NOT NULL,
  outstanding_amount int NOT NULL,
  create_dt date DEFAULT NULL,
  PRIMARY KEY (loan_number),
  CONSTRAINT loan_customer_ibfk_1 FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE CASCADE
);

INSERT INTO loans ( customer_id, start_dt, loan_type, total_loan, amount_paid, outstanding_amount, create_dt)
 VALUES ( 1, '2020-10-13', 'Home', 200000, 50000, 150000, '2020-10-13');

INSERT INTO loans ( customer_id, start_dt, loan_type, total_loan, amount_paid, outstanding_amount, create_dt)
 VALUES ( 1, '2020-06-06', 'Vehicle', 40000, 10000, 30000, '2020-06-06');

INSERT INTO loans ( customer_id, start_dt, loan_type, total_loan, amount_paid, outstanding_amount, create_dt)
 VALUES ( 1, '2018-02-14', 'Home', 50000, 10000, 40000, '2018-02-14');

INSERT INTO loans ( customer_id, start_dt, loan_type, total_loan, amount_paid, outstanding_amount, create_dt)
 VALUES ( 1, '2018-02-14', 'Personal', 10000, 3500, 6500, '2018-02-14');


CREATE TABLE cards (
  card_id int NOT NULL GENERATED ALWAYS AS IDENTITY,
  card_number varchar(100) NOT NULL,
  customer_id int NOT NULL,
  card_type varchar(100) NOT NULL,
  total_limit int NOT NULL,
  amount_used int NOT NULL,
  available_amount int NOT NULL,
  create_dt date DEFAULT NULL,
  PRIMARY KEY (card_id),
  CONSTRAINT card_customer_ibfk_1 FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE CASCADE
);

INSERT INTO cards (card_number, customer_id, card_type, total_limit, amount_used, available_amount, create_dt)
 VALUES ('4565XXXX4656', 1, 'Credit', 10000, 500, 9500, CURRENT_DATE);

INSERT INTO cards (card_number, customer_id, card_type, total_limit, amount_used, available_amount, create_dt)
 VALUES ('3455XXXX8673', 1, 'Credit', 7500, 600, 6900, CURRENT_DATE);

INSERT INTO cards (card_number, customer_id, card_type, total_limit, amount_used, available_amount, create_dt)
 VALUES ('2359XXXX9346', 1, 'Credit', 20000, 4000, 16000, CURRENT_DATE);


 CREATE TABLE notice_details (
   notice_id int NOT NULL GENERATED ALWAYS AS IDENTITY,
   notice_summary varchar(200) NOT NULL,
   notice_details varchar(500) NOT NULL,
   notic_beg_dt date NOT NULL,
   notic_end_dt date DEFAULT NULL,
   create_dt date DEFAULT NULL,
   update_dt date DEFAULT NULL,
   PRIMARY KEY (notice_id)
 );



INSERT INTO notice_details ( notice_summary, notice_details, notic_beg_dt, notic_end_dt, create_dt, update_dt)
VALUES ('Home Loan Interest rates reduced', 'Home loan interest rates are reduced as per the goverment guidelines. The updated rates will be effective immediately',
CURRENT_DATE - INTERVAL '30 DAY', CURRENT_DATE + INTERVAL '30 DAY', CURRENT_DATE, null);

INSERT INTO notice_details ( notice_summary, notice_details, notic_beg_dt, notic_end_dt, create_dt, update_dt)
VALUES ('Net Banking Offers', 'Customers who will opt for Internet banking while opening a saving account will get a $50 amazon voucher',
CURRENT_DATE - INTERVAL '30 DAY', CURRENT_DATE + INTERVAL '30 DAY', CURRENT_DATE, null);

INSERT INTO notice_details ( notice_summary, notice_details, notic_beg_dt, notic_end_dt, create_dt, update_dt)
VALUES ('Mobile App Downtime', 'The mobile application of the EazyBank will be down from 2AM-5AM on 12/05/2020 due to maintenance activities',
CURRENT_DATE - INTERVAL '30 DAY', CURRENT_DATE + INTERVAL '30 DAY', CURRENT_DATE, null);

INSERT INTO notice_details ( notice_summary, notice_details, notic_beg_dt, notic_end_dt, create_dt, update_dt)
VALUES ('E Auction notice', 'There will be a e-auction on 12/08/2020 on the Bank website for all the stubborn arrears.Interested parties can participate in the e-auction',
CURRENT_DATE - INTERVAL '30 DAY', CURRENT_DATE + INTERVAL '30 DAY', CURRENT_DATE, null);

INSERT INTO notice_details ( notice_summary, notice_details, notic_beg_dt, notic_end_dt, create_dt, update_dt)
VALUES ('Launch of Millennia Cards', 'Millennia Credit Cards are launched for the premium customers of EazyBank. With these cards, you will get 5% cashback for each purchase',
CURRENT_DATE - INTERVAL '30 DAY', CURRENT_DATE + INTERVAL '30 DAY', CURRENT_DATE, null);

INSERT INTO notice_details ( notice_summary, notice_details, notic_beg_dt, notic_end_dt, create_dt, update_dt)
VALUES ('COVID-19 Insurance', 'EazyBank launched an insurance policy which will cover COVID-19 expenses. Please reach out to the branch for more details',
CURRENT_DATE - INTERVAL '30 DAY', CURRENT_DATE + INTERVAL '30 DAY', CURRENT_DATE, null);


CREATE TABLE contact_messages (
  contact_id varchar(50) NOT NULL,
  contact_name varchar(50) NOT NULL,
  contact_email varchar(100) NOT NULL,
  subject varchar(500) NOT NULL,
  message varchar(2000) NOT NULL,
  create_dt date DEFAULT NULL,
  PRIMARY KEY (contact_id)
);