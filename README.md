# VILA Bank

The VILA bank is a collection of approximately 1,100 high-quality, multiple-choice visualization items designed to assess individuals' ability to perform various visualization tasks. It was generated using a pipeline that leverages large language models (LLMs) to create items across 12 different chart types and 13 visualization tasks. The VILA bank supports research and education in visualization literacy, providing a diverse set of questions suitable for repeated testing of the same skills in participants. The items were curated with input from 11 visualization experts and validated using an evaluation rulebook. Additionally, the VILA bank was used to create the VILA-VLAT, a visualization literacy test with demonstrated validity. This resource is available for practical use and further research applications in visualization literacy and assessment.

## Getting Started

First, clone the repository and navigate into the project directory:

```bash
git clone <repository-url>
cd <project-directory>
```

Then, install the dependencies:

```bash
npm install
# or
yarn install
# or
pnpm install
```

After the installation is complete, you can start the development server:

```bash
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result. (Or what your console says it is hosted on)

## File Structure

```
docs/                     # Documentation files.
node_modules/             # Installed dependencies and modules.
public/                   # Static assets such as images and supplemental materials.
src/                      # Source code for the application.
  ├── app/                # Main application code.
    ├── components/       # Reusable UI components.
    ├── fonts/            # Custom fonts used in the project.
    ├── gallery/          # Page component for the gallery view.
      └── page.tsx            # Main page for the gallery view.
    ├── styles/           # Custom styling files.
    └── utils/            # Utility and helper functions.
  ├── globals.css         # Global CSS styles.
  ├── layout.tsx          # Layout component for the application.
  └── page.tsx            # Main page component with Blue Matrix.
.eslintrc.json            # ESLint configuration.
.gitignore                # Git ignore file.
next-env.d.ts             # TypeScript environment definitions for Next.js.
next.config.ts            # Next.js configuration.
package-lock.json         # Lock file for installed packages.
package.json              # Project dependencies and scripts.
postcss.config.mjs        # PostCSS configuration.
tailwind.config.ts        # Tailwind CSS configuration.
tsconfig.json             # TypeScript configuration.
README.md                 # Project README with instructions and documentation.
```

## Learn More

To learn more about Next.js, take a look at the following resources:

- [Next.js Documentation](https://nextjs.org/docs) - Learn about Next.js features and API.
- [Learn Next.js](https://nextjs.org/learn) - An interactive Next.js tutorial.

## Deploy on Vercel

The easiest way to deploy your Next.js app is to use the Vercel Platform from the creators of Next.js.

Check out our [Next.js deployment documentation](https://nextjs.org/docs/deployment) for more details.

This version of the [README.md](https://nextjs.org/docs/deployment) includes a section on the overall file structure and instructions on how to run the app locally, with a focus on the [app](https://nextjs.org/docs/app) directory.