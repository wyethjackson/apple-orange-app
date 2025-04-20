import Link from 'next/link';

export default function LeafCategoryCard({ slug, title, breadcrumbs }) {
    return (
        <Link href={`/categories/${slug}`}>
            <span className="block bg-white border border-orange-200 rounded-lg p-6 shadow hover:shadow-md transition-shadow duration-200 hover:bg-orange-50">
                <div className="text-sm text-gray-500 mb-2">
                    {breadcrumbs.join(' › ')}
                </div>
                <h3 className="text-lg font-semibold text-orange-700">{title}</h3>
                <p className="text-sm text-gray-600 mt-1">Explore this comparison →</p>
            </span>
        </Link>
    );
}
