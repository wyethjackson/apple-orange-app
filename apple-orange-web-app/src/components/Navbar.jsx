// components/Navbar.jsx
import Link from 'next/link';

export default function Navbar() {
    return (
        <nav className="bg-white shadow">
            <div className="container mx-auto px-4 py-4 flex justify-between items-center">
                <Link href="/">
                    <span className="text-xl font-bold cursor-pointer">🍎 Apple Orange 🍊</span>
                </Link>
                <div>
                    <Link href="/">
                        <span className="mx-2 cursor-pointer hover:text-blue-600">Home</span>
                    </Link>
                    <Link href="/comparisons">
                        <span className="mx-2 cursor-pointer hover:text-blue-600">Comparisons</span>
                    </Link>
                </div>
            </div>
        </nav>
    );
}
