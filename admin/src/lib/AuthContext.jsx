import { createContext, useCallback, useContext, useEffect, useMemo, useState } from 'react'
import { apiClient, apiErrorMessage, tokenStorage } from './apiClient'

const AuthContext = createContext(null)

export function AuthProvider({ children }) {
  const [user, setUser] = useState(null)
  const [status, setStatus] = useState('loading') // 'loading' | 'signedOut' | 'signedIn'

  useEffect(() => {
    const token = tokenStorage.get()
    if (!token) {
      setStatus('signedOut')
      return
    }

    apiClient
      .get('/auth/me')
      .then(({ data }) => {
        setUser(data.data)
        setStatus('signedIn')
      })
      .catch(() => {
        tokenStorage.clear()
        setStatus('signedOut')
      })
  }, [])

  const login = useCallback(async (identifier, password) => {
    const { data } = await apiClient.post('/auth/login', {
      identifier,
      password,
      device_name: 'admin-dashboard',
    })

    if (data.user.role !== 'admin') {
      throw new Error('This account does not have admin access.')
    }

    tokenStorage.set(data.token)
    setUser(data.user)
    setStatus('signedIn')
  }, [])

  const logout = useCallback(async () => {
    try {
      await apiClient.post('/auth/logout')
    } catch {
      // token may already be invalid server-side — clear local state regardless
    } finally {
      tokenStorage.clear()
      setUser(null)
      setStatus('signedOut')
    }
  }, [])

  const value = useMemo(
    () => ({ user, status, login, logout, isAuthenticated: status === 'signedIn' }),
    [user, status, login, logout],
  )

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>
}

export function useAuth() {
  const context = useContext(AuthContext)
  if (!context) throw new Error('useAuth must be used within an AuthProvider')
  return context
}

export { apiErrorMessage }
