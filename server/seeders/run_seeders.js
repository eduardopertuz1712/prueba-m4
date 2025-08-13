
import { loadClientsToDatabase } from "./load_clients.js";

(async () => {
    try {
        console.log('Starting seeders...');
        await loadClientsToDatabase();
        console.log('✅ All seeders executed successfully.');
    } catch (error) {
        console.error('❌ Error running seeders:', error.message);
    } finally {
        process.exit();
    }
})();