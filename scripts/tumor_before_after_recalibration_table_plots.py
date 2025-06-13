import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Load the CSV file
df = pd.read_csv('/Users/alvise/Documents/semestre2/Demichelis-Human_Genomics/progetto/project_data/out_gatk_realignment/tumor.recal.csv')

# Check if 'After' data exists
if 'After' in df['Recalibration'].unique():
    before = df[df['Recalibration'] == 'Before']
    after = df[df['Recalibration'] == 'After']
else:
    before = df[df['Recalibration'] == 'Before']
    after = None


# 1. Reported Quality vs Empirical Quality (color by Before/After)
plt.figure(figsize=(8, 6))
plt.scatter(before['AverageReportedQuality'], before['EmpiricalQuality'], label='Before', alpha=0.6)
if after is not None and not after.empty:
    plt.scatter(after['AverageReportedQuality'], after['EmpiricalQuality'], label='After', alpha=0.6)
plt.xlabel('Average Reported Quality')
plt.ylabel('Empirical Quality')
plt.title('Reported Quality vs Empirical Quality')
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.savefig('/Users/alvise/Documents/semestre2/Demichelis-Human_Genomics/progetto/project_data/out_gatk_realignment/tumor_reported_vs_empirical_quality.png')
plt.show()

# 2. Machine Cycle vs Accuracy (color by Before/After)
plt.figure(figsize=(8, 6))
before_cycle = before[before['CovariateName'] == 'Cycle'].copy()
before_cycle['Cycle'] = pd.to_numeric(before_cycle['CovariateValue'], errors='coerce')
plt.scatter(before_cycle['Cycle'], before_cycle['Accuracy'], label='Before', alpha=0.6)
if after is not None and not after.empty:
    after_cycle = after[after['CovariateName'] == 'Cycle'].copy()
    after_cycle['Cycle'] = pd.to_numeric(after_cycle['CovariateValue'], errors='coerce')
    plt.scatter(after_cycle['Cycle'], after_cycle['Accuracy'], label='After', alpha=0.6)
plt.xlabel('Machine Cycle')
plt.ylabel('Accuracy (Empirical - Reported Quality)')
plt.title('Machine Cycle vs Accuracy')
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.savefig('/Users/alvise/Documents/semestre2/Demichelis-Human_Genomics/progetto/project_data/out_gatk_realignment/tumor_machine_cycle_vs_accuracy.png')
plt.show()

# 3. Dinucleotide vs Accuracy (color by Before/After)
plt.figure(figsize=(10, 6))
before_dinuc = before[(before['CovariateName'] == 'Context') & (before['CovariateValue'].str.len() == 2)]
before_dinuc['Recalibration'] = 'Before'
if after is not None and not after.empty:
    after_dinuc = after[(after['CovariateName'] == 'Context') & (after['CovariateValue'].str.len() == 2)]
    after_dinuc['Recalibration'] = 'After'
    dinuc_df = pd.concat([before_dinuc, after_dinuc])
else:
    dinuc_df = before_dinuc
sns.stripplot(x='CovariateValue', y='Accuracy', hue='Recalibration', data=dinuc_df, alpha=0.7, dodge=True)
plt.xlabel('Dinucleotide')
plt.ylabel('Accuracy (Empirical - Reported Quality)')
plt.title('Dinucleotide vs Accuracy')
plt.legend(title='Recalibration')
plt.grid(True, axis='y')
plt.tight_layout()
plt.savefig('/Users/alvise/Documents/semestre2/Demichelis-Human_Genomics/progetto/project_data/out_gatk_realignment/tumor_dinucleotide_vs_accuracy.png')
plt.show()
