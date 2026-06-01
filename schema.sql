-- ============================================================
-- Xaris Academy — Supabase Schema
-- Run this in: Supabase Dashboard → SQL Editor → New Query
-- ============================================================

-- School Years
create table if not exists school_years (
  id uuid primary key default gen_random_uuid(),
  year text not null unique,           -- e.g. '2026-2027'
  student_name text default 'Myrrh',
  grade text,                          -- e.g. 'Grade 2'
  goals text,
  methods text,
  created_at timestamptz default now()
);

-- Subjects (belongs to a school year)
create table if not exists subjects (
  id uuid primary key default gen_random_uuid(),
  school_year_id uuid references school_years(id) on delete cascade,
  name text not null,
  description text,
  icon text default '📚',             -- emoji icon
  color text default '#9d6a47',       -- hex color for calendar/tags
  display_order int default 0,
  created_at timestamptz default now()
);

-- Materials (belongs to a subject)
create table if not exists materials (
  id uuid primary key default gen_random_uuid(),
  subject_id uuid references subjects(id) on delete cascade,
  title text not null,
  type text default 'book',           -- book | link | worksheet | video | other
  url text,
  notes text,
  display_order int default 0,
  created_at timestamptz default now()
);

-- Calendar Events (belongs to school year, optionally linked to subject)
create table if not exists calendar_events (
  id uuid primary key default gen_random_uuid(),
  school_year_id uuid references school_years(id) on delete cascade,
  subject_id uuid references subjects(id) on delete set null,
  title text not null,
  event_date date not null,
  notes text,
  created_at timestamptz default now()
);

-- ============================================================
-- Row Level Security (RLS)
-- ============================================================

alter table school_years enable row level security;
alter table subjects enable row level security;
alter table materials enable row level security;
alter table calendar_events enable row level security;

-- Public can read everything
create policy "Public read school_years"    on school_years    for select using (true);
create policy "Public read subjects"        on subjects        for select using (true);
create policy "Public read materials"       on materials       for select using (true);
create policy "Public read calendar_events" on calendar_events for select using (true);

-- Only authenticated users (admin) can write
create policy "Admin write school_years"    on school_years    for all using (auth.role() = 'authenticated');
create policy "Admin write subjects"        on subjects        for all using (auth.role() = 'authenticated');
create policy "Admin write materials"       on materials       for all using (auth.role() = 'authenticated');
create policy "Admin write calendar_events" on calendar_events for all using (auth.role() = 'authenticated');

-- ============================================================
-- Seed: S.Y. 2026-2027
-- ============================================================

insert into school_years (year, student_name, grade, goals, methods)
values (
  '2026-2027',
  'Myrrh',
  'Grade 2',
  'To nurture a love for learning deeply rooted in faith, develop strong foundational skills in reading, writing, and mathematics, and cultivate godly character through discipleship, creativity, and family-centered education — all for the glory of God.',
  'We follow a Charlotte Mason-inspired approach combining living books, narration, nature study, hands-on learning, and structured skill practice. Each subject is taught through discovery and creativity within a Christ-centered framework, honoring the whole child — mind, body, and spirit.'
)
on conflict (year) do nothing;

-- Seed subjects after inserting the school year
-- Run this separately after confirming the school year was inserted:
/*
insert into subjects (school_year_id, name, description, icon, color, display_order)
select
  sy.id,
  sub.name,
  sub.description,
  sub.icon,
  sub.color,
  sub.display_order
from school_years sy,
(values
  ('Cursive Writing',              'Developing beautiful, legible handwriting through daily practice using structured penmanship curriculum.',  '✍️',  '#8B7355', 1),
  ('Philippines & World History',  'Exploring the stories of our nation and the world — from ancient civilizations to modern times.',           '🌏',  '#6B8E6B', 2),
  ('Arts, Music & Physical Education', 'Nurturing creativity, artistic expression, musical appreciation, and physical health and fitness.',    '🎨',  '#C4956A', 3),
  ('Math 3-4',                     'Building strong mathematical foundations with problem solving, critical thinking, and number mastery.',     '🔢',  '#7A8FA6', 4),
  ('Biblical Studies',             'Deepening our understanding of Scripture, theology, and living a life of faith and obedience to Christ.',  '✝️',  '#A67C52', 5),
  ('Reading & Language',           'Cultivating a love for literature, developing comprehension, vocabulary, grammar, and writing skills.',     '📖',  '#9B7FA6', 6)
) as sub(name, description, icon, color, display_order)
where sy.year = '2026-2027';
*/
