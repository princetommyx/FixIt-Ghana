import { useAuth } from '../lib/AuthContext'

export default function DashboardHome() {
  const { user } = useAuth()

  return (
    <div>
      <h1 className="text-2xl font-bold text-text-primary">Welcome back, {user?.name?.split(' ')[0]}</h1>
      <p className="mt-1 text-sm text-text-secondary">
        Here&apos;s a quick look at the FixIt Ghana marketplace.
      </p>

      <div className="mt-8 grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-4">
        <StatCard label="Open requests" value="—" />
        <StatCard label="Pending verifications" value="—" />
        <StatCard label="Jobs in progress" value="—" />
        <StatCard label="Open disputes" value="—" />
      </div>

      <div className="mt-8 rounded-2xl border border-dashed border-border bg-surface p-6">
        <h2 className="text-sm font-semibold text-text-primary">Analytics are on the way</h2>
        <p className="mt-1 text-sm text-text-secondary">
          This overview will populate once the admin reporting endpoints are built (see
          docs/development-phases.md, Phase 8). The sidebar below is fully wired for that
          work — each section already has its own route and layout slot.
        </p>
      </div>
    </div>
  )
}

function StatCard({ label, value }) {
  return (
    <div className="rounded-2xl border border-border bg-surface p-5">
      <p className="text-xs font-medium uppercase tracking-wide text-text-secondary">{label}</p>
      <p className="mt-2 text-2xl font-bold text-text-primary">{value}</p>
    </div>
  )
}
