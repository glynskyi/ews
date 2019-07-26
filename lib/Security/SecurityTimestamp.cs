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






    sealed class SecurityTimestamp
    {
        //  Pulled from SecurityProtocolFactory
        //
        const String DefaultTimestampValidityDurationString = "00:05:00";
        static readonly TimeSpan DefaultTimestampValidityDuration = TimeSpan.Parse(DefaultTimestampValidityDurationString);

        const String DefaultFormat = "yyyy-MM-ddTHH:mm:ss.fffZ";

        //                            012345678901234567890123
        static readonly TimeSpan DefaultTimeToLive = DefaultTimestampValidityDuration;
        /* private */ readonly String id;
        /* private */ readonly String digestAlgorithm;
        /* private */ readonly Uint8List digest;
        /* private */ char[] computedCreationTimeUtc;
        /* private */ char[] computedExpiryTimeUtc;
        /* private */ DateTime creationTimeUtc;
        /* private */ DateTime expiryTimeUtc;
 SecurityTimestamp(DateTime creationTimeUtc, DateTime expiryTimeUtc, String id)
            : this(creationTimeUtc, expiryTimeUtc, id, null, null)
        {
        }

        SecurityTimestamp(DateTime creationTimeUtc, DateTime expiryTimeUtc, String id, String digestAlgorithm, Uint8List digest)
        {
            EwsUtilities.Assert(
                creationTimeUtc.Kind == DateTimeKind.Utc,
                "SecurityTimestamp.ctor",
                "creation time must be in UTC");
            EwsUtilities.Assert(
                expiryTimeUtc.Kind == DateTimeKind.Utc,
                "SecurityTimestamp.ctor",
                "expiry time must be in UTC");

            if (creationTimeUtc > expiryTimeUtc)
            {
                throw new ArgumentOutOfRangeException("recordedExpiryTime");
            }

            this.creationTimeUtc = creationTimeUtc;
            this.expiryTimeUtc = expiryTimeUtc;
            this.id = id;

            this.digestAlgorithm = digestAlgorithm;
            this.digest = digest;
        }
 DateTime CreationTimeUtc
        {
            get
            {
                return this.creationTimeUtc;
            }
        }
 DateTime ExpiryTimeUtc
        {
            get
            {
                return this.expiryTimeUtc;
            }
        }
 String Id
        {
            get
            {
                return this.id;
            }
        }
 String DigestAlgorithm
        {
            get
            {
                return this.digestAlgorithm;
            }
        }

        Uint8List GetDigest()
        {
            return this.digest;
        }

        char[] GetCreationTimeChars()
        {
            if (this.computedCreationTimeUtc == null)
            {
                this.computedCreationTimeUtc = ToChars(ref this.creationTimeUtc);
            }
            return this.computedCreationTimeUtc;
        }

        char[] GetExpiryTimeChars()
        {
            if (this.computedExpiryTimeUtc == null)
            {
                this.computedExpiryTimeUtc = ToChars(ref this.expiryTimeUtc);
            }
            return this.computedExpiryTimeUtc;
        }

        /* private */ static char[] ToChars(ref DateTime utcTime)
        {
            char[] buffer = new char[DefaultFormat.Length];
            int offset = 0;

            ToChars(utcTime.Year, buffer, ref offset, 4);
            buffer[offset++] = '-';

            ToChars(utcTime.Month, buffer, ref offset, 2);
            buffer[offset++] = '-';

            ToChars(utcTime.Day, buffer, ref offset, 2);
            buffer[offset++] = 'T';

            ToChars(utcTime.Hour, buffer, ref offset, 2);
            buffer[offset++] = ':';

            ToChars(utcTime.Minute, buffer, ref offset, 2);
            buffer[offset++] = ':';

            ToChars(utcTime.Second, buffer, ref offset, 2);
            buffer[offset++] = '.';

            ToChars(utcTime.Millisecond, buffer, ref offset, 3);
            buffer[offset++] = 'Z';

            return buffer;
        }

        /* private */ static void ToChars(int n, char[] buffer, ref int offset, int count)
        {
            for (int i = offset + count - 1; i >= offset; i--)
            {
                buffer[i] = (char) ('0' + (n % 10));
                n /= 10;
            }
            EwsUtilities.Assert(
                n == 0,
                "SecurityTimestamp.ToChars",
                "Overflow in encoding timestamp field");
            offset += count;
        }
@override
 String toString()
        {
            return string.Format(
                CultureInfo.InvariantCulture,
                "SecurityTimestamp: Id={0}, CreationTimeUtc={1}, ExpirationTimeUtc={2}",
                this.Id,
                XmlConvert.ToString(this.CreationTimeUtc, XmlDateTimeSerializationMode.RoundtripKind),
                XmlConvert.ToString(this.ExpiryTimeUtc, XmlDateTimeSerializationMode.RoundtripKind));
        }
    }
