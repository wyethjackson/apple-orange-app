// pages/index.jsx
import BlogCard from '@/components/BlogCard';
import ProductCard from '@/components/ProductCard';

export default function Home() {
    // Replace with real data fetching later (API or GraphQL)
    const blogs = [
        { title: 'Best Tech Gadgets in 2025', slug: 'best-tech-gadgets-2025' },
        { title: 'Top Health Devices Reviewed', slug: 'top-health-devices' },
    ];

    const products = [
        { name: 'Ultra 4K Monitor', slug: 'ultra-4k-monitor', price: '$899' },
        { name: 'Smart Fitness Tracker', slug: 'smart-fitness-tracker', price: '$199' },
    ];

    return (
        <>
            <section className="mb-10">
                <h2 className="text-2xl font-semibold mb-4">Latest Blog Posts</h2>
                <div className="grid md:grid-cols-2 gap-4">
                    {blogs.map(blog => <BlogCard key={blog.slug} blog={blog} />)}
                </div>
            </section>

            <section>
                <h2 className="text-2xl font-semibold mb-4">Featured Products</h2>
                <div className="grid md:grid-cols-2 gap-4">
                    {products.map(product => <ProductCard key={product.slug} product={product} />)}
                </div>
            </section>
        </>
    );
}
