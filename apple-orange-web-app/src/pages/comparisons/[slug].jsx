// pages/comparisons/[slug].jsx
import { useRouter } from 'next/router';

export default function ComparisonDetail() {
    const router = useRouter();
    const { slug } = router.query;
    
    if(!slug) {
        return <div>Loading...</div>;
    }

    // Placeholder content until you fetch from backend:
    return (
        <>
            <h1 className="text-3xl font-semibold mb-4 capitalize">
                Comparison: {slug.replace(/-/g, ' ')}
            </h1>
            <div className="prose">
                <p>
                    Detailed comparison content goes here. You will eventually fetch data
                    from your backend based on the slug: <strong>{slug}</strong>.
                </p>
            </div>
        </>
    );
}
