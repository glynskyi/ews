/*
 * Exchange Web Services Managed API
 *
 * Copyright (c) Microsoft Corporation
 * All rights reserved.
 *
 * MIT License
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this
 * software and associated documentation files (the "Software"), to deal in the Software
 * without restriction, including without limitation the rights to use, copy, modify, merge,
 * publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons
 * to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or
 * substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED *AS IS*, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
 * PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
 * FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
 * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */


    /// <summary>
    /// Represents the Person.
    /// </summary>
 class Person : ComplexProperty
    {
        /// <summary>
        /// Initializes a local instance of <see cref="Person"/>
        /// </summary>
 Person()
            : super()
        {
        }

        /// <summary>
        /// Gets the EmailAddress.
        /// </summary>
 String EmailAddress
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the collection of insights.
        /// </summary>
 PersonInsightCollection Insights
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the display name.
        /// </summary>
 String FullName
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the display name.
        /// </summary>
 String DisplayName
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the given name.
        /// </summary>
 String GivenName
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the surname.
        /// </summary>
 String Surname
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the phone number.
        /// </summary>
 String PhoneNumber
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the sms number.
        /// </summary>
 String SMSNumber
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the facebook profile link.
        /// </summary>
 String FacebookProfileLink
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the linkedin profile link.
        /// </summary>
 String LinkedInProfileLink
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the list of skills.
        /// </summary>
 SkillInsightValueCollection Skills
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the professional biography.
        /// </summary>
 String ProfessionalBiography
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the management chain.
        /// </summary>
 ProfileInsightValueCollection ManagementChain
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the list of direct reports.
        /// </summary>
 ProfileInsightValueCollection DirectReports
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the list of peers.
        /// </summary>
 ProfileInsightValueCollection Peers
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the team size.
        /// </summary>
 String TeamSize
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the current job.
        /// </summary>
 JobInsightValueCollection CurrentJob
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the birthday.
        /// </summary>
 String Birthday
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the hometown.
        /// </summary>
 String Hometown
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the current location.
        /// </summary>
 String CurrentLocation
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the company profile.
        /// </summary>
 CompanyInsightValueCollection CompanyProfile
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the office.
        /// </summary>
 String Office
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the headline.
        /// </summary>
 String Headline
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the list of mutual connections.
        /// </summary>
 ProfileInsightValueCollection MutualConnections
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the title.
        /// </summary>
 String Title
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the mutual manager.
        /// </summary>
 ProfileInsightValue MutualManager
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the alias.
        /// </summary>
 String Alias
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the Department.
        /// </summary>
 String Department
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the user profile picture.
        /// </summary>
 UserProfilePicture UserProfilePicture
        {
            get;
            set;
        }

        /// <summary>
        /// Tries to read element from XML.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <returns>True if element was read.</returns>
@override
        bool TryReadElementFromXml(EwsServiceXmlReader reader)
        {
            switch (reader.LocalName)
            {
                case XmlElementNames.EmailAddress:
                    this.EmailAddress = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.FullName:
                    this.FullName = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.DisplayName:
                    this.DisplayName = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.GivenName:
                    this.GivenName = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.Surname:
                    this.Surname = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.PhoneNumber:
                    this.PhoneNumber = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.SMSNumber:
                    this.SMSNumber = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.FacebookProfileLink:
                    this.FacebookProfileLink = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.LinkedInProfileLink:
                    this.LinkedInProfileLink = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.ProfessionalBiography:
                    this.ProfessionalBiography = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.TeamSize:
                    this.TeamSize = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.Birthday:
                    this.Birthday = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.Hometown:
                    this.Hometown = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.CurrentLocation:
                    this.CurrentLocation = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.Office:
                    this.Office = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.Headline:
                    this.Headline = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.Title:
                    this.Title = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.Alias:
                    this.Alias = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.Department:
                    this.Department = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.MutualManager:
                    this.MutualManager = new ProfileInsightValue();
                    this.MutualManager.LoadFromXml(reader, XmlNamespace.Types, XmlElementNames.MutualManager);
                    break;
                case XmlElementNames.ManagementChain:
                    this.ManagementChain = new ProfileInsightValueCollection(XmlElementNames.Item);
                    this.ManagementChain.LoadFromXml(reader, XmlNamespace.Types, XmlElementNames.ManagementChain);
                    break;
                case XmlElementNames.DirectReports:
                    this.DirectReports = new ProfileInsightValueCollection(XmlElementNames.Item);
                    this.DirectReports.LoadFromXml(reader, XmlNamespace.Types, XmlElementNames.DirectReports);
                    break;
                case XmlElementNames.Peers:
                    this.Peers = new ProfileInsightValueCollection(XmlElementNames.Item);
                    this.Peers.LoadFromXml(reader, XmlNamespace.Types, XmlElementNames.Peers);
                    break;
                case XmlElementNames.MutualConnections:
                    this.MutualConnections = new ProfileInsightValueCollection(XmlElementNames.Item);
                    this.MutualConnections.LoadFromXml(reader, XmlNamespace.Types, XmlElementNames.MutualConnections);
                    break;
                case XmlElementNames.Skills:
                    this.Skills = new SkillInsightValueCollection(XmlElementNames.Item);
                    this.Skills.LoadFromXml(reader, XmlNamespace.Types, XmlElementNames.Skills);
                    break;
                case XmlElementNames.CurrentJob:
                    this.CurrentJob = new JobInsightValueCollection(XmlElementNames.Item);
                    this.CurrentJob.LoadFromXml(reader, XmlNamespace.Types, XmlElementNames.CurrentJob);
                    break;
                case XmlElementNames.CompanyProfile:
                    this.CompanyProfile = new CompanyInsightValueCollection(XmlElementNames.Item);
                    this.CompanyProfile.LoadFromXml(reader, XmlNamespace.Types, XmlElementNames.CompanyProfile);
                    break;
                case XmlElementNames.Insights:
                    this.Insights = new PersonInsightCollection();
                    this.Insights.LoadFromXml(reader, XmlNamespace.Types, XmlElementNames.Insights);
                    break;
                case XmlElementNames.UserProfilePicture:
                    this.UserProfilePicture = new UserProfilePicture();
                    this.UserProfilePicture.LoadFromXml(reader, XmlNamespace.Types, XmlElementNames.UserProfilePicture);
                    break;
                default:
                    return base.TryReadElementFromXml(reader);
            }

            return true;
        }
    }
