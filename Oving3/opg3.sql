create table postArea (
    postNR varchar(4),
    name    varchar(40) not null,
    constraint postArea_pk primary key (postNR)
);

create table customer (
    customerID	integer,
    name	varchar(40) not null,
    credit	integer not null,
    postNR	char(4),
    constraint customer_pk primary key (customerID),
    constraint customer_fk1 foreign key (postNR)
    references postArea(postNR)
    on update cascade
    on delete set null
);

create table item (
   itemID   integer,
   name	    varchar(40) not null,
   amount   integer not null,
   price    integer not null,
   constraint item_pk primary key (itemID)
);

create table ordr (
    itemID	integer,
    customerID	integer,
    quantity	integer not null,
    constraint order_fk1 foreign key (itemID)
    references item(itemID)
    on update cascade
    on delete cascade,
    constraint order_fk2 foreign key (customerID)
    references customer(customerID)
    on update cascade
    on delete cascade
);

create assertion no_exceed_credit check (
    0 = (
        select c.customerID, c.credit, o.quantity, i.price
        from customer as c, ordr as o, item as i
        where o.itemID = i.itemID
        and o.customerID = c.customerID
        group by c.customerID, c.credit
        having sum(i.price * o.quantity) > c.credit
    )
);
