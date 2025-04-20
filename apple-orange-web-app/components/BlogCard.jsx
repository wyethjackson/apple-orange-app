// components/BlogCard.jsx
import Link from 'next/link';
import {SectionTitle, SectionSubtitle} from './Typography'

export default function BlogCard({ blog }) {
    return (
        <Link href={`/comparisons/${blog.slug}`}>
            <div className="p-4 border rounded-lg shadow hover:shadow-lg cursor-pointer">
                <SectionSubtitle>{blog.title}</SectionSubtitle>
            </div>
        </Link>
    );
}
