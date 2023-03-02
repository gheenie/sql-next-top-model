\c topmodelsql

DROP TABLE IF EXISTS firstnf_models;

CREATE TABLE firstnf_models
( 
    model_id INT,
    model_name VARCHAR(100),
    area VARCHAR(50),
    price_per_event FLOAT,
    category VARCHAR(100),
    agent VARCHAR(50),
    brand TEXT,
    trait VARCHAR(60),
    rating INT, 
    event_date TEXT, 
    revenue  FLOAT
);

INSERT INTO firstnf_models
    (model_id, model_name, area, price_per_event, category, agent, brand, trait, rating, event_date, revenue ) 
VALUES
    (1, 'Bartholomew P', 'Milan', 499.99, 'Fashion', 'Verity', 'Louboutin', 'Pro strutter', 7, '15 November 2022', 2999.94),
    (1, 'Bartholomew P', 'Milan', 499.99, 'Fashion', 'Verity', 'H&M', 'Pro strutter', 7, '15 November 2022', 2999.94),
    (2, 'Notso Neat', 'Online', 9.99, 'Promotional', 'Alex', 'Aldi', 'The dadbod drop', 1, '12 September 2022', 149.85),
    (2, 'Notso Neat', 'Online', 9.99, 'Promotional', 'Alex', 'Poundland', 'The dadbod drop', 1, '12 September 2022', 149.85),
    (3,'Jarred MacKenzie', 'Los Angeles', 170.00, 'Fitness', 'Paul', 'Patagonia', 'Fire_eating', 4, '8 January 2022', 1530),
    (3, 'Jarred MacKenzie', 'Los Angeles', 170.00, 'Fitness', 'Paul', 'Buff', 'Fire_eating', 4, '8 January 2022', 1530),
    (3, 'Jarred MacKenzie', 'Los Angeles', 170.00, 'Fitness', 'Paul', 'Salomon', 'Fire_eating', 4, '8 January 2022', 1530),
    (4, 'Rathbones Arr', 'London', 263.82, 'Parts', 'Kev', 'Adidas', 'Hand modelling', 5, '6 March 2022', 1846.74),
    (5, 'Sarah B', 'Online', 432.25, 'Promotional', 'Alex', 'Ebay', 'Influencer', 7, '23 October 2022', 3458),
    (5, 'Sarah B', 'Online', 432.25, 'Promotional', 'Alex', 'Vinted', 'Influencer', 7, '23 October 2022', 3458),
    (5, 'Sarah B', 'Online', 432.25, 'Promotional', 'Alex', 'Instagram', 'Influencer', 7, '23 October 2022', 3458),
    (6, 'Cat Wang', 'Milan', 600.00, 'Fashion', 'Verity', 'Charities', 'Catwalker', 8, '14 May 2022', 3600),
    (7, 'Starr Schema', 'Crewe', 250.00, 'Glamour', 'Rose', 'Oricle', 'Databases', 5, '12 September 2022', 1500),
    (7, 'Starr Schema', 'Crewe', 250.00, 'Glamour', 'Rose', 'Marks and Spencer', 'Databases', 5, '12 September 2022', 1500),
    (8, 'Sam Pagne', 'Athens', 899.99 , 'Swimsuit', 'Katherine', 'Harrods', 'Old-money', 9, '20 January 2022', 9899.89),
    (8, 'Sam Pagne', 'Athens', 899.99 , 'Swimsuit', 'Katherine', 'HSBC', 'Old-money', 9, '20 January 2022', 9899.89),
    (9, 'Salle De Bain', 'Stockholm', 150.00 , 'Commercial', 'Christian', 'Ikea', 'Architect', 3, '16 July 2022', 1050),
    (9, 'Salle De Bain', 'Stockholm', 150.00 , 'Commercial', 'Christian', 'Wayfair', 'Architect', 3, '16 July 2022', 1050),
    (9, 'Salle De Bain', 'Stockholm', 150.00 , 'Commercial', 'Christian', 'Amazon', 'Architect', 3, '16 July 2022', 1050),
    (10, 'Slam Dunk', 'Los Angeles', 801.65 , 'Fitness', 'Paul', 'Nike', 'High-tops', 9, '23 August 2022', 7214.85),
    (10, 'Slam Dunk', 'Los Angeles', 801.65 , 'Fitness', 'Paul', 'Adidas', 'High-tops', 9, '23 August 2022', 7214.85),
    (10, 'Slam Dunk', 'Los Angeles', 801.65 , 'Fitness', 'Paul', 'Reebok', 'High-tops', 9, '23 August 2022', 7214.85),
    (11, 'Hannah Bee', 'Milan', 325.00 , 'Fashion', 'Verity', 'Chanel', 'Photography', 6, '1 March 2022', 1625),
    (11, 'Hannah Bee', 'Milan', 325.00 , 'Fashion', 'Verity', 'Dior', 'Photography', 6, '1 March 2022', 1625),
    (11, 'Hannah Bee', 'Milan', 325.00 , 'Fashion', 'Verity', 'Stella McCartney', 'Photography', 6, '1 March 2022', 1625),
    (12, 'Rainsface W', 'Athens', 120.00 , 'Swimsuit', 'Katherine', 'United Utilities', 'Impromptu crying', 3, '14 May 2022', 480),
    (13, 'Raul Pogerson', 'Stockholm', 50.00 , 'Commercial', 'Christian', 'Listo Burritos', 'Messy eating', 2, '12 September 2022', 950),
    (14, 'Ray Z', 'London', 470.68 , 'Parts', 'Kev', 'Marvel Studios', 'Card magic', 7, '18 April 2022', 5177.48)
RETURNING *;
