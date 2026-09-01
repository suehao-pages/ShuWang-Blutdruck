create table if not exists public.blood_pressure_entries (
  id uuid primary key,
  household_token text not null,
  person text not null check (person in ('Yihao','Wenqi')),
  systolic smallint not null check (systolic between 50 and 260),
  diastolic smallint not null check (diastolic between 30 and 160),
  pulse smallint not null check (pulse between 25 and 240),
  measured_at timestamptz not null,
  note text not null default '',
  created_at timestamptz not null default now()
);

alter table public.blood_pressure_entries enable row level security;
revoke all on public.blood_pressure_entries from anon, authenticated;
grant select, insert, update, delete on public.blood_pressure_entries to anon;

create policy "family can read its measurements" on public.blood_pressure_entries
for select to anon using (
  household_token = (current_setting('request.headers', true)::json ->> 'x-household-token')
);
create policy "family can add its measurements" on public.blood_pressure_entries
for insert to anon with check (
  household_token = (current_setting('request.headers', true)::json ->> 'x-household-token')
);
create policy "family can update its measurements" on public.blood_pressure_entries
for update to anon using (
  household_token = (current_setting('request.headers', true)::json ->> 'x-household-token')
) with check (
  household_token = (current_setting('request.headers', true)::json ->> 'x-household-token')
);
create policy "family can delete its measurements" on public.blood_pressure_entries
for delete to anon using (
  household_token = (current_setting('request.headers', true)::json ->> 'x-household-token')
);

create index if not exists blood_pressure_household_time_idx
on public.blood_pressure_entries (household_token, measured_at desc);
