// pages/comparisons/index.jsx
import Link from 'next/link';

export default function Comparisons() {
    const comparisons = [
        { title: 'Apple iPhone vs Samsung Galaxy', slug: 'iphone-vs-galaxy' },
        { title: 'Peloton Bike vs NordicTrack', slug: 'peloton-vs-nordictrack' },
    ];

    return (
        <>
            <h1 className="text-3xl font-semibold mb-6">Product Comparisons</h1>
            <ul>
                {comparisons.map(item => (
                    <li key={item.slug} className="mb-3">
                        <Link href={`/comparisons/${item.slug}`}>
                            <span className="text-blue-600 hover:underline cursor-pointer">
                                {item.title}
                            </span>
                        </Link>
                    </li>
                ))}
            </ul>
        </>
    );
}
