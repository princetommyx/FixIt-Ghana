import { NavLink, Outlet } from 'react-router-dom'
import { useAuth } from '../lib/AuthContext'

const NAV_SECTIONS = [
  {
    label: 'Overview',
    items: [{ to: '/', label: 'Dashboard', end: true }],
  },
  {
    label: 'Marketplace',
    items: [
      { to: '/customers', label: 'Customers' },
      { to: '/professionals/verification', label: 'Professional verification' },
      { to: '/professionals', label: 'Professionals' },
      { to: '/jobs', label: 'Job monitoring' },
      { to: '/disputes', label: 'Disputes' },
      { to: '/categories', label: 'Categories' },
      { to: '/reviews', label: 'Review moderation' },
    ],
  },
  {
    label: 'Business',
    items: [
      { to: '/payments', label: 'Payments & commission' },
      { to: '/analytics', label: 'Analytics' },
      { to: '/support', label: 'Support tickets' },
      { to: '/admin-roles', label: 'Admin roles' },
    ],
  },
]

export default function DashboardLayout() {
  const { user, logout } = useAuth()

  return (
    <div className="flex min-h-screen bg-background">
      <aside className="flex w-64 shrink-0 flex-col border-r border-border bg-surface">
        <div className="flex items-center gap-2 px-5 py-5">
          <div className="flex h-9 w-9 items-center justify-center rounded-lg bg-primary/10 text-primary">
            <svg viewBox="0 0 24 24" fill="none" className="h-5 w-5" aria-hidden="true">
              <path
                d="M14.7 6.3a4 4 0 0 1-5.4 5.4L4 17v3h3l5.3-5.3a4 4 0 0 1 5.4-5.4l-3 3-2-2 3-3Z"
                stroke="currentColor"
                strokeWidth="1.6"
                strokeLinejoin="round"
              />
            </svg>
          </div>
          <div>
            <p className="text-sm font-bold leading-tight text-text-primary">FixIt Ghana</p>
            <p className="text-xs text-text-secondary">Admin</p>
          </div>
        </div>

        <nav className="flex-1 overflow-y-auto px-3 py-2">
          {NAV_SECTIONS.map((section) => (
            <div key={section.label} className="mb-5">
              <p className="mb-1.5 px-2 text-xs font-semibold uppercase tracking-wide text-text-secondary">
                {section.label}
              </p>
              <div className="space-y-0.5">
                {section.items.map((item) => (
                  <NavLink
                    key={item.to}
                    to={item.to}
                    end={item.end}
                    className={({ isActive }) =>
                      `block rounded-lg px-2.5 py-2 text-sm font-medium transition ${
                        isActive
                          ? 'bg-primary/10 text-primary'
                          : 'text-text-primary hover:bg-background'
                      }`
                    }
                  >
                    {item.label}
                  </NavLink>
                ))}
              </div>
            </div>
          ))}
        </nav>

        <div className="border-t border-border px-4 py-4">
          <p className="truncate text-sm font-medium text-text-primary">{user?.name}</p>
          <p className="truncate text-xs text-text-secondary">{user?.email ?? user?.phone}</p>
          <button
            type="button"
            onClick={logout}
            className="mt-2 text-sm font-medium text-error hover:underline"
          >
            Log out
          </button>
        </div>
      </aside>

      <main className="flex flex-1 flex-col p-8">
        <Outlet />
      </main>
    </div>
  )
}
