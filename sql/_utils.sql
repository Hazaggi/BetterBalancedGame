
-- Create requirements for each technology
INSERT INTO RequirementSets(RequirementSetId, RequirementSetType)
    SELECT 'BBG_UTILS_PLAYER_HAS_' || TechnologyType, 'REQUIREMENTSET_TEST_ALL' FROM Technologies;
INSERT INTO Requirements(RequirementId, RequirementType)
    SELECT 'BBG_UTILS_PLAYER_HAS_' || TechnologyType || '_REQUIREMENT', 'REQUIREMENT_PLAYER_HAS_TECHNOLOGY' FROM Technologies;
INSERT INTO RequirementArguments(RequirementId, Name, Value)
    SELECT 'BBG_UTILS_PLAYER_HAS_' || TechnologyType || '_REQUIREMENT', 'TechnologyType', TechnologyType FROM Technologies;
INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId)
    SELECT 'BBG_UTILS_PLAYER_HAS_' || TechnologyType, 'BBG_UTILS_PLAYER_HAS_' || TechnologyType || '_REQUIREMENT' FROM Technologies;

-- Create requirements for each civic
INSERT INTO RequirementSets(RequirementSetId, RequirementSetType)
    SELECT 'BBG_PLAYER_HAS_' || CivicType || '_REQSET', 'REQUIREMENTSET_TEST_ALL' FROM Civics;
INSERT INTO Requirements(RequirementId, RequirementType)
    SELECT 'BBG_PLAYER_HAS_' || CivicType || '_REQUIREMENT', 'REQUIREMENT_PLAYER_HAS_CIVIC' FROM Civics;
INSERT INTO RequirementArguments(RequirementId, Name, Value)
    SELECT 'BBG_PLAYER_HAS_' || CivicType || '_REQUIREMENT', 'CivicType', CivicType FROM Civics;
INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId)
    SELECT 'BBG_PLAYER_HAS_' || CivicType || '_REQSET', 'BBG_PLAYER_HAS_' || CivicType || '_REQUIREMENT' FROM Civics;

-- Create requirements for each ressources
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
	('PLAYER_CAN_SEE_HORSES_CPLMOD', 	'REQUIREMENTSET_TEST_ALL'),
	('PLAYER_CAN_SEE_IRON_CPLMOD', 	'REQUIREMENTSET_TEST_ALL'),
	('PLAYER_CAN_SEE_NITER_CPLMOD', 	'REQUIREMENTSET_TEST_ALL'),
	('PLAYER_CAN_SEE_COAL_CPLMOD', 	'REQUIREMENTSET_TEST_ALL'),
	('PLAYER_CAN_SEE_ALUMINUM_CPLMOD', 	'REQUIREMENTSET_TEST_ALL'),
	('PLAYER_CAN_SEE_OIL_CPLMOD', 	'REQUIREMENTSET_TEST_ALL'),
	('PLAYER_CAN_SEE_URANIUM_CPLMOD', 	'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
	('PLAYER_CAN_SEE_HORSES_CPLMOD', 'REQUIRES_PLAYER_CAN_SEE_HORSES'),
	('PLAYER_CAN_SEE_IRON_CPLMOD', 'REQUIRES_PLAYER_CAN_SEE_IRON'),
	('PLAYER_CAN_SEE_NITER_CPLMOD', 'REQUIRES_PLAYER_CAN_SEE_NITER'),
	('PLAYER_CAN_SEE_COAL_CPLMOD', 'REQUIRES_PLAYER_CAN_SEE_COAL'),
	('PLAYER_CAN_SEE_ALUMINUM_CPLMOD', 'REQUIRES_PLAYER_CAN_SEE_ALUMINUM'),
	('PLAYER_CAN_SEE_OIL_CPLMOD', 'REQUIRES_PLAYER_CAN_SEE_OIL'),
	('PLAYER_CAN_SEE_URANIUM_CPLMOD', 'REQUIRES_PLAYER_CAN_SEE_URANIUM');

-- requirements game era (for portugal)
INSERT INTO Requirements(RequirementId, RequirementType)
    SELECT 'BBG_GAME_IS_IN_' || EraType || '_REQUIREMENT', 'REQUIREMENT_GAME_ERA_IS'
    FROM Eras;
INSERT INTO RequirementArguments(RequirementId, Name, Value)
    SELECT 'BBG_GAME_IS_IN_' || EraType || '_REQUIREMENT', 'EraType', EraType
    FROM Eras;
INSERT INTO RequirementSets(RequirementSetId, RequirementSetType)
    SELECT 'BBG_GAME_IS_IN_' || EraType || '_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL'
    FROM Eras;
INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId)
    SELECT 'BBG_GAME_IS_IN_' || EraType || '_REQUIREMENTS', 'BBG_GAME_IS_IN_' || EraType || '_REQUIREMENT'
    FROM Eras;

-- requirements game era (for teddy)
INSERT INTO Requirements(RequirementId, RequirementType)
    SELECT 'BBG_PLAYER_IS_IN_' || EraType || '_REQUIREMENT', 'REQUIREMENT_PLAYER_ERA_AT_LEAST'
    FROM Eras;
INSERT INTO RequirementArguments(RequirementId, Name, Value)
    SELECT 'BBG_PLAYER_IS_IN_' || EraType || '_REQUIREMENT', 'EraType', EraType
    FROM Eras;
INSERT INTO RequirementSets(RequirementSetId, RequirementSetType)
    SELECT 'BBG_PLAYER_IS_IN_' || EraType || '_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL'
    FROM Eras;
INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId)
    SELECT 'BBG_PLAYER_IS_IN_' || EraType || '_REQUIREMENTS', 'BBG_PLAYER_IS_IN_' || EraType || '_REQUIREMENT'
    FROM Eras;


-- requirement player is not erea
INSERT INTO Requirements(RequirementId, RequirementType, Inverse)
    SELECT 'BBG_PLAYER_IS_NOT_IN_' || EraType || '_REQUIREMENT', 'REQUIREMENT_PLAYER_ERA_AT_LEAST', 1
    FROM Eras;
INSERT INTO RequirementArguments(RequirementId, Name, Value)
    SELECT 'BBG_PLAYER_IS_NOT_IN_' || EraType || '_REQUIREMENT', 'EraType', EraType
    FROM Eras;

INSERT OR IGNORE INTO RequirementSets VALUES
    ('BBG_UNIT_ON_HILL_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSetRequirements VALUES
    ('BBG_UNIT_ON_HILL_REQUIREMENTS', 'PLOT_IS_HILLS_REQUIREMENT');

CREATE TABLE WonderTerrainFeature_BBG(
    WonderType TEXT NOT NULL,
    TerrainClassType TEXT,
    FeatureType TEXT,
    Other TEXT,
    PRIMARY KEY(WonderType)
);

CREATE TABLE AbstractModifiers(
    ParentObjectID TEXT NOT NULL,
    ModifierAId TEXT,
    ModifierAType TEXT,
    ModifierAName TEXT,
    ModifierAValue TEXT,
    ModifierBId TEXT,
    SubjectRequirementSetId TEXT,
    RequirementSetType TEXT,
    RequirementId TEXT,
    RequirementType TEXT,
    Inverse BOOL,
    Name TEXT,
    Value TEXT 
    );

CREATE TABLE CustomPlacement(
    ObjectType TEXT NOT NULL,
    Hash INTEGER NOT NULL,
    PlacementFunction TEXT NOT NULL,
    OverridePlacement BOOLEAN NOT NULL CHECK(OverridePlacement IN (0,1)) DEFAULT 0,
    PRIMARY KEY(ObjectType),
    FOREIGN KEY(Hash) REFERENCES Types(Hash) ON DELETE CASCADE ON UPDATE CASCADE
    );