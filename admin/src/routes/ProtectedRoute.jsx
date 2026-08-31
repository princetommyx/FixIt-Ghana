import { Navigate, Outlet, useLocation } from 'react-router-dom'
import { useAuth } from '../lib/AuthContext'

export default function ProtectedRoute() {
  const { status, isAuthenticated } = useAuth()
  const location = useLocation()

  if (status === 'loading') {
    return (
      <div className="flex min-h-screen items-center justify-center bg-background">
        <div className="h-8 w-8 animate-spin rounded-full border-2 border-border border-t-primary" />
      </div>
    )
  }

  if (!isAuthenticated) {
    return <Navigate to="/login" replace state={{ from: location.pathname }} />
  }

  return <Outlet />
}
