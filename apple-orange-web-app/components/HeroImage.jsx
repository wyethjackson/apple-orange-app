import Image from 'next/image';

export default function HeroImage(props) {
    console.log(props)
    return (
        <div className="relative w-full max-w-7xl mx-auto overflow-hidden rounded-b-lg shadow">
            <img
                src={props.imageSrc} // <- Place the generated image in /public/hero-banner-products.png
                alt="Assortment of Premium Products"
                layout="fill"
                objectFit="cover"
                priority={true}
                className="w-full h-full object-cover rounded-b-lg"
            />

            {/* Optional Overlay */}

            {/* Optional Centered Text on Hero (if needed later) */}
            {/* <div className="absolute inset-0 flex items-center justify-center">
        <h1 className="text-white text-3xl md:text-5xl font-bold">Discover Top Products</h1>
      </div> */}
        </div>
    );
}
