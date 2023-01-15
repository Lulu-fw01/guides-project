ALTER TABLE user_reports ALTER COLUMN status TYPE varchar (20);
ALTER TABLE user_reports ALTER COLUMN category TYPE varchar (20);
ALTER TABLE guide_reports ALTER COLUMN status TYPE varchar (20);
ALTER TABLE guide_reports ALTER COLUMN category TYPE varchar (20);

ALTER TABLE ONLY user_reports ALTER COLUMN status SET DEFAULT 'OPENED';
ALTER TABLE ONLY guide_reports ALTER COLUMN status SET DEFAULT 'OPENED';
ALTER TABLE ONLY users ALTER COLUMN role SET DEFAULT 'USER';

DROP TYPE IF EXISTS report_reason;
DROP TYPE IF EXISTS report_status;
DROP TYPE IF EXISTS user_role;