import { BrowserRouter, Route, Routes } from 'react-router-dom'
import { AuthProvider } from './lib/AuthContext'
import ComingSoon from './components/ComingSoon'
import CategoriesPage from './routes/CategoriesPage'
import DashboardHome from './routes/DashboardHome'
import DashboardLayout from './routes/DashboardLayout'
import LoginPage from './routes/LoginPage'
import ProtectedRoute from './routes/ProtectedRoute'

const PLACEHOLDER_ROUTES = [
  { path: 'customers', title: 'Customer management' },
  { path: 'professionals/verification', title: 'Professional verification' },
  { path: 'professionals', title: 'Professionals' },
  { path: 'jobs', title: 'Job monitoring' },
  { path: 'disputes', title: 'Dispute management' },
  { path: 'reviews', title: 'Review moderation' },
  { path: 'payments', title: 'Payments & commission reports' },
  { path: 'analytics', title: 'Platform analytics' },
  { path: 'support', title: 'Support tickets' },
  { path: 'admin-roles', title: 'Admin roles & permissions' },
]

export default function App() {
  return (
    <BrowserRouter>
      <AuthProvider>
        <Routes>
          <Route path="/login" element={<LoginPage />} />

          <Route element={<ProtectedRoute />}>
            <Route element={<DashboardLayout />}>
              <Route path="/" element={<DashboardHome />} />
              <Route path="/categories" element={<CategoriesPage />} />
              {PLACEHOLDER_ROUTES.map(({ path, title }) => (
                <Route key={path} path={`/${path}`} element={<ComingSoon title={title} />} />
              ))}
            </Route>
          </Route>
        </Routes>
      </AuthProvider>
    </BrowserRouter>
  )
}
