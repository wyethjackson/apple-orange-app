import FeaturedProductCard from '@/components/FeaturedProductCard';

export default function Category({ category }) {
    cosole.log(category)
    return (
        <div className="max-w-6xl mx-auto px-4 py-8">
            <h1 className="text-4xl font-bold text-orange-800 mb-4">{category.title}</h1>
            <p className="text-gray-600 mb-10">{category.overview}</p>

            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                {(category?.products || []).map((leafProduct) => (
                    <FeaturedProductCard
                        featuredProduct={leafProduct}
                    />
                ))}
            </div>
        </div>
    );
}
