-- FILE: infra/db/init.sql
-- Description: Database schema and initial seed data for the VeloRoute ecosystem.

-- Enable required extensions
-- PostGIS for geographical data support (future map features)
CREATE EXTENSION IF NOT EXISTS postgis;
-- pgcrypto for robust UUID generation
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Clean up existing structures to ensure a fresh state upon container re-initialisation
DROP TABLE IF EXISTS schedules;
DROP TABLE IF EXISTS routes;
DROP ROLE IF EXISTS anon;

-- Define the 'anon' role for PostgREST to allow unauthenticated read-only access
CREATE ROLE anon nologin;
GRANT USAGE ON SCHEMA public TO anon;

-- Routes table following GTFS (General Transit Feed Specification) naming conventions
CREATE TABLE routes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    short_name TEXT NOT NULL, -- e.g., "804" or "X1"
    long_name TEXT NOT NULL,  -- e.g., "Central Terminal - Northern District"
    route_colour TEXT,        -- Hexadecimal colour code for UI rendering
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Schedules table representing the arrival times at various stops
CREATE TABLE schedules (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    route_id UUID REFERENCES routes(id) ON DELETE CASCADE,
    stop_name TEXT NOT NULL,
    scheduled_time TIME NOT NULL,
    is_delayed BOOLEAN DEFAULT FALSE
);

-- Authorise the API to perform SELECT operations on all public tables
GRANT SELECT ON ALL TABLES IN SCHEMA public TO anon;

-- ---------------------------------------------------------
-- SEED DATA: Initial testing data for development
-- ---------------------------------------------------------

-- Insert a primary test route using a fixed UUID for development consistency
INSERT INTO routes (id, short_name, long_name, route_colour) 
VALUES ('00000000-0000-0000-0000-000000000000', '804', 'Central Terminal - VeloRoute Express', '#1B264F');

-- Insert corresponding stop schedules for the test route
INSERT INTO schedules (route_id, stop_name, scheduled_time, is_delayed)
VALUES 
('00000000-0000-0000-0000-000000000000', 'Peace Square Station', '08:15:00', false),
('00000000-0000-0000-0000-000000000000', 'Technology Avenue', '08:45:00', true),
('00000000-0000-0000-0000-000000000000', 'Velo Industrial Park', '09:20:00', false),
('00000000-0000-0000-0000-000000000000', 'Southern Interchange', '10:00:00', false);
