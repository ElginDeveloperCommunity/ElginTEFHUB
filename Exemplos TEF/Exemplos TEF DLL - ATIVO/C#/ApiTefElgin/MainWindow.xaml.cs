using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace WpfTesteVs
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void BtnCarregar_Click(object sender, RoutedEventArgs e)
        {
            if (CBox.Text.Contains("TEF"))
            {
                ControleApi.ModoOperacao = "vender";

                Pagamento JanelaP = new Pagamento();
                JanelaP.ShowDialog();
                JanelaP.Focus();
            }
            else if (CBox.Text.Contains("Adm"))
            {
                ControleApi.ModoOperacao = "adm";

                Administrativa JanelaA = new Administrativa();
                JanelaA.ShowDialog();
                JanelaA.Focus();
            }
            else if (CBox.Text.Contains("Coleta"))
            {
                ColetaPinPad JanelaColetaPinPad = new ColetaPinPad();
                _ = JanelaColetaPinPad.ShowDialog();
                _ = JanelaColetaPinPad.Focus();
            }
            else
            {
                MessageBox.Show("Selecione uma operação");
            }
        }

    }
}
