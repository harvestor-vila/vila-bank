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

    const [name, setName] = useState<string>('');
    const [comment, setComment] = useState<string>('');
    const [comments, setComments] = useState<{ name: string; comment: string }[]>([]);

    const itemKey = `${chartType}-${task}-${context}`;

    useEffect(() => {
        const loadTextContent = async () => {
            try {
                const response = await fetch(`/candidate_bank/1404_textual_component/${chartType}-${task}-${context}.txt`);
                if (!response.ok) {
                    throw new Error('Failed to load text content');
                }
                
                const text = await response.text();
                
                // Split into main parts
                const parts = text.split('part 2:');
                if (parts.length < 2) {
                    throw new Error('Invalid text format');
                }

                // Get question (part 1)
                const questionPart = parts[0].replace('part 1:', '').trim();
                const choicesAndAnswer = parts[1].split('part 3:');
                
                if (choicesAndAnswer.length < 2) {
                    throw new Error('Invalid text format');
                }

                // Parse choices
                const choicesPart = choicesAndAnswer[0].trim();
                // Match all choices in format (A) value, (B) value, etc.
                const choicesArray = choicesPart.match(/\([A-D]\)\s*[^(]*/g) || [];
                const formattedChoices = choicesArray.map(choice => choice.trim());

                const answerPart = choicesAndAnswer[1].trim();

                setQuestion(questionPart);
                setChoices(formattedChoices);
                setAnswer(answerPart);
            } catch (error) {
                console.error('Error loading text content:', error);
                setQuestion('Content not found');
                setChoices([]);
                setAnswer('');
            }
        };

        loadTextContent();

        // Fetch existing comments
        const fetchComments = async () => {
            const response = await fetch(`/api/comments`);
            const data = await response.json();
            setComments(data[itemKey] || []);
        };

        fetchComments();
    }, [chartType, task, context]);

    const handleCommentSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        if (!name || !comment) return;

        const response = await fetch('/api/comments', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ chartType, task, context, name, comment }),
        });

        if (response.ok) {
            setComments([...comments, { name, comment }]);
            setName('');
            setComment('');
        }
    };

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
                <div className="space-y-1 pl-5">
                    {choices.map((choice, index) => (
                        <p key={index}>{choice}</p>
                    ))}
                </div>
                <h2 className="font-bold mt-4">Answer</h2>
                <p>{answer}</p>
            </div>

            <div className="mt-4 p-4 bg-gray-50 rounded-lg">
                <h2 className="font-bold mb-2">Leave a Comment</h2>
                <form onSubmit={handleCommentSubmit} className="flex flex-col gap-2">
                    <input
                        type="text"
                        placeholder="Your Name"
                        value={name}
                        onChange={(e) => setName(e.target.value)}
                        required
                        className="p-2 border border-gray-300 rounded"
                    />
                    <textarea
                        placeholder="Your Comment"
                        value={comment}
                        onChange={(e) => setComment(e.target.value)}
                        required
                        className="p-2 border border-gray-300 rounded"
                    />
                    <button
                        type="submit"
                        className="bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600 transition-colors"
                    >
                        Submit
                    </button>
                </form>
            </div>

            <div className="mt-4">
                <h2 className="font-bold mb-2">Comments</h2>
                {comments.length > 0 ? (
                    comments.map((c, index) => (
                        <div key={index} className="p-2 border-b border-gray-200">
                            <p className="font-semibold">{c.name}</p>
                            <p>{c.comment}</p>
                        </div>
                    ))
                ) : (
                    <p className="text-gray-500">No comments yet.</p>
                )}
            </div>
        </div>
    );
};

export default Item;
