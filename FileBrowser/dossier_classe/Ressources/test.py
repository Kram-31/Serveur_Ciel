from tqdm import tqdm
import time

# Il suffit d'envelopper n'importe quel itérable avec tqdm()
for i in tqdm(range(100), desc="Traitement en cours", unit="it"):
    time.sleep(0.05)
