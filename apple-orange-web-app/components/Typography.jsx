import React from 'react';

// Main title used for page headings
export function Title({ children, className = '' }) {
    return (
        <h2 className={`text-2xl font-semibold text-orange-700 mb-2 ${className}`}>
            {children}
        </h2>
    );
}

// Secondary title, for subtitles or section headers
export function Subtitle({ children, className = '' }) {
    return (
        <h3 className={`text-2xl font-semibold text-orange-700 ${className}`}>
            {children}
        </h3>
    );
}

// General paragraph text
export function Description({ children, className = '' }) {
    return (
        <p className={`text-lg text-gray-700 ${className} pt-4`}>
            {children}
        </p>
    );
}

// Section title, can be used within product or blog sections
export function SectionTitle({ children, className = '' }) {
    return (
        <h3 className={`text-3xl font-bold text-orange-800 ${className}`}>
            {children}
        </h3>
    );
}

// Section subtitle, typically a secondary heading in a section
export function SectionSubtitle({ children, className = '' }) {
    return (
        <h4 className={`text-xl font-semibold text-orange-600 ${className}`}>
            {children}
        </h4>
    );
}

// Section description, for detailed text within a section
export function SectionDescription({ children, className = '' }) {
    return (
        <p className={`text-base text-gray-700 ${className}`}>
            {children}
        </p>
    );
}
