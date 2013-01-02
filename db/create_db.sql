/* User account management tables:
  load the password, account status (enabled or disabled) and a list of authorities (roles) for the user. */

create database if not exists doli;

user doli;

create table if not exists users(
    username varchar(50) not null primary key,
    password varchar(50) not null,
    enabled boolean not null
) engine=InnoDB;

create table if not exists authorities (
    username varchar(50) not null,
    authority varchar(50) not null,
    constraint fk_authorities_users foreign key(username) references users(username)
) engine=InnoDB;

/* Group management tables, defines different user group, ie: admin, customer, enterprise customer ,etc */
create table if not exists  groups (
    id mediumint NOT NULL AUTO_INCREMENT primary key,
    group_name varchar(50) not null
) engine=InnoDB;

create table if not exists group_authorities (
    group_id mediumint not null,
    authority varchar(50) not null,
    constraint fk_group_authorities_group foreign key(group_id) references groups(id)
) engine=InnoDB;

create table if not exists group_members (
    id bigint not null auto_increment primary key,
    username varchar(50) not null,
    group_id mediumint not null,
    constraint fk_group_members_group foreign key(group_id) references groups(id)
) engine=InnoDB AUTO_INCREMENT=0;

/* Persistent login: This table is used to store data used by the more secure persistent token remember-me implementation.*/

create table if not exists persistent_logins (
    username varchar(64) not null,
    series varchar(64) primary key,
    token varchar(64) not null,
    last_used timestamp not null
) engine=InnoDB;


/* Calendar events
When user create a calender event, an eventid will be created by concatenating 
username + '-' + 'index', where index is the max number of events this use has plus one. */

create table calendar (
    username varchar(50) not null,
    eventid varchar(100) not null primary key,
    constraint fk_calendar_users foreign key(username) references users(username)
) engine=InnoDB;

create table if not exists calendar_events (
    id varchar(100) not null primary key,
    title varchar(100) not null,
    url varchar(100),
    start_date timestamp not null,
    repeat_gap bigint,
    note varchar(500),
    enable_alarm tinyint(1) default TRUE,
    constraint fk_event foreign key(id) references calendar(eventid)
) engine=InnoDB;

/* notes 
When user create a note, a noteid will be created by concatenating username + '-' + 'index', where index is the max number of notes the user has plus one */

create table notes (
    username varchar(50) not null,
    noteid varchar(100) not null primary key,
    constraint fk_note_users foreign key(username) references users(username)
) engine=InnoDB;

create table note_content (
    id varchar(100) not null primary key,
    title varchar(200) not null,
    url varchar(100),
    create_date timestamp not null,
    last_modified timestamp not null,
    content varchar(100) not null, -- the file location of the content.
    constraint fk_note foreign key(id) references notes(noteid)) engine=InnoDB;

/* budgets
*/

create table budgets (
    id int auto_increment not null primary key,
    username varchar(50) not null,
    constraint fk_budget_user foreign key(username) references users(username)
) engine=InnoDB;

CREATE TABLE categories (
    id int auto_increment not null,
    name varchar(128),
    budget int default 0,
    primary key(id)
) ENGINE=InnoDB;

CREATE TABLE items (
    id int auto_increment not null,
    category int,
    name varchar(128),
    comments text,
    company varchar(128),
    general_price float,
    price_per_guest float,
    quantity_price float,
    foreign key(category) references categories(id) on update cascade on delete cascade,
    primary key(id)
) ENGINE=InnoDB;
