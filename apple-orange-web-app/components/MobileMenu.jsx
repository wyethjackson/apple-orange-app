import { useState } from 'react';
import Link from 'next/link';

export default function MobileMenu({ onClose, categories }) {
    const [searchOpen, setSearchOpen] = useState(false);

    return (
        <div className="fixed inset-0 z-50 bg-orange-100 text-orange-800 flex flex-col">
            {/* Top Bar */}
            <div className="flex items-center justify-between p-4 border-b border-orange-200">
                <button onClick={onClose} aria-label="Close menu">
                    {/* Close Icon (X) */}
                    <svg
                        className="w-6 h-6 text-orange-700"
                        fill="none"
                        stroke="currentColor"
                        strokeWidth="2"
                        viewBox="0 0 24 24"
                    >
                        <path strokeLinecap="round" strokeLinejoin="round" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </button>

                {/* Search Toggle */}
                <button
                    onClick={() => setSearchOpen(!searchOpen)}
                    aria-label="Toggle search"
                    className="text-orange-700"
                >
                    {/* Search Icon */}
                    <svg
                        className="w-6 h-6"
                        fill="none"
                        stroke="currentColor"
                        strokeWidth="2"
                        viewBox="0 0 24 24"
                    >
                        <path
                            strokeLinecap="round"
                            strokeLinejoin="round"
                            d="M21 21l-4.35-4.35M17 10.5A6.5 6.5 0 1 1 4 10.5a6.5 6.5 0 0 1 13 0z"
                        />
                    </svg>
                </button>
            </div>

            {/* Search Bar (optional) */}
            {searchOpen && (
                <div className="border-b border-orange-200 p-4">
                    <input
                        type="text"
                        placeholder="Search..."
                        className="w-full p-2 rounded-md border border-orange-300 focus:outline-none focus:ring-1 focus:ring-orange-400"
                    />
                </div>
            )}

            {/* Category Links */}
            <div className="flex-1 overflow-y-auto">
                {(categories || []).map((cat, idx) => (
                    <div
                        key={cat.name}
                        className="flex items-center justify-between px-4 py-3 border-b border-orange-200"
                    >
                        <Link href={`/categories/${cat.slug}`}>
                            <span className="text-orange-700 font-medium hover:text-orange-900">{cat.name}</span>
                        </Link>
                        {/* Chevron Icon (▼) */}
                        <svg
                            className="w-5 h-5 text-orange-600"
                            fill="currentColor"
                            viewBox="0 0 20 20"
                        >
                            <path d="M5.23 7.21a.75.75 0 011.06.02L10 10.44l3.71-3.21a.75.75 0 011.04 1.08l-4.25 3.67a.75.75 0 01-.98 0L5.21 8.29a.75.75 0 01.02-1.06z" />
                        </svg>
                    </div>
                ))}
            </div>
        </div>
    );
}
