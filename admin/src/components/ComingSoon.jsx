export default function ComingSoon({ title, description }) {
  return (
    <div className="flex flex-1 flex-col items-center justify-center rounded-2xl border border-dashed border-border bg-surface p-16 text-center">
      <h2 className="text-lg font-semibold text-text-primary">{title}</h2>
      <p className="mt-1 max-w-sm text-sm text-text-secondary">
        {description ?? 'This section is planned but not built in this pass.'}
      </p>
    </div>
  )
}
