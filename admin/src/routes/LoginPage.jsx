import { useState } from 'react'
import { Navigate, useLocation, useNavigate } from 'react-router-dom'
import { useAuth } from '../lib/AuthContext'

export default function LoginPage() {
  const { login, isAuthenticated } = useAuth()
  const navigate = useNavigate()
  const location = useLocation()

  const [identifier, setIdentifier] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState(null)
  const [isSubmitting, setIsSubmitting] = useState(false)

  if (isAuthenticated) {
    return <Navigate to={location.state?.from ?? '/'} replace />
  }

  async function handleSubmit(event) {
    event.preventDefault()
    setError(null)
    setIsSubmitting(true)

    try {
      await login(identifier, password)
      navigate(location.state?.from ?? '/', { replace: true })
    } catch (err) {
      setError(err?.response?.data?.message ?? err.message ?? 'Login failed. Please try again.')
    } finally {
      setIsSubmitting(false)
    }
  }

  return (
    <div className="flex min-h-screen items-center justify-center bg-background px-4">
      <div className="w-full max-w-sm rounded-2xl border border-border bg-surface p-8 shadow-sm">
        <div className="mb-8 text-center">
          <div className="mx-auto mb-3 flex h-12 w-12 items-center justify-center rounded-xl bg-primary/10 text-primary">
            <svg viewBox="0 0 24 24" fill="none" className="h-6 w-6" aria-hidden="true">
              <path
                d="M14.7 6.3a4 4 0 0 1-5.4 5.4L4 17v3h3l5.3-5.3a4 4 0 0 1 5.4-5.4l-3 3-2-2 3-3Z"
                stroke="currentColor"
                strokeWidth="1.6"
                strokeLinejoin="round"
              />
            </svg>
          </div>
          <h1 className="text-xl font-bold text-text-primary">FixIt Ghana Admin</h1>
          <p className="mt-1 text-sm text-text-secondary">Sign in to manage the marketplace.</p>
        </div>

        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label htmlFor="identifier" className="mb-1 block text-sm font-medium text-text-primary">
              Email or phone
            </label>
            <input
              id="identifier"
              type="text"
              required
              value={identifier}
              onChange={(event) => setIdentifier(event.target.value)}
              className="w-full rounded-xl border border-border bg-surface px-3.5 py-2.5 text-sm outline-none focus:border-primary"
              placeholder="admin@fixitghana.com"
            />
          </div>

          <div>
            <label htmlFor="password" className="mb-1 block text-sm font-medium text-text-primary">
              Password
            </label>
            <input
              id="password"
              type="password"
              required
              value={password}
              onChange={(event) => setPassword(event.target.value)}
              className="w-full rounded-xl border border-border bg-surface px-3.5 py-2.5 text-sm outline-none focus:border-primary"
              placeholder="••••••••"
            />
          </div>

          {error && (
            <p className="rounded-lg bg-error/10 px-3 py-2 text-sm text-error" role="alert">
              {error}
            </p>
          )}

          <button
            type="submit"
            disabled={isSubmitting}
            className="w-full rounded-xl bg-primary py-2.5 text-sm font-semibold text-white transition hover:bg-primary-dark disabled:opacity-60"
          >
            {isSubmitting ? 'Signing in…' : 'Sign in'}
          </button>
        </form>
      </div>
    </div>
  )
}
