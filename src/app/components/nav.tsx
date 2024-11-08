// components/nav.tsx
'use client';
import Link from 'next/link';
import { usePathname } from 'next/navigation';

const Navigation = () => {
  const pathname = usePathname();

  const navItems = [
    { href: '/', label: 'Matrix View' },
    { href: '/gallery', label: 'Gallery View' },
  ];

  return (
    <nav className="border-b bg-white/75 backdrop-blur-sm sticky z-50">
      <div className="px-5">
        <div className="flex h-16 items-center">
          <div className="flex items-center">
            <span className="font-mono text-lg font-bold">
              VILA Bank
            </span>
          </div>
          <div className="ml-auto flex gap-6">
            {navItems.map((item) => (
              <Link
                key={item.href}
                href={item.href}
                className={`relative flex items-center font-bold text-sm transition-colors text-black-500 hover:text-blue-500
                  after:absolute after:bottom-0 after:left-0 after:h-[2px] after:w-full after:scale-x-0 after:bg-blue-500 after:transition-transform after:duration-300
                  ${pathname === item.href 
                    ? 'after:scale-x-100' 
                    : 'hover:after:scale-x-100'
                  }
                `}
              >
                {item.label}
              </Link>
            ))}
          </div>
        </div>
      </div>
    </nav>
  );
};

export default Navigation;