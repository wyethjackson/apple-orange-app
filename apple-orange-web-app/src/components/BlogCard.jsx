// components/BlogCard.jsx
import Link from 'next/link';

export default function BlogCard({ blog }) {
    return (
        <Link href={`/comparisons/${blog.slug}`}>
            <div className="p-4 border rounded-lg shadow hover:shadow-lg cursor-pointer">
                <h3 className="text-xl font-medium">{blog.title}</h3>
            </div>
        </Link>
    );
}
