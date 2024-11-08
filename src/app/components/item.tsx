import { useEffect, useState } from 'react';
import Image from 'next/image';
 
import { ChartType, VisualizationTask, VisualizationContext } from '../utils/types';

interface ItemProps {
    chartType: ChartType;
    task: VisualizationTask;
    context: VisualizationContext;
}

const Item = ({ chartType, task, context }: ItemProps) => {
    const [question, setQuestion] = useState<string>('');
    const [choices, setChoices] = useState<string[]>([]);
    const [answer, setAnswer] = useState<string>('');
    const [imageError, setImageError] = useState<boolean>(false);

    useEffect(() => {
        const loadTextContent = async () => {
            try {
                const response = await fetch(`/candidate_bank/1404_textual_component/${chartType}-${task}-${context}.txt`);
                if (!response.ok) {
                    throw new Error('Failed to load text content');
                }
                
                const text = await response.text();
                
                const parts = text.split('part 2:');
                if (parts.length < 2) {
                    throw new Error('Invalid text format');
                }

                const questionPart = parts[0].replace('part 1:', '').trim();
                const choicesAndAnswer = parts[1].split('part 3:');
                
                if (choicesAndAnswer.length < 2) {
                    throw new Error('Invalid text format');
                }

                const choicesPart = choicesAndAnswer[0].trim().split('\n').map(choice => choice.trim());
                const answerPart = choicesAndAnswer[1].trim();

                setQuestion(questionPart);
                setChoices(choicesPart);
                setAnswer(answerPart);
            } catch (error) {
                console.error('Error loading text content:', error);
                setQuestion('Content not found');
                setChoices([]);
                setAnswer('');
            }
        };

        loadTextContent();
    }, [chartType, task, context]);

    const imagePath = `/candidate_bank/108_visualization_component/${chartType}-${context}.png`;

    return (
        <div className="flex flex-col gap-4 p-4">
            <div className="relative w-full h-[400px]">
                {!imageError ? (
                    <Image
                        src={imagePath}
                        alt={`${chartType} ${task} visualization`}
                        fill
                        style={{ objectFit: 'contain' }}
                        priority
                        onError={() => setImageError(true)}
                    />
                ) : (
                    <div className="w-full h-full flex items-center justify-center bg-gray-100">
                        <p className="text-gray-500">Image not found</p>
                    </div>
                )}
            </div>
            <div className="mt-4 p-4 bg-gray-50 rounded-lg">
                <h2 className="font-bold">Question</h2>
                <p>{question}</p>
                <h2 className="font-bold mt-4">Choices</h2>
                <div className="list-disc pl-5">
                    {choices.map((choice, index) => (
                        <p key={index}>{choice}</p>
                    ))}
                </div>
                <h2 className="font-bold mt-4">Answer</h2>
                <p>{answer}</p>
            </div>
        </div>
    );
};

export default Item;