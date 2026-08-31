import { useEffect, useState } from 'react'
import { apiClient, apiErrorMessage } from '../lib/apiClient'

export default function CategoriesPage() {
  const [categories, setCategories] = useState(null)
  const [error, setError] = useState(null)

  useEffect(() => {
    let cancelled = false

    apiClient
      .get('/services/categories')
      .then(({ data }) => {
        if (!cancelled) setCategories(data.data)
      })
      .catch((err) => {
        if (!cancelled) setError(apiErrorMessage(err))
      })

    return () => {
      cancelled = true
    }
  }, [])

  return (
    <div>
      <h1 className="text-2xl font-bold text-text-primary">Categories</h1>
      <p className="mt-1 text-sm text-text-secondary">
        Live from <code className="rounded bg-background px-1.5 py-0.5">GET /services/categories</code>.
        Creating/editing categories isn&apos;t wired up yet — this is read-only.
      </p>

      <div className="mt-6 overflow-hidden rounded-2xl border border-border bg-surface">
        {error && <p className="p-6 text-sm text-error">{error}</p>}

        {!error && !categories && <p className="p-6 text-sm text-text-secondary">Loading…</p>}

        {!error && categories && categories.length === 0 && (
          <p className="p-6 text-sm text-text-secondary">No categories yet.</p>
        )}

        {!error && categories && categories.length > 0 && (
          <table className="w-full text-left text-sm">
            <thead className="border-b border-border bg-background text-xs uppercase tracking-wide text-text-secondary">
              <tr>
                <th className="px-5 py-3 font-medium">Name</th>
                <th className="px-5 py-3 font-medium">Slug</th>
                <th className="px-5 py-3 font-medium">Icon</th>
              </tr>
            </thead>
            <tbody>
              {categories.map((category) => (
                <tr key={category.id} className="border-b border-border last:border-0">
                  <td className="px-5 py-3 font-medium text-text-primary">{category.name}</td>
                  <td className="px-5 py-3 text-text-secondary">{category.slug}</td>
                  <td className="px-5 py-3 text-text-secondary">{category.icon}</td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </div>
    </div>
  )
}
