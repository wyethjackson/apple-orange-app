// components/Navbar.jsx
import Link from 'next/link';
import { useState } from 'react';
import MobileMenu from './MobileMenu';

export default function Navbar({categories}) {
    const [menuOpen, setMenuOpen] = useState(false);

    const toggleMenu = () => setMenuOpen(!menuOpen);
    return (
        <nav className="bg-orange-100 shadow">
            <div className="w-full sm:max-w-full md:max-w-3xl lg:max-w-5xl xl:max-w-6xl mx-auto px-4 py-4 flex justify-center md:justify-between items-center relative">
                <div className="md:hidden mx-4 absolute left-4 pt-2">
                    <button
                        onClick={toggleMenu}
                        className="text-orange-600 focus:outline-none"
                        aria-label="Toggle navigation menu"
                    >
                        <svg
                            className="w-6 h-6"
                            fill="none"
                            stroke="currentColor"
                            viewBox="0 0 24 24"
                            xmlns="http://www.w3.org/2000/svg"
                        >
                            {menuOpen ? (
                                <path
                                    strokeLinecap="round"
                                    strokeLinejoin="round"
                                    strokeWidth={2}
                                    d="M6 18L18 6M6 6l12 12"
                                />
                            ) : (
                                <path
                                    strokeLinecap="round"
                                    strokeLinejoin="round"
                                    strokeWidth={2}
                                    d="M4 6h16M4 12h16M4 18h16"
                                />
                            )}
                        </svg>
                    </button>
                </div>
                <Link href="/">
                    <span className="text-2xl font-semibold text-orange-700">🍎 Apple Orange 🍊</span>
                </Link>
                {/* <div className="hidden md:flex space-x-4">
                    <Link href="/">
                        <span className="text-orange-600 hover:text-orange-800">Home</span>
                    </Link>
                    <Link href="/categories">
                        <span className="text-orange-600 hover:text-orange-800">Categories</span>
                    </Link>
                </div> */}

            </div>
            {/* Mobile Nav Menu */}
            {menuOpen && (
                <MobileMenu onClose={() => setMenuOpen(false)} categories={categories}/>
            )}

        </nav>
    );
}
