using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace TransfersDownload
{
    public partial class TransfersDownloaderForm : Form
    {
        #region Constants
        
        /// <summary>
        /// Transfers main website address.
        /// </summary>
        const string WebsiteAddress = @"http://www.soccernews.com/soccer-transfers/";

        /// <summary>
        /// Sign which separates website address and years.
        /// </summary>
        const string WebsiteSeparator = "-";

        /// <summary>
        /// Website years sorting.
        /// </summary>
        public readonly string[] TransfersYears = { "2007-2008", "2009-2010", "2011-2012", "2012-2013" };

        /// <summary>
        /// Transfer type (league, Europe, etc.).
        /// </summary>
        public readonly string[] TransferTypes = { "english-premier-league-transfers", "spanish-la-liga-transfers", "italian-serie-a-transfers", "rest-of-europe-transfers" };

        private object lockingObject = new object();

        #endregion

        #region Properties

        public bool Navigating { get; set; }

        #endregion

        #region Constructor

        /// <summary>
        /// Main form of application.
        /// </summary>
        public TransfersDownloaderForm()
        {
            InitializeComponent();

            // Load transfers data.
            this.transferTypeComboBox.DataSource = TransferTypes;
            this.yearsComboBox.DataSource = TransfersYears;

            // Add event that allows to full load of web page.
            this.webBrowser.DocumentCompleted += new WebBrowserDocumentCompletedEventHandler(webBrowser_DocumentCompleted);            
        }
        
        #endregion
        
        #region Event handling

        /// <summary>
        /// Create file with transfers data for Navigating address.
        /// </summary>
        /// <param name="sender">Sender parameter.</param>
        /// <param name="e">Event arguments.</param>
        void webBrowser_DocumentCompleted(object sender, WebBrowserDocumentCompletedEventArgs e)
        {
            string filename = this.GetFilename((sender as WebBrowser).Url.ToString());            
            string document = (sender as WebBrowser).DocumentText;

            TransferManager transferManager = new TransferManager();
            List<string> transfersData = transferManager.GetTransfersData(document);

            File.WriteAllLines(filename, transfersData);

            if ((sender as WebBrowser).ReadyState == WebBrowserReadyState.Complete)
            {
                MessageBox.Show("Download completed!");
            }
        }

        #endregion

        #region Methods helpers

        /// <summary>
        /// Create filename depending on web address.
        /// </summary>
        /// <param name="address">Web page address.</param>
        /// <returns>Created filename.</returns>
        private string GetFilename(string address)
        {
            string[] addressParts = address.Split('/');

            for (int counter = addressParts.Count() - 1; counter != 0; counter--)
            {
                if (!string.IsNullOrEmpty(addressParts[counter]))
                {
                    return this.saveFileTextBox.Text + "\\" + addressParts[counter] + ".txt";                    
                }
            }

            throw new Exception("Could not create filename!");
        }

        /// <summary>
        /// Browse file system for save location.
        /// </summary>
        /// <param name="sender">Sender object.</param>
        /// <param name="e">Event arguments.</param> 
        private void button2_Click(object sender, EventArgs e)
        {
            if (this.folderBrowserDialog.ShowDialog() == DialogResult.OK)
            {
                this.saveFileTextBox.Text = this.folderBrowserDialog.SelectedPath;
            }
        }

        /// <summary>
        /// Start navigation process.
        /// </summary>
        /// <param name="sender">Sender object.</param>
        /// <param name="e">Event arguments.</param> 
        private void button1_Click(object sender, EventArgs e)
        {
            if (this.yearsComboBox.SelectedValue == "2012-2013")
            {
                webBrowser.Navigate(WebsiteAddress + this.transferTypeComboBox.SelectedValue);
            }
            else
            {
                webBrowser.Navigate(WebsiteAddress + this.transferTypeComboBox.SelectedValue + "-" + this.yearsComboBox.SelectedValue);
            }
        }

        #endregion

    }
}
