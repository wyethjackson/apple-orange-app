import CategoryLeafCard from '@/components/LeafCategoryCard';

export default function Category({ category }) {
    
    return (
        <div className="max-w-6xl mx-auto px-4 py-8">
            <h1 className="text-4xl font-bold text-orange-800 mb-4">{category.title}</h1>
            <p className="text-gray-600 mb-10">{category.overview}</p>

            <div className="grid sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
                {(category?.leafCategories || []).map((leaf) => (
                    <CategoryLeafCard
                        key={leaf.slug}
                        slug={leaf.slug}
                        title={leaf.name}
                        breadcrumbs={leaf.breadcrumbs}
                    />
                ))}
            </div>
        </div>
    );
}
