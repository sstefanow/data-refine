namespace TransfersDownload
{
    #region Using statements
    
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Net;
    using System.Text;
    using System.Threading.Tasks;
    using System.Windows.Forms;

    #endregion

    class TransferManager
    {       
        #region Methods

        /// <summary>
        /// Get all transfers data as list of strings.
        /// </summary>
        /// <param name="htmlDocument">HTML document string representation.</param>
        /// <returns>String list of data.</returns>
        public List<String> GetTransfersData(string htmlDocument)
        {
            // Data container.
            List<string> dataToSave = new List<string>();

            // Load downloaded website.
            HtmlAgilityPack.HtmlDocument htmlDoc = new HtmlAgilityPack.HtmlDocument();
            htmlDoc.LoadHtml(htmlDocument);

            // Find proper HTML element with transfers 'table'.
            HtmlAgilityPack.HtmlNode div = htmlDoc.DocumentNode.SelectSingleNode("//div[@class='panes']");

            // Get all players with data, each data element as separate list element.
            if (div != null)
            {
                dataToSave = div.Descendants("li")
                               .Select(a => a.InnerText)
                               .ToList();
            }
            else
            {
                throw new Exception("Could not find div with transfers!");
            }

            return dataToSave;
        }

        #endregion
    }
}
